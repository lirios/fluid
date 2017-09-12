/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQml 2.2
import QtQuick 2.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype TimePicker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Picker to select time

    A standalone timepicker component to select a time

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.TimePicker {
            onAccepted: {
                console.log(date)
            }
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        }
    }

    \endcode
*/
Picker {
    id: timePicker

    property var selectedDate: new Date()

    property alias prefer24hView: timeSelector.prefer24hView

    function show(type) {
        timeSelector.selectMode(type)
    }

    orientation: Qt.PortraitOrientation

    onSelectedDateChanged: {
        timeSelector.selectedDate = selectedDate
    }

    header: Item {
        anchors.fill: parent
        anchors.margins: 16

        GridLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent

            columns: orientation === Qt.LandscapeOrientation ? 1 : 2
            rows: orientation === Qt.LandscapeOrientation ? 2 : 1

            Row {
                Layout.column: 1
                Layout.row: 1
                Label {
                    text: selectedDate.getHours() < 10 ? "0" + selectedDate.getHours() : selectedDate.getHours()
                    color: "white"
                    font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 40
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: timeSelector.currentSelector === "HOUR" ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.selectMode("HOUR")
                    }
                }

                Label {
                    text: ":"
                    color: "white"
                    font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 40
                }

                Label {
                    text: selectedDate.getMinutes() < 10 ? "0" + selectedDate.getMinutes() : selectedDate.getMinutes()
                    color: "white"
                    font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 40
                    opacity: timeSelector.currentSelector === "MINUTE" ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.selectMode("MINUTE")
                    }
                }

                Label {
                    text: ":"
                    color: "white"
                    font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 40
                }

                Label {
                    text: selectedDate.getSeconds() < 10 ? "0" + selectedDate.getSeconds() : selectedDate.getSeconds()
                    color: "white"
                    font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 40
                    opacity: timeSelector.currentSelector === "SECOND" ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.selectMode("SECOND")
                    }
                }
            }

            Column {
                Layout.column: orientation === Qt.LandscapeOrientation ? 1 : 2
                Layout.row: orientation === Qt.LandscapeOrientation ? 2 : 1

                visible: !timeSelector.prefer24hView
                anchors.horizontalCenter: orientation === Qt.LandscapeOrientation ? parent.horizontalCenter : undefined
                Label {
                    text: "AM"
                    color: "white"
                    font.pixelSize: 18
                    opacity: timeSelector.timeMode === "AM" ? 1 : 0.7
                    horizontalAlignment: Text.AlignHCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.timeMode = "AM"
                    }
                }
                Label {
                    text: "PM"
                    color: "white"
                    opacity: timeSelector.timeMode === "PM" ? 1 : 0.7
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.timeMode = "PM"
                    }
                }
            }
        }
    }

    selector: TimeSelector {
        id: timeSelector
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        onSelectedDateChanged: {
            if(timePicker.selectedDate != selectedDate)
                timePicker.selectedDate = selectedDate
        }
    }
}
