// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Templates as T

/*!
    \class MenuItem
    \brief A Material Design 3 Expressive menu item.

    MenuItem presents an action inside a Menu. It lays out an optional leading
    icon or selection indicator, a text label, shortcut text, and a cascading
    submenu indicator using Material sizing and state layers.

    Checkable items share one stable leading slot between their action icon and
    checkmark, so toggling an item does not move its label. Leading and trailing
    content, text alignment, and submenu direction mirror automatically for
    right-to-left locales.

    Menu creates MenuItem instances for its actions automatically. Applications
    can also use MenuItem when constructing menu content explicitly.
*/
T.MenuItem {
    id: menuItem
    objectName: "menuItem"

    //! \internal Whether the action supplies a Material symbol name.
    readonly property bool _hasNamedIcon: icon.name.length > 0

    //! \internal Whether the action supplies an image source.
    readonly property bool _hasSourceIcon: icon.source.toString().length > 0

    //! \internal Whether the action supplies either supported icon type.
    readonly property bool _hasIcon: _hasNamedIcon || _hasSourceIcon

    //! \internal Whether the leading slot currently presents a checkmark.
    readonly property bool _showsSelectionIndicator: checkable && checked

    //! \internal Whether the associated action supplies shortcut text.
    readonly property bool _hasShortcut: action !== null && action.shortcut !== undefined && action.shortcut.toString().length > 0

    //! \internal Effective foreground color for the text content.
    readonly property color _contentColor: checked ? menuItem.MD.Style.onSecondaryContainerColor : menuItem.MD.Style.onSurfaceColor

    //! \internal Effective foreground color for icon content.
    readonly property color _iconColor: checked ? menuItem.MD.Style.onSecondaryContainerColor : menuItem.MD.Style.onSurfaceVariantColor

    //! \internal Effective opacity for enabled and disabled content.
    readonly property real _contentOpacity: enabled ? 1 : MD.Tokens.menu.disabledContentOpacity

    implicitWidth: Math.max(MD.Tokens.menu.minimumWidth, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(MD.Tokens.menu.itemHeight, implicitContentHeight + topPadding + bottomPadding)

    leftPadding: MD.Tokens.menu.itemHorizontalPadding
    rightPadding: MD.Tokens.menu.itemHorizontalPadding
    topPadding: 0
    bottomPadding: 0
    spacing: MD.Tokens.menu.iconLabelGap
    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    LayoutMirroring.childrenInherit: true

    contentItem: Item {
        id: menuContent

        readonly property int visibleAuxiliaryItems: (iconSlot.visible ? 1 : 0) + (shortcutLabel.visible ? 1 : 0) + (submenuArrow.visible ? 1 : 0)
        readonly property real auxiliaryWidth: (iconSlot.visible ? iconSlot.width : 0) + (shortcutLabel.visible ? shortcutLabel.implicitWidth : 0) + (submenuArrow.visible ? submenuArrow.width : 0)
        readonly property int visibleItemCount: 1 + visibleAuxiliaryItems

        implicitWidth: auxiliaryWidth + label.implicitWidth + Math.max(0, visibleItemCount - 1) * menuItem.spacing
        implicitHeight: MD.Tokens.menu.iconSize

        Row {
            anchors.fill: parent
            spacing: menuItem.spacing
            LayoutMirroring.enabled: menuItem.mirrored
            LayoutMirroring.childrenInherit: true

            Item {
                id: iconSlot
                objectName: "menuItemIcon"

                anchors.verticalCenter: parent.verticalCenter
                width: MD.Tokens.menu.iconSize
                height: MD.Tokens.menu.iconSize
                visible: menuItem._hasIcon || menuItem.checkable

                Item {
                    id: selectionSlot
                    objectName: "menuItemSelection"

                    anchors.fill: parent
                    visible: menuItem._showsSelectionIndicator

                    MD.Symbol {
                        anchors.centerIn: parent
                        name: MD.SymbolNames.symbolCheck
                        iconWidth: MD.Tokens.menu.iconSize
                        iconHeight: MD.Tokens.menu.iconSize
                        color: menuItem._iconColor
                        opacity: menuItem._contentOpacity
                    }
                }

                Image {
                    anchors.fill: parent
                    source: menuItem.icon.source
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: menuItem._contentOpacity
                    visible: menuItem._hasSourceIcon && !menuItem._showsSelectionIndicator
                }

                MD.Symbol {
                    anchors.centerIn: parent
                    name: menuItem.icon.name
                    iconWidth: MD.Tokens.menu.iconSize
                    iconHeight: MD.Tokens.menu.iconSize
                    color: menuItem._iconColor
                    opacity: menuItem._contentOpacity
                    visible: !menuItem._hasSourceIcon && menuItem._hasNamedIcon && !menuItem._showsSelectionIndicator
                }
            }

            MD.Label {
                id: label
                objectName: "menuItemLabel"

                width: Math.max(0, menuContent.width - menuContent.auxiliaryWidth - Math.max(0, menuContent.visibleItemCount - 1) * menuItem.spacing)
                anchors.verticalCenter: parent.verticalCenter
                text: menuItem.text
                typescale: MD.Tokens.typescale.labelLarge
                color: menuItem._contentColor
                opacity: menuItem._contentOpacity
                horizontalAlignment: menuItem.mirrored ? Text.AlignRight : Text.AlignLeft
                elide: Text.ElideRight
            }

            MD.Label {
                id: shortcutLabel
                objectName: "menuItemShortcut"

                anchors.verticalCenter: parent.verticalCenter
                text: menuItem._hasShortcut ? menuItem.action.shortcut.toString() : ""
                typescale: MD.Tokens.typescale.labelLarge
                color: menuItem.MD.Style.onSurfaceVariantColor
                opacity: menuItem._contentOpacity
                visible: menuItem._hasShortcut
            }

            MD.Symbol {
                id: submenuArrow
                objectName: "menuItemSubmenuArrow"

                anchors.verticalCenter: parent.verticalCenter
                name: MD.SymbolNames.symbolChevronRight
                iconWidth: MD.Tokens.menu.iconSize
                iconHeight: MD.Tokens.menu.iconSize
                color: menuItem._iconColor
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
        color: menuItem.checked ? menuItem.MD.Style.secondaryContainerColor : "transparent"

        MD.Ripple {
            anchors.fill: parent
            pressed: menuItem.pressed
            pressX: menuItem.pressX
            pressY: menuItem.pressY
            color: menuItem._contentColor
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
