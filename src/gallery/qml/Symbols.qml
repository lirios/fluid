// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property int symbolSize: 96
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    component SymbolItem: MD.Control {
        id: symbolItem

        required property string name
        property int style: MD.Symbol.Style.Outlined

        implicitWidth: page.symbolSize
        implicitHeight: page.symbolSize

        MD.ToolTip.visible: hovered
        MD.ToolTip.text: name

        contentItem: MD.Symbol {
            name: symbolItem.name
            iconWidth: page.symbolSize
            iconHeight: page.symbolSize
            style: symbolItem.style
            opticalSize: page.symbolSize > 48 ? MD.Symbol.OpticalSize.Large : MD.Symbol.OpticalSize.Normal
        }
    }

    GalleryPage {
        id: galleryPage
        anchors.fill: parent
        headline: qsTr("Symbols")
        description: qsTr("Symbols provide scalable Material icons in outlined, rounded, and sharp styles.")

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Symbol catalog")

            ColumnLayout {
                width: parent.width
                spacing: galleryPage.sectionSpacing

                MD.ExposedDropdownMenu {
                    id: comboBox

                    Layout.alignment: Qt.AlignHCenter

                    label: qsTr("Symbol style")
                    model: ["Outlined", "Rounded", "Sharp"]
                }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: symbolGrid.height

                    MD.AutomaticGrid {
                        id: symbolGrid

                        anchors.horizontalCenter: parent.horizontalCenter
                        cellWidth: Math.min(page.symbolSize, Math.max(1, widthOverride - minColumnSpacing * 2))
                        cellHeight: cellWidth
                        widthOverride: parent.width
                        minColumnSpacing: page.sectionSpacing
                        rowSpacing: page.sectionSpacing
                        model: SymbolsModel {}

                        delegate: SymbolItem {
                            width: symbolGrid.cellWidth
                            height: symbolGrid.cellHeight
                            style: {
                                if (comboBox.currentIndex === 0)
                                    return MD.Symbol.Style.Outlined;
                                else if (comboBox.currentIndex === 1)
                                    return MD.Symbol.Style.Rounded;
                                else
                                    return MD.Symbol.Style.Sharp;
                            }
                        }
                    }
                }
            }
        }
    }
}
