// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl as TImpl
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class IconButton
    \brief A Material 3 Expressive button that presents an icon without a visible label.

    Set \c text to a short, localized description of the action. The template uses it
    as the accessible name even though the control only renders its icon.

    A checkable button fills its Material Symbol when selected. Set \c checkedIcon
    when the selected state needs a different symbol or source image instead.

    For more information see the
    <a href="https://m3.material.io/components/icon-buttons/overview">Material Design 3 icon button guidelines</a>.
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

        readonly property real currentContainerHeight: {
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.containerHeightExtraSmall;
            case IconButton.Size.Small: return MD.Tokens.iconButton.containerHeightSmall;
            case IconButton.Size.Medium: return MD.Tokens.iconButton.containerHeightMedium;
            case IconButton.Size.Large: return MD.Tokens.iconButton.containerHeightLarge;
            case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.containerHeightExtraLarge;
            }
        }
        readonly property real currentIconSize: {
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.iconSizeExtraSmall;
            case IconButton.Size.Small: return MD.Tokens.iconButton.iconSizeSmall;
            case IconButton.Size.Medium: return MD.Tokens.iconButton.iconSizeMedium;
            case IconButton.Size.Large: return MD.Tokens.iconButton.iconSizeLarge;
            case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.iconSizeExtraLarge;
            }
        }
        readonly property real currentLeadingSpace: {
            if (control.widthVariant === IconButton.Width.Narrow) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.narrowLeadingSpaceExtraSmall;
                case IconButton.Size.Small: return MD.Tokens.iconButton.narrowLeadingSpaceSmall;
                case IconButton.Size.Medium: return MD.Tokens.iconButton.narrowLeadingSpaceMedium;
                case IconButton.Size.Large: return MD.Tokens.iconButton.narrowLeadingSpaceLarge;
                case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.narrowLeadingSpaceExtraLarge;
                }
            }
            if (control.widthVariant === IconButton.Width.Wide) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.wideLeadingSpaceExtraSmall;
                case IconButton.Size.Small: return MD.Tokens.iconButton.wideLeadingSpaceSmall;
                case IconButton.Size.Medium: return MD.Tokens.iconButton.wideLeadingSpaceMedium;
                case IconButton.Size.Large: return MD.Tokens.iconButton.wideLeadingSpaceLarge;
                case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.wideLeadingSpaceExtraLarge;
                }
            }
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.defaultLeadingSpaceExtraSmall;
            case IconButton.Size.Small: return MD.Tokens.iconButton.defaultLeadingSpaceSmall;
            case IconButton.Size.Medium: return MD.Tokens.iconButton.defaultLeadingSpaceMedium;
            case IconButton.Size.Large: return MD.Tokens.iconButton.defaultLeadingSpaceLarge;
            case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.defaultLeadingSpaceExtraLarge;
            }
        }
        readonly property real currentTrailingSpace: {
            if (control.widthVariant === IconButton.Width.Narrow) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.narrowTrailingSpaceExtraSmall;
                case IconButton.Size.Small: return MD.Tokens.iconButton.narrowTrailingSpaceSmall;
                case IconButton.Size.Medium: return MD.Tokens.iconButton.narrowTrailingSpaceMedium;
                case IconButton.Size.Large: return MD.Tokens.iconButton.narrowTrailingSpaceLarge;
                case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.narrowTrailingSpaceExtraLarge;
                }
            }
            if (control.widthVariant === IconButton.Width.Wide) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.wideTrailingSpaceExtraSmall;
                case IconButton.Size.Small: return MD.Tokens.iconButton.wideTrailingSpaceSmall;
                case IconButton.Size.Medium: return MD.Tokens.iconButton.wideTrailingSpaceMedium;
                case IconButton.Size.Large: return MD.Tokens.iconButton.wideTrailingSpaceLarge;
                case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.wideTrailingSpaceExtraLarge;
                }
            }
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.defaultTrailingSpaceExtraSmall;
            case IconButton.Size.Small: return MD.Tokens.iconButton.defaultTrailingSpaceSmall;
            case IconButton.Size.Medium: return MD.Tokens.iconButton.defaultTrailingSpaceMedium;
            case IconButton.Size.Large: return MD.Tokens.iconButton.defaultTrailingSpaceLarge;
            case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.defaultTrailingSpaceExtraLarge;
            }
        }
        readonly property real outlineWidth: {
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return MD.Tokens.iconButton.outlinedOutlineWidthExtraSmall;
            case IconButton.Size.Small: return MD.Tokens.iconButton.outlinedOutlineWidthSmall;
            case IconButton.Size.Medium: return MD.Tokens.iconButton.outlinedOutlineWidthMedium;
            case IconButton.Size.Large: return MD.Tokens.iconButton.outlinedOutlineWidthLarge;
            case IconButton.Size.ExtraLarge: return MD.Tokens.iconButton.outlinedOutlineWidthExtraLarge;
            }
        }
        property size buttonSize: Qt.size(currentIconSize + currentLeadingSpace + currentTrailingSpace, currentContainerHeight)
        property size iconSize: Qt.size(currentIconSize, currentIconSize)

        property size inset: {
            const minimum = MD.Tokens.iconButton.minimumInteractiveSize;
            return Qt.size(Math.max(minimum, state.buttonSize.width) - state.buttonSize.width,
                           Math.max(minimum, state.buttonSize.height) - state.buttonSize.height);
        }

        property MD.shapeValue containerShape: {
            const tokens = MD.Tokens.iconButton;
            if (control.pressed) {
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return tokens.pressedContainerShapeExtraSmall;
                case IconButton.Size.Small: return tokens.pressedContainerShapeSmall;
                case IconButton.Size.Medium: return tokens.pressedContainerShapeMedium;
                case IconButton.Size.Large: return tokens.pressedContainerShapeLarge;
                case IconButton.Size.ExtraLarge: return tokens.pressedContainerShapeExtraLarge;
                }
            }
            if (control.checked) {
                if (control.shape === IconButton.Shape.Square)
                    return tokens.selectedContainerShapeSquare;
                switch (control.size) {
                case IconButton.Size.ExtraSmall: return tokens.selectedContainerShapeRoundExtraSmall;
                case IconButton.Size.Small: return tokens.selectedContainerShapeRoundSmall;
                case IconButton.Size.Medium: return tokens.selectedContainerShapeRoundMedium;
                case IconButton.Size.Large: return tokens.selectedContainerShapeRoundLarge;
                case IconButton.Size.ExtraLarge: return tokens.selectedContainerShapeRoundExtraLarge;
                }
            }
            if (control.shape === IconButton.Shape.Round)
                return tokens.containerShapeRound;
            switch (control.size) {
            case IconButton.Size.ExtraSmall: return tokens.containerShapeSquareExtraSmall;
            case IconButton.Size.Small: return tokens.containerShapeSquareSmall;
            case IconButton.Size.Medium: return tokens.containerShapeSquareMedium;
            case IconButton.Size.Large: return tokens.containerShapeSquareLarge;
            case IconButton.Size.ExtraLarge: return tokens.containerShapeSquareExtraLarge;
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
                state.containerOpacity: MD.Tokens.iconButton.disabledContainerOpacity
                state.contentOpacity: MD.Tokens.iconButton.disabledIconOpacity
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.iconButton.pressedStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.iconButton.focusStateLayerOpacity
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.iconButton.hoverStateLayerOpacity
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

        topLeftRadius: UiMetrics.resolveShapeRadius(state.containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(state.containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(state.containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(state.containerShape.bottomRight, width, height)

        Behavior on topLeftRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on topRightRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on bottomLeftRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on bottomRightRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }

        border.width: control.type === IconButton.Type.Outlined && !control.checked ? state.outlineWidth : 0
        border.color: control.outlineColor

        opacity: state.containerOpacity
        color: state.containerColor

        MD.Ripple {
            anchors.fill: parent

            topLeftRadius: parent.topLeftRadius
            topRightRadius: parent.topRightRadius
            bottomLeftRadius: parent.bottomLeftRadius
            bottomRightRadius: parent.bottomRightRadius

            pressed: control.pressed
            pressX: control.pressX
            pressY: control.pressY

            stateOpacity: state.stateLayerOpacity
            color: state.stateLayerColor
        }
    }
}
