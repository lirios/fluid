// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

GalleryPage {
    id: page

    readonly property var countries: [qsTr("Argentina"), qsTr("Brazil"), qsTr("Canada"), qsTr("France"), qsTr("Japan")]
    readonly property var destinations: [qsTr("Amsterdam"), qsTr("Athens"), qsTr("Bangkok"), qsTr("Barcelona"), qsTr("Berlin"), qsTr("Copenhagen"), qsTr("Dublin"), qsTr("Florence"), qsTr("Helsinki"), qsTr("Istanbul"), qsTr("Lisbon"), qsTr("London"), qsTr("Madrid"), qsTr("Melbourne"), qsTr("Mexico City"), qsTr("Montreal"), qsTr("New York"), qsTr("Oslo"), qsTr("Paris"), qsTr("Prague"), qsTr("Reykjavik"), qsTr("Rome"), qsTr("Seoul"), qsTr("Singapore"), qsTr("Stockholm"), qsTr("Sydney"), qsTr("Tokyo"), qsTr("Toronto"), qsTr("Venice"), qsTr("Vienna")]

    headline: qsTr("Exposed dropdown menus")
    description: qsTr("Exposed dropdown menus let people choose from a list, with optional editing, supporting text, and validation states.")

    component BorderlessGalleryCard: GalleryCard {
        typescale: MD.Tokens.typescale.titleLarge
        outlineVisible: false
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Filled and outlined")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Filled
                label: qsTr("Country")
                supportingText: qsTr("Choose your country of residence")
                model: page.countries
                currentIndex: 2
            }

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Outlined
                label: qsTr("Country")
                placeholderText: qsTr("Select a country")
                model: page.countries
                currentIndex: -1
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Selection and editing")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Filled
                label: qsTr("Favorite destination")
                placeholderText: qsTr("Select a destination")
                supportingText: qsTr("Selection only")
                model: page.destinations
                currentIndex: 5
            }

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Outlined
                editable: true
                label: qsTr("Favorite destination")
                placeholderText: qsTr("Type or select a destination")
                supportingText: qsTr("Editable")
                model: page.destinations
                currentIndex: -1
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Menu color styles")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Filled
                menuColorStyle: MD.ExposedDropdownMenu.Standard
                label: qsTr("Standard menu")
                model: page.countries
                currentIndex: 1
            }

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Outlined
                menuColorStyle: MD.ExposedDropdownMenu.Vibrant
                label: qsTr("Vibrant menu")
                model: page.countries
                currentIndex: 3
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Field content and states")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Filled
                label: qsTr("Language")
                placeholderText: qsTr("Select a language")
                leadingIconName: MD.Symbols.language
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
                model: page.countries
                currentIndex: -1
            }

            MD.ExposedDropdownMenu {
                Layout.fillWidth: true
                fieldStyle: MD.ExposedDropdownMenu.Filled
                enabled: false
                label: qsTr("Disabled country")
                model: page.countries
                currentIndex: 2
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Long menu")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

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
                leadingIconName: MD.Symbols.travelExplore
                model: page.destinations
                currentIndex: -1
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        title: qsTr("Right-to-left and keyboard")

        ColumnLayout {
            width: parent.width
            spacing: page.contentSpacing

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
                    leadingIconName: MD.Symbols.locationOn
                    model: [qsTr("القاهرة"), qsTr("دبي"), qsTr("الدوحة")]
                    currentIndex: -1
                }
            }
        }
    }
}
