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
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype NavigationDrawer
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief The navigation drawer slides in from the left and is a common pattern in apps.

    This is a temporary navigation drawer: it can toggle open or closed.
    Closed by default, this type of navigation drawer opens temporarily above all
    other content until a section is selected or the overlay is tapped.

    This navigation drawer comes with no contents, therefore it's completely customizable.

    By default the navigation drawer is permanent and pinned on desktop and
    temporary on mobile.

    \code
    import Fluid.Controls 2.0 as FluidControls

    FluidControls.ApplicationWindow {
        width: 400
        height: 400
        visible: true

        Button {
            text: "Open"
            onClicked: drawer.open()
        }

        FluidControls.NavigationDrawer {
            topContent: Image {
                source: "background.png"
                width: parent.width
                height: 200
            }

            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("content/inbox")
                text: "Inbox"
            }

            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("content/archive")
                text: "Archive"
            }

            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/settings")
                text: "Settings"
                showDivider: true
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/patterns/navigation-drawer.html}{Material Design guidelines}.
*/
Drawer {
    id: drawer

    /*!
        \qmlproperty list<Item> topContent

        The items added to this list will be displayed on top of the contents.
    */
    property alias topContent: topItem.data

    /*!
        \internal
    */
    default property alias contents: mainitem.data

    y: {
        if (ApplicationWindow && ApplicationWindow.header)
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
            break;
        }
        return 56 * 4;
    }
    height: {
        if (ApplicationWindow)
            return (ApplicationWindow.header ? ApplicationWindow.header.height : 0) +
                    (ApplicationWindow.contentItem ? ApplicationWindow.contentItem.height : 0);
        else if (Window)
            return Window.contentItem;
        else
            return parent.height;
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
        }

        Item {
            id: mainitem

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: drawer.padding

            height: pane.height - topItem.height
            visible: children.length > 0
        }
    }
}
