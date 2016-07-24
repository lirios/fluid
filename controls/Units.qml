/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

pragma Singleton

import QtQuick 2.5
import Fluid.Core 1.0

Item {
    readonly property alias gridUnit: fontMetrics.mSize
    readonly property alias smallSpacing: fontMetrics.smallSpacing
    readonly property alias largeSpacing: fontMetrics.mSize
    readonly property int shortDuration: 100
    readonly property int mediumDuration: 200
    readonly property int longDuration: 400
    readonly property QtObject iconSizes: QtObject {
        readonly property alias tiny: fontMetrics.tinyIconSize
        readonly property alias small: fontMetrics.smallIconSize
        readonly property alias smallMedium: fontMetrics.smallMediumIconSize
        readonly property alias medium: fontMetrics.mediumIconSize
        readonly property alias large: fontMetrics.largeIconSize
        readonly property alias huge: fontMetrics.hugeIconSize
        readonly property alias enormous: fontMetrics.enormousIconSize
    }

    id: units

    FontMetrics {
        property real mSize
        property real smallSpacing
        property real tinyIconSize
        property real smallIconSize
        property real smallMediumIconSize
        property real mediumIconSize
        property real largeIconSize
        property real hugeIconSize
        property real enormousIconSize

        id: fontMetrics
        onFontChanged: updateMSize()

        Component.onCompleted: updateMSize()

        function updateMSize() {
            mSize = fontMetrics.boundingRect("M").height;
            if (mSize % 2 != 0)
                mSize++;

            smallSpacing = Math.max(2, mSize / 4)

            tinyIconSize = calcIconSize(8);
            smallIconSize = calcIconSize(16);
            smallMediumIconSize = calcIconSize(22);
            mediumIconSize = calcIconSize(32);
            largeIconSize = calcIconSize(48);
            hugeIconSize = calcIconSize(64);
            enormousIconSize = calcIconSize(128);
        }

        function calcIconSize(x) {
            return x;
        }
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
            return 8;
        else if (x < 22)
            return 16;
        else if (x < 32)
            return 22;
        else if (x < 48)
            return 32;
        else if (x < 64)
            return 48;
        else if (x < 128)
            return 64;

        return x;
    }
}
