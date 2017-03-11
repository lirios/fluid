/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import Fluid.Core 1.0

Label {
    property int level: 1

    font.pixelSize: Device.isMobile ? 16 : 15
    lineHeight: level <= 1 ? 24.0 : 28.0
    lineHeightMode: Text.FixedHeight
    onLevelChanged: {
        if (level < 1 || level > 2)
            console.error("SubheadingLabel level must be either 1 or 2 with the Material style")
    }
}
