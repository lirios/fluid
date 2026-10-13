// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD
import "MotionAnimation.js" as MotionAnimation
import "../core/UiMetrics.js" as UiMetrics

Rectangle {
    id: root
    required property bool primary
    required property real targetX
    required property real targetWidth
    required property color indicatorColor
    required property bool animationEnabled
    readonly property MD.shapeValue indicatorShape: primary
        ? MD.Tokens.tab.primaryActiveIndicatorShape : MD.Tokens.tab.secondaryActiveIndicatorShape

    objectName: "tabIndicator"
    x: targetX
    width: targetWidth
    height: primary ? MD.Tokens.tab.primaryActiveIndicatorHeight
                    : MD.Tokens.tab.secondaryActiveIndicatorHeight
    color: indicatorColor
    topLeftRadius: Math.min(width / 2, height / 2,
                           UiMetrics.resolveShapeRadius(indicatorShape.topLeft, width, height))
    topRightRadius: Math.min(width / 2, height / 2,
                            UiMetrics.resolveShapeRadius(indicatorShape.topRight, width, height))
    bottomLeftRadius: Math.min(width / 2, height / 2,
                              UiMetrics.resolveShapeRadius(indicatorShape.bottomLeft, width, height))
    bottomRightRadius: Math.min(width / 2, height / 2,
                               UiMetrics.resolveShapeRadius(indicatorShape.bottomRight, width, height))
    Accessible.ignored: true

    // Pinned AndroidX TabRow.kt uses the motion scheme's DefaultSpatial spring.
    Behavior on x {
        enabled: root.animationEnabled
        NumberAnimation {
            duration: MotionAnimation.standardSpringDuration(MD.Tokens.motion.spring.standardDefaultSpatial)
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.standardSpringCurve(MD.Tokens.motion.spring.standardDefaultSpatial)
        }
    }
    Behavior on width {
        enabled: root.animationEnabled
        NumberAnimation {
            duration: MotionAnimation.standardSpringDuration(MD.Tokens.motion.spring.standardDefaultSpatial)
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.standardSpringCurve(MD.Tokens.motion.spring.standardDefaultSpatial)
        }
    }
}
