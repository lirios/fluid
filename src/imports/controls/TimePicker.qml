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

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/
FluidControls.Picker {
    id: timePicker

    property var selectedDate: new Date()

    property alias prefer24Hour: timeSelector.prefer24Hour

    onSelectedDateChanged: {
        timeSelector.selectedDate = selectedDate
    }

    header: Item {
        anchors.fill: parent
        anchors.margins: 16

        GridLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent

            columns: timePicker.orientation === FluidControls.Picker.Landscape ? 1 : 2
            rows: timePicker.orientation === FluidControls.Picker.Landscape ? 2 : 1

            Row {
                Layout.column: 1
                Layout.row: 1

                Label {
                    text: selectedDate.getHours() < 10 ? "0" + selectedDate.getHours() : selectedDate.getHours()
                    color: "white"
                    font.pixelSize: timePicker.orientation === FluidControls.Picker.Landscape ? 30 : 40
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: timeSelector.currentSelector === FluidControls.TimeSelector.Hour ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.mode = FluidControls.TimeSelector.Hour
                    }
                }

                Label {
                    text: ":"
                    color: "white"
                    font.pixelSize: timePicker.orientation === FluidControls.Picker.Landscape ? 30 : 40
                }

                Label {
                    text: selectedDate.getMinutes() < 10 ? "0" + selectedDate.getMinutes() : selectedDate.getMinutes()
                    color: "white"
                    font.pixelSize: timePicker.orientation === FluidControls.Picker.Landscape ? 30 : 40
                    opacity: timeSelector.currentSelector === FluidControls.TimeSelector.Minute ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.mode = FluidControls.TimeSelector.Minute
                    }
                }

                Label {
                    text: ":"
                    color: "white"
                    font.pixelSize: timePicker.orientation === FluidControls.Picker.Landscape ? 30 : 40
                }

                Label {
                    text: selectedDate.getSeconds() < 10 ? "0" + selectedDate.getSeconds() : selectedDate.getSeconds()
                    color: "white"
                    font.pixelSize: timePicker.orientation === FluidControls.Picker.Landscape ? 30 : 40
                    opacity: timeSelector.currentSelector === FluidControls.TimeSelector.Second ? 1 : 0.7
                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.mode = FluidControls.TimeSelector.Second
                    }
                }
            }

            Column {
                Layout.column: timePicker.orientation === FluidControls.Picker.Landscape ? 1 : 2
                Layout.row: timePicker.orientation === FluidControls.Picker.Landscape ? 2 : 1

                visible: !timeSelector.prefer24Hour
                anchors.horizontalCenter: orientation === FluidControls.Picker.Landscape ? parent.horizontalCenter : undefined

                Label {
                    text: "AM"
                    color: "white"
                    font.pixelSize: 18
                    opacity: timeSelector.timeMode === FluidControls.TimeSelector.AM ? 1 : 0.7
                    horizontalAlignment: Text.AlignHCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.timeMode = FluidControls.TimeSelector.AM
                    }
                }

                Label {
                    text: "PM"
                    color: "white"
                    opacity: timeSelector.timeMode === FluidControls.TimeSelector.PM ? 1 : 0.7
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: timeSelector.timeMode = FluidControls.TimeSelector.PM
                    }
                }
            }
        }
    }

    selector: FluidControls.TimeSelector {
        id: timeSelector
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        onSelectedDateChanged: {
            if (timePicker.selectedDate != selectedDate)
                timePicker.selectedDate = selectedDate;
        }
    }
}
