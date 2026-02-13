// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import Fluid as MD

Rectangle {
    property MD.corners corners: radius

    bottomLeftRadius: corners.bottomLeft
    bottomRightRadius: corners.bottomRight
    topLeftRadius: corners.topLeft
    topRightRadius: corners.topRight
}
