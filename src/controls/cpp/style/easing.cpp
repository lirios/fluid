// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QPointF>

#include "easing.h"

namespace Fluid {

/*
 * Easing
 */

QEasingCurve Easing::emphasized() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // M 0,0 C 0.05,0 0.133333,0.06 0.166666,0.4 C 0.208333,0.82 0.25,1, 1, 1)
    curve.addCubicBezierSegment({ 0.05, 0 }, { 0.133333, 0.06 }, { 0.166666, 0.4 });
    curve.addCubicBezierSegment({ 0.208333, 0.82 }, { 0.25, 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::emphasizedAccelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.3, y0:0, x1:0.8, y1:0.15
    curve.addCubicBezierSegment({ 0.3, 0. }, { 0.8, 0.15 }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::emphasizedDecelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.05, y0:0.7, x1:0.1, y1:1
    curve.addCubicBezierSegment({ 0.05, 0.7 }, { 0.1, 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::standard() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.2, y0:0, x1:0, y1:1
    curve.addCubicBezierSegment({ 0.2, 0. }, { 0., 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::standardAccelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.3, y0:0, x1:1, y1:1
    curve.addCubicBezierSegment({ 0.3, 0. }, { 1., 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::standardDecelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0, y0:0, x1:0, y1:1
    curve.addCubicBezierSegment({ 0., 0. }, { 0., 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::legacy() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.4, y0:0, x1:0.2, y1:1
    curve.addCubicBezierSegment({ 0.4, 0. }, { 0.2, 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::legacyAccelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.4, y0:0, x1:1, y1:1
    curve.addCubicBezierSegment({ 0.4, 0. }, { 1., 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::legacyDecelerate() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0, y0:0, x1:0.2, y1:1
    curve.addCubicBezierSegment({ 0., 0. }, { 0.2, 1. }, { 1., 1. });
    return curve;
}

QEasingCurve Easing::linear() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0, y0:0, x1:1, y1:1
    curve.addCubicBezierSegment({ 0., 0. }, { 1., 1. }, { 1., 1. });
    return curve;
}

/*
 * Spring
 */

SpringValue Spring::standardFastSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.27, y0:1.07, x1:0.18, y1:1.0
    curve.addCubicBezierSegment({ 0.27, 1.07 }, { 0.18, 1.0 }, { 1., 1. });
    return { curve, 350 };
}

SpringValue Spring::standardDefaultSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 500 };
}

SpringValue Spring::standardSlowSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 700 };
}

SpringValue Spring::standardFastEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 150 };
}

SpringValue Spring::standardDefaultEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 250 };
}

SpringValue Spring::standardSlowEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 400 };
}

SpringValue Spring::expressiveFastSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.42, y0:1.67, x1:0.21, y1:0.90
    curve.addCubicBezierSegment({ 0.42, 1.67 }, { 0.21, 0.90 }, { 1., 1. });
    return { curve, 350 };
}

SpringValue Spring::expressiveDefaultSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.38, y0:1.21, x1:0.22, y1:1.00
    curve.addCubicBezierSegment({ 0.38, 1.21 }, { 0.22, 1.00 }, { 1., 1. });
    return { curve, 500 };
}

SpringValue Spring::expressiveSlowSpatial() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.39, y0:1.29, x1:0.35, y1:0.98
    curve.addCubicBezierSegment({ 0.39, 1.29 }, { 0.35, 0.98 }, { 1., 1. });
    return { curve, 650 };
}

SpringValue Spring::expressiveFastEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.31, y0:0.94, x1:0.34, y1:1.00
    curve.addCubicBezierSegment({ 0.31, 0.94 }, { 0.34, 1.00 }, { 1., 1. });
    return { curve, 150 };
}

SpringValue Spring::expressiveDefaultEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.34, y0:0.80, x1:0.34, y1:1.00
    curve.addCubicBezierSegment({ 0.34, 0.80 }, { 0.34, 1.00 }, { 1., 1. });
    return { curve, 200 };
}

SpringValue Spring::expressiveSlowEffects() const
{
    QEasingCurve curve(QEasingCurve::BezierSpline);
    // Cubic Bezier: x0:0.34, y0:0.88, x1:0.34, y1:1.00
    curve.addCubicBezierSegment({ 0.34, 0.88 }, { 0.34, 1.00 }, { 1., 1. });
    return { curve, 300 };
}

} // namespace Fluid
