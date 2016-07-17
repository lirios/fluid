 /*
  * Fluid - QtQuick components for fluid and dynamic applications
  *
  * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
  *
  * This Source Code Form is subject to the terms of the Mozilla Public
  * License, v. 2.0. If a copy of the MPL was not distributed with this
  * file, You can obtain one at http://mozilla.org/MPL/2.0/.
  */

import QtQuick 2.4
import QtQuick.Templates 2.0 as T
import QtQuick.Controls.Material 2.0
import Fluid.Core 1.0

T.Label {
    property int level: 1

    font.pixelSize: Device.isMobile ? 14 : 13
    font.weight: level == 1 ? Font.Normal : Font.Medium
    lineHeight: level <= 1 ? 20.0 : 24.0
    lineHeightMode: Text.FixedHeight
    linkColor: Material.accentColor
    onLevelChanged: {
        if (level < 1 || level > 2)
            console.error("BodyLabel level must be either 1 or 2")
    }
}
