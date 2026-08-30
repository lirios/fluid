// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class Switch
    \brief A Material 3 switch for toggling a setting on or off.

    Switch supports optional selected and unselected handle icons. Set \c text to
    a short label that describes the setting controlled by the switch.

    For more information see the
    <a href="https://m3.material.io/components/switch/overview">Material Design 3 switch guidelines</a>.
*/
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

    //! The Material type scale used by the switch label.
    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    /*!
        \brief Controls whether icons appear on the handle.

        \sa MD.Switch.IconConfiguration
    */
    property int iconConfiguration: Switch.IconConfiguration.NoIcons

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding, implicitIndicatorHeight + topPadding + bottomPadding)

    padding: MD.Tokens.switch.contentPadding
    spacing: MD.Tokens.switch.contentSpacing

    hoverEnabled: true

    indicator: Item {
        implicitWidth: MD.Tokens.switch.trackWidth
        implicitHeight: MD.Tokens.switch.trackHeight

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
            property real trackOpacity: control.enabled ? 1.0 : MD.Tokens.switch.disabledTrackOpacity
            property real borderWidth: control.checked ? 0 : MD.Tokens.switch.trackOutlineWidth
            property color borderColor: control.enabled ? control.MD.Style.outlineColor : control.MD.Style.onSurfaceColor

            // Handle
            property color handleColor: {
                if (!control.enabled)
                    return control.checked ? control.MD.Style.surfaceColor : control.MD.Style.onSurfaceColor;
                if (control.checked)
                    return control.MD.Style.onPrimaryColor;
                return control.iconConfiguration === Switch.IconConfiguration.BothIcons ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.outlineColor;
            }
            property real handleSize: control.pressed ? MD.Tokens.switch.pressedHandleSize : (control.checked ? MD.Tokens.switch.selectedHandleSize : (control.iconConfiguration === Switch.IconConfiguration.BothIcons ? MD.Tokens.switch.withIconHandleSize : MD.Tokens.switch.unselectedHandleSize))
            property real handleOpacity: !control.enabled ? (control.checked ? MD.Tokens.switch.disabledSelectedHandleOpacity : MD.Tokens.switch.disabledUnselectedHandleOpacity) : 1.0

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
                    indicatorState.stateLayerOpacity: MD.Tokens.switch.hoverStateLayerOpacity
                }
            },
            State {
                name: "focused"
                when: control.visualFocus && control.enabled && !control.pressed
                PropertyChanges {
                    indicatorState.stateLayerOpacity: MD.Tokens.switch.focusStateLayerOpacity
                }
            },
            State {
                name: "pressed"
                when: control.pressed && control.enabled
                PropertyChanges {
                    indicatorState.stateLayerOpacity: MD.Tokens.switch.pressedStateLayerOpacity
                }
            }
        ]

        // Track
        Rectangle {
            objectName: "switchTrack"
            anchors.fill: parent
            topLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.switch.trackShape.topLeft,
                                                        width, height)
            topRightRadius: UiMetrics.resolveShapeRadius(MD.Tokens.switch.trackShape.topRight,
                                                         width, height)
            bottomLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.switch.trackShape.bottomLeft,
                                                           width, height)
            bottomRightRadius: UiMetrics.resolveShapeRadius(
                                       MD.Tokens.switch.trackShape.bottomRight, width, height)
            color: indicatorState.trackColor
            opacity: indicatorState.trackOpacity
            border.width: indicatorState.borderWidth
            border.color: indicatorState.borderColor

            Behavior on color {
                ColorAnimation {
                    duration: MD.Tokens.motion.duration.short2
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: MD.Tokens.motion.duration.short2
                }
            }
            Behavior on border.width {
                NumberAnimation {
                    duration: MD.Tokens.motion.duration.short2
                }
            }
        }

        // State layer + handle, in a 40dp container centered on the handle position
        // Handle center: 16dp from left (unchecked) or 36dp from left (checked)
        // Container x = handleCenter - 20
        Item {
            id: handleArea
            width: MD.Tokens.switch.stateLayerSize
            height: MD.Tokens.switch.stateLayerSize
            y: (parent.height - height) / 2
            x: control.checked ? parent.width - parent.height / 2 - width / 2 : parent.height / 2 - width / 2

            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                    duration: MotionAnimation.expressiveFastSpatialDuration
                }
            }

            MD.Ripple {
                objectName: "switchStateLayer"
                anchors.fill: parent
                topLeftRadius: UiMetrics.resolveShapeRadius(
                                       MD.Tokens.switch.stateLayerShape.topLeft, width, height)
                topRightRadius: UiMetrics.resolveShapeRadius(
                                        MD.Tokens.switch.stateLayerShape.topRight, width, height)
                bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                          MD.Tokens.switch.stateLayerShape.bottomLeft, width, height)
                bottomRightRadius: UiMetrics.resolveShapeRadius(
                                           MD.Tokens.switch.stateLayerShape.bottomRight, width,
                                           height)
                pressed: control.pressed
                pressX: width / 2
                pressY: height / 2
                stateOpacity: indicatorState.stateLayerOpacity
                color: indicatorState.stateLayerColor
            }

            Rectangle {
                objectName: "switchHandle"
                anchors.centerIn: parent
                width: indicatorState.handleSize
                height: width
                topLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.switch.handleShape.topLeft,
                                                            width, height)
                topRightRadius: UiMetrics.resolveShapeRadius(MD.Tokens.switch.handleShape.topRight,
                                                             width, height)
                bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                          MD.Tokens.switch.handleShape.bottomLeft, width, height)
                bottomRightRadius: UiMetrics.resolveShapeRadius(
                                           MD.Tokens.switch.handleShape.bottomRight, width, height)
                color: indicatorState.handleColor
                opacity: indicatorState.handleOpacity

                Behavior on width {
                    NumberAnimation {
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                        duration: MotionAnimation.expressiveFastSpatialDuration
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: MD.Tokens.motion.duration.short2
                    }
                }

                MD.Symbol {
                    anchors.centerIn: parent
                    iconWidth: control.checked ? MD.Tokens.switch.selectedIconSize : MD.Tokens.switch.unselectedIconSize
                    iconHeight: iconWidth
                    name: indicatorState.iconName
                    color: indicatorState.iconColor
                    opacity: indicatorState.showIcon ? 1.0 : 0.0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: MD.Tokens.motion.duration.short2
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: MD.Tokens.motion.duration.short2
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
