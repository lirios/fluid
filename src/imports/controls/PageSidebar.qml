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

import QtQuick 2.10
import QtQuick.Controls 2.3
import Fluid.Controls 1.1 as FluidControls

FluidControls.Page {
    id: pageSidebar

    default property alias sidebar: sidebar.data

    property alias edge: sidebar.edge
    property bool showing: true

    anchors.rightMargin: showing ? 0 : -width

    height: parent.height

    Behavior on anchors.rightMargin {
        id: behavior
        enabled: false

        NumberAnimation { duration: FluidControls.Units.mediumDuration }
    }

    FluidControls.Sidebar {
        id: sidebar

        anchors.fill: parent
    }

    Component.onCompleted: behavior.enabled = true
}
