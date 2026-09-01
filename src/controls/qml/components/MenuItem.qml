// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import QtQuick
import QtQuick.Templates as T

/*!
    \class MenuItem
    \brief A selectable Material Design 3 menu item.

    MenuItem supports Expressive vertical and baseline menu geometry, rich
    leading and trailing content, grouped corner shapes, and logical RTL layout.

    For more information see the
    <a href="https://m3.material.io/components/menus/specs">Material Design 3 menu specification</a>.
*/
T.MenuItem {
    id: menuItem
    objectName: "menuItem"
    readonly property int _menuContentType: 0

    //! Selects the menu-item geometry specification.
    enum Variant {
        //! Material 3 Expressive vertical geometry.
        Vertical,
        //! Original Material 3 baseline geometry.
        Baseline
    }

    //! Selects the semantic menu-item color family.
    enum ColorStyle {
        //! Neutral content with a tertiary-container selection.
        Standard,
        //! Tertiary content with a stronger tertiary selection.
        Vibrant
    }

    //! Identifies the item position in a visually connected group.
    enum GroupPosition {
        //! The item is the only member of its group.
        Only,
        //! The item begins its group.
        First,
        //! The item is between the first and last members.
        Middle,
        //! The item ends its group.
        Last
    }

    //! Geometry specification; defaults to \c MenuItem.Vertical.
    property int variant: MenuItem.Vertical
    //! Semantic color family; defaults to \c MenuItem.Standard.
    property int colorStyle: MenuItem.Standard
    //! Position in a connected group; defaults to \c MenuItem.Only.
    property int groupPosition: MenuItem.Only
    //! Optional secondary line displayed below the inherited \c text.
    property string supportingText: ""
    //! Optional trailing text displayed before shortcut and submenu content.
    property string trailingText: ""
    //! Optional textual badge content displayed in the trailing area.
    property var badgeContent: ""

    //! \internal Whether the action supplies a Material symbol name.
    readonly property bool _hasNamedIcon: icon.name.length > 0
    //! \internal Whether the action supplies an image source.
    readonly property bool _hasSourceIcon: icon.source.toString().length > 0
    //! \internal Whether either supported icon type is present.
    readonly property bool _hasIcon: _hasNamedIcon || _hasSourceIcon
    //! \internal Whether the associated action supplies shortcut text.
    readonly property bool _hasShortcut: action !== null && action.shortcut !== undefined
                                         && action.shortcut.toString().length > 0
    //! \internal Whether badge content is present.
    readonly property bool _hasBadge: badgeContent !== undefined && badgeContent !== null
                                      && badgeContent.toString().length > 0
    //! \internal Whether Expressive vertical geometry is active.
    readonly property bool _vertical: variant === MenuItem.Vertical
    //! \internal Icon size for the active geometry.
    readonly property real _iconSize: _vertical ? MD.Tokens.menu.verticalIconSize
                                                : MD.Tokens.menu.iconSize
    //! \internal Shape selected from the selection and group state.
    readonly property var _containerShape: {
        if (!_vertical)
            return MD.Tokens.shape.cornerNone;
        if (checked)
            return MD.Tokens.menu.verticalSelectedItemShape;
        switch (groupPosition) {
        case MenuItem.First: return MD.Tokens.menu.verticalFirstItemShape;
        case MenuItem.Middle: return MD.Tokens.menu.verticalMiddleItemShape;
        case MenuItem.Last: return MD.Tokens.menu.verticalLastItemShape;
        default: return MD.Tokens.menu.verticalOnlyItemShape;
        }
    }
    //! \internal Foreground color for primary content.
    readonly property color _contentColor: {
        if (!_vertical)
            return checked ? menuItem.MD.Style.onSecondaryContainerColor
                           : menuItem.MD.Style.onSurfaceColor;
        if (colorStyle === MenuItem.Vibrant)
            return checked ? menuItem.MD.Style.onTertiaryColor
                           : menuItem.MD.Style.onTertiaryContainerColor;
        return checked ? menuItem.MD.Style.onTertiaryContainerColor
                       : menuItem.MD.Style.onSurfaceColor;
    }
    //! \internal Foreground color for secondary and icon content.
    readonly property color _secondaryColor: {
        if (checked)
            return _contentColor;
        if (_vertical && colorStyle === MenuItem.Vibrant)
            return menuItem.MD.Style.onTertiaryContainerColor;
        return menuItem.MD.Style.onSurfaceVariantColor;
    }
    //! \internal Opacity for enabled and disabled content.
    readonly property real _contentOpacity: enabled ? 1 : MD.Tokens.menu.disabledContentOpacity

    implicitWidth: Math.max(MD.Tokens.menu.minimumWidth,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: supportingText.length > 0
                    ? Math.max(_vertical ? MD.Tokens.menu.verticalItemHeight
                                         : MD.Tokens.menu.itemHeight,
                               implicitContentHeight + topPadding + bottomPadding)
                    : _vertical ? MD.Tokens.menu.verticalItemHeight : MD.Tokens.menu.itemHeight
    leftPadding: _vertical ? MD.Tokens.menu.verticalItemLeadingSpace
                           : MD.Tokens.menu.itemHorizontalPadding
    rightPadding: _vertical ? MD.Tokens.menu.verticalItemTrailingSpace
                            : MD.Tokens.menu.itemHorizontalPadding
    topPadding: _vertical ? MD.Tokens.menu.verticalItemTopPadding : 0
    bottomPadding: _vertical ? MD.Tokens.menu.verticalItemBottomPadding : 0
    spacing: _vertical ? MD.Tokens.menu.verticalItemBetweenSpace : MD.Tokens.menu.iconLabelGap
    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    LayoutMirroring.childrenInherit: true

    contentItem: Item {
        id: menuContent
        readonly property int auxiliaryCount: (iconSlot.visible ? 1 : 0)
                                              + (trailingLabel.visible ? 1 : 0)
                                              + (badgeLabel.visible ? 1 : 0)
                                              + (shortcutLabel.visible ? 1 : 0)
                                              + (submenuArrow.visible ? 1 : 0)
        readonly property real auxiliaryWidth: (iconSlot.visible ? iconSlot.width : 0)
                                               + (trailingLabel.visible ? trailingLabel.implicitWidth : 0)
                                               + (badgeLabel.visible ? badgeLabel.implicitWidth : 0)
                                               + (shortcutLabel.visible ? shortcutLabel.implicitWidth : 0)
                                               + (submenuArrow.visible ? submenuArrow.width : 0)
        implicitWidth: auxiliaryWidth
                       + Math.max(primaryLabel.implicitWidth, supportingLabel.implicitWidth)
                       + auxiliaryCount * menuItem.spacing
        implicitHeight: Math.max(menuItem._iconSize, labelColumn.implicitHeight)

        Row {
            anchors.fill: parent
            spacing: menuItem.spacing
            LayoutMirroring.enabled: menuItem.mirrored
            LayoutMirroring.childrenInherit: true

            Item {
                id: iconSlot
                objectName: "menuItemIcon"
                anchors.verticalCenter: parent.verticalCenter
                width: menuItem._iconSize
                height: menuItem._iconSize
                visible: menuItem._hasIcon || menuItem.checkable

                MD.Symbol {
                    objectName: "menuItemSelection"
                    anchors.centerIn: parent
                    name: MD.SymbolNames.symbolCheck
                    iconWidth: menuItem._iconSize
                    iconHeight: menuItem._iconSize
                    color: menuItem._secondaryColor
                    opacity: menuItem._contentOpacity
                    visible: menuItem.checked
                }
                Image {
                    anchors.fill: parent
                    source: menuItem.icon.source
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: menuItem._contentOpacity
                    visible: menuItem._hasSourceIcon && !menuItem.checked
                }
                MD.Symbol {
                    anchors.centerIn: parent
                    name: menuItem.icon.name
                    iconWidth: menuItem._iconSize
                    iconHeight: menuItem._iconSize
                    color: menuItem._secondaryColor
                    opacity: menuItem._contentOpacity
                    visible: !menuItem._hasSourceIcon && menuItem._hasNamedIcon && !menuItem.checked
                }
            }

            Column {
                id: labelColumn
                width: Math.max(0, menuContent.width - menuContent.auxiliaryWidth
                                - menuContent.auxiliaryCount * menuItem.spacing)
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0
                MD.Label {
                    id: primaryLabel
                    objectName: "menuItemLabel"
                    width: parent.width
                    text: menuItem.text
                    typescale: MD.Tokens.typescale.labelLarge
                    color: menuItem._contentColor
                    opacity: menuItem._contentOpacity
                    horizontalAlignment: menuItem.mirrored ? Text.AlignRight : Text.AlignLeft
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }
                MD.Label {
                    id: supportingLabel
                    objectName: "menuItemSupportingText"
                    width: parent.width
                    text: menuItem.supportingText
                    typescale: MD.Tokens.typescale.bodySmall
                    color: menuItem._secondaryColor
                    opacity: menuItem._contentOpacity
                    horizontalAlignment: menuItem.mirrored ? Text.AlignRight : Text.AlignLeft
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    visible: text.length > 0
                }
            }

            MD.Label {
                id: trailingLabel
                objectName: "menuItemTrailingText"
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem.trailingText
                typescale: MD.Tokens.typescale.labelLarge
                color: menuItem._secondaryColor
                opacity: menuItem._contentOpacity
                visible: text.length > 0
            }
            MD.Label {
                id: badgeLabel
                objectName: "menuItemBadge"
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem._hasBadge ? menuItem.badgeContent.toString() : ""
                typescale: MD.Tokens.typescale.labelSmall
                color: menuItem._secondaryColor
                opacity: menuItem._contentOpacity
                visible: menuItem._hasBadge
            }
            MD.Label {
                id: shortcutLabel
                objectName: "menuItemShortcut"
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem._hasShortcut ? menuItem.action.shortcut.toString() : ""
                typescale: MD.Tokens.typescale.labelLarge
                color: menuItem._secondaryColor
                opacity: menuItem._contentOpacity
                visible: menuItem._hasShortcut
            }
            MD.Symbol {
                id: submenuArrow
                objectName: "menuItemSubmenuArrow"
                anchors.verticalCenter: parent.verticalCenter
                name: MD.SymbolNames.symbolChevronRight
                iconWidth: menuItem._iconSize
                iconHeight: menuItem._iconSize
                color: menuItem._secondaryColor
                opacity: menuItem._contentOpacity
                visible: menuItem.subMenu !== null
                transform: Scale {
                    origin.x: submenuArrow.width / 2
                    xScale: menuItem.mirrored ? -1 : 1
                }
            }
        }
    }

    background: Rectangle {
        objectName: "menuItemBackground"
        color: {
            if (!menuItem.checked)
                return "transparent";
            if (!menuItem._vertical)
                return menuItem.MD.Style.secondaryContainerColor;
            return menuItem.colorStyle === MenuItem.Vibrant
                    ? menuItem.MD.Style.tertiaryColor
                    : menuItem.MD.Style.tertiaryContainerColor;
        }
        topLeftRadius: UiMetrics.resolveShapeRadius(menuItem._containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(menuItem._containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(menuItem._containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(menuItem._containerShape.bottomRight, width, height)

        MD.Ripple {
            objectName: "menuItemStateLayer"
            anchors.fill: parent
            pressed: menuItem.pressed
            pressX: menuItem.pressX
            pressY: menuItem.pressY
            color: menuItem._contentColor
            topLeftRadius: parent.topLeftRadius
            topRightRadius: parent.topRightRadius
            bottomLeftRadius: parent.bottomLeftRadius
            bottomRightRadius: parent.bottomRightRadius
            stateOpacity: {
                if (!menuItem.enabled)
                    return 0;
                if (menuItem.pressed)
                    return MD.Tokens.menu.pressedStateLayerOpacity;
                if (menuItem.visualFocus || menuItem.highlighted)
                    return MD.Tokens.menu.focusStateLayerOpacity;
                if (menuItem.hovered)
                    return MD.Tokens.menu.hoverStateLayerOpacity;
                return 0;
            }
        }

    }
}
