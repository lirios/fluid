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

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

/*!
    \qmltype IconButton
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Tool button with an \l Icon.
*/
ToolButton {
    id: iconButton

    property alias iconName: icon.name
    property alias iconSource: icon.source
    property alias iconSize: icon.size
    property alias iconColor: icon.color

    property bool hoverAnimation: false

    indicator: Icon {
        id: icon

        anchors.centerIn: parent
        rotation: iconButton.hoverAnimation && iconButton.hovered ? 90 : 0

        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }
}
