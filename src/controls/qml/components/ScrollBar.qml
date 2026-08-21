// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class ScrollBar
    \brief An interactive scrollbar styled for the current Material 3 theme.

    ScrollBar expands when hovered or pressed and fades after scrolling stops.
    It supports horizontal and vertical orientations and the inherited policies.

    For more information see the
    <a href="https://m3.material.io/components/scrollbar/overview">Material Design 3 scrollbar guidelines</a>.
*/
T.ScrollBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    padding: control.interactive ? 1 : 2

    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    interactive: hovered || pressed

    visible: control.policy !== T.ScrollBar.AlwaysOff

    contentItem: Rectangle {
        implicitWidth: control.interactive ? 6 : 2
        implicitHeight: control.interactive ? 6 : 2

        color: MD.Utils.transparent(control.MD.Style.onSurfaceColor, control.pressed ? 0.8 : 0.38)
        radius: control.orientation === Qt.Horizontal ? height / 2.0 : width / 2.0
        opacity: 0.0
    }

    background: Rectangle {
        implicitWidth: control.interactive ? 4 : 2
        implicitHeight: control.interactive ? 4 : 2

        color: MD.Utils.transparent(control.MD.Style.onSurfaceColor, 0.12)
        radius: control.orientation === Qt.Horizontal ? height / 2.0 : width / 2.0
        opacity: 0.0
        visible: control.interactive
    }

    states: [
        State {
            name: "active"
            when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
        }
    ]

    transitions: [
        Transition {
            to: "active"

            NumberAnimation {
                targets: [control.contentItem, control.background]
                property: "opacity"
                to: 1.0
            }
        },
        Transition {
            from: "active"

            SequentialAnimation {
                PropertyAction {
                    targets: [control.contentItem, control.background]
                    property: "opacity"
                    value: 1.0
                }
                PauseAnimation {
                    duration: 2450
                }
                NumberAnimation {
                    targets: [control.contentItem, control.background]
                    property: "opacity"
                    to: 0.0
                }
            }
        }
    ]
}
