 /*
  * Fluid - QtQuick components for fluid and dynamic applications
  *
  * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
  *
  * This Source Code Form is subject to the terms of the Mozilla Public
  * License, v. 2.0. If a copy of the MPL was not distributed with this
  * file, You can obtain one at http://mozilla.org/MPL/2.0/.
  */

import QtQuick 2.0
import QtQuick.Templates 2.0 as T

/*!
    \qmltype SubheadingLabel
    \inqmlmodule Fluid.Controls 1.0
    \brief Text label with standard font and styling suitable to subheading.

    \code
    SubheadingLabel {
        text: qsTr("A translatable subheading")
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

    font.pixelSize: 14
    color: "#26282a"
    linkColor: "#45a7d7"
    onLevelChanged: {
        if (level < 1 || level > 2)
            console.error("BodyLabel level must be either 1 or 2")
    }
}
