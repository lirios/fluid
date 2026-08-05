// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    readonly property int symbolSize: 96

    component SymbolItem: MD.Control {
        property string name: ""
        property int style: MD.Symbol.Style.Outlined

        Layout.preferredWidth: symbolSize
        Layout.preferredHeight: symbolSize

        MD.ToolTip.visible: hovered
        MD.ToolTip.text: name

        contentItem: MD.Symbol {
            name: parent.name
            iconWidth: symbolSize
            iconHeight: symbolSize
            style: parent.style
            opticalSize: symbolSize > 48 ? MD.Symbol.OpticalSize.Large : MD.Symbol.OpticalSize.Normal
        }
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent

            MD.ComboBox {
                id: comboBox

                Layout.alignment: Qt.AlignHCenter

                model: ["Outlined", "Rounded", "Sharp"]
            }

            MD.ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                contentWidth: availableWidth

                GridLayout {
                    width: parent.width
                    columns: (parent.width - columnSpacing) / (symbolSize + columnSpacing)
                    rowSpacing: symbolSize / 2
                    columnSpacing: symbolSize / 2

                    Repeater {
                        model: SymbolsModel {}

                        delegate: SymbolItem {
                            name: model.name
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
