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

    font.pixelSize: {
        if (level <= 1)
            return 34
        else if (level == 2)
            return 45
        else if (level == 3)
            return 56
        return 112
    }
    lineHeight: {
        if (level <= 1)
            return 40.0
        else if (level == 2)
            return 48.0
        return 1.0
    }
    lineHeightMode: {
        if (level <= 2)
            return Text.FixedHeight
        return Text.ProportionalHeight
    }
    font.weight: level >= 4 ? Font.Light : Font.Normal
    linkColor: Material.accentColor
    onLevelChanged: {
        if (level < 1 || level > 4)
            console.error("DisplayLabel level must be between 1 and 4")
    }
}
