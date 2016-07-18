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
    \qmltype TitleLabel
    \inqmlmodule Fluid.Controls 1.0
    \brief Text label with standard font and styling suitable to titles.

    \code
    Title {
        text: qsTr("Translatable title")
    }
    \endcode
*/
T.Label {
    font.pixelSize: 18
    font.bold: true
    color: "#26282a"
    linkColor: "#45a7d7"
}
