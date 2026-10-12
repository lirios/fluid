// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

.pragma library

// Qt NumberAnimation adapters retained for controls that cannot consume the physical
// damping/stiffness values exposed by MD.Tokens.motion.spring directly. These are not
// Material system tokens.
var expressiveFastSpatialCurve = [0.42, 1.67, 0.21, 0.90, 1.0, 1.0]
var expressiveFastSpatialDuration = 350
var expressiveDefaultSpatialCurve = [0.38, 1.21, 0.22, 1.00, 1.0, 1.0]
var expressiveDefaultSpatialDuration = 400
var expressiveFastEffectsCurve = [0.31, 0.94, 0.34, 1.00, 1.0, 1.0]
var expressiveFastEffectsDuration = 150
var expressiveSlowEffectsCurve = [0.34, 0.88, 0.34, 1.00, 1.0, 1.0]
var expressiveSlowEffectsDuration = 300

// Analytic unit-mass spring adapters for the standard scheme. Sample the physical
// damping/stiffness tokens into piecewise cubic Hermite curves for NumberAnimation.
// This keeps the platform approximation private and restarts from the current value
// when a Behavior is interrupted. Source: pinned AndroidX MotionScheme.kt and
// tokens/StandardMotionTokens.kt, VERSION v0_14_0.
function standardSpringDuration(spring) {
    return Math.ceil(1000 * Math.log(1000) / (spring.damping * Math.sqrt(spring.stiffness)));
}

function standardSpringCurve(spring) {
    const omega = Math.sqrt(spring.stiffness);
    const damping = spring.damping;
    const seconds = standardSpringDuration(spring) / 1000;
    function value(t) {
        if (damping >= 1)
            return 1 - (1 + omega * t) * Math.exp(-omega * t);
        const wd = omega * Math.sqrt(1 - damping * damping);
        return 1 - Math.exp(-damping * omega * t)
               * (Math.cos(wd * t) + damping * omega / wd * Math.sin(wd * t));
    }
    function slope(t) {
        if (damping >= 1)
            return omega * omega * t * Math.exp(-omega * t);
        const wd = omega * Math.sqrt(1 - damping * damping);
        return omega * omega / wd * Math.exp(-damping * omega * t) * Math.sin(wd * t);
    }
    const curve = [];
    // Qt's BezierEase allocates ten curve/interval slots and does not resize them
    // in init(). Keep the analytic approximation within that native capacity.
    // https://code.qt.io/cgit/qt/qtbase.git/tree/src/corelib/tools/qeasingcurve.cpp
    const count = 10;
    const end = value(seconds);
    for (let i = 0; i < count; ++i) {
        const startT = seconds * i / count;
        const endT = seconds * (i + 1) / count;
        const interval = seconds / count;
        curve.push((i + 1 / 3) / count, (value(startT) + slope(startT) * interval / 3) / end,
                   (i + 2 / 3) / count, (value(endT) - slope(endT) * interval / 3) / end,
                   (i + 1) / count, i === count - 1 ? 1 : value(endT) / end);
    }
    return curve;
}
