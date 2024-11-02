/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick
import QtQuick.Controls
import Fluid as Fluid

/*!
    \brief Represents a split sidebar in a page, with its own title, actions, and color
    in the app bar.
*/
Fluid.Page {
    id: pageSidebar

    default property alias sidebar: sidebar.data

    property alias edge: sidebar.edge
    property bool showing: true

    anchors.rightMargin: showing ? 0 : -width

    height: parent.height

    Behavior on anchors.rightMargin {
        id: behavior
        enabled: false

        NumberAnimation { duration: Fluid.Units.mediumDuration }
    }

    Fluid.Sidebar {
        id: sidebar

        anchors.fill: parent
    }

    Component.onCompleted: behavior.enabled = true
}
