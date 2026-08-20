// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl as TImpl
import Fluid as MD

/*!
    \brief A Material 3 Expressive button that presents an icon without a visible label.

    Set \c text to a short, localized description of the action. The template uses it
    as the accessible name even though the control only renders its icon.

    A checkable button fills its Material Symbol when selected. Set \c checkedIcon
    when the selected state needs a different symbol or source image instead.
*/
T.ToolButton {
    id: control

    component IconData: QtObject {
        property string name
        property url source
        property color color
        property bool fill: false
    }

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
        The default is MD.IconButton.Type.Filled, which is the recommended color for most use cases.
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
            The default is MD.IconButton.Width.Default, which is the recommended width for most use cases.
            Use Narrow for buttons that need to be more compact, and Wide for buttons that need to be more prominent.
        */
    property int widthVariant: IconButton.Width.Default

    /*!
        Optional icon displayed while a checkable button is checked.

        When neither \c name nor \c source is set, the normal icon remains visible
        and a Material Symbol uses its filled variation.
    */
    property IconData checkedIcon: IconData {}

    //! Whether the icon is horizontally mirrored in right-to-left layouts.
    property bool mirrorIconInRtl: false

    /*!
        Whether source-based icons are tinted with their resolved foreground color.
        Disable this for multicolor artwork or photographs.
    */
    property bool tintSourceIcon: true

    /*!
        The foreground color used by the icon in its normal interactive states.
        By default this follows the selected type and checked state.
    */
    property color contentColor: {
        switch (type) {
        case IconButton.Type.Filled:
            return checked ? MD.Style.onPrimaryColor : MD.Style.onSurfaceVariantColor;
        case IconButton.Type.Tonal:
            return checked ? MD.Style.onSecondaryColor : MD.Style.onSecondaryContainerColor;
        case IconButton.Type.Outlined:
            return checked ? MD.Style.inverseOnSurfaceColor : MD.Style.onSurfaceVariantColor;
        case IconButton.Type.Standard:
            return checked ? MD.Style.primaryColor : MD.Style.onSurfaceVariantColor;
        }
    }

    /*!
        The background color used in the normal interactive states.
        By default this follows the selected type and checked state.
    */
    property color containerColor: {
        switch (type) {
        case IconButton.Type.Filled:
            return checked ? MD.Style.primaryColor : MD.Style.surfaceContainerColor;
        case IconButton.Type.Tonal:
            return checked ? MD.Style.secondaryColor : MD.Style.secondaryContainerColor;
        case IconButton.Type.Outlined:
            return checked ? MD.Style.inverseSurfaceColor : "transparent";
        case IconButton.Type.Standard:
            return "transparent";
        }
    }

    //! The foreground color used while the button is disabled.
    property color disabledContentColor: MD.Style.onSurfaceColor

    //! The background color used while a non-standard button is disabled.
    property color disabledContainerColor: MD.Style.onSurfaceColor

    //! The outline color used by an unselected outlined button.
    property color outlineColor: MD.Style.outlineVariantColor

    //! The resolved foreground color after interaction and disabled states.
    readonly property color effectiveContentColor: state.contentColor

    //! The resolved foreground opacity after interaction and disabled states.
    readonly property real effectiveContentOpacity: state.contentOpacity

    //! The resolved background color after interaction and disabled states.
    readonly property color effectiveContainerColor: state.containerColor

    //! Whether the optional checked-state icon is currently being used.
    readonly property bool usingCheckedIcon: checked && (checkedIcon.name.length > 0 || checkedIcon.source.toString().length > 0)

    //! The icon name resolved for the current checked state.
    readonly property string effectiveIconName: usingCheckedIcon ? checkedIcon.name : icon.name

    //! The icon source resolved for the current checked state.
    readonly property url effectiveIconSource: usingCheckedIcon ? checkedIcon.source : icon.source

    //! The icon color resolved for the current checked and interaction states.
    readonly property color effectiveIconColor: {
        const explicitColor = usingCheckedIcon ? checkedIcon.color : icon.color;
        return explicitColor.a > 0 ? explicitColor : effectiveContentColor;
    }

    //! Whether the resolved Material Symbol uses its filled variation.
    readonly property bool effectiveIconFill: checked && (usingCheckedIcon ? checkedIcon.fill : true)

    //! Whether the icon is currently mirrored for a right-to-left layout.
    readonly property bool effectiveIconMirrored: mirrorIconInRtl && mirrored

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
    focusPolicy: Qt.StrongFocus

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
                    return MD.Tokens.cornerRadiusSmall;
                case IconButton.Size.Medium:
                    return MD.Tokens.cornerRadiusMedium;
                case IconButton.Size.Large:
                case IconButton.Size.ExtraLarge:
                    return MD.Tokens.cornerRadiusLarge;
                }
            } else if (control.shape === IconButton.Shape.Round) {
                // When not pressed and the shape is round, the radius is always full
                return MD.Tokens.cornerRadiusFull;
            } else {
                // When not pressed and the shape is square, the radius depends on the size
                switch (control.size) {
                case IconButton.Size.ExtraSmall:
                case IconButton.Size.Small:
                    return MD.Tokens.cornerRadiusMedium;
                case IconButton.Size.Medium:
                    return MD.Tokens.cornerRadiusLarge;
                case IconButton.Size.Large:
                case IconButton.Size.ExtraLarge:
                    return MD.Tokens.cornerRadiusExtraLarge;
                }
            }
        }

        property color containerColor: control.containerColor
        property color contentColor: control.contentColor
        property color stateLayerColor: "transparent"

        property real contentOpacity: 1.0
        property real containerOpacity: 1.0
        property real stateLayerOpacity: 0.0
    }

    states: [
        State {
            name: "disabled"
            when: !control.enabled

            PropertyChanges {
                state.containerColor: control.type === IconButton.Type.Standard ? "transparent" : control.disabledContainerColor
                state.contentColor: control.disabledContentColor
                state.containerOpacity: 0.1
                state.contentOpacity: 0.38
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: 0.1
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: 0.1
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: 0.08
            }
        }
    ]

    contentItem: Item {
        id: iconContent

        implicitWidth: control.icon.width
        implicitHeight: control.icon.height

        transform: Scale {
            origin.x: iconContent.width / 2
            origin.y: iconContent.height / 2
            xScale: control.effectiveIconMirrored ? -1 : 1
        }

        TImpl.IconImage {
            id: sourceIcon

            objectName: "iconButtonSourceImage"
            anchors.centerIn: parent
            width: control.icon.width
            height: control.icon.height
            source: control.effectiveIconSource
            sourceSize: Qt.size(control.icon.width, control.icon.height)
            fillMode: Image.PreserveAspectFit
            color: control.tintSourceIcon ? control.effectiveIconColor : "transparent"
            opacity: state.contentOpacity
            visible: control.effectiveIconSource.toString().length > 0
        }

        MD.Symbol {
            objectName: "iconButtonSymbol"
            anchors.centerIn: parent
            name: control.effectiveIconName
            iconWidth: control.icon.width
            iconHeight: control.icon.height
            color: control.effectiveIconColor
            opacity: state.contentOpacity
            fill: control.effectiveIconFill
            visible: control.effectiveIconSource.toString().length === 0 && name.length > 0
        }
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

        border.width: control.type === IconButton.Type.Outlined && !control.checked ? 1 : 0
        border.color: control.outlineColor

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
