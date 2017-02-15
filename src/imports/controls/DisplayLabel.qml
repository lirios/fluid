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

import QtQuick 2.0
import QtQuick.Templates 2.0 as T

/*!
    \qmltype DisplayLabel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Text label with standard font and styling suitable to display text.

    \code
    DisplayLabel {
        text: qsTr("Display text")
    }
    \endcode
*/
T.Label {
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
            return 30
        else if (level == 2)
            return 40
        else if (level == 3)
            return 50
        return 100
    }
    color: "#26282a"
    linkColor: "#45a7d7"
    onLevelChanged: {
        if (level < 1 || level > 4)
            console.error("DisplayLabel level must be between 1 and 4")
    }
}
