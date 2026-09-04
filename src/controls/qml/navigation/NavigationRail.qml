// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import QtQuick.Window
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class NavigationRail
    \brief A persistent Material Design 3 Expressive navigation rail.

    NavigationRail provides access to primary application destinations on
    medium, expanded, large, and extra-large windows. Applications choose when
    to show it with \ref Breakpoints; the control does not hide or expand itself
    in response to window-size changes.

    The rail is collapsed by default. Collapsed destinations place their icons
    above their labels in a 96 dp rail. Expanded destinations use a logical
    leading icon in a content-sized rail constrained between 220 and 360 dp.
    A header remains at the top while destinations can be arranged at the top,
    center, or bottom. System safe-area margins are applied on the vertical and
    logical-start edges.

    NavigationRail inherits its destination collection API from
    \c QtQuick.Templates.Container. Declare NavigationRailItem objects as its
    default content, use \c count and \c itemAt() to inspect them, and use
    \c currentIndex to control their exclusive checked state. The initial
    current index is zero; assigning minus one clears selection.

    \code{.qml}
    MD.NavigationRail {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        expanded: MD.Breakpoints.fromWidth(window.width) >= MD.Breakpoints.Expanded

        header: Component {
            MD.IconButton {
                text: qsTr("Toggle navigation rail")
                icon.name: MD.Symbols.menu
            }
        }

        MD.NavigationRailItem {
            text: qsTr("Home")
            icon.name: MD.Symbols.home
        }
        MD.NavigationRailItem {
            text: qsTr("Settings")
            icon.name: MD.Symbols.settings
        }
    }
    \endcode

    Collapsed rails should normally contain three to seven destinations and are
    intended for windows at least 600 dp wide.

    For more information see the
    <a href="https://m3.material.io/components/navigation-rail/overview">Material Design 3 navigation rail guidelines</a>.
