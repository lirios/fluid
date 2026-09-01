// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "MotionAnimation.js" as MotionAnimation

/*!
    \class NavigationRailItemIndicator
    \internal
    \brief Renders the selection and interaction indicator for a navigation rail item.

    This bound delegate owns the animated Material shape and ripple used by
    NavigationRailItem. Its geometry and interaction state are supplied
    explicitly by the public control.
*/
Rectangle {
    id: indicator
    Accessible.ignored: true

    //! \internal Whether the destination is selected.
    property bool selected: false

    //! \internal Whether the destination is currently pressed.
    property bool pressed: false

    //! \internal Horizontal press coordinate in this delegate.
    property real pressX: width / 2

    //! \internal Vertical press coordinate in this delegate.
    property real pressY: height / 2

    //! \internal Selected indicator fill color.
    property color selectedColor: "transparent"

    //! \internal Interaction state-layer color.
    property color stateLayerColor: "transparent"

    //! \internal Interaction state-layer opacity.
    property real stateLayerOpacity: 0

    readonly property var _shape: MD.Tokens.navigationRail.activeIndicatorShape

    color: selected ? selectedColor : "transparent"
    topLeftRadius: UiMetrics.resolveShapeRadius(_shape.topLeft, width, height)
    topRightRadius: UiMetrics.resolveShapeRadius(_shape.topRight, width, height)
    bottomLeftRadius: UiMetrics.resolveShapeRadius(_shape.bottomLeft, width, height)
    bottomRightRadius: UiMetrics.resolveShapeRadius(_shape.bottomRight, width, height)

    Behavior on color {
        ColorAnimation {
            duration: MotionAnimation.expressiveFastEffectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
        }
    }

    MD.Ripple {
        anchors.fill: parent
        topLeftRadius: indicator.topLeftRadius
        topRightRadius: indicator.topRightRadius
        bottomLeftRadius: indicator.bottomLeftRadius
        bottomRightRadius: indicator.bottomRightRadius
        pressed: indicator.pressed
        pressX: indicator.pressX
        pressY: indicator.pressY
        stateOpacity: indicator.stateLayerOpacity
        color: indicator.stateLayerColor
    }
}
