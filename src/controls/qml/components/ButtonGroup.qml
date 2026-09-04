// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../internal"

/*!
    \class ButtonGroup
    \brief A horizontal Material 3 Expressive group of buttons.

    ButtonGroup accepts direct \l Button and \l IconButton children. Standard
    groups space independent actions and animate a pressed button's width.
    Connected groups provide segmented selection with shared outer geometry.

    The group owns child size, shape, checkability, selection accessibility, and
    roving focus. It leaves button type, icon, text, width variant, colors, and
    enabled state untouched. Invalid selected indexes are removed, duplicates are
    collapsed, and indexes are sorted. Single selection retains the first index;
    required selection chooses the first enabled visible child, then the first
    child when necessary. Selection follows child objects across insertions and
    removals whenever possible.

    Arrow keys move in visual order and wrap; Home and End move to the logical
    bounds. Space and Enter activate the focused child.

    \code{.qml}
    MD.ButtonGroup {
        MD.Button { text: qsTr("Back") }
        MD.Button { text: qsTr("Next") }
    }

    MD.ButtonGroup {
        variant: MD.ButtonGroup.Connected
        selectionMode: MD.ButtonGroup.SingleSelection
        selectionRequired: true
        MD.Button { text: qsTr("Day") }
        MD.Button { text: qsTr("Week") }
    }
    \endcode
*/
T.Container {
    id: control

    /*!
        \value Standard Spaces standalone buttons by 12 dp and redistributes
        width between a pressed button and its immediate visible neighbors.
        \value Connected Spaces buttons by 2 dp and joins their corner geometry.
    */
    enum Variant { Standard, Connected }

    /*!
        \value NoSelection Children are ordinary, non-checkable actions.
        \value SingleSelection At most one child is selected.
        \value MultiSelection Any number of children may be selected.
    */
    enum SelectionMode { NoSelection, SingleSelection, MultiSelection }

    /*!
        \value ExtraSmall Propagates the extra-small button size.
        \value Small Propagates the default small button size.
        \value Medium Propagates the medium button size.
        \value Large Propagates the large button size.
        \value ExtraLarge Propagates the extra-large button size.
    */
    enum Size { ExtraSmall, Small, Medium, Large, ExtraLarge }

    /*!
        \value Round Uses fully rounded outer connected corners.
        \value Square Uses the size-specific square outer corner token.
    */
    enum Shape { Round, Square }

    //! Whether buttons are independent or visually connected.
    property int variant: ButtonGroup.Standard
    //! The selection policy applied to direct child buttons.
    property int selectionMode: ButtonGroup.NoSelection
    //! Whether a selectable group must retain one selected child.
    property bool selectionRequired: false
    //! The expressive size propagated to every child.
    property int size: ButtonGroup.Small
    //! The round or square shape family propagated to every child.
    property int shape: ButtonGroup.Round
    //! Sorted, unique indexes of selected children.
    property list<int> selectedIndexes: []

    //! Emitted once whenever the effective selection changes.
    signal selectionChanged(list<int> selectedIndexes)

    property bool __updatingSelection: false
    property var __effectiveSelection: []
    property var __selectedObjects: []
    property var __knownChildren: []
    property bool __geometryInitialized: false
    readonly property int __standardVariant: ButtonGroup.Standard
    readonly property int __connectedVariant: ButtonGroup.Connected
    readonly property int __singleSelectionMode: ButtonGroup.SingleSelection
    readonly property int __multiSelectionMode: ButtonGroup.MultiSelection

    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding
    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding
    padding: 0

    Accessible.role: Accessible.Grouping

    contentItem: ButtonGroupLayout {
        id: layout
        group: control
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

    function __isSupported(item) {
        return item && item.__buttonGroup !== undefined;
    }

    function __firstRequiredIndex() {
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (__isSupported(item) && item.enabled && item.visible)
                return i;
        }
        for (let i = 0; i < count; ++i) {
            if (__isSupported(itemAt(i)))
                return i;
        }
        return -1;
    }

    function __canonicalIndexes(candidate) {
        if (selectionMode === ButtonGroup.NoSelection)
            return [];
        const unique = {};
        const result = [];
        for (let i = 0; i < candidate.length; ++i) {
            const value = Number(candidate[i]);
            if (Number.isInteger(value) && value >= 0 && value < count
                    && __isSupported(itemAt(value)) && !unique[value]) {
                unique[value] = true;
                result.push(value);
            }
        }
        result.sort((a, b) => a - b);
        if (selectionMode === ButtonGroup.SingleSelection && result.length > 1)
            result.splice(1);
        if (selectionRequired && result.length === 0) {
            const fallback = __firstRequiredIndex();
            if (fallback >= 0)
                result.push(fallback);
        }
        return result;
    }

    function __commitSelection(candidate) {
        if (__updatingSelection)
            return;
        const canonical = __canonicalIndexes(candidate);
        const changed = !__arraysEqual(canonical, __effectiveSelection);
        __updatingSelection = true;
        if (!__arraysEqual(Array.from(selectedIndexes), canonical))
            selectedIndexes = canonical;
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (__isSupported(item))
                item.checked = canonical.indexOf(i) >= 0;
        }
        __effectiveSelection = canonical.slice();
        __selectedObjects = canonical.map(index => itemAt(index));
        __updatingSelection = false;
        if (changed)
            selectionChanged(canonical);
        __updateFocusPolicies();
        layout.schedule();
    }

    function __childCheckedChanged(item) {
        if (__updatingSelection)
            return;
        const index = __indexOf(item);
        if (index < 0)
            return;
        let candidate = __effectiveSelection.slice();
        if (item.checked) {
            if (selectionMode === ButtonGroup.SingleSelection)
                candidate = [index];
            else if (candidate.indexOf(index) < 0)
                candidate.push(index);
        } else {
            candidate = candidate.filter(value => value !== index);
        }
        __commitSelection(candidate);
    }

    function __configureChild(item) {
        if (!__isSupported(item))
            return;
        item.__buttonGroup = control;
        item.size = size;
        item.shape = shape;
        item.checkable = selectionMode !== ButtonGroup.NoSelection;
    }

    function __releaseChild(item) {
        if (!item || item.__buttonGroup !== control)
            return;
        item.__buttonGroup = null;
        item.__groupTopLeftRadius = -1;
        item.__groupTopRightRadius = -1;
        item.__groupBottomLeftRadius = -1;
        item.__groupBottomRightRadius = -1;
        item.width = Qt.binding(() => item.implicitWidth);
        item.x = 0;
        item.y = 0;
    }

    function __childrenChanged() {
        Qt.callLater(function() {
            const preserved = [];
            for (const item of __selectedObjects) {
                const index = __indexOf(item);
                if (index >= 0)
                    preserved.push(index);
            }
            __commitSelection(preserved);
            __updateFocusPolicies();
            layout.schedule();
        });
    }

    function __syncChildren() {
        const current = [];
        for (let i = 0; i < count; ++i)
            current.push(itemAt(i));
        for (const oldItem of __knownChildren) {
            if (current.indexOf(oldItem) < 0)
                __releaseChild(oldItem);
        }
        for (const item of current)
            __configureChild(item);
        __knownChildren = current;
        __childrenChanged();
    }

    function __childGeometryChanged() {
        layout.schedule();
    }

    function __childFocused(item) {
        const index = __indexOf(item);
        if (index >= 0) {
            currentIndex = index;
            __updateFocusPolicies();
        }
    }

    function __focusableIndexes() {
        const result = [];
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (__isSupported(item) && item.enabled && item.visible)
                result.push(i);
        }
        return result;
    }

    function __updateFocusPolicies() {
        const focusable = __focusableIndexes();
        if (focusable.length > 0 && focusable.indexOf(currentIndex) < 0)
            currentIndex = focusable[0];
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (!__isSupported(item))
                continue;
            if (selectionMode === ButtonGroup.NoSelection)
                item.focusPolicy = Qt.StrongFocus;
            else
                item.focusPolicy = i === currentIndex ? Qt.StrongFocus : Qt.ClickFocus;
        }
    }

    function __handleKey(item, event) {
        if (selectionMode === ButtonGroup.NoSelection)
            return false;
        const indexes = __focusableIndexes();
        if (indexes.length === 0)
            return false;
        let target = -1;
        if (event.key === Qt.Key_Home)
            target = indexes[0];
        else if (event.key === Qt.Key_End)
            target = indexes[indexes.length - 1];
        else if (event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
            const physical = indexes.slice().sort((a, b) => itemAt(a).x - itemAt(b).x);
            let position = physical.indexOf(__indexOf(item));
            const delta = event.key === Qt.Key_Right ? 1 : -1;
            position = (position + delta + physical.length) % physical.length;
            target = physical[position];
        } else {
            return false;
        }
        currentIndex = target;
        itemAt(target).forceActiveFocus(Qt.TabFocusReason);
        __updateFocusPolicies();
        return true;
    }

    function __squareOuterRadius(height) {
        const tokens = MD.Tokens.button;
        let value = tokens.containerShapeSquareSmall.topLeft;
        switch (size) {
        case ButtonGroup.ExtraSmall: value = tokens.containerShapeSquareExtraSmall.topLeft; break;
        case ButtonGroup.Medium: value = tokens.containerShapeSquareMedium.topLeft; break;
        case ButtonGroup.Large: value = tokens.containerShapeSquareLarge.topLeft; break;
        case ButtonGroup.ExtraLarge: value = tokens.containerShapeSquareExtraLarge.topLeft; break;
        }
        return Math.min(value, height / 2);
    }

    function __resolveCorner(value, width, height) {
        return value === MD.Tokens.shape.cornerValueFull ? Math.min(width, height) / 2 : value;
    }

    function __applyConnectedCorners(items) {
        for (let i = 0; i < count; ++i) {
            const child = itemAt(i);
            if (!child || child.__buttonGroup === undefined)
                continue;
            child.__groupTopLeftRadius = -1;
            child.__groupTopRightRadius = -1;
            child.__groupBottomLeftRadius = -1;
            child.__groupBottomRightRadius = -1;
        }
        if (variant !== ButtonGroup.Connected || items.length <= 1)
            return;
        for (let i = 0; i < items.length; ++i) {
            const child = items[i];
            const height = child.background ? child.background.height : child.height;
            const full = Math.min(child.width, height)
                    * MD.Tokens.buttonGroup.selectedInnerCornerPercentage / 100;
            const outer = shape === ButtonGroup.Round
                    ? __resolveCorner(MD.Tokens.buttonGroup.connectedContainerShape.topLeft,
                                      child.width, height)
                    : __squareOuterRadius(height);
            const inner = child.pressed ? MD.Tokens.buttonGroup.pressedInnerCorner
                                       : MD.Tokens.buttonGroup.connectedInnerCorner;
            let left = i === 0 ? outer : inner;
            let right = i === items.length - 1 ? outer : inner;
            if (mirrored) {
                const swap = left;
                left = right;
                right = swap;
            }
            if (child.checked && !child.pressed)
                left = right = full;
            child.__groupTopLeftRadius = left;
            child.__groupBottomLeftRadius = left;
            child.__groupTopRightRadius = right;
            child.__groupBottomRightRadius = right;
        }
    }

    onSelectedIndexesChanged: {
        if (!__updatingSelection)
            __commitSelection(Array.from(selectedIndexes));
    }
    onVariantChanged: layout.updateGeometry()
    onSelectionModeChanged: {
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (item && item.__buttonGroup !== undefined)
                item.checkable = selectionMode !== ButtonGroup.NoSelection;
        }
        __commitSelection(__effectiveSelection);
    }
    onSelectionRequiredChanged: __commitSelection(__effectiveSelection)
    onSizeChanged: {
        for (let i = 0; i < count; ++i)
            __configureChild(itemAt(i));
        layout.schedule();
    }
    onShapeChanged: {
        for (let i = 0; i < count; ++i)
            __configureChild(itemAt(i));
        layout.schedule();
    }
    onMirroredChanged: layout.updateGeometry()
    onContentChildrenChanged: __syncChildren()
    onCountChanged: __syncChildren()

    Component.onCompleted: {
        for (let i = 0; i < count; ++i)
            __configureChild(itemAt(i));
        __knownChildren = Array.from(contentChildren);
        __commitSelection(Array.from(selectedIndexes));
        layout.schedule();
    }
}
