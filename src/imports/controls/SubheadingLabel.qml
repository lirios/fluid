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

import QtQuick 2.10
import QtQuick.Controls 2.3
import Fluid.Core 1.0 as FluidCore

/*!
    \qmltype SubheadingLabel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Text label with standard font and styling suitable to subheading.

    Text label for the Material Design subheading text style.

    \snippet fluidcontrols-subheadinglabel.qml file

    For more information you can read the
    \l{https://material.io/guidelines/style/typography.html}{Material Design guidelines}.
*/
Label {
    /*!
        \qmlproperty int level

        This property holds the label level that controls
        font style and size.

        Only values between 1 and 4 are allowed.

        Default value is 1.
    */
    property int level: 1

    font.pixelSize: FluidCore.Device.isMobile ? 16 : 15
    lineHeight: level <= 1 ? 24.0 : 28.0
    lineHeightMode: Text.FixedHeight

    onLevelChanged: {
        if (level < 1 || level > 2)
            console.error("BodyLabel level must be either 1 or 2");
    }
}
