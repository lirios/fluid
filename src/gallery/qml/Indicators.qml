// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

MD.ScrollView {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: MD.Tokens.spacingLarge
        spacing: MD.Tokens.spacingLarge

        MD.GroupBox {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: qsTr("CheckBox")

            GridLayout {
                anchors.fill: parent
                anchors.margins: MD.Tokens.spacingLarge
                columnSpacing: MD.Tokens.spacingMedium
                rowSpacing: MD.Tokens.spacingMedium

                columns: 3
                rows: 4

                // Enabled

                MD.CheckBox {
                    Layout.column: 0
                    Layout.row: 0

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: true
                }
                MD.CheckBox {
                    Layout.column: 1
                    Layout.row: 0

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: true
                }
                MD.CheckBox {
                    Layout.column: 2
                    Layout.row: 0

                    text: qsTr("Partially Checked")
                    checkState: Qt.PartiallyChecked
                    tristate: true
                    enabled: true
                    nextCheckState: function () {
                        return Qt.PartiallyChecked;
                    }
                }

                // Disabled

                MD.CheckBox {
                    Layout.column: 0
                    Layout.row: 1

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: false
                }
                MD.CheckBox {
                    Layout.column: 1
                    Layout.row: 1

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: false
                }
                MD.CheckBox {
                    Layout.column: 2
                    Layout.row: 1

                    text: qsTr("Partially Checked")
                    checkState: Qt.PartiallyChecked
                    tristate: true
                    enabled: false
                    nextCheckState: function () {
                        return Qt.PartiallyChecked;
                    }
                }

                // Enabled and Error

                MD.CheckBox {
                    Layout.column: 0
                    Layout.row: 2

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: true
                    error: true
                }
                MD.CheckBox {
                    Layout.column: 1
                    Layout.row: 2

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: true
                    error: true
                }
                MD.CheckBox {
                    Layout.column: 2
                    Layout.row: 2

                    text: qsTr("Partially Checked")
                    checkState: Qt.PartiallyChecked
                    nextCheckState: function () {
                        return Qt.PartiallyChecked;
                    }
                    tristate: true
                    enabled: true
                    error: true
                }

                // Disabled and Error

                MD.CheckBox {
                    Layout.column: 0
                    Layout.row: 3

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: false
                    error: true
                }
                MD.CheckBox {
                    Layout.column: 1
                    Layout.row: 3

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: false
                    error: true
                }
                MD.CheckBox {
                    Layout.column: 2
                    Layout.row: 3

                    text: qsTr("Partially Checked")
                    checkState: Qt.PartiallyChecked
                    nextCheckState: function () {
                        return Qt.PartiallyChecked;
                    }
                    tristate: true
                    enabled: false
                    error: true
                }
            }
        }

        MD.GroupBox {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: qsTr("RadioButton")
        }

        MD.GroupBox {
            Layout.fillWidth: true
            Layout.fillHeight: true

            title: qsTr("Switch")

            GridLayout {
                anchors.fill: parent
                anchors.margins: MD.Tokens.spacingLarge
                columnSpacing: MD.Tokens.spacingMedium
                rowSpacing: MD.Tokens.spacingMedium

                columns: 4
                rows: 3

                // NoIcons

                MD.Switch {
                    Layout.column: 0
                    Layout.row: 0

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                }
                MD.Switch {
                    Layout.column: 1
                    Layout.row: 0

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                }
                MD.Switch {
                    Layout.column: 2
                    Layout.row: 0

                    text: qsTr("Unchecked Disabled")
                    checkable: false
                    checked: false
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                }
                MD.Switch {
                    Layout.column: 3
                    Layout.row: 0

                    text: qsTr("Checked Disabled")
                    checkable: false
                    checked: true
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                }

                // SelectedIcon

                MD.Switch {
                    Layout.column: 0
                    Layout.row: 1

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                }
                MD.Switch {
                    Layout.column: 1
                    Layout.row: 1

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                }
                MD.Switch {
                    Layout.column: 2
                    Layout.row: 1

                    text: qsTr("Unchecked Disabled")
                    checkable: false
                    checked: false
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                }
                MD.Switch {
                    Layout.column: 3
                    Layout.row: 1

                    text: qsTr("Checked Disabled")
                    checkable: false
                    checked: true
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                }

                // BothIcons

                MD.Switch {
                    Layout.column: 0
                    Layout.row: 2

                    text: qsTr("Unchecked")
                    checkable: false
                    checked: false
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                }
                MD.Switch {
                    Layout.column: 1
                    Layout.row: 2

                    text: qsTr("Checked")
                    checkable: false
                    checked: true
                    enabled: true
                    iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                }
                MD.Switch {
                    Layout.column: 2
                    Layout.row: 2

                    text: qsTr("Unchecked Disabled")
                    checkable: false
                    checked: false
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                }
                MD.Switch {
                    Layout.column: 3
                    Layout.row: 2

                    text: qsTr("Checked Disabled")
                    checkable: false
                    checked: true
                    enabled: false
                    iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                }
            }
        }
    }
}
