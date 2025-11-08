/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    // title: qsTr("Elevation")

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

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 24

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

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
            spacing: 36

            Elevation {
                elevation: 0
            }
            Elevation {
                elevation: 1
            }
            Elevation {
                elevation: 2
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 36

            Elevation {
                elevation: 3
            }
            Elevation {
                elevation: 4
            }
            Elevation {
                elevation: 5
            }
        }
    }
}
