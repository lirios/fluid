/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0

ApplicationWindow {
    id: window

    visible: true

    width: 1024
    height: 800

    title: qsTr("Fluid Demo")

    appBar.maxActionCount: 3

    Material.primary: Material.LightBlue
    Material.accent: Material.Blue

    Universal.accent: Universal.Cobalt

    NavigationDrawer {
        id: navDrawer

        //width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        topContent: [
            Rectangle {
                color: Material.primary
                height: 48

                Label {
                    anchors.centerIn: parent
                    text: qsTr("Top Content")
                }

                Layout.fillWidth: true
            }
        ]

        actions: [
            Action {
                text: qsTr("Action 1")
                icon.name: "action/info"
                onTriggered: console.log("action1 triggered")
            },
            Action {
                text: qsTr("Action 2")
                icon.name: "action/info"
                hasDividerAfter: true
                onTriggered: console.log("action2 triggered")
            },
            Action {
                text: qsTr("Action 3")
                icon.name: "action/info"
                onTriggered: console.log("action3 triggered")
            },
            Action {
                text: qsTr("Action 4")
                icon.name: "action/info"
                onTriggered: console.log("action4 triggered")
            },
            Action {
                text: qsTr("Action 5")
                icon.name: "action/info"
                visible: false
                onTriggered: console.log("action5 triggered")
            }
        ]
    }

    initialPage: TabbedPage {
        title: window.title

        leftAction: Action {
            icon.name: "navigation/menu"
            onTriggered: navDrawer.open()
        }

        actions: [
            Action {
                text: qsTr("Dummy error")
                icon.name: "alert/warning"
                toolTip: qsTr("Show a dummy error")
                onTriggered: console.log("Dummy error")
            },
            Action {
                text: qsTr("Colors")
                icon.name: "image/color_lens"
                toolTip: qsTr("Pick a color")
                onTriggered: console.log("Colors")
            },
            Action {
                text: qsTr("Settings")
                icon.name: "action/settings"
                toolTip: qsTr("Settings")
                hoverAnimation: true
                onTriggered: console.log("Settings clicked")
            },
            Action {
                text: qsTr("This should not be visible")
                icon.name: "alert/warning"
                visible: false
            },
            Action {
                text: qsTr("Language")
                icon.name: "action/language"
                enabled: false
            },
            Action {
                text: qsTr("Accounts")
                icon.name: "action/account_circle"
            }
        ]

        BasicComponents {}
        LayoutComponents {}
        Controls {}
        Style {}
    }
}
