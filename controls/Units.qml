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

    /*!
        \qmlproperty real smallSpacing
        The amount of spacing that should be used around smaller UI
        elements. It can be used as margin around button box and
        spacing between buttons.
    */
    readonly property real smallSpacing: 8

    /*!
        \qmlproperty real mediumSpacing
        The amount of spacing that should be used inside medium UI
        elements such as padding between title and body text in a dialog box.
    */
    readonly property real mediumSpacing: 20

    /*!
        \qmlproperty real largeSpacing
        The amount of spacing that should be used inside bigger UI
        elements such as padding in a dialog box.
    */
    readonly property real largeSpacing: 24

    readonly property int shortDuration: 100
    readonly property int mediumDuration: 200
    readonly property int longDuration: 400

    /*!
        \qmlproperty object iconSizes
        Standard icon sizes.
    */
    readonly property QtObject iconSizes: QtObject {
        readonly property int tiny: 8
        readonly property int small: 16
        readonly property int smallMedium: 22
        readonly property int medium: 32
        readonly property int large: 48
        readonly property int huge: 64
        readonly property int enormous: 128
    }

    id: units

    FontMetrics {
        property real mSize

        id: fontMetrics
        onFontChanged: updateMSize()

        Component.onCompleted: updateMSize()

        function updateMSize() {
            mSize = fontMetrics.boundingRect("M").height;
            if (mSize % 2 != 0)
                mSize++;
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
