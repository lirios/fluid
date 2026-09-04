// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class ExtendedFAB
    \brief A labeled Material Design 3 Expressive floating action button.

    ExtendedFAB combines a Material Symbol and a short text label for the most
    important action on a screen. The inherited \c text property supplies both
    the visible label and the accessible name. The control can animate between
    its natural labeled width and the square width of a regular FAB by changing
    \c expanded.

    Collapsing requires a Material Symbol in \c icon.name. A text-only control
    remains visually extended even when \c expanded is \c false. This initial
    version renders icons from \c icon.name only; inherited \c icon.source and
    glyph mirroring are unsupported. In right-to-left layouts, the logical
    icon and label order is reversed without flipping the glyph.

    An explicit \c width or horizontal anchors override the animated implicit
    width. Label text retains its natural single-line size; content may be
    clipped when a caller imposes a narrower width.

    \code{.qml}
    MD.ExtendedFAB {
        text: qsTr("Create")
        icon.name: MD.Symbols.add
        onClicked: createDocument()
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/extended-fab/overview">Material Design 3 Extended FAB guidelines</a>.
*/
T.ToolButton {
    id: control

    //! The supported Material 3 Expressive Extended FAB sizes.
    enum Size {
        //! A 56-dp-high Extended FAB with a 24-dp icon.
        Default,
        //! An 80-dp-high Extended FAB with a 28-dp icon.
        Medium,
        //! A 96-dp-high Extended FAB with a 32-dp icon.
        Large
    }

    //! The supported Material 3 Extended FAB semantic color variants.
    enum Variant {
        //! A surface container with primary-colored content.
        Surface,
        //! A primary container with on-primary-container content.
        Primary,
        //! A secondary container with on-secondary-container content.
        Secondary,
        //! A tertiary container with on-tertiary-container content.
        Tertiary
    }

    //! The size of the Extended FAB.
    property int size: ExtendedFAB.Size.Default

    //! The semantic color variant of the Extended FAB.
    property int variant: ExtendedFAB.Variant.Primary

    //! Whether the Extended FAB uses the lower-emphasis elevation treatment.
    property bool lowered: false

    /*!
        Whether the Extended FAB displays its label and natural labeled width.

        Setting this property to \c false collapses a control with an
        \c icon.name to the corresponding regular-FAB square. A text-only
        control remains extended so its action stays visible.
    */
    property bool expanded: true

    //! The Material type scale used for the label, selected from \c size by default.
    property MD.typescale typescale: UiMetrics.extendedFabTypescale(control)

    //! Whether \c icon.name provides a Material Symbol for this Extended FAB.
    readonly property bool hasIcon: icon.name.length > 0

    //! The background color used in normal interactive states.
    property color containerColor: {
        switch (variant) {
        case ExtendedFAB.Variant.Surface:
            return lowered ? control.MD.Style.surfaceContainerLowColor : control.MD.Style.surfaceContainerHighColor;
        case ExtendedFAB.Variant.Primary:
            return control.MD.Style.primaryContainerColor;
        case ExtendedFAB.Variant.Secondary:
            return control.MD.Style.secondaryContainerColor;
        case ExtendedFAB.Variant.Tertiary:
            return control.MD.Style.tertiaryContainerColor;
        }
    }

    //! The foreground color used in normal interactive states.
    property color contentColor: {
        switch (variant) {
        case ExtendedFAB.Variant.Surface:
            return control.MD.Style.primaryColor;
        case ExtendedFAB.Variant.Primary:
            return control.MD.Style.onPrimaryContainerColor;
        case ExtendedFAB.Variant.Secondary:
            return control.MD.Style.onSecondaryContainerColor;
        case ExtendedFAB.Variant.Tertiary:
            return control.MD.Style.onTertiaryContainerColor;
        }
    }

    //! The resolved background color after interaction states.
    readonly property color effectiveContainerColor: state.containerColor

    //! The resolved foreground color after interaction states.
    readonly property color effectiveContentColor: state.contentColor

    //! The resolved elevation after interaction states.
    readonly property real effectiveElevation: state.elevation

    //! The Material Symbol name resolved from \c icon.name.
    readonly property string effectiveIconName: icon.name

    //! The resolved Material Symbol and state-layer color.
    readonly property color effectiveIconColor: icon.color.a > 0 ? icon.color : effectiveContentColor

    //! \internal Whether the label must remain visible for the current content.
    readonly property bool _effectiveExpanded: expanded || !hasIcon

    //! \internal The square regular-FAB width for the current size.
    readonly property real _collapsedWidth: UiMetrics.extendedFabContainerWidth(control)

    //! \internal The Extended FAB's natural labeled width.
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

    QtObject {
        id: state

        readonly property real containerHeight: UiMetrics.extendedFabContainerHeight(control)
        readonly property MD.shapeValue containerShape: UiMetrics.extendedFabContainerShape(control)
        readonly property real iconSize: UiMetrics.extendedFabIconSize(control)
        readonly property real expandedLeadingSpace: UiMetrics.extendedFabLeadingSpace(control)
        readonly property real expandedTrailingSpace: UiMetrics.extendedFabTrailingSpace(control)
        readonly property real iconLabelSpacing: UiMetrics.extendedFabSpacing(control)
        readonly property real collapsedIconPadding: (control._collapsedWidth - iconSize) / 2

        property real containerWidth: control._effectiveExpanded ? control._expandedWidth : control._collapsedWidth
        property color containerColor: control.containerColor
        property color contentColor: control.contentColor
        property color stateLayerColor: "transparent"
        property real elevation: control.lowered ? MD.Tokens.fab.loweredContainerElevation : MD.Tokens.fab.containerElevation
        property real stateLayerOpacity: 0

        Behavior on containerWidth {
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
        objectName: "extendedFabContent"

        clip: true
        text: control.text
        display: MD.IconLabel.TextBesideIcon
        mirrored: control.mirrored
        spacing: state.iconLabelSpacing
        typescale: control.typescale
        color: control.effectiveContentColor
        textOpacity: control._effectiveExpanded ? 1 : 0
        icon.name: control.effectiveIconName
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
        objectName: "extendedFabBackground"
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
            objectName: "extendedFabRipple"
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
