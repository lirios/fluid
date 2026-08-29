// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class FabMenuButton
    \brief The toggle button of a Material Design 3 Expressive FAB menu.

    FabMenuButton renders as a floating action button while it is collapsed and
    morphs into a close button while it is expanded: the container, its corner
    radius and the icon spring to the FAB menu close-button metrics while the
    collapsed and expanded Material Symbols cross-fade.

    The collapsed metrics follow the FAB size tokens, so a collapsed
    FabMenuButton matches a FAB of the same size. Set \c text to a short,
    localized description of the action; it is used as the accessible name while
    the control renders only its icon.

    FabMenu creates a FabMenuButton automatically. Applications normally use
    FabMenu rather than instantiating this control directly.

    For more information see the
    <a href="https://m3.material.io/components/fab-menu/overview">Material Design 3 FAB menu guidelines</a>.
*/
T.ToolButton {
    id: control

    //! The supported Material 3 Expressive FAB sizes.
    enum Size {
        Default,
        Medium,
        Large
    }

    //! The size of the button while it is collapsed.
    property int size: FabMenuButton.Size.Default

    /*!
        Whether the button renders as a close button.

        The specification morphs the toggle button of an expanded FAB menu into
        a close button, so this springs the container, its corner radius and the
        icon between the FAB size metrics and the close-button metrics, and
        cross-fades \c collapsedIconName into \c expandedIconName.
    */
    property bool expanded: false

    //! The background color used in normal interactive states.
    property color containerColor: control.MD.Style.primaryContainerColor

    //! The foreground color used in normal interactive states.
    property color contentColor: control.MD.Style.onPrimaryContainerColor

    //! The Material Symbol shown while the button is collapsed.
    property string collapsedIconName: MD.SymbolNames.symbolAdd

    //! The Material Symbol shown while the button is expanded.
    property string expandedIconName: MD.SymbolNames.symbolClose

    //! The resolved background color after interaction states.
    readonly property color effectiveContainerColor: state.containerColor

    //! The resolved foreground color after interaction states.
    readonly property color effectiveContentColor: state.contentColor

    //! The resolved elevation after interaction states.
    readonly property real effectiveElevation: state.elevation

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

        readonly property real collapsedContainerWidth: {
            switch (control.size) {
            case FabMenuButton.Size.Default:
                return MD.Tokens.fab.containerWidth;
            case FabMenuButton.Size.Medium:
                return MD.Tokens.fab.mediumContainerWidth;
            case FabMenuButton.Size.Large:
                return MD.Tokens.fab.largeContainerWidth;
            }
        }
        readonly property real collapsedContainerHeight: {
            switch (control.size) {
            case FabMenuButton.Size.Default:
                return MD.Tokens.fab.containerHeight;
            case FabMenuButton.Size.Medium:
                return MD.Tokens.fab.mediumContainerHeight;
            case FabMenuButton.Size.Large:
                return MD.Tokens.fab.largeContainerHeight;
            }
        }
        readonly property real collapsedContainerShape: {
            switch (control.size) {
            case FabMenuButton.Size.Default:
                return MD.Tokens.fab.containerShape;
            case FabMenuButton.Size.Medium:
                return MD.Tokens.fab.mediumContainerShape;
            case FabMenuButton.Size.Large:
                return MD.Tokens.fab.largeContainerShape;
            }
        }
        readonly property real collapsedIconSize: {
            switch (control.size) {
            case FabMenuButton.Size.Default:
                return MD.Tokens.fab.iconSize;
            case FabMenuButton.Size.Medium:
                return MD.Tokens.fab.mediumIconSize;
            case FabMenuButton.Size.Large:
                return MD.Tokens.fab.largeIconSize;
            }
        }

        property real containerWidth: control.expanded ? MD.Tokens.fabMenu.closeButtonContainerWidth : state.collapsedContainerWidth
        property real containerHeight: control.expanded ? MD.Tokens.fabMenu.closeButtonContainerHeight : state.collapsedContainerHeight
        property real containerShape: control.expanded ? MD.Tokens.fabMenu.closeButtonContainerShape : state.collapsedContainerShape
        property real iconSize: control.expanded ? MD.Tokens.fabMenu.closeButtonIconSize : state.collapsedIconSize

        property color containerColor: control.containerColor
        property color contentColor: control.contentColor
        property color stateLayerColor: "transparent"

        property real elevation: control.expanded ? MD.Tokens.fabMenu.closeButtonContainerElevation : MD.Tokens.fab.containerElevation
        property real stateLayerOpacity: 0

        Behavior on containerWidth {
            NumberAnimation {
                // qmllint disable unresolved-type
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
                // qmllint enable unresolved-type
            }
        }

        Behavior on containerHeight {
            NumberAnimation {
                // qmllint disable unresolved-type
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
                // qmllint enable unresolved-type
            }
        }

        Behavior on containerShape {
            NumberAnimation {
                // qmllint disable unresolved-type
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
                // qmllint enable unresolved-type
            }
        }

        Behavior on iconSize {
            NumberAnimation {
                // qmllint disable unresolved-type
                easing: MD.Tokens.spring.expressiveFastSpatial.easing
                duration: MD.Tokens.spring.expressiveFastSpatial.duration
                // qmllint enable unresolved-type
            }
        }
    }

    states: [
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                state.elevation: control.expanded ? MD.Tokens.fabMenu.closeButtonPressedContainerElevation : MD.Tokens.fab.pressedContainerElevation
                state.stateLayerColor: control.effectiveContentColor
                state.stateLayerOpacity: MD.Tokens.fabMenu.pressedStateLayerOpacity
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                state.elevation: control.expanded ? MD.Tokens.fabMenu.closeButtonFocusContainerElevation : MD.Tokens.fab.focusContainerElevation
                state.stateLayerColor: control.effectiveContentColor
                state.stateLayerOpacity: MD.Tokens.fabMenu.focusStateLayerOpacity
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                state.elevation: control.expanded ? MD.Tokens.fabMenu.closeButtonHoverContainerElevation : MD.Tokens.fab.hoverContainerElevation
                state.stateLayerColor: control.effectiveContentColor
                state.stateLayerOpacity: MD.Tokens.fabMenu.hoverStateLayerOpacity
            }
        }
    ]

    contentItem: Item {
        implicitWidth: state.iconSize
        implicitHeight: state.iconSize

        MD.Symbol {
            objectName: "fabMenuButtonCollapsedSymbol"

            anchors.centerIn: parent
            name: control.collapsedIconName
            iconWidth: state.iconSize
            iconHeight: state.iconSize
            color: control.effectiveContentColor
            opacity: control.expanded ? 0 : 1
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: MD.Tokens.durationShort4
                }
            }
        }

        MD.Symbol {
            objectName: "fabMenuButtonExpandedSymbol"

            anchors.centerIn: parent
            name: control.expandedIconName
            iconWidth: state.iconSize
            iconHeight: state.iconSize
            color: control.effectiveContentColor
            opacity: control.expanded ? 1 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: MD.Tokens.durationShort4
                }
            }
        }
    }

    background: MD.ElevationRectangle {
        implicitWidth: state.containerWidth
        implicitHeight: state.containerHeight
        radius: state.containerShape
        color: state.containerColor
        elevation: state.elevation

        MD.Ripple {
            objectName: "fabMenuButtonRipple"

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
