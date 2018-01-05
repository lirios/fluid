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

/*!
    \qmltype DisplayLabel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Text label with standard font and styling suitable to display text.

    Text label for the Material Design display text style.

    \snippet fluidcontrols-displaylabel.qml file

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

    font.pixelSize: {
        if (level <= 1)
            return 34;
        else if (level == 2)
            return 45;
        else if (level == 3)
            return 56;
        return 112;
    }
    lineHeight: {
        if (level <= 1)
            return 40.0;
        else if (level == 2)
            return 48.0;
        return 1.0;
    }
    lineHeightMode: {
        if (level <= 2)
            return Text.FixedHeight;
        return Text.ProportionalHeight;
    }
    font.weight: level >= 4 ? Font.Light : Font.Normal

    onLevelChanged: {
        if (level < 1 || level > 4)
            console.error("DisplayLabel level must be between 1 and 4");
    }
}
