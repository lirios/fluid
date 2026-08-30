// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property int sectionSpacing: 24

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: page.sectionSpacing

        MD.Switch {
            id: segmentedSwitch

            text: qsTr("Segmented")
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: page.sectionSpacing

            MD.ScrollView {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 400

                ListView {
                    anchors.fill: parent

                    model: ListModel {
                        ListElement {
                            text: qsTr("Label text")
                            supportingText: qsTr("Supporting text")
                            trailingText: qsTr("100+")
                        }
                        ListElement {
                            text: qsTr("Label text 2")
                            supportingText: qsTr("Supporting text")
                            trailingText: qsTr("78")
                        }
                        ListElement {
                            text: qsTr("Label text 3")
                            supportingText: qsTr("Supporting text")
                            trailingText: qsTr("47")
                        }
                    }

                    delegate: MD.ListItem {
                        segmented: segmentedSwitch.checked
                        text: model.text
                        supportingText: model.supportingText
                        trailing: MD.Label {
                            text: model.trailingText
                        }
                    }
                }
            }

            MD.ScrollView {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 400

                ListView {
                    anchors.fill: parent

                    model: ListModel {
                        ListElement {
                            text: qsTr("One line")
                        }
                        ListElement {
                            text: qsTr("Two lines\nSecond line")
                        }
                        ListElement {
                            text: qsTr("Three lines\nSecond line\nThird line")
                        }
                        ListElement {
                            text: qsTr("Three lines\nSecond line\nThird line\nFourth line\nFifth line")
                        }
                        ListElement {
                            text: qsTr("Primary text")
                            supportingText: qsTr("Supporting text")
                        }
                        ListElement {
                            text: qsTr("Primary text")
                            overline: qsTr("Overline")
                            supportingText: qsTr("Supporting text")
                        }
                    }

                    delegate: MD.ListItem {
                        segmented: segmentedSwitch.checked
                        text: model.text
                        overline: model.overline
                        supportingText: model.supportingText
                    }
                }
            }

            MD.ScrollView {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 400

                ListView {
                    anchors.fill: parent

                    model: ListModel {
                        ListElement {
                            text: qsTr("Photo 1")
                            seed: "pic1"
                        }
                        ListElement {
                            text: qsTr("Photo 2")
                            seed: "pic2"
                        }
                        ListElement {
                            text: qsTr("Photo 3")
                            seed: "pic3"
                        }
                    }

                    delegate: MD.ListItem {
                        segmented: segmentedSwitch.checked
                        leading: Image {
                            anchors.centerIn: parent
                            sourceSize.width: 64
                            sourceSize.height: 64
                            asynchronous: true
                            cache: false
                            fillMode: Image.PreserveAspectFit
                            source: "https://picsum.photos/seed/%1/%2/%3".arg(model.seed).arg(sourceSize.width).arg(sourceSize.height)
                        }
                        text: model.text
                        supportingText: qsTr("updated yesterday")
                    }
                }
            }

            MD.ScrollView {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 400

                ListView {
                    anchors.fill: parent

                    model: ListModel {
                        ListElement {
                            text: qsTr("Milk")
                        }
                        ListElement {
                            text: qsTr("Bread")
                        }
                        ListElement {
                            text: qsTr("Vegetables")
                        }
                        ListElement {
                            text: qsTr("Meat")
                        }
                    }

                    delegate: MD.ListItem {
                        segmented: segmentedSwitch.checked
                        text: model.text
                        trailing: MD.CheckBox {
                            checked: false
                            checkable: true
                        }
                    }
                }
            }

            MD.ScrollView {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 400

                ListView {
                    anchors.fill: parent

                    model: ListModel {
                        ListElement {
                            text: qsTr("Milk")
                        }
                        ListElement {
                            text: qsTr("Bread")
                        }
                        ListElement {
                            text: qsTr("Vegetables")
                        }
                        ListElement {
                            text: qsTr("Meat")
                        }
                    }

                    delegate: MD.ListItem {
                        segmented: segmentedSwitch.checked
                        text: model.text
                        trailing: MD.Switch {
                            checked: false
                            checkable: true
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
