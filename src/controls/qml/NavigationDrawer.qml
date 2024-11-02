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
import Fluid as Fluid

/*!
    \brief The navigation drawer slides in from the left and is a common pattern in apps.

    This is a temporary navigation drawer: it can toggle open or closed.
    Closed by default, this type of navigation drawer opens temporarily above all
    other content until a section is selected or the overlay is tapped.

    This navigation drawer comes with no contents, therefore it's completely customizable.

    By default the navigation drawer is permanent and pinned on desktop and
    temporary on mobile.

    \code{.qml}
    import Fluid as Fluid

    Fluid.ApplicationWindow {
        width: 400
        height: 400
        visible: true

        Fluid.Button {
            text: "Open"
            onClicked: drawer.open()
        }

        Fluid.NavigationDrawer {
            topContent: Image {
                source: "background.png"
                width: parent.width
                height: 200
            }

            Fluid.ListItem {
                icon.source: Fluid.Utils.iconUrl("content/inbox")
                text: "Inbox"
            }

            Fluid.ListItem {
                icon.source: Fluid.Utils.iconUrl("content/archive")
                text: "Archive"
            }

            Fluid.ListItem {
                icon.source: Fluid.Utils.iconUrl("action/settings")
                text: "Settings"
                showDivider: true
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/patterns/navigation-drawer.html">Material Design guidelines</a>.
*/
Drawer {
    id: drawer

    /*!
        The items added to this list will be displayed on top of the contents.
    */
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
        switch (Fluid.Device.formFactor) {
        case Fluid.Device.Phone:
            return 280;
        case Fluid.Device.Tablet:
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

    modal: Fluid.Device.isMobile
    interactive: Fluid.Device.isMobile
    position: Fluid.Device.isMobile ? 0.0 : 1.0
    visible: !Fluid.Device.isMobile

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
                NumberAnimation { duration: Fluid.Units.shortDuration }
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
                NumberAnimation { duration: Fluid.Units.shortDuration }
            }
        }
    }
}
