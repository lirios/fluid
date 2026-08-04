/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Fluid as MD

Window {
    id: window

    visible: true

    width: 1024
    height: 800

    title: qsTr("Fluid Gallery")

    RowLayout {
        anchors.fill: parent

        ListView {
            Layout.preferredWidth: 200
            Layout.fillHeight: true

            model: ListModel {
                ListElement {
                    name: qsTr("Elevation")
                    source: "Elevation.qml"
                }
                ListElement {
                    name: qsTr("Symbols")
                    source: "Symbols.qml"
                }
                ListElement {
                    name: qsTr("Components")
                    source: "Components.qml"
                }
                ListElement {
                    name: qsTr("Icon Button")
                    source: "IconButton.qml"
                }
                ListElement {
                    name: qsTr("Indicators")
                    source: "Indicators.qml"
                }
                ListElement {
                    name: qsTr("Slider")
                    source: "Slider.qml"
                }
                ListElement {
                    name: qsTr("Lists")
                    source: "Lists.qml"
                }
                ListElement {
                    name: qsTr("Typography")
                    source: "Typography.qml"
                }
            }

            delegate: MD.ListItem {
                text: model.name

                onClicked: {
                    loader.source = model.source;
                }
            }
        }

        Loader {
            id: loader

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
