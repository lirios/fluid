// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtQuick.Templates as T
import Fluid as MD
import "../internal"
import "../core/UiMetrics.js" as UiMetrics

/*!
    \class SplitButton
    \brief A primary action paired with an independent menu trigger.

    SplitButton supports Filled, Tonal, Elevated and Outlined appearances and
    ExtraSmall, Small, Medium, Large and ExtraLarge sizes. Set \c type and \c size
    to select them; the defaults are Filled and Small. The primary action accepts
    label-only, icon-only and combined content through \c text, the native \c icon
    group and \c display. Icons support Material symbol names and image sources.
    The \c action alias uses the native template, and each activation emits
    \c clicked once. The caller can override the size-specific \c typescale.

    \c primaryEnabled and \c secondaryEnabled control the two actions independently
    and combine with the outer control's enabled state. Primary action enabled
    state is also respected. The two templates expose separate accessible targets
    and keyboard focus stops, in logical primary-then-secondary order in RTL.
    The read-only \c leadingButton and \c trailingButton references support focus,
    accessible-name overrides and popup anchoring. The secondary accessible name
    comes from \c secondaryText, which defaults to translated "More options".

    Attach a \ref Menu through \c menu to let the control manage placement,
    expansion and focus restoration. Secondary activation emits
    \c secondaryClicked before toggling that menu. Writing \c expanded requests
    opening or closing; external menu opening and dismissal synchronize it.
    \c openMenu(), \c closeMenu() and \c toggleMenu() operate on the attached menu.
    Replacing or destroying a menu clears its managed state, and disabling or
    hiding the control, or disabling its secondary action, closes it.

    \code{.qml}
    import Fluid as MD

    MD.SplitButton {
        text: qsTr("Save")
        icon.name: MD.Symbols.save
        secondaryText: qsTr("More save options")

        onClicked: saveDocument()

        menu: MD.Menu {
            MD.Action {
                text: qsTr("Save as")
                onTriggered: saveDocumentAs()
            }
            MD.Action {
                text: qsTr("Export")
                onTriggered: exportDocument()
            }
        }
    }
    \endcode

    Without an attached menu, secondary activation only emits
    \c secondaryClicked, and the menu methods do nothing. The application owns a
    custom popup's lifecycle and keeps \c expanded synchronized by binding it to
    the popup's visible state. This binding also updates the structured expanded
    accessibility state of the secondary template. The following example anchors
    the popup to \c trailingButton and measures the token-defined gap from the
    visible surface rather than the taller interaction target:

    \code{.qml}
    import QtQuick
    import QtQuick.Controls as C
    import Fluid as MD

    Item {
        MD.SplitButton {
            id: filterButton

            text: qsTr("Filter")
            secondaryText: qsTr("Filter options")
            expanded: filterPopup.visible
            onSecondaryClicked: filterPopup.visible ? filterPopup.close() : filterPopup.open()
        }

        C.Popup {
            id: filterPopup

            parent: filterButton.trailingButton
            focus: true
            closePolicy: C.Popup.CloseOnEscape | C.Popup.CloseOnPressOutsideParent
            onAboutToShow: {
                x = filterButton.mirrored || filterButton.locale.textDirection === Qt.RightToLeft
                    ? filterButton.trailingButton.width - width : 0
                y = filterButton.trailingButton.background.y + filterButton.trailingButton.background.height
                    + MD.Tokens.splitButton.menuAnchorGap
            }

            contentItem: MD.Label { text: qsTr("Filter options") }
        }
    }
    \endcode

    An icon-only primary action needs a meaningful accessible name on
    \c leadingButton. The outer container is ignored by accessibility, so its
    accessible name does not label either action. This example installs a
    translated name binding while keeping the visible primary content icon-only:

    \code{.qml}
    import QtQuick
    import QtQuick.Templates as T
    import Fluid as MD

    MD.SplitButton {
        icon.name: MD.Symbols.save
        display: T.AbstractButton.IconOnly
        secondaryText: qsTr("More save options")
        Component.onCompleted: leadingButton.Accessible.name = Qt.binding(() => qsTr("Save"))
    }
    \endcode

    Each action has a minimum 48 by 48 dp interaction target. ExtraSmall and Small
    surfaces are centered vertically inside those targets. Additional height
    enlarges the interaction area while the selected size retains its visible
    surface height. Extra width grows the primary part. Constrained width elides
    its label and preserves the trailing part's preferred width; an allocation
    below the combined 48 dp targets and 2 dp separator cannot satisfy both
    minimum targets. Large sizes may require more width for their trailing part.

    See <a href="https://m3.material.io/components/split-button/overview">Material 3
    split-button guidelines</a>.
*/
T.Control {
    id: control

    enum Type { Filled, Tonal, Elevated, Outlined }
    enum Size { ExtraSmall, Small, Medium, Large, ExtraLarge }

    //! Semantic appearance. Defaults to Filled.
    property int type: SplitButton.Filled
    //! Visible surface size. Defaults to Small.
    property int size: SplitButton.Small
    //! Primary action label.
    property alias text: leading.text
    //! Primary action's native icon group; source and name icons are supported.
    property alias icon: leading.icon
    //! Native primary content display mode. Defaults to TextBesideIcon.
    property alias display: leading.display
    //! Native primary action; activation triggers it exactly once.
    property alias action: leading.action
    //! Caller-overridable typography, selected from common-button tokens by size.
    property MD.typescale typescale: UiMetrics.buttonTypescale(control)
    //! Enables the primary action in combination with control and action state.
    property bool primaryEnabled: true
    //! Enables the menu action in combination with control state.
    property bool secondaryEnabled: true
    //! Optional managed menu. Custom popups can instead bind expanded.
    property T.Menu menu: null
    //! Menu expansion; requests opening/closing when a menu is attached.
    property bool expanded: false
    //! Accessible label of the secondary button.
    property string secondaryText: qsTr("More options")
    //! Native primary template for focus and accessibility customization.
    readonly property T.Button leadingButton: leading
    //! Native secondary template for focus, accessibility and popup anchoring.
    readonly property T.ToolButton trailingButton: trailing

    //! Emitted once per primary activation.
    signal clicked()
    //! Emitted once per secondary activation, before managed menu toggling.
    signal secondaryClicked()

    readonly property string _suffix: ["ExtraSmall", "Small", "Medium", "Large", "ExtraLarge"][Math.max(0, Math.min(4, size))]
    readonly property real _surfaceHeight: MD.Tokens.splitButton["containerHeight" + _suffix]
    readonly property bool _mirrored: mirrored || locale.textDirection === Qt.RightToLeft
    readonly property color _containerColor: type === SplitButton.Filled ? control.MD.Style.primaryColor
        : type === SplitButton.Tonal ? control.MD.Style.secondaryContainerColor
        : type === SplitButton.Elevated ? control.MD.Style.surfaceContainerLowColor : "transparent"
    readonly property color _contentColor: type === SplitButton.Filled ? control.MD.Style.onPrimaryColor
        : type === SplitButton.Tonal ? control.MD.Style.onSecondaryContainerColor
        : type === SplitButton.Elevated ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor
    readonly property color _outlineColor: type === SplitButton.Outlined ? control.MD.Style.outlineVariantColor : "transparent"
    readonly property real _outlineWidth: type === SplitButton.Outlined ? MD.Tokens.button["outlinedOutlineWidth" + _suffix] : 0
    property T.Menu _managedMenu: null
    property bool _hadManagedMenu: false
    property bool _syncingExpanded: false
    property bool _keyboardOpening: false
    property bool _restoreMenuFocus: false
    property bool _menuOwnedFocus: false
    property bool _menuClosing: false
    property bool _reopenMenuAfterClose: false
    property Item _focusBeforeMenu: null
    property Item _closingFocusItem: null
    property Item _outsideMenuFocus: null
    property Item _menuContentItem: null
    property Item _menuPopupItem: null
    property bool _menuOpenBeforePointerPress: false

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: 0
    focusPolicy: Qt.NoFocus
    Accessible.ignored: true

    // Overlay observes a pointer press before CloseOnPressOutside dismisses the menu.
    T.Overlay.onPressed: {
        _menuOpenBeforePointerPress = menu !== null && expanded;
        Qt.callLater(() => control._menuOpenBeforePointerPress = false);
    }

    function _partContainerColor(partEnabled: bool): color {
        return partEnabled ? _containerColor
            : type === SplitButton.Outlined ? "transparent" : control.MD.Style.onSurfaceColor;
    }

    function _partElevation(partEnabled: bool, hovered: bool, down: bool): real {
        if (!partEnabled)
            return MD.Tokens.splitButton.disabledContainerElevation;
        if (type === SplitButton.Outlined)
            return MD.Tokens.splitButton.flatContainerElevation;
        if (type === SplitButton.Elevated)
            return hovered && !down ? MD.Tokens.splitButton.elevatedHoverContainerElevation
                                    : MD.Tokens.splitButton.elevatedContainerElevation;
        return hovered && !down ? MD.Tokens.splitButton.flatHoverContainerElevation
                                : MD.Tokens.splitButton.flatContainerElevation;
    }

    function _syncExpanded(value: bool) {
        _syncingExpanded = true;
        expanded = value;
        _syncingExpanded = false;
    }

    function _insideMenu(item: Item): bool {
        // Menu can already be marked deleted while focus teardown signals arrive.
        // Read the Item references captured at opening instead of touching that Menu.
        const content = control._menuContentItem;
        const container = control._menuPopupItem;
        if (!item || (!content && !container))
            return false;
        let cursor = item;
        while (cursor) {
            if (cursor === content || cursor === container)
                return true;
            cursor = cursor.parent;
        }
        return false;
    }

    function _placeMenu() {
        if (!menu || !control.Window.window)
            return;
        const viewport = control.Window.window.contentItem;
        const anchor = trailing.mapToItem(viewport, 0, 0);
        const whole = control.mapToItem(viewport, 0, 0);
        const menuWidth = menu.width > 0 ? menu.width : menu.implicitWidth;
        const menuHeight = menu.height > 0 ? menu.height : menu.implicitHeight;
        const left = Math.max(0, menu.leftMargin);
        const right = viewport.width - Math.max(0, menu.rightMargin);
        const top = Math.max(0, menu.topMargin);
        const bottom = viewport.height - Math.max(0, menu.bottomMargin);
        const candidates = _mirrored
            ? [anchor.x + trailing.width - menuWidth, anchor.x,
               whole.x + control.width - menuWidth, whole.x]
            : [anchor.x, anchor.x + trailing.width - menuWidth,
               whole.x, whole.x + control.width - menuWidth];
        let chosenX = candidates[0];
        for (let index = 0; index < candidates.length; ++index) {
            if (candidates[index] >= left && candidates[index] + menuWidth <= right) {
                chosenX = candidates[index];
                break;
            }
        }
        chosenX = Math.max(left, Math.min(Math.max(left, right - menuWidth), chosenX));
        const surfaceTop = anchor.y + layout.surfaceY;
        const below = surfaceTop + _surfaceHeight + MD.Tokens.splitButton.menuAnchorGap;
        const above = surfaceTop - MD.Tokens.splitButton.menuAnchorGap - menuHeight;
        const belowSpace = bottom - below;
        const aboveSpace = surfaceTop - MD.Tokens.splitButton.menuAnchorGap - top;
        const preferAbove = belowSpace < menuHeight && (above >= top || aboveSpace > belowSpace);
        const chosenY = preferAbove ? above : below;
        menu.parent = trailing;
        menu.x = chosenX - anchor.x;
        menu.y = chosenY - anchor.y;
    }

    //! Opens the attached menu; does nothing without one or when unavailable.
    function openMenu() {
        if (!menu || !enabled || !visible || !secondaryEnabled)
            return;
        if (_menuClosing && menu.visible) {
            _reopenMenuAfterClose = true;
            _syncExpanded(true);
            return;
        }
        _placeMenu();
        menu.open();
    }

    //! Closes the attached menu; does nothing without one.
    function closeMenu() {
        _reopenMenuAfterClose = false;
        if (menu) {
            _syncExpanded(false);
            menu.close();
        }
    }

    //! Toggles the attached menu; does nothing without one.
    function toggleMenu() {
        if (!menu)
            return;
        if (expanded)
            closeMenu();
        else
            openMenu();
    }

    onExpandedChanged: {
        if (menu && !_syncingExpanded) {
            if (expanded) {
                if (enabled && visible && secondaryEnabled)
                    openMenu();
                else
                    _syncExpanded(false);
            } else {
                closeMenu();
            }
        }
    }
    onMenuChanged: {
        const previous = _managedMenu;
        const hadManagedMenu = _hadManagedMenu;
        _managedMenu = menu;
        _hadManagedMenu = menu !== null;
        _restoreMenuFocus = false;
        _menuOwnedFocus = false;
        _menuClosing = false;
        _reopenMenuAfterClose = false;
        _focusBeforeMenu = null;
        _closingFocusItem = null;
        _outsideMenuFocus = null;
        _menuContentItem = null;
        _menuPopupItem = null;
        if (previous && previous !== menu)
            previous.close();
        if (!hadManagedMenu && menu && expanded)
            openMenu();
        else if (hadManagedMenu || menu)
            _syncExpanded(menu ? menu.visible : false);
    }
    onEnabledChanged: if (!enabled) closeMenu()
    onVisibleChanged: if (!visible) closeMenu()
    onSecondaryEnabledChanged: if (!secondaryEnabled) closeMenu()
    Component.onDestruction: if (_managedMenu) _managedMenu.close()

    Connections {
        target: control.Window.window
        function onActiveFocusItemChanged() {
            const focused = control.Window.window.activeFocusItem;
            if (control._insideMenu(focused)) {
                control._menuOwnedFocus = true;
                control._outsideMenuFocus = null;
            } else if (control._menuClosing) {
                // Qt restores the previous focus with PopupFocusReason or OtherFocusReason.
                // A pointer/keyboard move during dismissal belongs to the user instead.
                const focusedControl = focused as T.Control;
                if (focusedControl && focusedControl.focusReason !== Qt.PopupFocusReason
                                   && focusedControl.focusReason !== Qt.OtherFocusReason) {
                    control._restoreMenuFocus = false;
                    control._outsideMenuFocus = focused;
                }
            } else if (control.expanded) {
                const focusedControl = focused as T.Control;
                if (focusedControl && focusedControl.focusReason !== Qt.PopupFocusReason
                                   && focusedControl.focusReason !== Qt.OtherFocusReason) {
                    control._menuOwnedFocus = false;
                    control._outsideMenuFocus = focused;
                }
                // Popup removes focus before aboutToHide, so defer relinquishing ownership.
                Qt.callLater(() => {
                    if (control.Window.window && control.expanded && !control._menuClosing
                            && !control._insideMenu(control.Window.window.activeFocusItem))
                        control._menuOwnedFocus = false;
                });
            }
        }
    }

    Connections {
        target: control.menu
        function onAboutToShow() {
            control._menuContentItem = control.menu.contentItem;
            control._menuPopupItem = control._menuContentItem ? control._menuContentItem.parent : null;
            control._focusBeforeMenu = control.Window.window ? control.Window.window.activeFocusItem : null;
            control._menuOwnedFocus = false;
            control._menuClosing = false;
            control._reopenMenuAfterClose = false;
            control._restoreMenuFocus = false;
            control._outsideMenuFocus = null;
            control._placeMenu();
            control._syncExpanded(true);
        }
        function onOpened() {
            control._syncExpanded(true);
            if (control._keyboardOpening && control.menu) {
                for (let index = 0; index < control.menu.count; ++index) {
                    const item = control.menu.itemAt(index);
                    if (item && item.enabled && item.visible && item.focusPolicy !== Qt.NoFocus) {
                        control.menu.currentIndex = index;
                        item.forceActiveFocus(Qt.PopupFocusReason);
                        break;
                    }
                }
            }
            control._keyboardOpening = false;
        }
        function onAboutToHide() {
            control._closingFocusItem = control.Window.window ? control.Window.window.activeFocusItem : null;
            control._restoreMenuFocus = control._menuOwnedFocus;
            control._menuClosing = true;
            control._syncExpanded(false);
        }
        function onClosed() {
            if (control._reopenMenuAfterClose) {
                control._reopenMenuAfterClose = false;
                control._menuClosing = false;
                control.openMenu();
                return;
            }
            control._syncExpanded(false);
            Qt.callLater(() => {
                if (!control || (control.menu && control.menu.visible))
                    return;
                const focused = control.Window.window ? control.Window.window.activeFocusItem : null;
                const nativeFallback = !focused || focused === control.Window.window.contentItem
                            || focused === control._focusBeforeMenu
                            || focused === control._closingFocusItem || control._insideMenu(focused);
                if (nativeFallback && control._outsideMenuFocus
                        && control._outsideMenuFocus.enabled && control._outsideMenuFocus.visible)
                    control._outsideMenuFocus.forceActiveFocus(Qt.PopupFocusReason);
                else if (nativeFallback && control._restoreMenuFocus && trailing.enabled && control.visible)
                    trailing.forceActiveFocus(Qt.PopupFocusReason);
                control._restoreMenuFocus = false;
                control._menuOwnedFocus = false;
                control._menuClosing = false;
                control._focusBeforeMenu = null;
                control._closingFocusItem = null;
                control._outsideMenuFocus = null;
            });
        }
    }

    contentItem: SplitButtonLayout {
        id: layout
        objectName: "splitButtonLayout"
        mirrored: control._mirrored
        surfaceHeight: control._surfaceHeight
        minimumTarget: MD.Tokens.measurement.minimumInteractiveSize
        betweenSpace: MD.Tokens.splitButton["betweenSpace" + control._suffix]
        leadingContentWidth: leading.implicitContentWidth
        leadingStartPadding: MD.Tokens.splitButton["leadingButtonLeadingSpace" + control._suffix]
        leadingEndPadding: MD.Tokens.splitButton["leadingButtonTrailingSpace" + control._suffix]
        trailingIconSize: MD.Tokens.splitButton["trailingIconSize" + control._suffix]
        trailingStartPadding: MD.Tokens.splitButton["trailingButtonLeadingSpace" + control._suffix]
        trailingEndPadding: MD.Tokens.splitButton["trailingButtonTrailingSpace" + control._suffix]

        T.Button {
            id: leading
            objectName: "splitButtonLeadingButton"
            x: layout.leadingX
            width: layout.leadingWidth
            height: layout.height
            enabled: control.enabled && control.primaryEnabled && (!action || action.enabled)
            display: T.AbstractButton.TextBesideIcon
            focusPolicy: Qt.StrongFocus
            hoverEnabled: true
            padding: 0
            icon.width: MD.Tokens.button["iconSize" + control._suffix]
            icon.height: MD.Tokens.button["iconSize" + control._suffix]
            font.pixelSize: control.typescale.fontSize
            font.weight: control.typescale.fontWeight
            font.letterSpacing: control.typescale.tracking
            LayoutMirroring.enabled: control._mirrored
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                    event.accepted = true;
            }
            Keys.onReleased: event => {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    event.accepted = true;
                    if (!event.isAutoRepeat)
                        leading.click();
                }
            }
            onClicked: control.clicked()

            contentItem: SplitButtonContent {
                objectName: "splitButtonLeadingContent"
                trailing: false
                mirrored: control._mirrored
                expanded: false
                text: leading.text
                iconName: leading.icon.name
                iconSource: leading.icon.source
                iconWidth: leading.icon.width
                iconHeight: leading.icon.height
                display: leading.display
                textFont: leading.font
                lineHeight: control.typescale.lineHeight
                contentColor: leading.enabled ? control._contentColor : control.MD.Style.onSurfaceVariantColor
                iconColor: leading.enabled && leading.icon.color.a > 0 ? leading.icon.color : contentColor
                contentOpacity: leading.enabled ? 1 : MD.Tokens.button.disabledLabelTextOpacity
                spacing: MD.Tokens.button["iconLabelSpace" + control._suffix]
                startPadding: layout.leadingStartPadding
                endPadding: layout.leadingEndPadding
                opticalOffset: leadingSurface.opticalOffset
            }

            background: SplitButtonBackground {
                id: leadingSurface
                objectName: "splitButtonLeadingBackground"
                y: layout.surfaceY
                width: leading.width
                height: control._surfaceHeight
                leading: true
                mirrored: control._mirrored
                partEnabled: leading.enabled
                hovered: leading.hovered
                focused: leading.visualFocus
                pressed: leading.down
                expanded: false
                restingInnerRadius: MD.Tokens.splitButton["innerCornerCornerSize" + control._suffix]
                hoveredInnerRadius: MD.Tokens.splitButton["innerHoveredCornerCornerSize" + control._suffix]
                pressedInnerRadius: MD.Tokens.splitButton["innerPressedCornerCornerSize" + control._suffix]
                outerShape: MD.Tokens.splitButton.outerCornerShape
                expandedShape: MD.Tokens.splitButton.trailingExpandedInnerCornerShape
                containerColor: control._partContainerColor(leading.enabled)
                contentColor: control._contentColor
                outlineColor: control._outlineColor
                containerOpacity: leading.enabled ? 1 : MD.Tokens.button.disabledContainerOpacity
                outlineWidth: control._outlineWidth
                selectedOpacity: MD.Tokens.splitButton.trailingSelectedStateLayerOpacity
                leadingPadding: layout.leadingStartPadding
                trailingPadding: layout.leadingEndPadding
                opticalCoefficient: MD.Tokens.splitButton.opticalCenteringCoefficient
                elevation: control._partElevation(leading.enabled, leading.hovered, leading.down)
            }
        }

        T.ToolButton {
            id: trailing
            property bool _closeMenuOnActivation: false
            objectName: "splitButtonTrailingButton"
            x: layout.trailingX
            width: layout.trailingWidth
            height: layout.height
            enabled: control.enabled && control.secondaryEnabled
            focusPolicy: Qt.StrongFocus
            hoverEnabled: true
            padding: 0
            LayoutMirroring.enabled: control._mirrored
            Accessible.name: control.secondaryText
            Accessible.expandable: true
            Accessible.expanded: control.expanded
            onPressed: _closeMenuOnActivation = control.menu !== null
                && (control._menuOpenBeforePointerPress || control.expanded)
            onCanceled: _closeMenuOnActivation = false
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Space || event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                    control._keyboardOpening = true;
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                    event.accepted = true;
            }
            Keys.onReleased: event => {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    event.accepted = true;
                    if (!event.isAutoRepeat)
                        trailing.click();
                }
            }
            onClicked: {
                control._keyboardOpening = control._keyboardOpening && trailing.focusReason !== Qt.MouseFocusReason;
                const closeMenu = _closeMenuOnActivation || (control.menu !== null && control.expanded);
                _closeMenuOnActivation = false;
                control.secondaryClicked();
                if (closeMenu)
                    control.closeMenu();
                else
                    control.openMenu();
            }

            contentItem: SplitButtonContent {
                objectName: "splitButtonTrailingContent"
                trailing: true
                mirrored: control._mirrored
                expanded: control.expanded
                text: ""
                iconName: ""
                iconSource: ""
                iconWidth: layout.trailingIconSize
                iconHeight: layout.trailingIconSize
                display: T.AbstractButton.IconOnly
                textFont: leading.font
                lineHeight: control.typescale.lineHeight
                contentColor: trailing.enabled ? control._contentColor : control.MD.Style.onSurfaceVariantColor
                iconColor: contentColor
                contentOpacity: trailing.enabled ? 1 : MD.Tokens.button.disabledIconOpacity
                spacing: 0
                startPadding: layout.trailingStartPadding
                endPadding: layout.trailingEndPadding
                opticalOffset: trailingSurface.opticalOffset
            }

            background: SplitButtonBackground {
                id: trailingSurface
                objectName: "splitButtonTrailingBackground"
                y: layout.surfaceY
                width: trailing.width
                height: control._surfaceHeight
                leading: false
                mirrored: control._mirrored
                partEnabled: trailing.enabled
                hovered: trailing.hovered
                focused: trailing.visualFocus
                pressed: trailing.down
                expanded: control.expanded
                restingInnerRadius: MD.Tokens.splitButton["innerCornerCornerSize" + control._suffix]
                hoveredInnerRadius: MD.Tokens.splitButton["innerHoveredCornerCornerSize" + control._suffix]
                pressedInnerRadius: MD.Tokens.splitButton["innerPressedCornerCornerSize" + control._suffix]
                outerShape: MD.Tokens.splitButton.outerCornerShape
                expandedShape: MD.Tokens.splitButton.trailingExpandedInnerCornerShape
                containerColor: control._partContainerColor(trailing.enabled)
                contentColor: control._contentColor
                outlineColor: control._outlineColor
                containerOpacity: trailing.enabled ? 1 : MD.Tokens.button.disabledContainerOpacity
                outlineWidth: control._outlineWidth
                selectedOpacity: MD.Tokens.splitButton.trailingSelectedStateLayerOpacity
                leadingPadding: layout.trailingStartPadding
                trailingPadding: layout.trailingEndPadding
                opticalCoefficient: MD.Tokens.splitButton.opticalCenteringCoefficient
                elevation: control._partElevation(trailing.enabled, trailing.hovered, trailing.down)
            }
        }
    }
}
