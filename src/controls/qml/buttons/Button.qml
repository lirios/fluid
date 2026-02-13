// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD
import Fluid.Private as P
import "../core/UiMetrics.js" as UiMetrics

P.BaseButton {
    id: control

    /*!
        The type of the button. This controls the button's appearance and behavior.
    */
    property int type: P.BaseButton.Type.Elevated

    /*!
        The shape of the button. This controls the corner radius and overall appearance of the button.
        The default is MD.Button.Shape.Round, which is the recommended shape for most use cases.
        Use Square for a more angular and modern look, and Round for a softer and more traditional appearance.
    */
    property int shape: P.BaseButton.Shape.Round

    /*!
        The size of the button. This controls the button's dimensions, padding, and font size.
        The default is MD.Button.Small, which is the recommended size for most use cases.
        Use larger sizes for buttons that need to be more prominent,
        and smaller sizes for buttons that are less important or used in tight spaces.
    */
    property int size: P.BaseButton.Size.Small

    /*!
        The typescale to use for the button's text. This controls the font size, weight, and letter spacing.
        Ignore when the button is set to IconOnly display, as the text will not be shown.
    */
    property MD.typescale typescale: MD.Tokens.typescale.labelLarge

    /*!
        Whether the button has an icon. This is used to determine padding and layout.
    */
    readonly property bool hasIcon: icon.name.length > 0

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    leftInset: 0
    rightInset: 0
    topInset: UiMetrics.buttonInset(control)
    bottomInset: UiMetrics.buttonInset(control)

    leftPadding: UiMetrics.buttonPadding(control)
    rightPadding: UiMetrics.buttonPadding(control)
    topPadding: control.display === P.BaseButton.TextUnderIcon ? UiMetrics.buttonPadding(control) : 0
    bottomPadding: control.display === P.BaseButton.TextUnderIcon ? UiMetrics.buttonPadding(control) : 0

    flat: control.type === P.BaseButton.Type.Text || control.type === P.BaseButton.Type.Outlined

    hoverEnabled: true

    spacing: UiMetrics.buttonSpacing(control)

    icon.width: UiMetrics.buttonIconSize(control)
    icon.height: UiMetrics.buttonIconSize(control)

    font.pixelSize: typescale.fontSize
    font.weight: typescale.fontWeight
    font.letterSpacing: typescale.tracking

    QtObject {
        id: state

        property color containerColor: {
            switch (control.type) {
            case P.BaseButton.Type.Elevated:
                return control.checked ? control.MD.Style.primaryColor : control.MD.Style.surfaceContainerLowColor;
            case P.BaseButton.Type.Filled:
                return !control.checked ? control.MD.Style.surfaceContainerColor : control.MD.Style.primaryColor;
            case P.BaseButton.Type.Tonal:
                return control.checked ? control.MD.Style.secondaryColor : control.MD.Style.secondaryContainerColor;
            case P.BaseButton.Type.Outlined:
                return control.checked ? control.MD.Style.inverseSurfaceColor : "transparent";
            case P.BaseButton.Type.Text:
                return "transparent";
            }
        }
        property color labelColor: {
            switch (control.type) {
            case P.BaseButton.Type.Elevated:
                return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
            case P.BaseButton.Type.Filled:
                return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
            case P.BaseButton.Type.Tonal:
                return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
            case P.BaseButton.Type.Outlined:
                return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
            case P.BaseButton.Type.Text:
                return control.MD.Style.primaryColor;
            }
        }
        property color stateLayerColor: "transparent"

        property real elevation: control.type === P.BaseButton.Type.Elevated ? control.MD.Tokens.elevationLevel1 : control.MD.Tokens.elevationLevel0

        property real contentOpacity: 1.0
        property real containerOpacity: 1.0
        property real stateLayerOpacity: 1.0
    }

    states: [
        State {
            name: "disabled"
            when: !control.enabled

            PropertyChanges {
                state {
                    containerColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.MD.Style.onSurfaceColor;
                        case P.BaseButton.Type.Filled:
                        case P.BaseButton.Type.Tonal:
                            return control.MD.Style.onSurfaceColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.onSurfaceColor : control.MD.Style.outlineVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.onSurfaceColor;
                        }
                    }
                    labelColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.MD.Style.onSurfaceColor;
                        case P.BaseButton.Type.Filled:
                        case P.BaseButton.Type.Tonal:
                        case P.BaseButton.Type.Outlined:
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.onSurfaceColor;
                        }
                    }
                    elevation: control.MD.Tokens.elevationLevel0
                    containerOpacity: 0.1
                    contentOpacity: 0.38
                }
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                state {
                    labelColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    stateLayerOpacity: 0.08
                }
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                state {
                    labelColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    elevation: control.type === P.BaseButton.Type.Elevated ? control.MD.Tokens.elevationLevel1 : control.MD.Tokens.elevationLevel0
                    stateLayerOpacity: 0.1
                }
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state {
                    labelColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case P.BaseButton.Type.Elevated:
                            return control.checked ? control.MD.Style.onPrimaryColor : control.MD.Style.primaryColor;
                        case P.BaseButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case P.BaseButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case P.BaseButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case P.BaseButton.Type.Text:
                            return control.MD.Style.primaryColor;
                        }
                    }
                    elevation: control.type === P.BaseButton.Type.Elevated ? control.MD.Tokens.elevationLevel1 : control.MD.Tokens.elevationLevel0
                    stateLayerOpacity: 0.1
                }
            }
        }
    ]

    contentItem: MD.IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon.name: control.icon.name
        icon.width: control.icon.width
        icon.height: control.icon.height
        icon.color: color

        typescale: control.typescale
        text: control.text
        opacity: state.contentOpacity
        color: state.labelColor
    }

    background: MD.ElevationRectangle {
        implicitWidth: 64
        implicitHeight: {
            switch (control.size) {
            case P.BaseButton.Size.ExtraSmall:
                return 32;
            case P.BaseButton.Size.Small:
                return 40;
            case P.BaseButton.Size.Medium:
                return 56;
            case P.BaseButton.Size.Large:
                return 96;
            case P.BaseButton.Size.ExtraLarge:
                return 136;
            }
        }

        radius: Math.min(UiMetrics.buttonRadius(control), control.height / 2)

        Behavior on radius {
            NumberAnimation {
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
            }
        }

        border.width: control.type == P.BaseButton.Type.Outlined ? 1 : 0
        border.color: MD.Style.outlineVariantColor

        elevation: state.elevation
        elevationVisible: !MD.Utils.epsilonEqual(elevation, MD.Tokens.elevationLevel0) && !control.flat && color.a > 0

        opacity: state.containerOpacity
        color: state.containerColor

        MD.Ripple {
            anchors.fill: parent

            radius: parent.radius

            pressed: control.pressed
            pressX: control.pressX
            pressY: control.pressY

            stateOpacity: state.stateLayerOpacity
            color: state.stateLayerColor
        }
    }
}
