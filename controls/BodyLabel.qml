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
    \qmltype BodyLabel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Text label with standard font and styling suitable to body text.

    \code
    BodyLabel {
        text: qsTr("Body text")
    }
    \endcode
*/
T.Label {
    /*!
        \qmlproperty int level

        This property holds the label level that controls
        font style and size.

        It can be either 1 or 2.

        Default value is 1.
    */
    property int level: 1

    font.pixelSize: 14
    color: "#26282a"
    linkColor: "#45a7d7"
    onLevelChanged: {
        if (level < 1 || level > 2)
            console.error("BodyLabel level must be either 1 or 2")
    }
}
