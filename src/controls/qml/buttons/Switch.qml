// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import Fluid.Private as P
import "../core/UiMetrics.js" as UiMetrics

T.Switch {
    id: control

    /*!
        \brief Defines which icons are shown on the handle.
    */
    enum IconConfiguration {
        //! No icons are shown (default).
        NoIcons,
        //! An icon is shown only when the switch is selected.
        SelectedIcon,
        //! Icons are shown both when selected and unselected.
        BothIcons
    }

    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    /*!
        \brief Controls whether icons appear on the handle.

        \sa MD.Switch.IconConfiguration
    */
    property int iconConfiguration: Switch.IconConfiguration.NoIcons

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding, implicitIndicatorHeight + topPadding + bottomPadding)

    padding: MD.Tokens.spacingSmall
    spacing: MD.Tokens.spacingSmall

    hoverEnabled: true

    indicator: Item {
        implicitWidth: 52
        implicitHeight: 32

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        QtObject {
            id: indicatorState

            // Track
            property color trackColor: {
                if (!control.enabled)
                    return control.checked ? control.MD.Style.onSurfaceColor : control.MD.Style.surfaceContainerHighestColor;
                return control.checked ? control.MD.Style.primaryColor : control.MD.Style.surfaceContainerHighestColor;
            }
            property real trackOpacity: control.enabled ? 1.0 : 0.12
            property real borderWidth: control.checked ? 0 : 2
            property color borderColor: control.enabled ? control.MD.Style.outlineColor : control.MD.Style.onSurfaceColor

            // Handle
            property color handleColor: {
                if (!control.enabled)
                    return control.checked ? control.MD.Style.surfaceColor : control.MD.Style.onSurfaceColor;
                if (control.checked)
                    return control.MD.Style.onPrimaryColor;
                return control.iconConfiguration === Switch.IconConfiguration.BothIcons ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.outlineColor;
            }
            property real handleSize: control.pressed ? 28 : (control.checked ? 24 : (control.iconConfiguration === Switch.IconConfiguration.BothIcons ? 24 : 16))
            property real handleOpacity: (!control.enabled && !control.checked) ? 0.38 : 1.0

            // Icon
            property bool showIcon: control.iconConfiguration === Switch.IconConfiguration.BothIcons || (control.iconConfiguration === Switch.IconConfiguration.SelectedIcon && control.checked)
            property string iconName: {
                if (control.checked)
                    return control.icon.name.length > 0 ? control.icon.name : "check";
                if (control.iconConfiguration === Switch.IconConfiguration.BothIcons)
                    return "close";
                // SelectedIcon + unselected: keep the check name while fading out
                return control.icon.name.length > 0 ? control.icon.name : "check";
            }
            property color iconColor: control.checked ? control.MD.Style.primaryColor : control.MD.Style.surfaceContainerHighestColor

            // State layer
            property color stateLayerColor: control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor
            property real stateLayerOpacity: 0
        }

        states: [
            State {
                name: "hovered"
                when: control.hovered && control.enabled && !control.pressed
                PropertyChanges {
                    indicatorState.stateLayerOpacity: 0.08
                }
            },
            State {
                name: "focused"
                when: control.visualFocus && control.enabled && !control.pressed
                PropertyChanges {
                    indicatorState.stateLayerOpacity: 0.1
                }
            },
            State {
                name: "pressed"
                when: control.pressed && control.enabled
                PropertyChanges {
                    indicatorState.stateLayerOpacity: 0.1
                }
            }
        ]

        // Track
        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: indicatorState.trackColor
            opacity: indicatorState.trackOpacity
            border.width: indicatorState.borderWidth
            border.color: indicatorState.borderColor

            Behavior on color {
                ColorAnimation {
                    duration: MD.Tokens.durationShort2
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: MD.Tokens.durationShort2
                }
            }
            Behavior on border.width {
                NumberAnimation {
                    duration: MD.Tokens.durationShort2
                }
            }
        }

        // State layer + handle, in a 40dp container centered on the handle position
        // Handle center: 16dp from left (unchecked) or 36dp from left (checked)
        // Container x = handleCenter - 20
        Item {
            id: handleArea
            width: 40
            height: 40
            y: (parent.height - height) / 2
            x: control.checked ? 16 : -4

            Behavior on x {
                NumberAnimation {
                    easing: MD.Tokens.spring.expressiveFastSpatial.easing
                    duration: MD.Tokens.spring.expressiveFastSpatial.duration
                }
            }

            MD.Ripple {
                anchors.fill: parent
                radius: width / 2
                pressed: control.pressed
                pressX: width / 2
                pressY: height / 2
                stateOpacity: indicatorState.stateLayerOpacity
                color: indicatorState.stateLayerColor
            }

            Rectangle {
                anchors.centerIn: parent
                width: indicatorState.handleSize
                height: width
                radius: width / 2
                color: indicatorState.handleColor
                opacity: indicatorState.handleOpacity

                Behavior on width {
                    NumberAnimation {
                        easing: MD.Tokens.spring.expressiveFastSpatial.easing
                        duration: MD.Tokens.spring.expressiveFastSpatial.duration
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: MD.Tokens.durationShort2
                    }
                }

                MD.Symbol {
                    anchors.centerIn: parent
                    iconWidth: 16
                    iconHeight: 16
                    name: indicatorState.iconName
                    color: indicatorState.iconColor
                    opacity: indicatorState.showIcon ? 1.0 : 0.0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: MD.Tokens.durationShort2
                        }
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: MD.Tokens.durationShort2
                        }
                    }
                }
            }
        }
    }

    contentItem: MD.Label {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        typescale: control.typescale
        color: control.enabled ? control.MD.Style.onSurfaceColor : control.MD.Style.onSurfaceVariantColor
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
