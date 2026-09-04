// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    readonly property real spaciousSpacing: MD.Tokens.measurement.space400

    component ValueCircle: Rectangle {
        property alias number: label.text

        // Validate number is a single digit
        onNumberChanged: {
            if (number.length > 1) {
                console.warn("NumberCircle: number should be a single digit");
                number = number[0];
            }
        }

        width: 24
        height: 24
        radius: width / 2

        border.color: "white"
        color: "#322F35"

        MD.Label {
            id: label

            anchors.centerIn: parent
            font.pixelSize: 12
            font.weight: Font.Bold
            color: "white"
        }
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Buttons")
        description: qsTr("Buttons help people take actions with sizes, shapes, colors, and icon arrangements for different levels of emphasis.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Content arrangements")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.floor(width / 144))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                MD.Button {
                    objectName: "iconOnlyButton"
                    display: MD.Button.IconOnly
                    icon.name: MD.Symbols.search
                    text: qsTr("Icon Only")
                }

                MD.Button {
                    objectName: "textOnlyButton"
                    display: MD.Button.TextOnly
                    icon.name: MD.Symbols.search
                    text: qsTr("Text Only")
                }

                MD.Button {
                    objectName: "textBesideIconButton"
                    display: MD.Button.TextBesideIcon
                    icon.name: MD.Symbols.search
                    text: qsTr("Text Beside Icon")
                }

                MD.Button {
                    objectName: "textUnderIconButton"
                    display: MD.Button.TextUnderIcon
                    icon.name: MD.Symbols.search
                    text: qsTr("Text Under Icon")
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Configurations")

            ColumnLayout {
                width: parent.width
                spacing: page.sectionSpacing

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.floor(width / 112))
                    columnSpacing: page.sectionSpacing
                    rowSpacing: page.sectionSpacing

                    ValueCircle {
                        number: "1"
                    }

                    MD.Button {
                        objectName: "extraSmallButton"
                        size: MD.Button.ExtraSmall
                        text: qsTr("Extra Small")
                    }

                    MD.Button {
                        objectName: "smallButton"
                        size: MD.Button.Small
                        text: qsTr("Small")
                    }

                    MD.Button {
                        objectName: "mediumButton"
                        size: MD.Button.Medium
                        text: qsTr("Medium")
                    }

                    MD.Button {
                        objectName: "largeButton"
                        size: MD.Button.Large
                        text: qsTr("Large")
                    }

                    MD.Button {
                        objectName: "extraLargeButton"
                        size: MD.Button.ExtraLarge
                        text: qsTr("Extra Large")
                    }
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.floor(width / 112))
                    columnSpacing: page.sectionSpacing
                    rowSpacing: page.sectionSpacing

                    ValueCircle {
                        number: "2"
                    }

                    MD.Button {
                        objectName: "roundButton"
                        shape: MD.Button.Round
                        text: qsTr("Round")
                    }

                    MD.Button {
                        objectName: "squareButton"
                        shape: MD.Button.Square
                        text: qsTr("Square")
                    }
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.floor(width / 112))
                    columnSpacing: page.sectionSpacing
                    rowSpacing: page.sectionSpacing

                    ValueCircle {
                        number: "3"
                    }

                    MD.Button {
                        objectName: "elevatedButton"
                        type: MD.Button.Elevated
                        text: qsTr("Elevated")
                    }

                    MD.Button {
                        objectName: "filledButton"
                        type: MD.Button.Filled
                        text: qsTr("Filled")
                    }

                    MD.Button {
                        objectName: "tonalButton"
                        type: MD.Button.Tonal
                        text: qsTr("Tonal")
                    }

                    MD.Button {
                        objectName: "outlinedButton"
                        type: MD.Button.Outlined
                        text: qsTr("Outlined")
                    }

                    MD.Button {
                        objectName: "textButton"
                        type: MD.Button.Text
                        text: qsTr("Text")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Colors")

            ColumnLayout {
                width: parent.width
                spacing: page.spaciousSpacing

                RowLayout {
                    spacing: page.sectionSpacing

                    MD.Switch {
                        id: enabledSwitch

                        text: qsTr("Enabled")
                        checked: true
                    }
                }

                GridLayout {
                    columns: 4
                    rows: 6

                    columnSpacing: page.sectionSpacing
                    rowSpacing: page.sectionSpacing

                    // Numbers and letters

                    ValueCircle {
                        Layout.row: 0
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "1"
                    }

                    ValueCircle {
                        Layout.row: 0
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "2"
                    }

                    ValueCircle {
                        Layout.row: 0
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "3"
                    }

                    ValueCircle {
                        Layout.row: 1
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "A"
                    }

                    ValueCircle {
                        Layout.row: 2
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "B"
                    }

                    ValueCircle {
                        Layout.row: 3
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "C"
                    }

                    ValueCircle {
                        Layout.row: 4
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "D"
                    }

                    ValueCircle {
                        Layout.row: 5
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        number: "E"
                    }

                    // Column 1 (default)

                    MD.Button {
                        Layout.row: 1
                        Layout.column: 1

                        objectName: "elevatedButton"
                        type: MD.Button.Elevated
                        icon.name: MD.Symbols.edit
                        text: qsTr("Elevated button")
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 2
                        Layout.column: 1

                        objectName: "filledButton"
                        type: MD.Button.Filled
                        icon.name: MD.Symbols.edit
                        text: qsTr("Filled button")
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 3
                        Layout.column: 1

                        objectName: "tonalButton"
                        type: MD.Button.Tonal
                        icon.name: MD.Symbols.edit
                        text: qsTr("Tonal button")
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 4
                        Layout.column: 1

                        objectName: "outlinedButton"
                        type: MD.Button.Outlined
                        icon.name: MD.Symbols.edit
                        text: qsTr("Outlined button")
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 5
                        Layout.column: 1

                        objectName: "textButton"
                        type: MD.Button.Text
                        icon.name: MD.Symbols.edit
                        text: qsTr("Text button")
                        enabled: enabledSwitch.checked
                    }

                    // Column 2 (toggle unselected)

                    MD.Button {
                        Layout.row: 1
                        Layout.column: 2

                        objectName: "elevatedButton"
                        type: MD.Button.Elevated
                        icon.name: MD.Symbols.edit
                        text: qsTr("Elevated unselected")
                        checkable: false
                        checked: false
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 2
                        Layout.column: 2

                        objectName: "filledButton"
                        type: MD.Button.Filled
                        icon.name: MD.Symbols.edit
                        text: qsTr("Filled unselected")
                        checkable: false
                        checked: false
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 3
                        Layout.column: 2

                        objectName: "tonalButton"
                        type: MD.Button.Tonal
                        icon.name: MD.Symbols.edit
                        text: qsTr("Tonal unselected")
                        checkable: false
                        checked: false
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 4
                        Layout.column: 2

                        objectName: "outlinedButton"
                        type: MD.Button.Outlined
                        icon.name: MD.Symbols.edit
                        text: qsTr("Outlined unselected")
                        checkable: false
                        checked: false
                        enabled: enabledSwitch.checked
                    }

                    // Column 3 (toggle selected)

                    MD.Button {
                        Layout.row: 1
                        Layout.column: 3

                        objectName: "elevatedButton"
                        type: MD.Button.Elevated
                        icon.name: MD.Symbols.edit
                        text: qsTr("Elevated selected")
                        checkable: false
                        checked: true
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 2
                        Layout.column: 3

                        objectName: "filledButton"
                        type: MD.Button.Filled
                        icon.name: MD.Symbols.edit
                        text: qsTr("Filled selected")
                        checkable: false
                        checked: true
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 3
                        Layout.column: 3

                        objectName: "tonalButton"
                        type: MD.Button.Tonal
                        icon.name: MD.Symbols.edit
                        text: qsTr("Tonal selected")
                        checkable: false
                        checked: true
                        enabled: enabledSwitch.checked
                    }

                    MD.Button {
                        Layout.row: 4
                        Layout.column: 3

                        objectName: "outlinedButton"
                        type: MD.Button.Outlined
                        icon.name: MD.Symbols.edit
                        text: qsTr("Outlined selected")
                        checkable: false
                        checked: true
                        enabled: enabledSwitch.checked
                    }
                }
            }
        }
    }
}
