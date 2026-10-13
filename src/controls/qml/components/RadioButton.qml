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
    id: rootControl

    Accessible.role: Accessible.RadioButton
    Accessible.name: text
    Accessible.checkable: true
    Accessible.checked: checked
    Accessible.focusable: enabled && focusPolicy !== Qt.NoFocus
    Accessible.focused: activeFocus
    Accessible.pressed: down
    Accessible.onPressAction: {
        if (rootControl.enabled)
            rootControl.click();
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
        id: visualState

        property color iconColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                  : rootControl.MD.Style.onSurfaceVariantColor
        property color labelColor: rootControl.MD.Style.onSurfaceColor
        property color stateLayerColor: "transparent"

        property real iconOpacity: 1.0
        property real contentOpacity: 1.0
        property real stateLayerOpacity: 0.0
    }

    states: [
        State {
            name: "disabled"
            when: !rootControl.enabled

            PropertyChanges {
                visualState.iconColor: rootControl.MD.Style.onSurfaceColor
                visualState.iconOpacity: rootControl.checked
                                   ? MD.Tokens.radioButton.selectedDisabledIconOpacity
                                   : MD.Tokens.radioButton.unselectedDisabledIconOpacity
                visualState.contentOpacity: MD.Tokens.radioButton.unselectedDisabledIconOpacity
            }
        },
        State {
            name: "hovered"
            when: rootControl.hovered && rootControl.enabled && !rootControl.down

            PropertyChanges {
                visualState.iconColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                 : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                       : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.radioButton.hoverStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: rootControl.visualFocus && rootControl.enabled && !rootControl.down

            PropertyChanges {
                visualState.iconColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                 : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                       : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.radioButton.focusStateLayerOpacity
            }
        },
        State {
            name: "pressed"
            when: rootControl.down && rootControl.enabled

            PropertyChanges {
                visualState.iconColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                 : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerColor: rootControl.checked ? rootControl.MD.Style.primaryColor
                                                       : rootControl.MD.Style.onSurfaceColor
                visualState.stateLayerOpacity: MD.Tokens.radioButton.pressedStateLayerOpacity
            }
        }
    ]

    indicator: MD.RadioIndicator {
        id: radioIndicator

        x: rootControl.text
           ? (rootControl.mirrored ? rootControl.width - width - rootControl.rightPadding
                               : rootControl.leftPadding)
           : rootControl.leftPadding + (rootControl.availableWidth - width) / 2
        y: rootControl.topPadding + (rootControl.availableHeight - height) / 2

        control: rootControl
        color: visualState.iconColor
        opacity: visualState.iconOpacity

        MD.Ripple {
            objectName: "radioStateLayer"
            anchors.centerIn: parent
            width: MD.Tokens.radioButton.stateLayerSize
            height: width
            radius: width / 2
            pressX: width / 2
            pressY: height / 2
            pressed: rootControl.pressed
            stateOpacity: visualState.stateLayerOpacity
            color: visualState.stateLayerColor
        }
    }

    contentItem: MD.Label {
        Accessible.ignored: true

        leftPadding: rootControl.indicator && !rootControl.mirrored
                     ? rootControl.indicator.width + rootControl.spacing : 0
        rightPadding: rootControl.indicator && rootControl.mirrored
                      ? rootControl.indicator.width + rootControl.spacing : 0

        text: rootControl.text
        typescale: rootControl.typescale
        color: visualState.labelColor
        opacity: visualState.contentOpacity
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
