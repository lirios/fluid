// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class FAB
    \brief A Material Design 3 Expressive floating action button.

    A FAB represents the most important action on a screen. Set \c text to a
    short, localized description of the action; it is used as the accessible
    name while the control renders only its icon. Material Symbols use the
    resolved content color, while source images preserve their intrinsic colors.

    For more information see the
    <a href="https://m3.material.io/components/floating-action-button/overview">Material Design 3 FAB guidelines</a>.
*/
T.ToolButton {
    id: control

    //! The supported Material 3 Expressive FAB sizes.
    enum Size {
        Default,
        Medium,
        Large
    }

    //! The supported Material 3 FAB color variants.
    enum Variant {
        Surface,
        Primary,
        Secondary,
        Tertiary
    }

    //! The size of the FAB.
    property int size: FAB.Size.Default

    //! The semantic color variant of the FAB.
    property int variant: FAB.Variant.Primary

    //! Whether the FAB uses the lower-emphasis elevation treatment.
    property bool lowered: false

    //! Whether the icon is horizontally mirrored in right-to-left layouts.
    property bool mirrorIconInRtl: false

    //! The background color used in normal interactive states.
    property color containerColor: {
        switch (variant) {
        case FAB.Variant.Surface:
            return lowered ? control.MD.Style.surfaceContainerLowColor : control.MD.Style.surfaceContainerHighColor;
        case FAB.Variant.Primary:
            return control.MD.Style.primaryContainerColor;
        case FAB.Variant.Secondary:
            return control.MD.Style.secondaryContainerColor;
        case FAB.Variant.Tertiary:
            return control.MD.Style.tertiaryContainerColor;
        }
    }

    //! The foreground color used in normal interactive states.
    property color contentColor: {
        switch (variant) {
        case FAB.Variant.Surface:
            return control.MD.Style.primaryColor;
        case FAB.Variant.Primary:
            return control.MD.Style.onPrimaryContainerColor;
        case FAB.Variant.Secondary:
            return control.MD.Style.onSecondaryContainerColor;
        case FAB.Variant.Tertiary:
            return control.MD.Style.onTertiaryContainerColor;
        }
    }

    //! The resolved foreground color after interaction states.
    readonly property color effectiveContentColor: state.contentColor

    //! The resolved background color after interaction states.
    readonly property color effectiveContainerColor: state.containerColor

    //! The resolved elevation after interaction states.
    readonly property real effectiveElevation: state.elevation

    //! The resolved icon name.
    readonly property string effectiveIconName: icon.name

    //! The resolved icon source.
    readonly property url effectiveIconSource: icon.source

    //! The resolved Material Symbol and state-layer color.
    readonly property color effectiveIconColor: icon.color.a > 0 ? icon.color : effectiveContentColor

    //! Whether the icon is currently mirrored for a right-to-left layout.
    readonly property bool effectiveIconMirrored: mirrorIconInRtl && mirrored

    icon.width: state.iconSize
    icon.height: state.iconSize

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0
    padding: 0
    spacing: 0

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    Accessible.name: text
    Accessible.role: Accessible.Button

    QtObject {
        id: state

        readonly property real containerWidth: {
            switch (control.size) {
            case FAB.Size.Default:
                return MD.Tokens.fab.containerWidth;
            case FAB.Size.Medium:
                return MD.Tokens.fab.mediumContainerWidth;
            case FAB.Size.Large:
                return MD.Tokens.fab.largeContainerWidth;
            }
        }
        readonly property real containerHeight: {
            switch (control.size) {
            case FAB.Size.Default:
                return MD.Tokens.fab.containerHeight;
            case FAB.Size.Medium:
                return MD.Tokens.fab.mediumContainerHeight;
            case FAB.Size.Large:
                return MD.Tokens.fab.largeContainerHeight;
            }
        }
        readonly property real containerShape: {
            switch (control.size) {
            case FAB.Size.Default:
                return MD.Tokens.fab.containerShape;
            case FAB.Size.Medium:
                return MD.Tokens.fab.mediumContainerShape;
            case FAB.Size.Large:
                return MD.Tokens.fab.largeContainerShape;
            }
        }
        readonly property real iconSize: {
            switch (control.size) {
            case FAB.Size.Default:
                return MD.Tokens.fab.iconSize;
            case FAB.Size.Medium:
                return MD.Tokens.fab.mediumIconSize;
            case FAB.Size.Large:
                return MD.Tokens.fab.largeIconSize;
            }
        }

        property color containerColor: control.containerColor
        property color contentColor: control.contentColor
        property color stateLayerColor: "transparent"

        property real elevation: control.lowered ? MD.Tokens.fab.loweredContainerElevation : MD.Tokens.fab.containerElevation
        property real stateLayerOpacity: 0
    }

    states: [
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state.elevation: control.lowered ? MD.Tokens.fab.loweredPressedContainerElevation : MD.Tokens.fab.pressedContainerElevation
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.fab.pressedStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                state.elevation: control.lowered ? MD.Tokens.fab.loweredFocusContainerElevation : MD.Tokens.fab.focusContainerElevation
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.fab.focusStateLayerOpacity
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                state.elevation: control.lowered ? MD.Tokens.fab.loweredHoverContainerElevation : MD.Tokens.fab.hoverContainerElevation
                state.stateLayerColor: control.effectiveIconColor
                state.stateLayerOpacity: MD.Tokens.fab.hoverStateLayerOpacity
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

        Image {
            id: sourceIcon

            objectName: "fabSourceImage"
            anchors.centerIn: parent
            width: control.icon.width
            height: control.icon.height
            source: control.effectiveIconSource
            sourceSize: Qt.size(control.icon.width, control.icon.height)
            fillMode: Image.PreserveAspectFit
            visible: control.effectiveIconSource.toString().length > 0
        }

        MD.Symbol {
            objectName: "fabSymbol"
            anchors.centerIn: parent
            name: control.effectiveIconName
            iconWidth: control.icon.width
            iconHeight: control.icon.height
            color: control.effectiveIconColor
            visible: control.effectiveIconSource.toString().length === 0 && name.length > 0
        }
    }

    background: MD.ElevationRectangle {
        implicitWidth: state.containerWidth
        implicitHeight: state.containerHeight
        radius: state.containerShape
        color: state.containerColor
        elevation: state.elevation

        MD.Ripple {
            objectName: "fabRipple"
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
