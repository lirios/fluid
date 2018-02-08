/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Controls.Material 2.3

/*!
   \qmltype ThinDivider
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief A 1px high divider for use in lists and other columns of content.
 */
Rectangle {
    color: Material.dividerColor
    width: parent.width
    height: 1
}
