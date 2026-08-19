// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

T.ToolButton {
    id: control

    //! The type of button to display. This controls the default background and foreground colors.
    enum Type {
        Filled,
        Tonal,
        Outlined,
        Standard
    }

    /*!
        The shape of the button. This controls the corner radius and overall appearance.
        Shape morphs when the button is pressed or selected.
    */
    enum Shape {
        Round,
        Square
    }

    //! The size of the button. This controls the padding, font size, and overall dimensions.
    enum Size {
        ExtraSmall,
        Small,
        Medium,
        Large,
        ExtraLarge
    }

    //! The width of the button. This controls the horizontal padding and overall width of the button.
    enum Width {
        Default,
        Narrow,
        Wide
    }

    /*!
        The type of the button. This controls the background and foreground colors of the button.
        The default is MD.IconButton.Color.Filled, which is the recommended color for most use cases.
        Use Tonal for a more subdued look, Outlined for a more minimal look, and Standard for a more neutral look.
    */
    property int type: IconButton.Type.Filled

    /*!
        The shape of the button. This controls the corner radius and overall appearance of the button.
        The default is MD.IconButton.Shape.Round, which is the recommended shape for most use cases.
        Use Square for a more angular and modern look, and Round for a softer and more traditional appearance.
    */
    property int shape: IconButton.Shape.Round

    /*!
        The size of the button. This controls the button's dimensions, padding, and font size.
        The default is MD.IconButton.Size.Small, which is the recommended size for most use cases.
        Use larger sizes for buttons that need to be more prominent,
        and smaller sizes for buttons that are less important or used in tight spaces.
    */
    property int size: IconButton.Size.Small

    /*!
            The width variant of the button. This controls the horizontal padding and overall width of the button.
            The default is MD.IconButton.WidthVariant.Default, which is the recommended width for most use cases.
            Use Narrow for buttons that need to be more compact, and Wide for buttons that need to be more prominent.
        */
    property int widthVariant: IconButton.Width.Default

    icon.width: state.iconSize.width
    icon.height: state.iconSize.height

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    leftInset: state.inset.width / 2
    rightInset: state.inset.width / 2
    topInset: state.inset.height / 2
    bottomInset: state.inset.height / 2

    padding: 0

    spacing: 0

    hoverEnabled: true

    QtObject {
        id: state

        property size buttonSize: {
            switch (control.size) {
            case IconButton.Size.ExtraSmall:
                switch (control.widthVariant) {
                case IconButton.Width.Default:
                    return Qt.size(32, 32);
                case IconButton.Width.Narrow:
                    return Qt.size(28, 32);
                case IconButton.Width.Wide:
                    return Qt.size(32, 32);
                }
                break;
            case IconButton.Size.Small:
                switch (control.widthVariant) {
                case IconButton.Width.Default:
                    return Qt.size(40, 40);
                case IconButton.Width.Narrow:
                    return Qt.size(32, 40);
                case IconButton.Width.Wide:
                    return Qt.size(52, 40);
                }
                break;
            case IconButton.Size.Medium:
                switch (control.widthVariant) {
                case IconButton.Width.Default:
                    return Qt.size(56, 56);
                case IconButton.Width.Narrow:
                    return Qt.size(48, 56);
                case IconButton.Width.Wide:
                    return Qt.size(72, 56);
                }
                break;
            case IconButton.Size.Large:
                switch (control.widthVariant) {
                case IconButton.Width.Default:
                    return Qt.size(96, 96);
                case IconButton.Width.Narrow:
                    return Qt.size(64, 96);
                case IconButton.Width.Wide:
                    return Qt.size(128, 96);
                }
                break;
            case IconButton.Size.ExtraLarge:
                switch (control.widthVariant) {
                case IconButton.Width.Default:
                    return Qt.size(136, 136);
                case IconButton.Width.Narrow:
                    return Qt.size(104, 136);
                case IconButton.Width.Wide:
                    return Qt.size(184, 136);
                }
                break;
            }
        }
        property size iconSize: {
            switch (control.size) {
            case IconButton.Size.ExtraSmall:
                return Qt.size(20, 20);
            case IconButton.Size.Small:
            case IconButton.Size.Medium:
                return Qt.size(24, 24);
            case IconButton.Size.Large:
                return Qt.size(32, 32);
            case IconButton.Size.ExtraLarge:
                return Qt.size(40, 40);
            }
        }

        property size inset: {
            // Extra small and small icon buttons must have a target size of 48x48 to be accessible,
            // except for wide small buttons that must be at least 52x48.
            switch (control.size) {
            case IconButton.Size.ExtraSmall:
                return Qt.size(48 - state.buttonSize.width, 48 - state.buttonSize.height);
            case IconButton.Size.Small:
                if (control.widthVariant === IconButton.Width.Wide) {
                    return Qt.size(52 - state.buttonSize.width, 48 - state.buttonSize.height);
                }
                return Qt.size(48 - state.buttonSize.width, 48 - state.buttonSize.height);
            default:
                return Qt.size(0, 0);
            }
        }

        property real radius: {
            // When pressed it morphs into a square shape, and when it's a selected toggle the shape morphs
            // from round to square and vice versa
            const isSquare = control.pressed || (control.checked && control.shape === IconButton.Shape.Round) || (!control.checked && control.shape === IconButton.Shape.Square);
            if (isSquare) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall:
                case IconButton.Size.Small:
                    return control.MD.Tokens.cornerRadiusSmall;
                case IconButton.Size.Medium:
                    return control.MD.Tokens.cornerRadiusMedium;
                case IconButton.Size.Large:
                case IconButton.Size.ExtraLarge:
                    return control.MD.Tokens.cornerRadiusLarge;
                }
            } else if (control.shape === IconButton.Shape.Round) {
                // When not pressed and the shape is round, the radius is always full
                return control.MD.Tokens.cornerRadiusFull;
            } else {
                // When not pressed and the shape is square, the radius depends on the size
                switch (control.size) {
                case IconButton.Size.ExtraSmall:
                case IconButton.Size.Small:
                    return control.MD.Tokens.cornerRadiusMedium;
                case IconButton.Size.Medium:
                    return control.MD.Tokens.cornerRadiusLarge;
                case IconButton.Size.Large:
                case IconButton.Size.ExtraLarge:
                    return control.MD.Tokens.cornerRadiusExtraLarge;
                }
            }
        }

        property color containerColor: {
            switch (control.type) {
            case IconButton.Type.Filled:
                return !control.checked ? control.MD.Style.surfaceContainerColor : control.MD.Style.primaryColor;
            case IconButton.Type.Tonal:
                return control.checked ? control.MD.Style.secondaryColor : control.MD.Style.secondaryContainerColor;
            case IconButton.Type.Outlined:
                return control.checked ? control.MD.Style.inverseSurfaceColor : "transparent";
            case IconButton.Type.Standard:
                return "transparent";
            }
        }
        property color contentColor: {
            switch (control.type) {
            case IconButton.Type.Filled:
                return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
            case IconButton.Type.Tonal:
                return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
            case IconButton.Type.Outlined:
                return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
            case IconButton.Type.Standard:
                return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
            }
        }
        property color stateLayerColor: "transparent"

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
                        case IconButton.Type.Filled:
                        case IconButton.Type.Tonal:
                        case IconButton.Type.Outlined:
                            return control.MD.Style.onSurfaceColor;
                        case IconButton.Type.Standard:
                            return "transparent";
                        }
                    }
                    contentColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                        case IconButton.Type.Tonal:
                        case IconButton.Type.Outlined:
                        case IconButton.Type.Standard:
                            return control.MD.Style.onSurfaceColor;
                        }
                    }
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
                    contentColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
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
                    contentColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
                        }
                    }
                    stateLayerOpacity: 0.1
                }
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state {
                    contentColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
                        }
                    }
                    stateLayerColor: {
                        switch (control.type) {
                        case IconButton.Type.Filled:
                            return !control.checked ? control.MD.Style.onSurfaceVariantColor : control.MD.Style.onPrimaryColor;
                        case IconButton.Type.Tonal:
                            return control.checked ? control.MD.Style.onSecondaryColor : control.MD.Style.onSecondaryContainerColor;
                        case IconButton.Type.Outlined:
                            return control.checked ? control.MD.Style.inverseOnSurfaceColor : control.MD.Style.onSurfaceVariantColor;
                        case IconButton.Type.Standard:
                            return control.checked ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceVariantColor;
                        }
                    }
                    stateLayerOpacity: 0.1
                }
            }
        }
    ]

    contentItem: MD.Symbol {
        name: control.icon.name

        iconWidth: control.icon.width
        iconHeight: control.icon.height
        width: iconWidth
        height: iconHeight

        color: state.contentColor
        opacity: state.contentOpacity

        fill: control.checked

        visible: control.icon.name.length > 0
    }

    background: Rectangle {
        implicitWidth: state.buttonSize.width
        implicitHeight: state.buttonSize.height

        radius: Math.min(state.radius, control.height / 2)

        Behavior on radius {
            NumberAnimation {
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
            }
        }

        border.width: control.type == IconButton.Type.Outlined && !(control.checkable && !control.checked) ? 1 : 0
        border.color: control.MD.Style.outlineVariantColor

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
