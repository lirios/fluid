// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

MD.ScrollView {
    id: scrollView

    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    readonly property var countries: [
        qsTr("Argentina"),
        qsTr("Brazil"),
        qsTr("Canada"),
        qsTr("France"),
        qsTr("Japan")
    ]
    readonly property var destinations: [
        qsTr("Amsterdam"),
        qsTr("Athens"),
        qsTr("Bangkok"),
        qsTr("Barcelona"),
        qsTr("Berlin"),
        qsTr("Copenhagen"),
        qsTr("Dublin"),
        qsTr("Florence"),
        qsTr("Helsinki"),
        qsTr("Istanbul"),
        qsTr("Lisbon"),
        qsTr("London"),
        qsTr("Madrid"),
        qsTr("Melbourne"),
        qsTr("Mexico City"),
        qsTr("Montreal"),
        qsTr("New York"),
        qsTr("Oslo"),
        qsTr("Paris"),
        qsTr("Prague"),
        qsTr("Reykjavik"),
        qsTr("Rome"),
        qsTr("Seoul"),
        qsTr("Singapore"),
        qsTr("Stockholm"),
        qsTr("Sydney"),
        qsTr("Tokyo"),
        qsTr("Toronto"),
        qsTr("Venice"),
        qsTr("Vienna")
    ]

    Flow {
        id: flow

        x: scrollView.sectionSpacing
        y: scrollView.sectionSpacing
        width: Math.max(0, scrollView.availableWidth - scrollView.sectionSpacing * 2)
        spacing: scrollView.sectionSpacing

        readonly property int minCardWidth: 400
        readonly property int columns: Math.max(1, Math.floor((width + spacing) / (minCardWidth + spacing)))
        readonly property real cardWidth: (width - spacing * (columns - 1)) / columns

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Filled and outlined")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    label: qsTr("Country")
                    supportingText: qsTr("Choose your country of residence")
                    model: scrollView.countries
                    currentIndex: 2
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Outlined
                    label: qsTr("Country")
                    placeholderText: qsTr("Select a country")
                    model: scrollView.countries
                    currentIndex: -1
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Selection and editing")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    label: qsTr("Favorite destination")
                    placeholderText: qsTr("Select a destination")
                    supportingText: qsTr("Selection only")
                    model: scrollView.destinations
                    currentIndex: 5
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Outlined
                    editable: true
                    label: qsTr("Favorite destination")
                    placeholderText: qsTr("Type or select a destination")
                    supportingText: qsTr("Editable")
                    model: scrollView.destinations
                    currentIndex: -1
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Menu color styles")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    menuColorStyle: MD.ExposedDropdownMenu.Standard
                    label: qsTr("Standard menu")
                    model: scrollView.countries
                    currentIndex: 1
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Outlined
                    menuColorStyle: MD.ExposedDropdownMenu.Vibrant
                    label: qsTr("Vibrant menu")
                    model: scrollView.countries
                    currentIndex: 3
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Field content and states")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    label: qsTr("Language")
                    placeholderText: qsTr("Select a language")
                    leadingIconName: MD.SymbolNames.symbolLanguage
                    model: [qsTr("English"), qsTr("Italian"), qsTr("Japanese")]
                    currentIndex: -1
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Outlined
                    label: qsTr("Gallery icon")
                    supportingText: qsTr("A source-based leading icon")
                    leadingIconSource: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                    model: [qsTr("Default"), qsTr("Featured"), qsTr("Archived")]
                    currentIndex: 0
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Outlined
                    label: qsTr("Delivery region")
                    error: true
                    errorText: qsTr("Select a delivery region")
                    model: scrollView.countries
                    currentIndex: -1
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    enabled: false
                    label: qsTr("Disabled country")
                    model: scrollView.countries
                    currentIndex: 2
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Long menu")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Open the menu to browse a scrolling model.")
                    wrapMode: Text.Wrap
                }

                MD.ExposedDropdownMenu {
                    Layout.fillWidth: true
                    fieldStyle: MD.ExposedDropdownMenu.Filled
                    label: qsTr("Destination")
                    placeholderText: qsTr("Choose from 30 destinations")
                    leadingIconName: MD.SymbolNames.symbolTravelExplore
                    model: scrollView.destinations
                    currentIndex: -1
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Right-to-left and keyboard")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Keyboard: Tab to focus, Space or Alt+Down to open, Up/Down to navigate, Enter to select, and Escape to close.")
                    wrapMode: Text.Wrap
                }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: rtlMenu.implicitHeight
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true

                    MD.ExposedDropdownMenu {
                        id: rtlMenu

                        width: parent.width
                        fieldStyle: MD.ExposedDropdownMenu.Outlined
                        label: qsTr("الوجهة")
                        placeholderText: qsTr("اختر وجهة")
                        leadingIconName: MD.SymbolNames.symbolLocationOn
                        model: [qsTr("القاهرة"), qsTr("دبي"), qsTr("الدوحة")]
                        currentIndex: -1
                    }
                }
            }
        }
    }
}
