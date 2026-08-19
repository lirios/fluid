// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import Fluid as MD

Rectangle {
    id: root

    property alias elevation: shadow.elevation
    property alias elevationItem: shadow
    property alias elevationVisible: shadow.visible

    MD.Elevation {
        id: shadow

        z: -1

        radius: root.radius
        topLeftRadius: root.topLeftRadius
        topRightRadius: root.topRightRadius
        bottomLeftRadius: root.bottomLeftRadius
        bottomRightRadius: root.bottomRightRadius

        width: root.width
        height: root.height

        visible: !MD.Utils.epsilonEqual(elevation, MD.Tokens.elevationLevel0) && root.color.a > 0
    }
}
