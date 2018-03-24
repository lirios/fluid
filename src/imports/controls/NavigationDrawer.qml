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

    NavigationDrawer is recommended on phones and tablets.

    This navigation drawer comes with no contents, therefore it's completely customizable.

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

                Layout.fillWidth: true
                Layout.preferredHeight: 200
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
    property alias topContent: topContent.data

    /*!
        \internal
    */
    default property alias contents: mainLayout.data

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

    padding: 0

    Material.elevation: interactive ? 4 : 0

    Pane {
        id: pane

        anchors.fill: parent
        padding: 0

        ColumnLayout {
            id: mainLayout

            anchors.fill: parent
            spacing: 0

            ColumnLayout {
                id: topContent

                spacing: 0
                visible: children.length > 0

                Layout.margins: drawer.padding
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
