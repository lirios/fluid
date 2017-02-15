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
import QtQuick.Controls 2.0
import Fluid.Material 1.0

ListItemDelegate {
    id: listItem

    background: Rectangle {
        color: listItem.highlighted ? Qt.rgba(0,0,0,0.05)
                                    : ripple.containsMouse ? Qt.rgba(0,0,0,0.03)
                                                           : Qt.rgba(0,0,0,0)

        Ripple {
            id: ripple
            width: parent.width
            height: parent.height
            enabled: interactive

            control: listItem
        }

        ThinDivider {
            x: dividerInset
            y: parent.height - height

            width: parent.width - x

            visible: showDivider
        }
    }
}
