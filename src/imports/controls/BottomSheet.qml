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

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid.Controls as FluidControls

Drawer {
    id: bottomSheet

    /*!
        \internal
    */
    default property alias content: containerPane.data

    property int maxHeight: ApplicationWindow.contentItem.height - ApplicationWindow.header.height

    modal: true
    edge: Qt.BottomEdge

    width: parent.width
    height: Math.min(containerPane.childrenRect.height, maxHeight)

    Pane {
        id: containerPane

        width: parent.width
        height: parent.height
    }
}
