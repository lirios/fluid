// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

GalleryPage {
    id: page

    anchors.fill: parent
    headline: qsTr("Lists")
    description: qsTr("Lists organize related content into rows with text, imagery, and interactive trailing controls.")

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Presentation")

        MD.Switch {
            id: segmentedSwitch
            text: qsTr("Segmented")
        }
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Supporting and trailing text")
        MD.ScrollView {
            width: parent.width
            height: 400

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
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Line arrangements")

        MD.ScrollView {
            width: parent.width
            height: 400

            ListView {
                anchors.fill: parent

                clip: true

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
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Images")
        MD.ScrollView {
            width: parent.width
            height: 400

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
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Checkboxes")
        MD.ScrollView {
            width: parent.width
            height: 400

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
                        Accessible.name: model.text
                        checked: false
                        checkable: true
                    }
                }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Switches")
        MD.ScrollView {
            width: parent.width
            height: 400

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
                        Accessible.name: model.text
                        checked: false
                        checkable: true
                    }
                }
            }
        }
    }
}
