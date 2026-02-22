// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

Item {
    MD.ScrollView {
        anchors.fill: parent

        Column {
            anchors.fill: parent

            MD.Switch {
                id: emphasizedSwitch

                text: qsTr("Use emphasized typescales")
            }

            Repeater {
                model: ListModel {
                    ListElement {
                        name: "displayLarge"
                        label: qsTr("Display Large")
                    }
                    ListElement {
                        name: "displayMedium"
                        label: qsTr("Display Medium")
                    }
                    ListElement {
                        name: "displaySmall"
                        label: qsTr("Display Small")
                    }
                    ListElement {
                        name: "headlineLarge"
                        label: qsTr("Headline Large")
                    }
                    ListElement {
                        name: "headlineMedium"
                        label: qsTr("Headline Medium")
                    }
                    ListElement {
                        name: "headlineSmall"
                        label: qsTr("Headline Small")
                    }
                    ListElement {
                        name: "titleLarge"
                        label: qsTr("Title Large")
                    }
                    ListElement {
                        name: "titleMedium"
                        label: qsTr("Title Medium")
                    }
                    ListElement {
                        name: "titleSmall"
                        label: qsTr("Title Small")
                    }
                    ListElement {
                        name: "bodyLarge"
                        label: qsTr("Body Large")
                    }
                    ListElement {
                        name: "bodyMedium"
                        label: qsTr("Body Medium")
                    }
                    ListElement {
                        name: "bodySmall"
                        label: qsTr("Body Small")
                    }
                    ListElement {
                        name: "labelLarge"
                        label: qsTr("Label Large")
                    }
                    ListElement {
                        name: "labelMedium"
                        label: qsTr("Label Medium")
                    }
                    ListElement {
                        name: "labelSmall"
                        label: qsTr("Label Small")
                    }
                }

                MD.Label {
                    typescale: emphasizedSwitch ? MD.Tokens.emphasizedTypeScale[model.name] : MD.Tokens.typescale[model.name]
                    text: model.label
                }
            }
        }
    }
}
