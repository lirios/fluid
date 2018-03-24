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
    \qmltype CaptionLabel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Text label with standard font and styling suitable to captions.

    Text label for the Material Design caption text style.

    \snippet fluidcontrols-captionlabel.qml file

    For more information you can read the
    \l{https://material.io/guidelines/style/typography.html}{Material Design guidelines}.
*/
Label {
    font.pixelSize: 12
}
