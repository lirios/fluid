// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class RadioButton
    \brief A Material 3 radio button for selecting one option from a set.

    RadioButton inherits the Qt Quick Templates radio-button API, including
    \c text, \c checked, \c autoExclusive, and ButtonGroup integration.
    Sibling radio buttons are mutually exclusive by default; use ButtonGroup
    when the choices do not share the same visual parent.

    For more information see the
    <a href="https://m3.material.io/components/radio-button/overview">Material Design 3 radio-button guidelines</a>.

    \sa RadioIndicator
*/
T.RadioButton {
    id: control

    Accessible.role: Accessible.RadioButton
    Accessible.name: text
    Accessible.checkable: true
    Accessible.checked: checked
    Accessible.focusable: enabled && focusPolicy !== Qt.NoFocus
    Accessible.focused: activeFocus
    Accessible.pressed: down
    Accessible.onPressAction: {
        if (control.enabled)
            control.click();
    }

    //! The Material type scale used by the radio-button label.
    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    implicitWidth: Math.max(MD.Tokens.radioButton.minimumInteractiveSize,
                            implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(MD.Tokens.radioButton.minimumInteractiveSize,
                             implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: MD.Tokens.radioButton.contentPadding
    spacing: MD.Tokens.radioButton.contentSpacing

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    QtObject {
        id: state

        property color iconColor: control.checked ? control.MD.Style.primaryColor
                                                  : control.MD.Style.onSurfaceVariantColor
        property color labelColor: control.MD.Style.onSurfaceColor
        property color stateLayerColor: "transparent"

        property real iconOpacity: 1.0
        property real contentOpacity: 1.0
        property real stateLayerOpacity: 0.0
    }

    states: [
        State {
            name: "disabled"
            when: !control.enabled

            PropertyChanges {
                state.iconColor: control.MD.Style.onSurfaceColor
                state.iconOpacity: control.checked
                                   ? MD.Tokens.radioButton.selectedDisabledIconOpacity
                                   : MD.Tokens.radioButton.unselectedDisabledIconOpacity
                state.contentOpacity: MD.Tokens.radioButton.unselectedDisabledIconOpacity
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled && !control.down

            PropertyChanges {
                state.iconColor: control.checked ? control.MD.Style.primaryColor
                                                 : control.MD.Style.onSurfaceColor
                state.stateLayerColor: control.checked ? control.MD.Style.primaryColor
                                                       : control.MD.Style.onSurfaceColor
                state.stateLayerOpacity: MD.Tokens.radioButton.hoverStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled && !control.down

            PropertyChanges {
                state.iconColor: control.checked ? control.MD.Style.primaryColor
                                                 : control.MD.Style.onSurfaceColor
                state.stateLayerColor: control.checked ? control.MD.Style.primaryColor
                                                       : control.MD.Style.onSurfaceColor
                state.stateLayerOpacity: MD.Tokens.radioButton.focusStateLayerOpacity
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state.iconColor: control.checked ? control.MD.Style.primaryColor
                                                 : control.MD.Style.onSurfaceColor
                state.stateLayerColor: control.checked ? control.MD.Style.primaryColor
                                                       : control.MD.Style.onSurfaceColor
                state.stateLayerOpacity: MD.Tokens.radioButton.pressedStateLayerOpacity
            }
        }
    ]

    indicator: MD.RadioIndicator {
        id: radioIndicator

        x: control.text
           ? (control.mirrored ? control.width - width - control.rightPadding
                               : control.leftPadding)
           : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        control: control
        color: state.iconColor
        opacity: state.iconOpacity

        MD.Ripple {
            objectName: "radioStateLayer"
            anchors.centerIn: parent
            width: MD.Tokens.radioButton.stateLayerSize
            height: width
            radius: width / 2
            pressX: width / 2
            pressY: height / 2
            pressed: control.pressed
            stateOpacity: state.stateLayerOpacity
            color: state.stateLayerColor
        }
    }

    contentItem: MD.Label {
        Accessible.ignored: true

        leftPadding: control.indicator && !control.mirrored
                     ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored
                      ? control.indicator.width + control.spacing : 0

        text: control.text
        typescale: control.typescale
        color: state.labelColor
        opacity: state.contentOpacity
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
