// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../internal" as Internal

/*!
    \class TabBar
    \brief A Material 3 primary or secondary tab strip.

    Tabs organize related views at the same level. Use primary tabs for the main
    sections of a screen and secondary tabs to divide content within one section.
    Primary tabs underline the displayed content; secondary tabs underline the
    full tab. The default variant is Primary and the default layout is Fixed.
    TabButton describes label, icon, badge, and accessibility customization.

    \par Layout and overflow
    Fixed tabs share the available width equally and retain at least 48 by 48
    logical-pixel interaction targets. When their targets or badge paint bounds
    cannot fit, the bar scrolls horizontally. Set layoutMode to Scrollable for
    natural destination widths and longer labels. Scrollable tabs start after a
    52 logical-pixel leading inset, mirrored in right-to-left layouts.

    Hidden tabs occupy no layout space. Offscreen tabs remain in the native item
    model and accessible tree, and focused or selected destinations are revealed
    without moving external focus. Inherited padding, background implicit size,
    and insets contribute to the bar's implicit size.

    \par Selection and keyboard interaction
    The inherited count, contentModel, currentIndex, currentItem, itemAt(),
    addItem(), insertItem(), moveItem(), removeItem(), takeItem(), and
    setCurrentIndex() remain Qt Quick Templates APIs, including native empty,
    dynamic-item, and out-of-range behavior. Programmatic selection can address
    disabled or hidden destinations; user activation cannot.

    Left and Right move focus in physical order, mirrored in right-to-left
    layouts, wrapping around available tabs and skipping disabled and hidden
    destinations. Home and End focus the logical boundaries. Arrow navigation
    changes focus only; Space or Enter activates the focused tab. The bar has one
    tab stop at its selected available tab or first available tab. Tab and
    Shift+Tab leave the tab list.

    \par Connecting content
    Bind a StackLayout's currentIndex to the bar so its visible page follows the
    selected tab. The content container owns its pages; applications should give
    associated panels meaningful accessible names.

    \code{.qml}
    import QtQuick
    import QtQuick.Layouts
    import Fluid as MD

    ColumnLayout {
        MD.TabBar {
            id: tabs
            Layout.fillWidth: true
            variant: MD.TabBar.Primary
            layoutMode: MD.TabBar.Fixed

            MD.TabButton { text: qsTr("Overview"); icon.name: MD.Symbols.home }
            MD.TabButton { text: qsTr("Updates"); icon.name: MD.Symbols.notifications }
            MD.TabButton { text: qsTr("Saved"); icon.name: MD.Symbols.bookmark }
        }

        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabs.currentIndex

            MD.Label { text: qsTr("Overview content") }
            MD.Label { text: qsTr("Updates content") }
            MD.Label { text: qsTr("Saved content") }
        }
    }
    \endcode

    For swipeable pages, compose Qt Quick Controls SwipeView. Bind the bar's
    currentIndex to the view and route tab changes through setCurrentIndex() to
    preserve that binding and synchronize both directions without loops.

    \code{.qml}
    import QtQuick
    import QtQuick.Controls as QC
    import Fluid as MD

    Column {
        MD.TabBar {
            id: tabs
            anchors.left: parent.left
            anchors.right: parent.right
            currentIndex: pages.currentIndex

            MD.TabButton { text: qsTr("Photos") }
            MD.TabButton { text: qsTr("Albums") }
            MD.TabButton { text: qsTr("Shared") }
            onCurrentIndexChanged: pages.setCurrentIndex(currentIndex)
        }

        QC.SwipeView {
            id: pages
            clip: true
            width: parent.width
            height: 400

            MD.Label { text: qsTr("Photos") }
            MD.Label { text: qsTr("Albums") }
            MD.Label { text: qsTr("Shared") }
        }
    }
    \endcode

    \par Surrounding layout and theme
    A parent layout can place primary and secondary bars together, constrain
    their widths, or center a narrower group in a wide region. Use leading
    alignment instead when the surrounding content calls for a leading group.

    \code{.qml}
    import QtQuick.Layouts
    import Fluid as MD

    RowLayout {
        Layout.fillWidth: true
        MD.TabBar {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 520
            Layout.maximumWidth: 680
            variant: MD.TabBar.Primary
            MD.TabButton { text: qsTr("Today") }
            MD.TabButton { text: qsTr("Week") }
            MD.TabButton { text: qsTr("Month") }
        }
    }
    \endcode

    Tabs inherit the active Fluid Style. Set MD.Style.theme to MD.Style.Light or
    MD.Style.Dark on a local parent to override the theme for its descendants.
    Container, indicator, divider, and tab content colors have semantic defaults.
    Keep app-bar attachment, sticky placement, page padding, and swipe gesture
    coordination in the surrounding layout. Avoid assigning horizontal swipe
    gestures to both the page container and a handler over the same area.

    \sa TabButton, Badge
    <a href="https://m3.material.io/components/tabs/overview">Material tabs guidelines</a>,
    <a href="https://github.com/lirios/fluid/issues/393">Fluid tabs implementation</a>.
*/
T.TabBar {
    id: control

    enum Variant { Primary, Secondary }
    enum LayoutMode { Fixed, Scrollable }
    //! Primary by default; Secondary underlines the full tab.
    property int variant: MD.TabBar.Primary
    //! Fixed by default; Scrollable uses natural widths and a leading inset.
    property int layoutMode: MD.TabBar.Fixed
    //! Active semantic container color.
    property color containerColor: control.MD.Style.surfaceColor
    //! Semantic active indicator color for both variants.
    property color indicatorColor: control.MD.Style.primaryColor
    //! Semantic divider color. The specification supersedes the old SurfaceVariant token.
    property color dividerColor: control.MD.Style.outlineVariantColor

    property int _focusIndex: -1
    property bool _initialized: false
    property bool _destroying: false
    readonly property bool _scrollable: layoutMode === MD.TabBar.Scrollable
    readonly property int _visibleCount: {
        let result = 0;
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (item && item.visible)
                ++result;
        }
        return result;
    }
    readonly property real _naturalWidth: {
        let result = 0;
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (item && item.visible)
                result += item.implicitWidth;
        }
        return result + (layoutMode === MD.TabBar.Scrollable && _visibleCount > 0
            ? MD.Tokens.tab.scrollableLeadingOffset : 0);
    }
    readonly property real _naturalHeight: {
        let result = variant === MD.TabBar.Primary ? MD.Tokens.tab.primaryContainerHeight
                                                  : MD.Tokens.tab.secondaryContainerHeight;
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (item && item.visible)
                result = Math.max(result, item.implicitHeight);
        }
        return result;
    }
    readonly property real _minimumTabWidth: {
        let result = MD.Tokens.tab.minimumInteractiveSize;
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i) as MD.TabButton;
            if (item && item.visible)
                result = Math.max(result, item._minimumWidth);
        }
        return result;
    }

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            _naturalWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             _naturalHeight + topPadding + bottomPadding)
    padding: 0
    spacing: 0
    focusPolicy: Qt.NoFocus
    wheelEnabled: false
    LayoutMirroring.childrenInherit: true

    function _indexOf(item) {
        for (let i = 0; i < count; ++i) {
            if (itemAt(i) === item)
                return i;
        }
        return -1;
    }
    function _available(index) {
        const item = index >= 0 && index < count ? itemAt(index) : null;
        return item !== null && item.visible && item.enabled;
    }
    function _entryIndex() {
        if (_available(currentIndex))
            return currentIndex;
        for (let i = 0; i < count; ++i) {
            if (_available(i))
                return i;
        }
        return -1;
    }
    function _isTabStop(item) {
        const index = _available(_focusIndex) ? _focusIndex : _entryIndex();
        return _indexOf(item) === index;
    }
    function _widthFor(item) {
        if (control._scrollable)
            return item.implicitWidth;
        return _visibleCount > 0 ? Math.max(_minimumTabWidth,
                                           availableWidth / _visibleCount) : 0;
    }
    function _focusEntered(item) {
        _focusIndex = _indexOf(item);
        _reveal(item);
    }
    function _focusedItem() {
        for (let i = 0; i < count; ++i) {
            const item = itemAt(i);
            if (item && item.activeFocus)
                return item;
        }
        return null;
    }
    function _focusLeft() {
        if (control._destroying)
            return;
        if (!_focusedItem())
            _focusIndex = _entryIndex();
    }
    function _focusAt(index) {
        if (!_available(index))
            return;
        _focusIndex = index;
        const item = itemAt(index);
        item.forceActiveFocus(Qt.TabFocusReason);
        _reveal(item);
    }
    function _handleNavigation(event) {
        let delta = 0;
        if (event.key === Qt.Key_Left)
            delta = mirrored ? 1 : -1;
        else if (event.key === Qt.Key_Right)
            delta = mirrored ? -1 : 1;
        else if (event.key === Qt.Key_Home || event.key === Qt.Key_End) {
            const fromEnd = event.key === Qt.Key_End;
            for (let step = 0; step < count; ++step) {
                const index = fromEnd ? count - 1 - step : step;
                if (_available(index)) {
                    _focusAt(index);
                    break;
                }
            }
            event.accepted = true;
            return true;
        } else {
            return false;
        }
        const focused = _focusedItem();
        const start = focused ? _indexOf(focused) : _entryIndex();
        for (let step = 1; step <= count; ++step) {
            const index = ((start + delta * step) % count + count) % count;
            if (_available(index)) {
                _focusAt(index);
                break;
            }
        }
        event.accepted = true;
        return true;
    }
    function _availabilityChanged() {
        if (control._destroying)
            return;
        const focused = _focusedItem();
        if (focused && !_available(_indexOf(focused)))
            _focusAt(_entryIndex());
        else if (!focused)
            _focusIndex = _entryIndex();
        _scheduleReveal();
    }
    function _reveal(item) {
        if (!item || !item.visible || viewport.width <= 0)
            return;
        let bounds = item.mapToItem(viewport, 0, 0);
        const realItem = viewport.itemAt(item.x + item.width / 2, item.y + item.height / 2) === item;
        const contained = item.width <= viewport.width
            ? bounds.x >= 0 && bounds.x + item.width <= viewport.width
            : bounds.x <= 0 && bounds.x + item.width >= viewport.width;
        if (realItem && contained)
            return;
        const index = control._indexOf(item);
        if ((!realItem || !contained) && index >= 0)
            viewport.positionViewAtIndex(index, ListView.Contain);
        bounds = item.mapToItem(viewport, 0, 0);
        let destination = viewport.contentX;
        if (bounds.x < 0)
            destination += bounds.x;
        else if (bounds.x + item.width > viewport.width)
            destination += bounds.x + item.width - viewport.width;
        viewport.contentX = Math.max(viewport._minimumContentX,
                                     Math.min(viewport._maximumContentX, destination));
    }
    function _revealCurrent() {
        const focused = _focusedItem();
        _reveal(focused || currentItem);
    }
    function _revealSelected() {
        _reveal(currentItem);
    }
    function _scheduleSelectedReveal() {
        if (!control._destroying)
            Qt.callLater(control._revealSelected);
    }
    function _scheduleReveal() {
        if (!control._destroying)
            Qt.callLater(control._revealCurrent);
    }

    onCountChanged: Qt.callLater(control._availabilityChanged)
    onCurrentIndexChanged: {
        if (!_focusedItem())
            _focusIndex = _entryIndex();
        _scheduleSelectedReveal();
    }
    onCurrentItemChanged: _scheduleSelectedReveal()
    onAvailableWidthChanged: _scheduleReveal()
    onLayoutModeChanged: _scheduleReveal()
    onMirroredChanged: _scheduleReveal()
    Component.onCompleted: {
        _focusIndex = _entryIndex();
        Qt.callLater(function() { control._initialized = true; control._revealCurrent(); });
    }
    Component.onDestruction: control._destroying = true

    Keys.priority: Keys.BeforeItem
    Keys.onPressed: event => { control._handleNavigation(event); }

    contentItem: ListView {
        id: viewport
        objectName: "tabViewport"
        model: control.contentModel
        orientation: ListView.Horizontal
        currentIndex: -1
        interactive: contentWidth > width
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        boundsMovement: Flickable.StopAtBounds
        flickableDirection: Flickable.HorizontalFlick
        snapMode: ListView.NoSnap
        readonly property real _contentStart: {
            let result = headerItem ? headerItem.x : 0;
            for (let i = 0; i < control.count; ++i) {
                const item = control.itemAt(i);
                if (item && item.visible)
                    result = Math.min(result, item.x);
            }
            return result;
        }
        readonly property real _contentEnd: {
            let result = headerItem ? headerItem.x + headerItem.width : 0;
            for (let i = 0; i < control.count; ++i) {
                const item = control.itemAt(i);
                if (item && item.visible)
                    result = Math.max(result, item.x + item.width);
            }
            return result;
        }
        readonly property real _minimumContentX: control.mirrored
            ? Math.min(_contentStart, _contentEnd - width) : _contentStart
        readonly property real _maximumContentX: control.mirrored
            ? _contentEnd - width : Math.max(_contentStart, _contentEnd - width)
        header: Item {
            width: control.layoutMode === MD.TabBar.Scrollable && control._visibleCount > 0
                ? MD.Tokens.tab.scrollableLeadingOffset : 0
            height: viewport.height
        }

        Internal.TabIndicator {
            parent: viewport
            primary: control.variant === MD.TabBar.Primary
            readonly property MD.TabButton selectedTab: control.currentItem as MD.TabButton
            readonly property real selectedWidth: selectedTab && selectedTab.visible
                ? (primary ? selectedTab._primaryIndicatorWidth : selectedTab.width) : 0
            targetWidth: selectedWidth
            targetX: selectedTab ? selectedTab.x - viewport.contentX
                + (selectedTab.width - selectedWidth) / 2 : 0
            y: viewport.height - height
            indicatorColor: control.indicatorColor
            animationEnabled: control._initialized && !viewport.moving
            visible: selectedWidth > 0
            z: 2
        }
    }

    background: Rectangle {
        color: control.containerColor
        Rectangle {
            objectName: "tabDivider"
            parent: viewport
            z: 1
            width: viewport.width
            height: MD.Tokens.tab.dividerHeight
            y: viewport.height - height
            color: control.dividerColor
            Accessible.ignored: true
        }
    }
}
