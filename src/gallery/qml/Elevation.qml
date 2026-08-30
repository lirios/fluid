// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property int sectionSpacing: 24
    readonly property int spaciousSpacing: 32

    component Elevation: MD.Elevation {
        Layout.fillWidth: true
        Layout.preferredWidth: 160
        Layout.preferredHeight: width
        Layout.maximumWidth: 160
        Layout.maximumHeight: 160

        implicitWidth: 40
        implicitHeight: width

        radius: radiusSlider.value

        visible: true

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "lightgray"
        }
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: page.sectionSpacing

            RowLayout {
                Layout.fillWidth: true
                spacing: page.sectionSpacing

                MD.Label {
                    text: qsTr("Elevation: %1").arg(radiusSlider.value)
                }

                MD.Slider {
                    id: radiusSlider

                    Layout.fillWidth: true

                    from: 0
                    to: 80
                    stepSize: 2
                    value: 8
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: page.spaciousSpacing

                Elevation {
                    elevation: MD.Tokens.elevation.level0
                }
                Elevation {
                    elevation: MD.Tokens.elevation.level1
                }
                Elevation {
                    elevation: MD.Tokens.elevation.level2
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: page.spaciousSpacing

                Elevation {
                    elevation: MD.Tokens.elevation.level3
                }
                Elevation {
                    elevation: MD.Tokens.elevation.level4
                }
                Elevation {
                    elevation: MD.Tokens.elevation.level5
                }
            }
        }
    }
}
