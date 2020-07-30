/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

pragma Singleton

import QtQuick 2.10
import Fluid.Core 1.0

Item {
    readonly property int gridUnit: textMetrics.height

    readonly property real smallSpacing: 8
    readonly property real mediumSpacing: 20
    readonly property real largeSpacing: 24

    readonly property int shortDuration: 100
    readonly property int mediumDuration: 200
    readonly property int longDuration: 400

    readonly property QtObject iconSizes: QtObject {
        readonly property int tiny: 8
        readonly property int small: 16
        readonly property int smallMedium: 22
        readonly property int medium: 32
        readonly property int large: 48
        readonly property int huge: 64
        readonly property int enormous: 128
    }

    TextMetrics {
        id: textMetrics
        text: "M"
    }

    function gu(x) {
        return Math.round(x * gridUnit);
    }

    function roundToIconSize(x) {
        // Find the size closest to icon size
        if (x <= 0)
            return 0;
        else if (x < 8)
            return 8;
        else if (x < 16)
            return 16;
        else if (x < 22)
            return 22;
        else if (x < 32)
            return 32;
        else if (x < 48)
            return 48;
        else if (x < 64)
            return 64;
        else if (x < 128)
            return 128;

        return x;
    }
}
