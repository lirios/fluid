/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2024 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Controls as C
import Fluid as Fluid

C.Button {
    C.ToolTip.delay: Fluid.Device.isMobile ? Qt.styleHints.mousePressAndHoldInterval : 0
    C.ToolTip.visible: C.ToolTip.text ? Fluid.Device.isMobile ? pressed : hovered : false

    hoverEnabled: Fluid.Device.hoverEnabled
}
