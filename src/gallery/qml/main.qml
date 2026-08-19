// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Fluid as MD

MD.ApplicationWindow {
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
                    name: qsTr("Divider")
                    source: "Divider.qml"
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