*/
T.Container {
    id: control

    //! Selects the vertical arrangement of destinations.
    enum Arrangement {
        //! Destinations follow the header at the top of the rail.
        Top,
        //! Destinations are centered in the full rail height.
        Center,
        //! Destinations are aligned to the bottom of the rail.
        Bottom
    }

    /*! Whether the rail displays its expanded layout.

        The width and item geometry animate when this value changes.
    */
    property bool expanded: false

    //! Vertical arrangement used by the destination list.
    property int arrangement: NavigationRail.Arrangement.Top

    /*! Optional component shown at the top of the rail.

        A header commonly contains a menu button, floating action button, logo,
        or a custom combination of those elements.
    */
    property Component header: null

    //! Semantic background color of the rail container.
    property color containerColor: control.MD.Style.surfaceColor

    //! \internal Whether the rail uses modal surface styling.
    property bool _modal: false

    //! \internal Prevents checked/current-index synchronization from recursing.
    property bool _syncingSelection: false

    //! \internal Single normalized progress shared by rail and item geometry.
    property real _layoutProgress: expanded ? 1 : 0

    //! \internal Width required by the widest destination or header.
    readonly property real _naturalExpandedWidth: {
        const headerItem = headerLoader.item as Item;
        let naturalWidth = headerItem ? headerItem.implicitWidth : 0;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index) as MD.NavigationRailItem;
            if (item)
                naturalWidth = Math.max(naturalWidth,
                                        item._expandedImplicitWidth
                                        + MD.Tokens.navigationRail.itemHorizontalPadding);
        }
        return naturalWidth;
    }

    //! \internal Collapsed endpoint including the logical-start safe area.
    readonly property real _collapsedWidth: MD.Tokens.navigationRail.collapsedContainerWidth
                                            + leftPadding + rightPadding

    //! \internal Expanded content-sized endpoint including safe areas.
    readonly property real _expandedWidth: Math.min(
                                               MD.Tokens.navigationRail.expandedContainerWidthMaximum,
                                               Math.max(MD.Tokens.navigationRail.expandedContainerWidthMinimum,
                                                        _naturalExpandedWidth + leftPadding + rightPadding))

    //! \internal Effective spacing between consecutive destinations.
    readonly property real _itemSpacing: MD.Tokens.navigationRail.collapsedItemVerticalSpace
                                         * (1 - _layoutProgress)

    //! \internal Total height occupied by destination items and their spacing.
    readonly property real _itemsHeight: {
        let total = 0;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index);
            if (item)
                total += item.implicitHeight;
        }
        return total + Math.max(0, count - 1) * _itemSpacing;
    }

    /*! \internal The enabled destination that forms the rail's single tab stop.

        Use the selected destination when possible, otherwise the first enabled
        one. Each NavigationRailItem derives its focus policy from this index so
        Tab enters the group once while arrow keys move within it.
    */
    readonly property int _tabStopIndex: {
        const selected = itemAt(currentIndex);
        if (selected && selected.enabled)
            return currentIndex;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index);
            if (item && item.enabled)
                return index;
        }
        return -1;
    }

    //! \internal The instantiated header, used by modal focus trapping.
    readonly property Item _headerItem: headerLoader.item as Item

    /*! \internal Finds the first keyboard-focusable control in the header.

        Headers are arbitrary components, so modal focus trapping recursively
        locates their first visible, enabled control instead of assuming a shape.
    */
    function _headerFocusItem(item) {
        const candidate = item || control._headerItem;
        if (!candidate || !candidate.visible || !candidate.enabled)
            return null;
        if (candidate.focusPolicy !== undefined && candidate.focusPolicy !== Qt.NoFocus)
            return candidate;
        for (let index = 0; index < candidate.children.length; ++index) {
            const descendant = control._headerFocusItem(candidate.children[index]);
            if (descendant)
                return descendant;
        }
        return null;
    }

    //! \internal Space reserved below the fixed header for top and bottom arrangements.
    readonly property real _headerOffset: {
        const headerItem = headerLoader.item as Item;
        return headerItem && headerItem.height > 0
               ? headerItem.height + MD.Tokens.navigationRail.headerSpaceMinimum
               : 0;
    }

    //! \internal Vertical position of the first destination.
    readonly property real _itemsOrigin: {
        if (arrangement === NavigationRail.Arrangement.Center)
            return Math.max(headerLoader.item ? (headerLoader.item as Item).height : 0,
                            (contentArea.height - _itemsHeight) / 2);
        if (arrangement === NavigationRail.Arrangement.Bottom)
            return Math.max(_headerOffset, contentArea.height - _itemsHeight);
        return _headerOffset;
    }

    /*! Expands the rail.

        This is equivalent to assigning \c true to \c expanded.
    */
    function expand() {
        control.expanded = true;
    }

    /*! Collapses the rail.

        This is equivalent to assigning \c false to \c expanded.
    */
    function collapse() {
        control.expanded = false;
    }

    //! Toggles between expanded and collapsed layouts.
    function toggle() {
        control.expanded = !control.expanded;
    }

    //! \internal Returns the vertical position of a destination.
    function _itemY(itemIndex) {
        let itemY = control._itemsOrigin;
        for (let index = 0; index < itemIndex; ++index) {
            const previous = control.itemAt(index);
            if (previous)
                itemY += previous.implicitHeight + control._itemSpacing;
        }
        return itemY;
    }

    //! \internal Binds destinations to the rail and updates their geometry.
    function _bindItems() {
        for (let index = 0; index < control.count; ++index) {
            const item = control.itemAt(index) as MD.NavigationRailItem;
            if (!item)
                continue;
            item.rail = control;
            item._railIndex = index;
            item.x = Qt.binding(function() {
                return MD.Tokens.navigationRail.itemHorizontalPadding
                       * control._layoutProgress / 2;
            });
            item.y = Qt.binding(function() { return control._itemY(index); });
            item.width = Qt.binding(function() {
                return Math.max(0, contentArea.width
                                - MD.Tokens.navigationRail.itemHorizontalPadding
                                  * control._layoutProgress);
            });
        }
        control._syncSelection();
    }

    //! \internal Synchronizes destination checked states with currentIndex.
    function _syncSelection() {
        if (control._syncingSelection)
            return;
        control._syncingSelection = true;
        for (let index = 0; index < control.count; ++index) {
            const item = control.itemAt(index) as MD.NavigationRailItem;
            if (item)
                item.checked = index === control.currentIndex;
        }
        control._syncingSelection = false;
    }

    //! \internal Selects a clicked destination.
    function _activateItem(item) {
        if (!item || !item.enabled || item._railIndex < 0)
            return;
        control.currentIndex = item._railIndex;
        item.forceActiveFocus(Qt.TabFocusReason);
    }

    //! \internal Applies a destination's externally changed checked state.
    function _itemCheckedChanged(item) {
        if (control._syncingSelection || !item || item._railIndex < 0)
            return;
        if (item.checked)
            control.currentIndex = item._railIndex;
        else if (control.currentIndex === item._railIndex)
            control.currentIndex = -1;
    }

    //! \internal Selects and focuses an enabled destination at index.
    function _selectIndex(index) {
        const item = control.itemAt(index) as MD.NavigationRailItem;
        if (!item || !item.enabled)
            return false;
        control.currentIndex = index;
        item.forceActiveFocus(Qt.TabFocusReason);
        return true;
    }

    /*! \internal Moves selection by one enabled destination, wrapping at the ends.

        Vertical navigation has the same logical direction in left-to-right and
        right-to-left layouts; disabled destinations are skipped in both modes.
    */
    function _moveSelection(direction) {
        if (control.count <= 0)
            return;
        let index = control.currentIndex;
        for (let attempt = 0; attempt < control.count; ++attempt) {
            index = (index + direction + control.count) % control.count;
            if (control._selectIndex(index))
                return;
        }
    }

    //! \internal Selects the first or last enabled destination.
    function _selectBoundary(last) {
        let index = last ? control.count - 1 : 0;
        const end = last ? -1 : control.count;
        const direction = last ? -1 : 1;
        for (; index !== end; index += direction) {
            if (control._selectIndex(index))
                return;
        }
    }

    currentIndex: 0
    implicitWidth: _collapsedWidth + (_expandedWidth - _collapsedWidth) * _layoutProgress
    implicitHeight: topPadding + bottomPadding + Math.max(_headerOffset + _itemsHeight,
                                                          MD.Tokens.navigationRail.itemContainerHeight)

    topPadding: SafeArea.margins.top + MD.Tokens.navigationRail.topSpace
    bottomPadding: SafeArea.margins.bottom + MD.Tokens.navigationRail.topSpace
    leftPadding: mirrored ? 0 : SafeArea.margins.left
    rightPadding: mirrored ? SafeArea.margins.right : 0
    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0

    // Destinations, rather than the container, own keyboard focus. This creates
    // one Tab entry point while retaining a PageTabList node for screen readers.
    focusPolicy: Qt.NoFocus
    clip: true
    LayoutMirroring.childrenInherit: true

    Accessible.role: Accessible.PageTabList

    Behavior on _layoutProgress {
        NumberAnimation {
            duration: MotionAnimation.expressiveDefaultSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveDefaultSpatialCurve
        }
    }

    onCountChanged: Qt.callLater(control._bindItems)
    onCurrentIndexChanged: control._syncSelection()
    onExpandedChanged: control._bindItems()
    Component.onCompleted: control._bindItems()

    // These handlers also cover the rare case where the modal wrapper focuses
    // an empty rail; instantiated destinations provide the same key contract.
    Keys.onUpPressed: control._moveSelection(-1)
    Keys.onDownPressed: control._moveSelection(1)
    Keys.onPressed: event => {
        if (event.key === Qt.Key_Home) {
            control._selectBoundary(false);
            event.accepted = true;
        } else if (event.key === Qt.Key_End) {
            control._selectBoundary(true);
            event.accepted = true;
        } else {
            event.accepted = false;
        }
    }

    contentItem: Item {
        id: contentArea
        objectName: "navigationRailContent"
        LayoutMirroring.enabled: control.mirrored
        LayoutMirroring.childrenInherit: true
    }

    data: Loader {
        id: headerLoader
        objectName: "navigationRailHeader"

        x: control.leftPadding
        y: control.topPadding
        width: Math.max(0, control.width - control.leftPadding - control.rightPadding)
        sourceComponent: control.header
        active: control.header !== null
        LayoutMirroring.enabled: control.mirrored
        LayoutMirroring.childrenInherit: true

        // The loader is structural only. Its accessible header descendants stay
        // available, while the wrapper itself does not add a redundant node.
        Accessible.ignored: true
    }

    background: MD.ElevationRectangle {
        objectName: "navigationRailBackground"

        readonly property var containerShape: control._modal && control.expanded
                                              ? MD.Tokens.navigationRail.modalContainerShape
                                              : MD.Tokens.navigationRail.containerShape

        color: control.containerColor
        elevation: control._modal && control.expanded
                   ? MD.Tokens.navigationRail.modalContainerElevation
                   : MD.Tokens.navigationRail.containerElevation
        topLeftRadius: UiMetrics.resolveShapeRadius(containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(containerShape.bottomRight, width, height)
    }
}
