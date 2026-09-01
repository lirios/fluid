// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import QtQuick.Shapes as QQS

/*!
    \class Shape
    \internal
    \brief Provides the shared synchronous shape renderer for Fluid visuals.

    Shape is an internal rendering wrapper used by Fluid controls and effects;
    it has no standalone Material 3 component specification.
*/
QQS.Shape {
    asynchronous: false
    preferredRendererType: QQS.Shape.CurveRenderer
    Accessible.ignored: true
}
