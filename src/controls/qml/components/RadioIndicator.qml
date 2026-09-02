// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
    \class RadioIndicator
    \brief Draws the Material 3 selected or unselected radio-button indicator.

    RadioIndicator is the visual delegate used by RadioButton. The \c control
    must expose a boolean \c checked property, while \c color supplies the
    resolved color for the current interaction state.

    For more information see the
    <a href="https://m3.material.io/components/radio-button/overview">Material Design 3 radio-button guidelines</a>.

    \sa RadioButton
*/
Item {
    id: indicatorItem
    Accessible.ignored: true

    //! The radio button whose \c checked state is rendered.
    property Item control

    //! The color of the outer ring and selected dot.
    property color color

    implicitWidth: MD.Tokens.radioButton.iconSize
                   + MD.Tokens.radioButton.indicatorPadding * 2
    implicitHeight: MD.Tokens.radioButton.iconSize
                    + MD.Tokens.radioButton.indicatorPadding * 2

    Rectangle {
        id: outerRing

        objectName: "radioOuterRing"
        anchors.centerIn: parent
        width: MD.Tokens.radioButton.iconSize
        height: width
        radius: width / 2
        color: "transparent"
        border.width: MD.Tokens.radioButton.outlineWidth
        border.color: indicatorItem.color

        Behavior on border.color {
            // Disabled color changes must snap rather than animate.
            // qmllint disable missing-property
            enabled: indicatorItem.control && indicatorItem.control.enabled
            // qmllint enable missing-property

            ColorAnimation {
                // qmllint disable unresolved-type
                duration: MD.Tokens.motion.duration.short2
                // qmllint enable unresolved-type
            }
        }

        Rectangle {
            id: selectedDot

            objectName: "radioSelectedDot"
            anchors.centerIn: parent
            // qmllint disable missing-property
            width: indicatorItem.control && indicatorItem.control.checked
                   ? MD.Tokens.radioButton.iconSize / 2 : 0
            // qmllint enable missing-property
            height: width
            radius: width / 2
            color: indicatorItem.color

            Behavior on width {
                NumberAnimation {
                    // qmllint disable unresolved-type
                    duration: MD.Tokens.motion.duration.short2
                    // qmllint enable unresolved-type
                }
            }

            Behavior on color {
                // Disabled color changes must snap rather than animate.
                // qmllint disable missing-property
                enabled: indicatorItem.control && indicatorItem.control.enabled
                // qmllint enable missing-property

                ColorAnimation {
                    // qmllint disable unresolved-type
                    duration: MD.Tokens.motion.duration.short2
                    // qmllint enable unresolved-type
                }
            }
        }
    }
}
