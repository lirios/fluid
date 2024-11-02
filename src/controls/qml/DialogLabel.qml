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

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
    \brief Text label with standard font and styling suitable to message box text.

    Text label for the Material Design dialog text style.

    \code{.qml}
    import Fluid as Fluid

    Fluid.DialogLabel {
        text: "Text to display"
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/style/typography.html">Material Design guidelines</a>.
*/
Label {
    font.pixelSize: Fluid.Device.isMobile ? 18 : 17
    color: Material.secondaryTextColor
}
