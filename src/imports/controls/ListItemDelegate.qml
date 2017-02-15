/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Fluid.Material 1.0

/*!
    \qmltype ListItemDelegate
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief A delegate for list views.
*/
ItemDelegate {
    Layout.fillWidth: true

    property int dividerInset: 0
    property bool showDivider: false
    property bool interactive: true

    width: parent ? parent.width : undefined

    leftPadding: 16
    rightPadding: 16
    topPadding: 0
    bottomPadding: 0

    opacity: enabled ? 1 : 0.6
}
