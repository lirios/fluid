// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class CheckBox
    \brief A Material 3 checkbox for independent or grouped selections.

    CheckBox supports checked, unchecked, and partially checked states. Set \c error
    when the current selection is invalid and provide a short label through \c text.

    For more information see the
    <a href="https://m3.material.io/components/checkbox/overview">Material Design 3 checkbox guidelines</a>.
*/
T.CheckBox {
    id: rootControl

    //! The Material type scale used by the checkbox label.
    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    //! Whether the checkbox is displayed in its error state.
    property bool error: false

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding, implicitIndicatorHeight + topPadding + bottomPadding)

    spacing: MD.Tokens.checkBox.contentSpacing
    padding: MD.Tokens.checkBox.contentPadding
    verticalPadding: padding + 7

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    QtObject {
        id: visualState

        property color iconColor: rootControl.error ? rootControl.MD.Style.onErrorColor : rootControl.MD.Style.onPrimaryColor
        property color containerColor: rootControl.checkState === Qt.Unchecked ? "transparent" : rootControl.error ? rootControl.MD.Style.errorColor : rootControl.MD.Style.primaryColor
        property color outlineColor: rootControl.error ? rootControl.MD.Style.errorColor : MD.Style.onSurfaceVariantColor
        property color labelColor: rootControl.MD.Style.onSurfaceColor
        property color stateLayerColor: "transparent"

        property real outlineWidth: rootControl.checkState == Qt.Checked ? MD.Tokens.checkBox.selectedOutlineWidth : MD.Tokens.checkBox.unselectedOutlineWidth

        property real contentOpacity: 1.0
        property real containerOpacity: 1.0
        property real stateLayerOpacity: 1.0
    }

    states: [
        State {
            name: "disabled"
            when: !rootControl.enabled

            PropertyChanges {
                visualState.iconColor: rootControl.MD.Style.surfaceColor
                visualState.containerColor: rootControl.checkState === Qt.Unchecked ? "transparent" : rootControl.error ? rootControl.MD.Style.errorColor : rootControl.MD.Style.onSurfaceColor
                visualState.outlineColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : rootControl.MD.Style.onSurfaceColor
                visualState.outlineWidth: rootControl.checkState == Qt.Checked ? MD.Tokens.checkBox.selectedOutlineWidth : MD.Tokens.checkBox.unselectedOutlineWidth
                visualState.contentOpacity: MD.Tokens.checkBox.selectedDisabledContainerOpacity
                visualState.containerOpacity: MD.Tokens.checkBox.selectedDisabledContainerOpacity
            }
        },
        State {
            name: "hovered"
            when: rootControl.hovered && rootControl.enabled

            PropertyChanges {
                visualState.outlineColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? rootControl.MD.Style.primaryColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.checkBox.hoverStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: rootControl.visualFocus && rootControl.enabled

            PropertyChanges {
                visualState.outlineColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? rootControl.MD.Style.primaryColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.checkBox.focusStateLayerOpacity
            }
        },
        State {
            name: "pressed"
            when: rootControl.down && rootControl.enabled

            PropertyChanges {
                visualState.outlineColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.error ? rootControl.MD.Style.errorColor : rootControl.checkState === Qt.Checked ? rootControl.MD.Style.primaryColor : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.checkBox.pressedStateLayerOpacity
            }
        }
    ]

    indicator: MD.CheckIndicator {
        x: rootControl.text ? (rootControl.mirrored ? rootControl.width - width - rootControl.rightPadding : rootControl.leftPadding) : rootControl.leftPadding + (rootControl.availableWidth - width) / 2
        y: rootControl.topPadding + (rootControl.availableHeight - height) / 2

        control: rootControl
        color: visualState.iconColor
        opacity: visualState.containerOpacity
        backgroundColor: visualState.containerColor
        outlineColor: visualState.outlineColor
        outlineWidth: visualState.outlineWidth

        MD.Ripple {
            anchors.centerIn: parent
            width: MD.Tokens.checkBox.stateLayerSize
            height: MD.Tokens.checkBox.stateLayerSize
            radius: width / 2
            pressX: rootControl.pressX
            pressY: rootControl.pressY
            pressed: rootControl.pressed
            stateOpacity: visualState.stateLayerOpacity
            color: visualState.stateLayerColor
        }
    }

    contentItem: MD.Label {
        leftPadding: rootControl.indicator && !rootControl.mirrored ? rootControl.indicator.width + rootControl.spacing : 0
        rightPadding: rootControl.indicator && rootControl.mirrored ? rootControl.indicator.width + rootControl.spacing : 0

        text: rootControl.text
        typescale: rootControl.typescale
        color: visualState.labelColor
        opacity: visualState.contentOpacity
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
