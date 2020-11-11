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
import QtQuick.Layouts 1.3
import Fluid.Controls 1.1 as FluidControls
import "../.." as Components

Components.StyledPage {
    FluidControls.Placeholder {
        anchors.centerIn: parent
        icon.source: FluidControls.Utils.iconUrl("social/notifications_none")
        text: qsTr("No notifications")
        subText: qsTr("At the moment there are no notifications available")
    }
}
