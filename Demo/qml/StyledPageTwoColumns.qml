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

StyledPage {
    id: page

    property alias leftColumn: leftColumn.data
    property alias rightColumn: rightColumn.data

    Row {
        anchors.fill: parent

        Item {
            id: leftColumn

            width: parent.width * 0.5
            height: parent.height
        }

        Item {
            id: rightColumn

            width: parent.width * 0.5
            height: parent.height
        }
    }
}
