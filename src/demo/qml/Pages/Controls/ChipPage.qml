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
import Fluid.Controls 1.1

Item {
    Row {
        anchors.centerIn: parent
        spacing: 16
        Chip {
            caption: qsTr("Chip")
        }
        Chip {
            caption: qsTr("Deletable chip")
            deletable: true
        }
        Chip {
            caption: qsTr("Chip with icon")
            icon.source: Utils.iconUrl("action/face")
        }
        Chip {
            caption: qsTr("Deletable chip with icon")
            icon.source: Utils.iconUrl("social/person")
            deletable: true
        }
    }
}
