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
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid.Core as FluidCore
import Fluid.Controls as FluidControls

Drawer {
    id: drawer

    property alias topContent: topItem.data

    /*!
        \internal
    */
    default property alias contents: mainitem.data

    y: {
        if (!modal && ApplicationWindow && ApplicationWindow.header)
            return ApplicationWindow.header.height;
        return 0;
    }
    width: {
        switch (FluidCore.Device.formFactor) {
        case FluidCore.Device.Phone:
            return 280;
        case FluidCore.Device.Tablet:
            return 320;
        default:
            return 56 * 4;
        }
    }
    height: {
        if (ApplicationWindow)
            return (ApplicationWindow.header ? ApplicationWindow.header.height : 0) +
                    (ApplicationWindow.contentItem ? ApplicationWindow.contentItem.height : 0) - y;
        else if (Window)
            return Window.contentItem - y;
        else
            return parent.height - y;
    }

    modal: FluidCore.Device.isMobile
    interactive: FluidCore.Device.isMobile
    position: FluidCore.Device.isMobile ? 0.0 : 1.0
    visible: !FluidCore.Device.isMobile

    padding: 0

    Material.elevation: interactive ? 4 : 0

    Pane {
        id: pane

        anchors.fill: parent
        padding: 0

        Item {
            id: topItem

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: drawer.padding

            height: childrenRect.height
            visible: height > 0

            Behavior on height {
                NumberAnimation { duration: FluidControls.Units.shortDuration }
            }
        }

        Item {
            id: mainitem

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: drawer.padding

            height: pane.height - topItem.height
            visible: children.length > 0

            Behavior on height {
                NumberAnimation { duration: FluidControls.Units.shortDuration }
            }
        }
    }
}
