// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

GalleryPage {
    id: page

    readonly property real preferredCardWidth: 400
    readonly property real cardContentWidth: Math.max(1, width - 2 * MD.Breakpoints.margin(breakpoint) - MD.Tokens.measurement.space400)

    headline: qsTr("Indicators")
    description: qsTr("Checkboxes, radio buttons, and switches communicate selection and on/off states across enabled, disabled, and error configurations.")

    component StaticCheckBox: MD.CheckBox {
        checkable: false
    }

    component PartialCheckBox: MD.CheckBox {
        tristate: true
        checkState: Qt.PartiallyChecked
        nextCheckState: function () {
            return Qt.PartiallyChecked;
        }
    }

    component StaticSwitch: MD.Switch {
        checkable: false
    }

    component BorderlessGalleryCard: GalleryCard {
        typescale: MD.Tokens.typescale.titleLarge
        outlineVisible: false
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Checkbox")

        MD.AutomaticGrid {
            id: checkBoxGrid

            anchors.horizontalCenter: parent.horizontalCenter
            cellWidth: Math.min(page.preferredCardWidth, Math.max(1, widthOverride - minColumnSpacing * 2))
            cellHeight: 216
            widthOverride: page.cardContentWidth
            minColumnSpacing: page.contentSpacing
            rowSpacing: page.contentSpacing
            model: 4

            delegate: MD.GroupBox {
                id: checkBoxSection

                required property int index
                readonly property bool controlsEnabled: index < 2
                readonly property bool errorState: index % 2 === 1

                width: checkBoxGrid.cellWidth
                height: checkBoxGrid.cellHeight
                title: {
                    if (controlsEnabled && errorState)
                        return qsTr("Enabled — Error");
                    if (controlsEnabled)
                        return qsTr("Enabled — Standard");
                    if (errorState)
                        return qsTr("Disabled — Error");
                    return qsTr("Disabled — Standard");
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 0

                    StaticCheckBox {
                        text: qsTr("Unchecked")
                        enabled: checkBoxSection.controlsEnabled
                        error: checkBoxSection.errorState
                    }

                    StaticCheckBox {
                        text: qsTr("Checked")
                        checked: true
                        enabled: checkBoxSection.controlsEnabled
                        error: checkBoxSection.errorState
                    }

                    PartialCheckBox {
                        text: qsTr("Partially checked")
                        enabled: checkBoxSection.controlsEnabled
                        error: checkBoxSection.errorState
                    }
                }
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Radio button")

        MD.AutomaticGrid {
            id: radioButtonGrid

            anchors.horizontalCenter: parent.horizontalCenter
            cellWidth: Math.min(page.preferredCardWidth, Math.max(1, widthOverride - minColumnSpacing * 2))
            cellHeight: 216
            widthOverride: page.cardContentWidth
            minColumnSpacing: page.contentSpacing
            rowSpacing: page.contentSpacing
            model: 2

            delegate: MD.GroupBox {
                id: radioButtonSection

                required property int index
                readonly property bool controlsEnabled: index === 0

                width: radioButtonGrid.cellWidth
                height: radioButtonGrid.cellHeight
                title: controlsEnabled ? qsTr("Enabled") : qsTr("Disabled")

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 0

                    MD.RadioButton {
                        text: radioButtonSection.controlsEnabled ? qsTr("First option") : qsTr("Unselected")
                        enabled: radioButtonSection.controlsEnabled
                    }

                    MD.RadioButton {
                        text: radioButtonSection.controlsEnabled ? qsTr("Second option") : qsTr("Selected")
                        checked: true
                        enabled: radioButtonSection.controlsEnabled
                    }

                    MD.RadioButton {
                        visible: radioButtonSection.controlsEnabled
                        text: qsTr("Third option")
                    }
                }
            }
        }
    }

    BorderlessGalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Switch")

        MD.AutomaticGrid {
            id: switchGrid

            anchors.horizontalCenter: parent.horizontalCenter
            cellWidth: Math.min(page.preferredCardWidth, Math.max(1, widthOverride - minColumnSpacing * 2))
            cellHeight: 264
            widthOverride: page.cardContentWidth
            minColumnSpacing: page.contentSpacing
            rowSpacing: page.contentSpacing
            model: 2

            delegate: MD.GroupBox {
                id: switchSection

                required property int index
                readonly property bool controlsEnabled: index === 0

                width: switchGrid.cellWidth
                height: switchGrid.cellHeight
                title: controlsEnabled ? qsTr("Enabled") : qsTr("Disabled")

                GridLayout {
                    anchors.centerIn: parent
                    columns: 3
                    columnSpacing: page.contentSpacing
                    rowSpacing: 0

                    Item {
                        Layout.preferredWidth: 112
                    }
                    MD.Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("Off")
                        typescale: MD.Tokens.typescale.labelMedium
                    }
                    MD.Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("On")
                        typescale: MD.Tokens.typescale.labelMedium
                    }

                    MD.Label {
                        text: qsTr("No icons")
                        typescale: MD.Tokens.typescale.labelLarge
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("No icons, off")
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("No icons, on")
                        checked: true
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.NoIcons
                    }

                    MD.Label {
                        text: qsTr("Selected icon")
                        typescale: MD.Tokens.typescale.labelLarge
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("Selected icon, off")
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("Selected icon, on")
                        checked: true
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.SelectedIcon
                    }

                    MD.Label {
                        text: qsTr("Both icons")
                        typescale: MD.Tokens.typescale.labelLarge
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("Both icons, off")
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                    }
                    StaticSwitch {
                        Accessible.name: qsTr("Both icons, on")
                        checked: true
                        enabled: switchSection.controlsEnabled
                        iconConfiguration: MD.Switch.IconConfiguration.BothIcons
                    }
                }
            }
        }
    }
}
