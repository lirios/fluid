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
    \qmltype DatePicker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Picker to select a date

    A standalone datepicker component to select a date

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DatePicker {
            id: datepicker
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                Material.theme: Material.Light
                Material.foreground: Material.accent
                flat: true
                onClicked: {
                    datepicker.selectedDate = new Date()
                }
            }
            onAccepted: {
                console.log(date)
            }
        }
    }

    \endcode*/
Picker {
    id: datePicker

    property bool dayOfWeekRowVisible: true
    property bool weekNumberVisible: true
    property var selectedDate: new Date()
    property var minDate: new Date(1976, 0, 1)
    property var maxDate: new Date(2150, 11, 31)

    function show(type) {
        switch(type) {
        case "YEAR":
            dateSelector.visible = false;
            yearSelector.visible = true;
            break;
        case "MONTH":
            dateSelector.visible = true;
            yearSelector.visible = false;
            break;
        }
    }

    onSelectedDateChanged: {
        dateSelector.selectedDate = datePicker.selectedDate
        yearSelector.selectedDate = datePicker.selectedDate
    }

    header: Item {
        id: header
        anchors.fill: parent
        anchors.margins: 16

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            FluidControls.BodyLabel {
                text: selectedDate.getFullYear()
                level: 2
                color: "white"
                opacity: 0.7
                font.pixelSize: 16

                MouseArea {
                    anchors.fill: parent
                    onClicked: datePicker.show("YEAR")
                }
            }

            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: selectedDate.toLocaleString(datePicker.locale, "ddd, MMM dd")
                font.pixelSize: 30
                color: "white"
                wrapMode: Text.Wrap

                MouseArea {
                    anchors.fill: parent
                    onClicked: datePicker.show("MONTH")
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
            orientation: datePicker.orientation
            dayOfWeekRowVisible: datePicker.dayOfWeekRowVisible
            weekNumberVisible: datePicker.weekNumberVisible
            minDate: datePicker.minDate
            maxDate: datePicker.maxDate
            visible: true
            locale: datePicker.locale
            onSelectedDateChanged: {
                if(datePicker.selectedDate != selectedDate)
                    datePicker.selectedDate = selectedDate
            }
        }

        YearSelector {
            id: yearSelector
            anchors.fill: parent
            minDate: datePicker.minDate
            maxDate: datePicker.maxDate
            visible: false
            onSelectedDateChanged: {
                if(datePicker.selectedDate != selectedDate)
                    datePicker.selectedDate = selectedDate
            }
        }
    }
}
