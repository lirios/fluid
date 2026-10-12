// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "MotionAnimation.js" as MotionAnimation

MD.ElevationRectangle {
    id: surface

    required property bool leading
    required property bool mirrored
    required property bool partEnabled
    required property bool hovered
    required property bool focused
    required property bool pressed
    required property bool expanded
    required property real restingInnerRadius
    required property real hoveredInnerRadius
    required property real pressedInnerRadius
    required property MD.shapeValue outerShape
    required property MD.shapeValue expandedShape
    required property color containerColor
    required property color contentColor
    required property color outlineColor
    required property real containerOpacity
    required property real outlineWidth
    required property real selectedOpacity
    required property real leadingPadding
    required property real trailingPadding
    required property real opticalCoefficient

    readonly property real surfaceHeight: height
    readonly property real maximumRadius: Math.max(0, Math.min(width, height) / 2)
    readonly property real outerRadius: Math.min(maximumRadius,
        UiMetrics.resolveShapeRadius(outerShape.topLeft, width, height))
    property real animatedInnerRadius: !leading && expanded
        ? UiMetrics.resolveShapeRadius(expandedShape.topLeft, width, height)
        : partEnabled && pressed ? pressedInnerRadius
        : partEnabled && (focused || hovered) ? hoveredInnerRadius : restingInnerRadius
    readonly property real innerRadius: Math.max(0, Math.min(maximumRadius, animatedInnerRadius))
    readonly property bool outerOnLeft: leading !== mirrored
    readonly property real logicalStartRadius: leading ? outerRadius : innerRadius
    readonly property real logicalEndRadius: leading ? innerRadius : outerRadius
    readonly property real opticalOffset: Math.max(-leadingPadding, Math.min(trailingPadding,
        opticalCoefficient * (logicalStartRadius - logicalEndRadius)))
    readonly property real stateOpacity: !partEnabled ? 0
        : pressed ? MD.Tokens.state.pressedStateLayerOpacity
        : !leading && expanded ? selectedOpacity
        : focused ? MD.Tokens.state.focusStateLayerOpacity
        : hovered ? MD.Tokens.state.hoverStateLayerOpacity : 0

    color: Qt.alpha(containerColor, containerColor.a * containerOpacity)
    topLeftRadius: outerOnLeft ? outerRadius : innerRadius
    bottomLeftRadius: topLeftRadius
    topRightRadius: outerOnLeft ? innerRadius : outerRadius
    bottomRightRadius: topRightRadius
    border.width: outlineWidth
    border.color: outlineColor

    Behavior on animatedInnerRadius {
        NumberAnimation {
            duration: MotionAnimation.standardSpringDuration(MD.Tokens.motion.spring.standardFastSpatial)
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.standardSpringCurve(MD.Tokens.motion.spring.standardFastSpatial)
        }
    }

    Rectangle {
        objectName: surface.leading ? "splitButtonLeadingStateLayer" : "splitButtonTrailingStateLayer"
        anchors.fill: parent
        color: surface.contentColor
        opacity: surface.stateOpacity
        topLeftRadius: surface.topLeftRadius
        topRightRadius: surface.topRightRadius
        bottomLeftRadius: surface.bottomLeftRadius
        bottomRightRadius: surface.bottomRightRadius
        Accessible.ignored: true

        Behavior on opacity {
            NumberAnimation {
                duration: MotionAnimation.standardSpringDuration(MD.Tokens.motion.spring.standardFastEffects)
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.standardSpringCurve(MD.Tokens.motion.spring.standardFastEffects)
            }
        }
    }
}
