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
        anchors.margins: 24
        spacing: 24

        ListView {
            Layout.fillHeight: true
            Layout.preferredWidth: 200

            model: ListModel {
                ListElement {
                    name: "Components"
                    source: "Components.qml"
                }
                ListElement {
                    name: "Elevation"
                    source: "Elevation.qml"
                }
                ListElement {
                    name: "Symbols"
                    source: "Symbols.qml"
                }
            }

            delegate: MD.Label {
                text: model.name
                padding: 12

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        loader.source = model.source;
                    }
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
