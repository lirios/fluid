// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

.pragma library

// Qt NumberAnimation adapters retained for controls that cannot consume the physical
// damping/stiffness values exposed by MD.Tokens.motion.spring directly. These are not
// Material system tokens.
var expressiveFastSpatialCurve = [0.42, 1.67, 0.21, 0.90, 1.0, 1.0]
var expressiveFastSpatialDuration = 350
var expressiveFastEffectsCurve = [0.31, 0.94, 0.34, 1.00, 1.0, 1.0]
var expressiveFastEffectsDuration = 150
