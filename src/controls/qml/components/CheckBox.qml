// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

T.CheckBox {
    id: control

    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    property bool error: false

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding, implicitIndicatorHeight + topPadding + bottomPadding)

    spacing: MD.Tokens.spacingSmall
    padding: MD.Tokens.spacingSmall
    verticalPadding: padding + 7

    hoverEnabled: true

    QtObject {
        id: state

        property color iconColor: control.error ? control.MD.Style.onErrorColor : control.MD.Style.onPrimaryColor
        property color containerColor: control.checkState === Qt.Unchecked ? "transparent" : control.error ? control.MD.Style.errorColor : control.MD.Style.primaryColor
        property color outlineColor: control.error ? control.MD.Style.errorColor : MD.Style.onSurfaceVariantColor
        property color labelColor: control.MD.Style.onSurfaceColor
        property color stateLayerColor: "transparent"

        property real outlineWidth: control.checkState == Qt.Checked ? 0 : 2

        property real contentOpacity: 1.0
        property real containerOpacity: 1.0
        property real stateLayerOpacity: 1.0
    }

    states: [
        State {
            name: "disabled"
            when: !control.enabled

            PropertyChanges {
                target: state
                iconColor: control.MD.Style.surfaceColor
                containerColor: control.checkState === Qt.Unchecked ? "transparent" : control.error ? control.MD.Style.errorColor : control.MD.Style.onSurfaceColor
                outlineColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : control.MD.Style.onSurfaceColor
                outlineWidth: control.checkState == Qt.Checked ? 0 : 2
                contentOpacity: 0.38
                containerOpacity: 0.38
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                target: state
                outlineColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : control.MD.Style.onSurfaceColor
                stateLayerColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
                stateLayerOpacity: 0.08
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                target: state
                outlineColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : control.MD.Style.onSurfaceColor
                stateLayerColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
                stateLayerOpacity: 0.1
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                target: state
                outlineColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? MD.Style.onSurfaceVariantColor : control.MD.Style.onSurfaceColor
                stateLayerColor: control.error ? control.MD.Style.errorColor : control.checkState === Qt.Checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
                stateLayerOpacity: 0.1
            }
        }
    ]

    indicator: MD.CheckIndicator {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        control: control
        color: state.iconColor
        opacity: state.containerOpacity
        backgroundColor: state.containerColor
        outlineColor: state.outlineColor
        outlineWidth: state.outlineWidth

        MD.Ripple {
            anchors.centerIn: parent
            width: 40
            height: 40
            radius: 20
            pressX: control.pressX
            pressY: control.pressY
            pressed: control.pressed
            stateOpacity: state.stateLayerOpacity
            color: state.stateLayerColor
        }
    }

    contentItem: MD.Label {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        typescale: control.typescale
        color: state.labelColor
        opacity: state.contentOpacity
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
