// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class FAB
    \brief A Material Design 3 Expressive floating action button.

    A FAB represents the most important action on a screen. When \c text is
    empty, the control renders as a square icon-only FAB. Setting \c text adds
    a visible label and gives the control its natural extended width. Labeled
    FABs can animate between their extended and square forms with \c expanded.
    Material Symbols use the resolved content color, while source images
    preserve their intrinsic colors.

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

    /*!
        Whether a labeled FAB displays its label and natural labeled width.

        Setting this property to \c false collapses a labeled control with an
        \c icon.name to the corresponding square FAB. A text-only control stays
        extended so its action remains visible.
    */
    property bool expanded: true

    //! The Material type scale used for the label, selected from \c size by default.
    property MD.typescale typescale: UiMetrics.fabTypescale(control)

    //! Whether the icon is horizontally mirrored in right-to-left layouts.
    property bool mirrorIconInRtl: false

    //! Whether \c icon.name provides a Material Symbol for this FAB.
    readonly property bool hasIcon: icon.name.length > 0

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

    //! \internal Whether the label must remain visible for the current content.
    readonly property bool _effectiveExpanded: expanded || !hasIcon

    //! \internal The square FAB width for the current size.
    readonly property real _collapsedWidth: UiMetrics.fabContainerWidth(control)

    //! \internal The FAB's natural labeled width.
    readonly property real _expandedWidth: Math.max(_collapsedWidth,
                                                    state.expandedLeadingSpace
                                                    + contentItem.implicitWidth
                                                    + state.expandedTrailingSpace)

    //! \internal Expansion progress derived solely from the animated container width.
    readonly property real _layoutProgress: {
        const distance = _expandedWidth - _collapsedWidth;
        if (distance <= 0)
            return _effectiveExpanded ? 1 : 0;
        return Math.max(0, Math.min(1, (state.containerWidth - _collapsedWidth) / distance));
    }

    //! \internal Logical leading padding interpolated from the centered icon endpoint.
    readonly property real _leadingPadding: state.collapsedIconPadding
                                             + (state.expandedLeadingSpace
                                                - state.collapsedIconPadding)
                                             * _layoutProgress

    //! \internal Logical trailing padding interpolated from the centered icon endpoint.
    readonly property real _trailingPadding: state.collapsedIconPadding
                                              + (state.expandedTrailingSpace
                                                 - state.collapsedIconPadding)
                                              * _layoutProgress

    icon.width: state.iconSize
    icon.height: state.iconSize

    implicitWidth: state.containerWidth
    implicitHeight: state.containerHeight

    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0
    leftPadding: mirrored ? _trailingPadding : _leadingPadding
    rightPadding: mirrored ? _leadingPadding : _trailingPadding
    topPadding: 0
    bottomPadding: 0
    spacing: state.iconLabelSpacing

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    Accessible.name: text
    Accessible.role: Accessible.Button

    QtObject {
        id: state

        readonly property real containerHeight: UiMetrics.fabContainerHeight(control)
        readonly property MD.shapeValue containerShape: UiMetrics.fabContainerShape(control)
        readonly property real iconSize: UiMetrics.fabIconSize(control)
        readonly property real expandedLeadingSpace: UiMetrics.fabLeadingSpace(control)
        readonly property real expandedTrailingSpace: UiMetrics.fabTrailingSpace(control)
        readonly property real iconLabelSpacing: UiMetrics.fabSpacing(control)
        readonly property real collapsedIconPadding: (control._collapsedWidth - iconSize) / 2

        property real containerWidth: control._effectiveExpanded ? control._expandedWidth : control._collapsedWidth
        property color containerColor: control.containerColor
        property color contentColor: control.contentColor
        property color stateLayerColor: "transparent"

        property real elevation: control.lowered ? MD.Tokens.fab.loweredContainerElevation : MD.Tokens.fab.containerElevation
        property real stateLayerOpacity: 0

        Behavior on containerWidth {
            enabled: control.text.length > 0

            NumberAnimation {
                // qmllint disable unresolved-type
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
                // qmllint enable unresolved-type
            }
        }
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

    contentItem: MD.IconLabel {
        id: iconLabel
        objectName: "fabContent"

        clip: true
        text: control.text
        display: MD.IconLabel.TextBesideIcon
        mirrored: control.mirrored
        mirrorIconInRtl: control.mirrorIconInRtl
        spacing: state.iconLabelSpacing
        typescale: control.typescale
        color: control.effectiveContentColor
        textOpacity: control._effectiveExpanded ? 1 : 0
        icon.name: control.effectiveIconName
        icon.source: control.effectiveIconSource
        icon.width: state.iconSize
        icon.height: state.iconSize
        icon.color: control.effectiveIconColor

        Behavior on textOpacity {
            NumberAnimation {
                // qmllint disable unresolved-type
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
                duration: MotionAnimation.expressiveFastEffectsDuration
                // qmllint enable unresolved-type
            }
        }
    }

    background: MD.ElevationRectangle {
        implicitWidth: state.containerWidth
        implicitHeight: state.containerHeight
        topLeftRadius: UiMetrics.resolveShapeRadius(state.containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(state.containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(state.containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(state.containerShape.bottomRight, width,
                                                        height)
        color: state.containerColor
        elevation: state.elevation

        MD.Ripple {
            objectName: "fabRipple"
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
