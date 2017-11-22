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
import Qt.labs.calendar 1.0

/*!
    \qmltype DateTimePicker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Picker to select a datetime

    A standalone DateTimePicker component to select a datetime

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DateTimePicker {
            id: dateTimePicker
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                Material.theme: Material.Light
                Material.foreground: Material.accent
                flat: true
                onClicked: {
                    dateTimePicker.selectedDate = new Date()
                }
            }
            onAccepted: {
                console.log(date)
            }
        }
    }

    \endcode*/
Picker {
    id: dateTimePicker

    property bool dayOfWeekRowVisible: true
    property bool weekNumberVisible: true
    property alias prefer24hView: timeSelector.prefer24hView
    property var selectedDate: new Date()
    property var minDate: new Date(1976, 0, 1)
    property var maxDate: new Date(2150, 11, 31)

    property string __mode: "MONTH"

    function show(type) {
        __mode = type;
        switch(type) {
        case "YEAR":
            dateSelector.visible = false;
            timeSelector.visible = false;
            yearSelector.visible = true;
            yearSelector.selectedDate = dateTimePicker.selectedDate
            break;
        case "MONTH":
            dateSelector.visible = true;
            timeSelector.visible = false;
            yearSelector.visible = false;
            dateSelector.selectedDate = dateTimePicker.selectedDate
            break;
        case "HOUR":
            dateSelector.visible = false;
            timeSelector.visible = true;
            yearSelector.visible = false;
            timeSelector.selectMode("HOUR")
            timeSelector.selectedDate = dateTimePicker.selectedDate
            break;
        case "MINUTE":
            dateSelector.visible = false;
            timeSelector.visible = true;
            yearSelector.visible = false;
            timeSelector.selectMode("MINUTE")
            timeSelector.selectedDate = dateTimePicker.selectedDate
            break;
        case "SECOND":
            dateSelector.visible = false;
            timeSelector.visible = true;
            yearSelector.visible = false;
            timeSelector.selectMode("SECOND")
            timeSelector.selectedDate = dateTimePicker.selectedDate
            break;
        }
    }

    header: Item {
        id: header
        anchors.fill: parent
        anchors.margins: 16

        GridLayout {
            anchors.fill: parent
            columns: orientation === Qt.LandscapeOrientation ? 1 : 2
            rows: orientation === Qt.LandscapeOrientation ? 2 : 1

            ColumnLayout {
                Layout.column: 1
                Layout.row: 1
                Layout.alignment: orientation === Qt.LandscapeOrientation ? Qt.AlignTop : Qt.AlignBottom
                Layout.fillHeight: false

                FluidControls.BodyLabel {
                    text: selectedDate.getFullYear()
                    level: 2
                    color: "white"
                    opacity: __mode === "YEAR" ? 1 : 0.7
                    font.pixelSize: 16

                    MouseArea {
                        anchors.fill: parent
                        onClicked: dateTimePicker.show("YEAR")
                    }
                }

                Label {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: selectedDate.toLocaleString(dateTimePicker.locale, "ddd, MMM dd")
                    font.pixelSize: 30
                    color: "white"
                    wrapMode: Text.Wrap
                    opacity: __mode === "MONTH" ? 1 : 0.7

                    MouseArea {
                        anchors.fill: parent
                        onClicked: dateTimePicker.show("MONTH")
                    }
                }

            }

            GridLayout {
                Layout.row: orientation === Qt.LandscapeOrientation ? 2 : 1
                Layout.column: orientation === Qt.LandscapeOrientation ? 1 : 2
                Layout.alignment: orientation === Qt.LandscapeOrientation ? Qt.AlignTop : Qt.AlignBottom | Qt.AlignRight

                columns: orientation === Qt.LandscapeOrientation ? 1 : 2
                rows: orientation === Qt.LandscapeOrientation ? 2 : 1

                Row {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                    Label {
                        text: selectedDate.getHours() < 10 ? "0" + selectedDate.getHours() : selectedDate.getHours()
                        color: "white"
                        font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 25
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: __mode === "HOUR" ? 1 : 0.7
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dateTimePicker.show("HOUR")
                        }
                    }

                    Label {
                        text: ":"
                        color: "white"
                        font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 25
                    }

                    Label {
                        text: selectedDate.getMinutes() < 10 ? "0" + selectedDate.getMinutes() : selectedDate.getMinutes()
                        color: "white"
                        font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 25
                        opacity: __mode === "MINUTE" ? 1 : 0.7
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dateTimePicker.show("MINUTE")
                        }
                    }

                    Label {
                        text: ":"
                        color: "white"
                        font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 25
                    }

                    Label {
                        text: selectedDate.getSeconds() < 10 ? "0" + selectedDate.getSeconds() : selectedDate.getSeconds()
                        color: "white"
                        font.pixelSize: orientation === Qt.LandscapeOrientation ? 30 : 25
                        opacity: __mode === "SECOND" ? 1 : 0.7
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dateTimePicker.show("SECOND")
                        }
                    }
                }

                Column {
                    Layout.column: orientation === Qt.LandscapeOrientation ? 1 : 2
                    Layout.row: orientation === Qt.LandscapeOrientation ? 2 : 1
                    Layout.alignment: orientation === Qt.LandscapeOrientation ? Qt.AlignHCenter : Qt.AlignBottom
                    visible: !timeSelector.prefer24hView

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
    }

    selector: Item {
        id: selectorContainer
        width: parent.width
        height: parent.height

        DateSelector {
            id: dateSelector
            width: parent.width
            height: parent.height
            orientation: dateTimePicker.orientation
            dayOfWeekRowVisible: dateTimePicker.dayOfWeekRowVisible
            weekNumberVisible: dateTimePicker.weekNumberVisible
            minDate: dateTimePicker.minDate
            maxDate: dateTimePicker.maxDate
            visible: true
            locale: dateTimePicker.locale
            onSelectedDateChanged: {
                if(dateTimePicker.selectedDate != selectedDate) {
                    var date = new Date(dateTimePicker.selectedDate.getTime());
                    date.setDate(selectedDate.getDate());
                    date.setMonth(selectedDate.getMonth());
                    date.setFullYear(selectedDate.getFullYear());
                    dateTimePicker.selectedDate = new Date(date.getTime())
                }
            }
        }

        YearSelector {
            id: yearSelector
            anchors.fill: parent
            minDate: dateTimePicker.minDate
            maxDate: dateTimePicker.maxDate
            visible: false
            onSelectedDateChanged: {
                if(dateTimePicker.selectedDate != selectedDate)
                    dateTimePicker.selectedDate = selectedDate
            }
        }

        TimeSelector {
                id: timeSelector
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                visible: false

                onSelectedDateChanged: {
                    if(dateTimePicker.selectedDate != selectedDate)
                        dateTimePicker.selectedDate = selectedDate
                }
       }
    }

    onSelectedDateChanged: {
        switch(__mode) {
        case "YEAR":
            if(yearSelector.selectedDate.getTime() != dateTimePicker.selectedDate.getTime())
                yearSelector.selectedDate = dateTimePicker.selectedDate;
            break;
        case "MONTH":
            if(dateSelector.selectedDate.getTime() != dateTimePicker.selectedDate.getTime())
                dateSelector.selectedDate = dateTimePicker.selectedDate;
            break;
        default:
            if(timeSelector.selectedDate.getTime() != dateTimePicker.selectedDate.getTime())
                timeSelector.selectedDate = dateTimePicker.selectedDate;
            break;
        }
    }
}
