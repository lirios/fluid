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

import QtQml 2.2
import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Controls.Private 1.0 as FluidControlsPrivate
import Fluid.Templates 1.0 as FluidTemplates
import Qt.labs.calendar 1.0

FluidTemplates.DateTimePicker {
    id: picker

    /*!
        \internal
    */
    readonly property bool __isLandscape : picker.orientation === FluidTemplates.DateTimePicker.Landscape

    /*!
        \internal
    */
    readonly property bool __footerIsVisible: footer && footer.children.length > 0

    onSelectedDateTimeChanged: {
        switch(mode) {
        case FluidTemplates.DateTimePicker.Year:
            if (yearSelector.selectedYear !== picker.selectedDateTime.getFullYear())
                yearSelector.selectedYear = picker.selectedDateTime.getFullYear();
            break;
        case FluidTemplates.DateTimePicker.Month:
            if (dateSelector.selectedDate.getTime() !== picker.selectedDateTime.getTime())
                dateSelector.selectedDate = picker.selectedDateTime;
            break;
        default:
            if (timeSelector.selectedTime.getTime() !== picker.selectedDateTime.getTime())
                timeSelector.selectedTime = picker.selectedDateTime;
            break;
        }
    }

    Component.onCompleted: {
        dateSelector.selectedDate = picker.selectedDateTime;
        yearSelector.selectedYear = picker.selectedDateTime.getFullYear();
        timeSelector.selectedTime = picker.selectedDateTime;
    }

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    background: Pane {
        implicitWidth: __isLandscape ? 500 : 340
        implicitHeight: __isLandscape ? 350 : 470

        locale: picker.locale

        Material.elevation: __footerIsVisible ? 0 : 1
    }

    header: Rectangle {
        color: picker.Material.theme === Material.Dark ? picker.Material.dialogColor : picker.Material.accent

        Item {
            anchors.fill: parent
            anchors.margins: 16

            GridLayout {
                anchors.fill: parent
                columns: __isLandscape ? 1 : 2
                rows: __isLandscape ? 2 : 1

                ColumnLayout {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: __isLandscape ? Qt.AlignTop : Qt.AlignBottom
                    Layout.fillHeight: false

                    FluidControls.BodyLabel {
                        text: yearSelector.selectedYear
                        level: 2
                        color: "white"
                        opacity: yearSelector.visible ? 1 : 0.7
                        font.pixelSize: 16

                        MouseArea {
                            anchors.fill: parent
                            onClicked: picker.mode = FluidTemplates.DateTimePicker.Year
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: dateSelector.selectedDate.toLocaleString(picker.locale, "ddd, MMM dd")
                        font.pixelSize: 30
                        color: "white"
                        wrapMode: Text.Wrap
                        opacity: dateSelector.visible ? 1 : 0.7

                        MouseArea {
                            anchors.fill: parent
                            onClicked: picker.mode = FluidTemplates.DateTimePicker.Month
                        }
                    }

                }

                GridLayout {
                    Layout.row: __isLandscape ? 2 : 1
                    Layout.column: __isLandscape ? 1 : 2
                    Layout.alignment: __isLandscape ? Qt.AlignTop : Qt.AlignBottom | Qt.AlignRight

                    columns: __isLandscape ? 1 : 2
                    rows: __isLandscape ? 2 : 1

                    Row {
                        Layout.column: 1
                        Layout.row: 1
                        Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                        Label {
                            text: timeSelector.selectedTime.getHours() < 10 ? "0" + timeSelector.selectedTime.getHours() : timeSelector.selectedTime.getHours()
                            color: "white"
                            font.pixelSize: __isLandscape ? 30 : 25
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: timeSelector.currentSelector === FluidControlsPrivate.TimeSelector.Hour ? 1 : 0.7

                            MouseArea {
                                anchors.fill: parent
                                onClicked: timeSelector.mode = FluidControlsPrivate.TimeSelector.Hour
                            }
                        }

                        Label {
                            text: ":"
                            color: "white"
                            font.pixelSize: __isLandscape ? 30 : 25
                        }

                        Label {
                            text: timeSelector.selectedTime.getMinutes() < 10 ? "0" + timeSelector.selectedTime.getMinutes() : timeSelector.selectedTime.getMinutes()
                            color: "white"
                            font.pixelSize: __isLandscape ? 30 : 25
                            opacity: timeSelector.currentSelector === FluidControlsPrivate.TimeSelector.Minute ? 1 : 0.7

                            MouseArea {
                                anchors.fill: parent
                                onClicked: timeSelector.mode = FluidControlsPrivate.TimeSelector.Minute
                            }
                        }

                        Label {
                            text: ":"
                            color: "white"
                            font.pixelSize: __isLandscape ? 30 : 25
                        }

                        Label {
                            text: timeSelector.selectedTime.getSeconds() < 10 ? "0" + timeSelector.selectedTime.getSeconds() : timeSelector.selectedTime.getSeconds()
                            color: "white"
                            font.pixelSize: __isLandscape ? 30 : 25
                            opacity: timeSelector.currentSelector === FluidControlsPrivate.TimeSelector.Second ? 1 : 0.7

                            MouseArea {
                                anchors.fill: parent
                                onClicked: timeSelector.mode = FluidControlsPrivate.TimeSelector.Second
                            }
                        }
                    }

                    Column {
                        Layout.column: __isLandscape ? 1 : 2
                        Layout.row: __isLandscape ? 2 : 1
                        Layout.alignment: __isLandscape ? Qt.AlignHCenter : Qt.AlignBottom
                        visible: !timeSelector.prefer24Hour

                        Label {
                            text: "AM"
                            color: "white"
                            font.pixelSize: 18
                            opacity: timeSelector.timeMode === FluidControlsPrivate.TimeSelector.AM ? 1 : 0.7
                            horizontalAlignment: Text.AlignHCenter

                            MouseArea {
                                anchors.fill: parent
                                onClicked: timeSelector.timeMode = FluidControlsPrivate.TimeSelector.AM
                            }
                        }

                        Label {
                            text: "PM"
                            color: "white"
                            opacity: timeSelector.timeMode === FluidControlsPrivate.TimeSelector.PM ? 1 : 0.7
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter

                            MouseArea {
                                anchors.fill: parent
                                onClicked: timeSelector.timeMode = FluidControlsPrivate.TimeSelector.PM
                            }
                        }
                    }
                }
            }
        }
    }

    selector: Item {
        FluidControlsPrivate.DateSelector {
            id: dateSelector
            width: parent.width
            height: parent.height
            dayOfWeekRowVisible: picker.dayOfWeekRowVisible
            weekNumberVisible: picker.weekNumberVisible
            from: picker.from
            to: picker.to
            locale: picker.locale
            visible: picker.mode === FluidTemplates.DateTimePicker.Month
            onSelectedDateChanged: {
                if (picker.selectedDateTime !== selectedDate) {
                    var date = new Date(picker.selectedDateTime.getTime());
                    date.setDate(selectedDate.getDate());
                    date.setMonth(selectedDate.getMonth());
                    date.setFullYear(selectedDate.getFullYear());
                    picker.selectedDateTime = new Date(date.getTime());
                    yearSelector.selectedYear = selectedDate.getFullYear();
                }
            }
        }

        FluidControlsPrivate.YearSelector {
            id: yearSelector
            width: parent.width
            height: parent.height
            from: picker.from
            to: picker.to
            visible: picker.mode === FluidTemplates.DateTimePicker.Year
            onSelectedYearChanged: {
                if (picker.selectedDateTime.getFullYear() !== selectedYear) {
                    var date = new Date(picker.selectedDateTime.getTime());
                    date.setFullYear(selectedYear);
                    picker.selectedDateTime = new Date(date.getTime());
                    dateSelector.selectedDate = new Date(date.getTime());
                }
            }
        }

        FluidControlsPrivate.TimeSelector {
            id: timeSelector
            width: parent.width
            height: parent.height
            prefer24Hour: picker.prefer24Hour
            visible: picker.mode === FluidTemplates.DateTimePicker.Hour ||
                     picker.mode === FluidTemplates.DateTimePicker.Minute ||
                     picker.mode === FluidTemplates.DateTimePicker.Second
            onModeChanged: {
                switch (mode) {
                case FluidTemplates.TimeSelector.Hour:
                    picker.mode = FluidTemplates.DateTimePicker.Hour;
                    break;
                case FluidTemplates.TimeSelector.Minute:
                    picker.mode = FluidTemplates.DateTimePicker.Minute;
                    break;
                case FluidTemplates.TimeSelector.Second:
                    picker.mode = FluidTemplates.DateTimePicker.Second;
                    break;
                }
            }
            onSelectedTimeChanged: {
                if (compareTime(picker.selectedDateTime, selectedTime)) {
                    var date = new Date(picker.selectedDateTime.getTime());
                    date.setHours(selectedTime.getHours());
                    date.setMinutes(selectedTime.getMinutes());
                    date.setSeconds(selectedTime.getSeconds());
                    date.setMilliseconds(selectedTime.getMilliseconds());
                    picker.selectedDateTime = date;
                }
            }

            // Compare the time portion of \a dateTime with \a time.
            function compareTime(dateTime, time) {
                return dateTime.getHours() === time.getHours() &&
                        dateTime.getMinutes() === time.getMinutes() &&
                        dateTime.getSeconds() === time.getSeconds() &&
                        dateTime.getMilliseconds() === time.getMilliseconds();
            }
        }
    }
}
