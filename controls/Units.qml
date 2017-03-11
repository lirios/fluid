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

pragma Singleton

import QtQuick 2.4
import Fluid.Core 1.0

/*!
    \qmltype Units
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Units.
*/
Item {
    /*
        \qmlproperty int gridUnit
        Fundamental unit of space for sizes depending on the current font.
        It correspond to the capital letter M width in pixel.
    */
    readonly property int gridUnit: textMetrics.height

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

    /*!
        \qmlproperty int shortDuration
        Duration for short animations to make UI events noticeable.
    */
    readonly property int shortDuration: 100

    /*!
        \qmlproperty int mediumDuration
        Duration for medium length animations.
    */
    readonly property int mediumDuration: 200

    /*!
        \qmlproperty int longDuration
        Duration for long animations such as windows opening or closing.
    */
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

    TextMetrics {
        id: textMetrics
        text: "M"
    }

    /*!
        Returns a round size in pixels multiplied by grid unit.
    */
    function gu(x) {
        return Math.round(x * gridUnit);
    }

    /*!
        Returns the size in pixel closes to the icon size.
    */
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
