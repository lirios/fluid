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

import QtQuick.Controls 2.0 as C
import QtQuick.Controls.Material 2.0

/*!
    \qmltype Card
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Cards display content composed of different elements.

    \snippet fluidcontrols-card.qml file

    For more information you can read the
    \l{https://material.io/guidelines/components/cards.html}{Material Design guidelines}.
*/
C.Pane {
    padding: 0

    Material.background: "white"
    Material.elevation: 1
}
