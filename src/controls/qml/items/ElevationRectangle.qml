/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2024-2025 hypengw <hypengwip@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick
import Fluid as MD

MD.Rectangle {
    id: root

    property alias elevation: shadow.elevation
    property alias elevationItem: shadow
    property alias elevationVisible: shadow.visible

    MD.Elevation {
        id: shadow

        z: -1
        corners: root.corners
        width: root.width
        height: root.height
        // visible: !MD.Util.epsilonEqual(elevation, MD.Token.elevation.level0) && root.color.a > 0
    }
}
