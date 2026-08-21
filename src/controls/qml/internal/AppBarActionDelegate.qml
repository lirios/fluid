// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class AppBarActionDelegate
    \internal
    \brief Presents an AppBarAction as an interactive app-bar control.

    Icon and avatar presentations use IconButton so they share Material sizing,
    focus, ripple, checked-state, and accessibility behavior. Filled actions use
    a text-capable tool button. The wrapper preserves a uniform interface for
    adaptive measurement and click forwarding.

    The delegate implements presentation details for the
    <a href="https://m3.material.io/components/app-bars/overview">Material Design 3 app bar guidelines</a>
    and is not part of the public QML API.
*/
Item {
    id: control

    //! The action represented by this delegate.
    required property MD.AppBarAction actionData

    //! Foreground color for icon and avatar presentations.
    property color contentColor: MD.Style.onSurfaceVariantColor

    //! Container color for the filled-button presentation.
    property color filledContainerColor: MD.Style.primaryColor

    //! Foreground color for the filled-button presentation.
    property color filledContentColor: MD.Style.onPrimaryColor

    //! Whether the action uses the filled-button presentation.
    readonly property bool isFilled: actionData !== null && actionData.presentation === MD.AppBarAction.FilledButton

    //! Whether the action uses the avatar presentation.
    readonly property bool isAvatar: actionData !== null && actionData.presentation === MD.AppBarAction.Avatar

    //! \internal The currently instantiated interactive control.
    readonly property Item loadedAction: actionLoader.item as Item

    //! Forwarded when the instantiated action control is clicked.
    signal clicked

    implicitWidth: loadedAction ? loadedAction.implicitWidth : MD.Tokens.appBar.minimumInteractiveSize
    implicitHeight: loadedAction ? loadedAction.implicitHeight : MD.Tokens.appBar.minimumInteractiveSize
    width: implicitWidth
    height: implicitHeight

    Loader {
        id: actionLoader

        anchors.fill: parent
        // sourceComponent: control.isFilled
        //     ? filledButtonComponent
        //     : control.isAvatar
        //         ? avatarButtonComponent
        //         : iconButtonComponent
        sourceComponent: control.isAvatar ? avatarButtonComponent : iconButtonComponent
    }

    Component {
        id: iconButtonComponent

        MD.IconButton {
            action: control.actionData
            type: control.isFilled ? MD.IconButton.Type.Filled : MD.IconButton.Type.Standard
            shape: MD.IconButton.Shape.Round
            size: MD.IconButton.Size.Small
            contentColor: control.contentColor
            disabledContentColor: control.contentColor

            onClicked: control.clicked()
        }
    }

    Component {
        id: avatarButtonComponent

        MD.IconButton {
            id: avatarButton

            action: control.actionData
            type: MD.IconButton.Type.Standard
            shape: MD.IconButton.Shape.Round
            size: MD.IconButton.Size.Small
            contentColor: control.contentColor
            disabledContentColor: control.contentColor

            onClicked: control.clicked()

            contentItem: Item {
                opacity: avatarButton.effectiveContentOpacity

                Rectangle {
                    anchors.centerIn: parent
                    width: MD.Tokens.appBar.searchAvatarSize
                    height: width
                    radius: MD.Tokens.cornerRadiusFull
                    clip: true
                    color: control.MD.Style.surfaceContainerHighestColor

                    Image {
                        anchors.fill: parent
                        source: control.actionData.icon.source
                        fillMode: Image.PreserveAspectCrop
                        visible: source.toString().length > 0
                    }

                    MD.Symbol {
                        anchors.centerIn: parent
                        name: control.actionData.icon.name
                        iconWidth: MD.Tokens.appBar.iconSize
                        iconHeight: MD.Tokens.appBar.iconSize
                        color: avatarButton.effectiveContentColor
                        visible: control.actionData.icon.source.toString().length === 0
                    }
                }
            }
        }
    }

    Component {
        id: filledButtonComponent

        T.ToolButton {
            id: filledButton

            action: control.actionData
            hoverEnabled: true
            focusPolicy: Qt.StrongFocus
            padding: 0
            spacing: MD.Tokens.appBar.searchIconLabelGap

            implicitWidth: Math.max(MD.Tokens.appBar.minimumInteractiveSize, filledContent.implicitWidth + MD.Tokens.appBar.titleInset * 2)
            implicitHeight: MD.Tokens.appBar.minimumInteractiveSize
            opacity: enabled ? 1 : MD.Tokens.appBar.disabledContentOpacity

            onClicked: control.clicked()

            contentItem: Row {
                id: filledContent

                spacing: filledButton.spacing

                MD.Symbol {
                    anchors.verticalCenter: parent.verticalCenter
                    name: control.actionData.icon.name
                    iconWidth: MD.Tokens.appBar.iconSize
                    iconHeight: MD.Tokens.appBar.iconSize
                    width: visible ? iconWidth : 0
                    height: iconHeight
                    color: control.filledContentColor
                    fill: filledButton.checked
                    visible: name.length > 0
                }

                MD.Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: control.actionData.text
                    typescale: MD.Tokens.typescale.labelLarge
                    color: control.filledContentColor
                }
            }

            background: Rectangle {
                implicitWidth: filledButton.implicitWidth
                implicitHeight: filledButton.implicitHeight
                radius: MD.Tokens.cornerRadiusFull
                color: control.filledContainerColor

                MD.Ripple {
                    anchors.fill: parent
                    radius: parent.radius
                    pressed: filledButton.pressed
                    pressX: filledButton.pressX
                    pressY: filledButton.pressY
                    color: control.filledContentColor
                    stateOpacity: filledButton.pressed ? MD.Tokens.appBar.pressedStateLayerOpacity : filledButton.visualFocus ? MD.Tokens.appBar.focusStateLayerOpacity : filledButton.hovered ? MD.Tokens.appBar.hoverStateLayerOpacity : 0
                }
            }
        }
    }
}
