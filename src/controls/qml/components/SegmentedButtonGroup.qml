// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../internal"

/*!
    \class SegmentedButtonGroup
    \brief A horizontal group of outlined Material 3 choices.

    Add SegmentedButton children directly or use the inherited Container
    addItem(), insertItem(), moveItem(), removeItem(), and takeItem() methods.
    Two to five choices are recommended; empty groups and other counts are
    supported for dynamic construction. Hidden choices do not occupy width.
    All visible segments receive equal widths based on the widest natural
    content, or an equal share of an explicitly assigned group width.

    Selection is authoritative in selectedIndexes and synchronized to each
    child's checked property. Assigning checked requests a group selection
    change and is normalized by the same policy. Initial child checked values
    are overridden by selectedIndexes. Selection follows child identities
    across insertion, movement, and removal. Required single selection retains
    its current choice when that choice is clicked or unchecked directly.

    The inherited currentIndex is the focus index, independent of selection.
    The group has one tab stop among enabled visible choices. Left and Right
    wrap in visual order, including RTL; Home and End use logical bounds.
    Navigation changes focus only. Space and Enter activate the focused choice.
    Disabled and hidden choices are skipped by keyboard navigation.

    Semantic colors inherit through Style and can be overridden on individual
    segments. See SegmentedButton for icon-only accessible naming and content
    customization.

    \code{.qml}
    MD.SegmentedButtonGroup {
        selectedIndexes: [1]
        MD.SegmentedButton { text: qsTr("Day") }
        MD.SegmentedButton { text: qsTr("Week") }
        MD.SegmentedButton { text: qsTr("Month") }
    }

    MD.SegmentedButtonGroup {
        selectionMode: MD.SegmentedButtonGroup.MultiSelection
        selectedIndexes: [0, 1]
        MD.SegmentedButton { text: qsTr("Photos") }
        MD.SegmentedButton { text: qsTr("Videos") }
    }
    \endcode
*/
T.Container {
    id: control

    /*!
        Selection policy:
        - SingleSelection permits at most one selected child (the default).
        - MultiSelection permits independently selected children.
    */
    enum SelectionMode { SingleSelection, MultiSelection }

    //! Selection policy, defaulting to SingleSelection.
    property int selectionMode: SegmentedButtonGroup.SingleSelection

    /*!
        Whether a nonempty group must retain a selection. The default binding
        is true for SingleSelection and false for MultiSelection. Explicitly
        assigning this property replaces that binding. If selection is empty,
        choose the first enabled visible child, falling back to the first child
        when none is interactive. Existing disabled or hidden selections remain
        selected until explicitly replaced or removed.
    */
    property bool selectionRequired: selectionMode === SegmentedButtonGroup.SingleSelection

    /*!
        Sorted, unique, valid indexes of selected children. Defaults to an empty
        list before required-selection normalization. Invalid indexes are
        discarded; SingleSelection keeps the lowest valid index. Assigning an
        empty list applies the required-selection fallback when enabled.
        Structural changes update indexes while preserving selected objects.
    */
    property list<int> selectedIndexes: []

    /*!
        Emitted once when the normalized index list changes, including changes
        caused by structural edits. Equivalent assignments and rejected
        attempts to clear required selection do not emit this signal.
        The argument is the effective sorted list.
    */
    signal selectionChanged(list<int> selectedIndexes)

    property bool __ready: false
    property bool __updatingSelection: false
    property bool __updatingFocus: false
    property bool __syncingChildren: false
    property var __effectiveSelection: []
    property var __selectedObjects: []
    property var __knownChildren: []
    property list<MD.SegmentedButton> __visibleSegments: []
    property real __naturalSegmentWidth: 0
    property real __naturalHeight: 0

    implicitWidth: __visibleSegments.length * __naturalSegmentWidth + leftPadding + rightPadding
    implicitHeight: __naturalHeight + topPadding + bottomPadding
    padding: 0
    focusPolicy: Qt.NoFocus
    Accessible.role: Accessible.Grouping

    contentItem: SegmentedButtonLayout {
        segments: control.__visibleSegments
        mirrored: control.mirrored
    }

    function __arraysEqual(a, b) {
        if (a.length !== b.length)
            return false;
        for (let i = 0; i < a.length; ++i) {
            if (a[i] !== b[i])
                return false;
        }
        return true;
    }

    function __indexOf(item) {
        for (let i = 0; i < count; ++i) {
            if (itemAt(i) === item)
                return i;
        }
        return -1;
    }

    function __segmentAt(index: int): MD.SegmentedButton {
        return itemAt(index) as MD.SegmentedButton;
    }

    function __firstRequiredIndex(): int {
        let fallback = -1;
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (!segment)
                continue;
            if (fallback < 0)
                fallback = i;
            if (segment.enabled && segment.visible)
                return i;
        }
        return fallback;
    }

    function __canonicalIndexes(candidate) {
        const result = [];
        for (let i = 0; i < candidate.length; ++i) {
            const index = Number(candidate[i]);
            if (Number.isInteger(index) && index >= 0 && index < count
                    && __segmentAt(index) && result.indexOf(index) < 0)
                result.push(index);
        }
        result.sort((a, b) => a - b);
        if (selectionMode === SegmentedButtonGroup.SingleSelection && result.length > 1)
            result.splice(1);
        if (selectionRequired && result.length === 0) {
            const fallback = __firstRequiredIndex();
            if (fallback >= 0)
                result.push(fallback);
        }
        return result;
    }

    function __commitSelection(candidate) {
        if (!__ready || __updatingSelection)
            return;
        const canonical = __canonicalIndexes(candidate);
        const changed = !__arraysEqual(canonical, __effectiveSelection);
        __updatingSelection = true;
        if (!__arraysEqual(Array.from(selectedIndexes), canonical))
            selectedIndexes = canonical;
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (segment)
                segment.checked = canonical.indexOf(i) >= 0;
        }
        __effectiveSelection = canonical.slice();
        __selectedObjects = canonical.map(index => itemAt(index));
        __updatingSelection = false;
        if (changed)
            selectionChanged(canonical);
    }

    function __childCheckedChanged(segment: MD.SegmentedButton) {
        if (!__ready || __updatingSelection)
            return;
        const index = __indexOf(segment);
        if (index < 0)
            return;
        // Resolve identities now: an insert/move can precede the deferred sync.
        let candidate = __selectedObjects.map(item => __indexOf(item)).filter(value => value >= 0);
        if (segment.checked) {
            if (selectionMode === SegmentedButtonGroup.SingleSelection)
                candidate = [index];
            else if (candidate.indexOf(index) < 0)
                candidate.push(index);
        } else if (!(selectionRequired && candidate.length === 1 && candidate[0] === index)) {
            candidate = candidate.filter(value => value !== index);
        }
        __commitSelection(candidate);
    }

    function __releaseChild(segment: MD.SegmentedButton) {
        if (!segment || segment.__segmentedButtonGroup !== control)
            return;
        segment.__segmentedButtonGroup = null;
        segment.__leftEnd = true;
        segment.__rightEnd = true;
        segment.focusPolicy = Qt.StrongFocus;
        segment.width = Qt.binding(() => segment.implicitWidth);
        segment.height = Qt.binding(() => segment.implicitHeight);
        segment.x = 0;
        segment.y = 0;
    }

    function __syncChildren() {
        if (!__ready)
            return;
        if (__syncingChildren) {
            Qt.callLater(__syncChildren);
            return;
        }
        __syncingChildren = true;
        const current = [];
        const visible = [];
        let naturalWidth = 0;
        let naturalHeight = 0;
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (!segment)
                continue;
            current.push(segment);
            segment.__segmentedButtonGroup = control;
            segment.checkable = true;
            segment.autoExclusive = false;
            if (segment.visible) {
                visible.push(segment);
                naturalWidth = Math.max(naturalWidth, segment.implicitWidth);
                naturalHeight = Math.max(naturalHeight, segment.implicitHeight);
            }
        }
        for (const oldItem of __knownChildren) {
            if (current.indexOf(oldItem) < 0)
                __releaseChild(oldItem);
        }
        __knownChildren = current;
        __naturalSegmentWidth = naturalWidth;
        __naturalHeight = naturalHeight;
        __visibleSegments = visible;
        __commitSelection(__selectedObjects.map(item => __indexOf(item)).filter(index => index >= 0));
        __updateFocusPolicies();
        __syncingChildren = false;
    }

    function __scheduleSync() {
        if (__ready)
            Qt.callLater(__syncChildren);
    }

    function __focusableIndexes() {
        const result = [];
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (segment && segment.enabled && segment.visible)
                result.push(i);
        }
        return result;
    }

    function __updateFocusPolicies() {
        if (!__ready || __updatingFocus)
            return;
        __updatingFocus = true;
        const indexes = __focusableIndexes();
        const focusIndex = indexes.indexOf(currentIndex) >= 0 ? currentIndex
                           : (indexes.length > 0 ? indexes[0] : -1);
        if (currentIndex !== focusIndex)
            currentIndex = focusIndex;
        // Qt requires moving active focus before removing its tab policy.
        // A programmatic currentIndex change also moves focus when the group
        // already contains the active item, without stealing external focus.
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (segment && segment.activeFocus && i !== focusIndex) {
                const next = __segmentAt(focusIndex);
                if (next)
                    next.forceActiveFocus(Qt.TabFocusReason);
                else
                    segment.focus = false;
                break;
            }
        }
        for (let i = 0; i < count; ++i) {
            const segment = __segmentAt(i);
            if (segment)
                segment.focusPolicy = i === focusIndex ? Qt.StrongFocus : Qt.ClickFocus;
        }
        __updatingFocus = false;
    }

    function __childFocused(segment: MD.SegmentedButton) {
        const index = __indexOf(segment);
        if (index >= 0)
            currentIndex = index;
    }

    function __handleKey(segment: MD.SegmentedButton, event): bool {
        const indexes = __focusableIndexes();
        if (indexes.length === 0)
            return false;
        let target = -1;
        if (event.key === Qt.Key_Home)
            target = indexes[0];
        else if (event.key === Qt.Key_End)
            target = indexes[indexes.length - 1];
        else if (event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
            const physical = mirrored ? indexes.slice().reverse() : indexes;
            const position = physical.indexOf(__indexOf(segment));
            const delta = event.key === Qt.Key_Right ? 1 : -1;
            target = physical[(position + delta + physical.length) % physical.length];
        } else {
            return false;
        }
        const next = __segmentAt(target);
        if (next)
            next.forceActiveFocus(Qt.TabFocusReason);
        currentIndex = target;
        return true;
    }

    onSelectedIndexesChanged: {
        if (__ready && !__updatingSelection)
            __commitSelection(Array.from(selectedIndexes));
    }
    onSelectionModeChanged: __commitSelection(Array.from(selectedIndexes))
    onSelectionRequiredChanged: __commitSelection(Array.from(selectedIndexes))
    onCurrentIndexChanged: __updateFocusPolicies()
    onContentChildrenChanged: __syncChildren()
    onCountChanged: __syncChildren()
    onVisibleChanged: __scheduleSync()
    onEnabledChanged: __scheduleSync()

    Component.onCompleted: {
        __ready = true;
        __commitSelection(Array.from(selectedIndexes));
        __syncChildren();
    }
}
