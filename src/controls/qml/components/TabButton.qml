// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import Fluid.Private as P
import "../core/BadgeContent.js" as BadgeContent
import "../internal" as Internal

/*!
    \class TabButton
    \brief A Material 3 tab using the native Qt tab selection contract.

    Place buttons directly inside TabBar. Qt's attached TabBar.tabBar relationship
    supplies the owner and effectiveVariant; a standalone button uses Primary.
    Selection, Action, clicked, checked, enabled, and dynamic-item behavior remain
    Qt Quick Templates APIs. TabBar describes layout, navigation, and connecting
    tabs to StackLayout or SwipeView content.

    \par Labels and icons
    Primary tabs default to TextUnderIcon and secondary tabs to TextBesideIcon.
    Secondary icon-and-label content is always inline. TextOnly and IconOnly
    suppress the corresponding content without reserving its space. Keep labels
    concise and consistent within a bar; icon-only tabs are exceptional and need
    an explicit Accessible.name describing their destination.

    Long labels are elided on one line by default. Prefer a scrollable bar for
    longer labels, or set maximumLineCount to 2 to wrap onto two lines before
    elision. Labels default to the titleSmall type scale; typescale and explicit
    font overrides customize typography. Natural height grows with font metrics
    and multiline content. Padding, background size, and insets contribute to
    implicit size while preserving the minimum interaction target.

    \code{.qml}
    MD.TabButton {
        text: qsTr("A longer destination label")
        maximumLineCount: 2
    }

    MD.TabButton {
        icon.name: MD.Symbols.settings
        display: MD.TabButton.IconOnly
        Accessible.name: qsTr("Settings destination")
    }
    \endcode

    \par Badges and accessible descriptions
    Set badgeContent to a number or string for a count or status badge, or set
    badgeNotification for a dot. badgeVariant chooses Badge.Small, Badge.Large,
    or Badge.Auto. Badge properties default from a Fluid Action when supplied.
    badgeVisible controls rendering, and a badge is shown only when it has valid
    content or a notification. Badges remain passive and create no separate
    accessible or interactive node.

    Inline badges contribute to a primary indicator's content width. Stacked and
    icon-only badges overlap the icon without changing that width. Natural size
    reserves badge paint bounds so overlays remain visible; fixed bars retain
    equal widths and can scroll when those bounds need more space.

    badgeAccessibleDescription supplies a localized full description, included
    in the default accessible name while the badge is shown. If an application
    overrides Accessible.name, it must include meaningful badge information
    itself. Hidden or cleared badges contribute no stale description. Counts
    above 999 display a localized 999+; status strings longer than four grapheme
    clusters display their first three clusters followed by an ellipsis.

    Applications own notification state and should update or clear it after the
    related content has been viewed. Badge never clears caller state.

    \code{.qml}
    MD.TabBar {
        id: tabs
        property int unreadCount: 12

        MD.TabButton { text: qsTr("Overview") }
        MD.TabButton {
            text: qsTr("Messages")
            icon.name: MD.Symbols.mail
            badgeContent: tabs.unreadCount
            badgeVisible: tabs.unreadCount > 0
            badgeAccessibleDescription: qsTr("%n unread message(s)", "", tabs.unreadCount)
            onClicked: tabs.unreadCount = 0
        }
    }
    \endcode

    \par Theme and interaction
    Container, content, and state-layer colors resolve through attached Style
    and inherit local or ancestor theme overrides. icon.color overrides the icon
    independently; disable tintSourceIcon for multicolor source artwork.
    Disabled destinations remain visible but cannot be focused or activated by
    the user. Programmatic selection follows the native Qt tab bar contract.
    Focus remains distinct from selection: arrows move focus, while Space or
    Enter uses the native press, release, and cancellation lifecycle to activate
    the destination. Tab and Shift+Tab leave the bar's single tab stop.

    \sa TabBar, Badge, Action
    <a href="https://m3.material.io/components/tabs/overview">Material tabs guidelines</a>.
*/
T.TabButton {
    id: control

    //! Variant inherited from a Fluid TabBar; standalone buttons use Primary.
    readonly property int effectiveVariant: _tabBar ? _tabBar.variant : MD.TabBar.Primary
    //! One line by default; set to two to wrap before eliding the final line.
    property int maximumLineCount: 1
    //! Material type scale; explicit font overrides are retained.
    property MD.typescale typescale: MD.Tokens.typescale.titleSmall
    //! Active semantic container color.
    property color containerColor: control.MD.Style.surfaceColor
    //! Active semantic label/icon color; explicit icon.color overrides only the icon.
    property color contentColor: checked && effectiveVariant === MD.TabBar.Primary
        ? control.MD.Style.primaryColor
        : checked || hovered || visualFocus || down
          ? control.MD.Style.onSurfaceColor : control.MD.Style.onSurfaceVariantColor
    //! Semantic interaction state-layer color.
    property color stateLayerColor: checked && effectiveVariant === MD.TabBar.Primary
        ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
    //! Whether source icons are tinted; disable for multicolor artwork.
    property bool tintSourceIcon: true
    //! String or nonnegative safe integer, defaulting from Fluid Action.
    property var badgeContent: _badgeAction ? _badgeAction.badgeContent : ""
    //! Requests a Small notification dot while retaining its full accessible value.
    property bool badgeNotification: _badgeAction ? _badgeAction.badgeNotification : false
    //! Whether badge content is rendered and described.
    property bool badgeVisible: _badgeAction ? _badgeAction.badgeVisible : true
    //! Requested badge presentation; notification uses Small.
    property int badgeVariant: MD.Badge.Auto
    //! Localized full badge description; empty uses Badge's default.
    property string badgeAccessibleDescription: _badgeAction ? _badgeAction.badgeAccessibleDescription : ""

    readonly property MD.TabBar _tabBar: T.TabBar.tabBar as MD.TabBar
    property bool _destroying: false
    readonly property MD.Action _badgeAction: action as MD.Action
    readonly property bool _showIcon: (icon.name.length > 0 || icon.source.toString().length > 0)
        && display !== T.AbstractButton.TextOnly
    readonly property bool _showText: text.length > 0 && display !== T.AbstractButton.IconOnly
    readonly property bool _stacked: effectiveVariant === MD.TabBar.Primary
        && display === T.AbstractButton.TextUnderIcon && _showIcon && _showText
    readonly property bool _showBadge: badgeVisible
        && (badgeNotification || BadgeContent.hasContent(badgeContent))
    readonly property real _displayedContentWidth: tabContent.displayedContentWidth
    readonly property real _primaryIndicatorWidth: Math.min(width,
        Math.max(MD.Tokens.tab.primaryActiveIndicatorMinimumWidth,
                 _displayedContentWidth - 2 * MD.Tokens.tab.primaryActiveIndicatorHorizontalInset))
    readonly property real _minimumWidth: Math.max(MD.Tokens.tab.minimumInteractiveSize,
                                                  tabContent.overlayPaintWidth)
    readonly property real _baselineHeight: _stacked
        ? MD.Tokens.tab.primaryWithIconAndLabelContainerHeight
        : effectiveVariant === MD.TabBar.Primary ? MD.Tokens.tab.primaryContainerHeight
                                                : MD.Tokens.tab.secondaryContainerHeight
    readonly property real _nominalContentHeight: _stacked
        ? MD.Tokens.tab.iconSize + MD.Tokens.tab.stackedIconLabelGap
          + MD.Tokens.typescale.titleSmall.lineHeight
        : Math.max(_showIcon ? MD.Tokens.tab.iconSize : 0,
                   _showText ? MD.Tokens.typescale.titleSmall.lineHeight : 0)
    readonly property real _stateOpacity: !enabled ? 0
        : down ? MD.Tokens.tab.pressedStateLayerOpacity
        : visualFocus ? MD.Tokens.tab.focusStateLayerOpacity
        : hovered ? MD.Tokens.tab.hoverStateLayerOpacity : 0

    implicitWidth: Math.max(MD.Tokens.tab.minimumInteractiveSize,
                           implicitBackgroundWidth + leftInset + rightInset,
                           implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(_baselineHeight,
                             implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             _baselineHeight + tabContent.contentHeight - _nominalContentHeight)
    width: !visible ? 0 : _tabBar ? _tabBar._widthFor(control) : implicitWidth
    height: _tabBar ? _tabBar.availableHeight : implicitHeight
    padding: 0
    leftPadding: MD.Tokens.tab.horizontalPadding
    rightPadding: MD.Tokens.tab.horizontalPadding
    display: effectiveVariant === MD.TabBar.Primary ? T.AbstractButton.TextUnderIcon
                                                   : T.AbstractButton.TextBesideIcon
    icon.width: MD.Tokens.tab.iconSize
    icon.height: MD.Tokens.tab.iconSize
    font.family: typescale.face === MD.Style.TypeFace.Brand
        ? control.MD.Style.brandFontFamily : control.MD.Style.plainFontFamily
    font.pixelSize: typescale.fontSize
    font.weight: typescale.fontWeight
    font.letterSpacing: typescale.tracking
    hoverEnabled: true
    wheelEnabled: false
    focusPolicy: !_tabBar || _tabBar._isTabStop(control) || activeFocus
        ? Qt.StrongFocus : Qt.ClickFocus

    Accessible.name: BadgeContent.accessibleName(text, tabContent.accessibleBadgeDescription)
    // PageTab's accessible press action activates the same native button path.
    Accessible.selectable: true
    Accessible.selected: checked
    Accessible.onPressAction: {
        if (control.enabled && control.visible)
            control.click();
    }

    onActiveFocusChanged: {
        if (control._destroying)
            return;
        const owner = control._tabBar;
        if (!owner || owner._destroying)
            return;
        if (activeFocus)
            owner._focusEntered(control);
        else
            Qt.callLater(control._notifyFocusLeft);
    }
    function _notifyFocusLeft() {
        const owner = control._tabBar;
        if (owner && !owner._destroying) owner._focusLeft();
    }
    function _notifyAvailability() {
        const owner = control._tabBar;
        if (owner && !owner._destroying) owner._availabilityChanged();
    }
    function _notifyGeometry() {
        const owner = control._tabBar;
        if (owner && !owner._destroying) owner._scheduleReveal();
    }
    onVisibleChanged: if (!control._destroying) Qt.callLater(control._notifyAvailability)
    onEnabledChanged: if (!control._destroying) Qt.callLater(control._notifyAvailability)
    onWidthChanged: if (!control._destroying) Qt.callLater(control._notifyGeometry)
    onCheckedChanged: if (!control._destroying && checked) Qt.callLater(control._notifyGeometry)
    Component.onDestruction: control._destroying = true

    Keys.priority: Keys.BeforeItem
    Keys.onPressed: event => {
        if (event.isAutoRepeat && (event.key === Qt.Key_Space
                || event.key === Qt.Key_Return || event.key === Qt.Key_Enter)) {
            event.accepted = true;
            return;
        }
        if (_tabBar)
            _tabBar._handleNavigation(event);
    }
    Keys.onReleased: event => {
        if (event.isAutoRepeat && (event.key === Qt.Key_Space
                || event.key === Qt.Key_Return || event.key === Qt.Key_Enter))
            event.accepted = true;
    }

    P.TabKeyBridge { target: control }

    FontMetrics { id: fontMetrics; font: control.font }

    contentItem: Internal.TabContent {
        id: tabContent
        text: control.text
        iconName: control.icon.name
        iconSource: control.icon.source
        iconWidth: control.icon.width
        iconHeight: control.icon.height
        iconColor: control.icon.color.a > 0 ? control.icon.color : control.contentColor
        contentColor: control.contentColor
        textFont: control.font
        textLineHeight: Math.max(control.typescale.lineHeight, fontMetrics.height)
        showIcon: control._showIcon
        showText: control._showText
        stacked: control._stacked
        layoutMirrored: control.mirrored
        tintSourceIcon: control.tintSourceIcon
        maximumLineCount: control.maximumLineCount
        showBadge: control._showBadge
        badgeContent: control.badgeContent
        badgeNotification: control.badgeNotification
        badgeVariant: control.badgeVariant
        badgeAccessibleDescription: control.badgeAccessibleDescription
        locale: control.locale
    }

    background: Rectangle {
        color: control.containerColor
        clip: true
        Internal.TabIndicator {
            objectName: "standaloneTabIndicator"
            primary: true
            targetX: (control.width - targetWidth) / 2
            targetWidth: control._primaryIndicatorWidth
            y: control.height - height
            indicatorColor: control.MD.Style.primaryColor
            animationEnabled: false
            visible: !control._tabBar && control.checked
            z: 1
        }
        Internal.Ripple {
            objectName: "tabStateLayer"
            anchors.fill: parent
            pressed: control.pressed || control.down
            pressX: control.pressX
            pressY: control.pressY
            stateOpacity: control._stateOpacity
            color: control.stateLayerColor
        }
    }
}
