/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
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

FluidWindow {
    id: window

    visible: true

    width: 1024
    height: 800

    title: qsTr("Fluid Demo")

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
                onTriggered: console.log("action1 triggered")
            },
            Action {
                text: qsTr("Action 2")
                onTriggered: console.log("action2 triggered")
            },
            Action {
                text: qsTr("Action 3")
                onTriggered: console.log("action3 triggered")
            }
        ]
    }

    initialPage: Page {
        header: ToolBar {
            TabBar {
                id: bar
                width: parent.width

                TabButton {
                    text: qsTr("Basic components")
                }

                TabButton {
                    text: qsTr("Compound components")
                }

                TabButton {
                    text: qsTr("Material components")
                }

                TabButton {
                    text: qsTr("Navigation components")
                }

                TabButton {
                    text: qsTr("Style")
                }
            }
        }

        StackLayout {
            anchors.fill: parent
            currentIndex: bar.currentIndex

            BasicComponents {}
            CompoundComponents {}
            MaterialComponents {}
            NavigationComponents {}
            Style {}
        }
    }
}
