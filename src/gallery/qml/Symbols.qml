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

        Layout.columnSpan: 2
        Layout.fillWidth: true
        Layout.preferredHeight: page.symbolSize

        MD.ToolTip.visible: hovered
        MD.ToolTip.text: name

        contentItem: MD.Symbol {
            name: symbolItem.name
            iconWidth: page.symbolSize
            iconHeight: page.symbolSize
            style: symbolItem.style
            opticalSize: page.symbolSize > 48 ? MD.Symbol.OpticalSize.Large
                                               : MD.Symbol.OpticalSize.Normal
        }
    }

    MD.ScrollView {
        id: scrollView

        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: scrollView.availableWidth
            spacing: page.sectionSpacing

            MD.ExposedDropdownMenu {
                id: comboBox

                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: page.sectionSpacing

                label: qsTr("Symbol style")
                model: ["Outlined", "Rounded", "Sharp"]
            }

            MD.AdaptiveGrid {
                id: symbolGrid

                Layout.fillWidth: true
                Layout.bottomMargin: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                Repeater {
                    model: SymbolsModel {}

                    delegate: SymbolItem {
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
