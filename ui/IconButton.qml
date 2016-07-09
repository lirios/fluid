/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

ToolButton {
    id: iconButton

    property alias iconName: icon.name
    property alias iconSource: icon.source
    property alias iconSize: icon.size
    property alias iconColor: icon.color

    indicator: Icon {
        id: icon

        anchors.centerIn: parent
    }
}
