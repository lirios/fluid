// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class ScrollIndicator
    \brief A non-interactive indicator of the visible portion of scrolling content.

    ScrollIndicator follows the current Material 3 surface color and fades after
    activity ends. Use ScrollBar when users must be able to drag the indicator.

    For more information see the
    <a href="https://m3.material.io/components/scrollbar/overview">Material Design 3 scrollbar guidelines</a>.
*/
T.ScrollIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    padding: 2

    contentItem: Rectangle {
        implicitWidth: 4
        implicitHeight: 4

        color: MD.Utils.transparent(control.MD.Style.onSurfaceColor, 0.12)
        visible: control.size < 1.0
        opacity: 0.0

        states: State {
            name: "active"
            when: control.active

            PropertyChanges {
                control.contentItem.opacity: 0.75
            }
        }

        transitions: [
            Transition {
                from: "active"

                SequentialAnimation {
                    PauseAnimation {
                        duration: MD.Tokens.durationLong1
                    }
                    NumberAnimation {
                        target: control.contentItem
                        duration: MD.Tokens.durationShort4
                        property: "opacity"
                        to: 0.0
                    }
                }
            }
        ]
    }
}
