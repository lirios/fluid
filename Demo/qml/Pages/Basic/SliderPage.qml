/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.1
import "../.." as Components

Components.StyledPageTwoColumns {
    leftColumn: ColumnLayout {
        anchors.centerIn: parent

        TitleLabel {
            text: qsTr("Enabled")

            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            rows: 4
            columns: 2

            Label {
                text: qsTr("Horizontal / Single")
            }

            Slider {
                from: 0.0
                to: 1.0
                value: 0.5
            }

            Label {
                text: qsTr("Horizontal / Range")
            }

            RangeSlider {
                from: 0.0
                to: 1.0
                first.value: 0.4
                second.value: 0.6
            }

            Label {
                text: qsTr("Vertical / Single")
            }

            Slider {
                from: 0.0
                to: 1.0
                value: 0.5
                orientation: Qt.Vertical
            }

            Label {
                text: qsTr("Vertical / Range")
            }

            RangeSlider {
                from: 0.0
                to: 1.0
                first.value: 0.4
                second.value: 0.6
                orientation: Qt.Vertical
            }
        }
    }

    rightColumn: ColumnLayout {
        anchors.centerIn: parent

        TitleLabel {
            text: qsTr("Disabled")

            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            rows: 4
            columns: 2

            Label {
                text: qsTr("Horizontal / Single")
            }

            Slider {
                enabled: false
                from: 0.0
                to: 1.0
                value: 0.5
            }

            Label {
                text: qsTr("Horizontal / Range")
            }

            RangeSlider {
                enabled: false
                from: 0.0
                to: 1.0
                first.value: 0.4
                second.value: 0.6
            }

            Label {
                text: qsTr("Vertical / Single")
            }

            Slider {
                enabled: false
                from: 0.0
                to: 1.0
                value: 0.5
                orientation: Qt.Vertical
            }

            Label {
                text: qsTr("Vertical / Range")
            }

            RangeSlider {
                enabled: false
                from: 0.0
                to: 1.0
                first.value: 0.4
                second.value: 0.6
                orientation: Qt.Vertical
            }
        }
    }
}
