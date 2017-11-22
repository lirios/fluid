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

import QtQuick 2.0
import QtQuick.Controls 2.1
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Controls.Material 2.0

Item {
    Column {
        anchors.centerIn: parent

        Button {
            text: qsTr("Alert")
            onClicked: alert.open()
        }

        Button {
            text: qsTr("Input")
            onClicked: input.open()
        }

        Button {
            text: qsTr("DatePicker (Landscape)")
            onClicked: datePickerPopup.show()
        }

        Button {
            text: qsTr("TimePicker (Landscape)")
            onClicked: timePickerPopup.show()
        }

        Button {
            text: qsTr("DateTimePicker (Landscape)")
            onClicked: dateTimePickerPopup.show()
        }

        Button {
            text: qsTr("DatePicker (Portrait)")
            onClicked: datePickerPopup2.show()
        }

        Button {
            text: qsTr("TimePicker (Portrait)")
            onClicked: timePickerPopup2.show()
        }

        Button {
            text: qsTr("DateTimePicker (Portrait)")
            onClicked: dateTimePickerPopup2.show()
        }
    }

    FluidControls.AlertDialog {
        id: alert

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        text: qsTr("Discard draft?")
        standardButtons: Dialog.Discard | Dialog.Cancel
    }

    FluidControls.InputDialog {
        id: input

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 280

        title: qsTr("In what year were you born?")
        text: qsTr("We need to know in what year you were born in order to verify your age.")
        textField.inputMask: "9999"
        textField.placeholderText: qsTr("Type a 4 digits number")
    }

    Popup {
        function show() {
            datepicker.show("MONTH")
            datePickerPopup.open()
        }

        id: datePickerPopup
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.DatePicker {
            id: datepicker
            orientation: Qt.LandscapeOrientation
            onAccepted: datePickerPopup.close()
            onRejected: datePickerPopup.close()

            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                flat: true
                onClicked: datepicker.selectedDate = new Date()
            }
        }
    }

    Popup {
        function show() {
            timepicker.show("HOUR")
            timePickerPopup.open()
        }

        id: timePickerPopup
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.TimePicker {
            id: timepicker
            orientation: Qt.LandscapeOrientation
            onAccepted: timePickerPopup.close()
            onRejected: timePickerPopup.close()
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        }
    }

    Popup {
        function show() {
            datepicker2.show("MONTH")
            datePickerPopup2.open()
        }

        id: datePickerPopup2
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.DatePicker {
            id: datepicker2
            orientation: Qt.PortraitOrientation
            onAccepted: datePickerPopup2.close()
            onRejected: datePickerPopup2.close()

            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                flat: true
                onClicked: datepicker2.selectedDate = new Date()
            }
        }
    }

    Popup {
        function show() {
            timepicker2.show("HOUR")
            timePickerPopup2.open()
        }

        id: timePickerPopup2
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.TimePicker {
            id: timepicker2
            orientation: Qt.PortraitOrientation
            onAccepted: timePickerPopup2.close()
            onRejected: timePickerPopup2.close()
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        }
    }

    Popup {
        function show() {
            datetimepicker.show("MONTH")
            dateTimePickerPopup.open()
        }

        id: dateTimePickerPopup
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.DateTimePicker {
            id: datetimepicker
            onAccepted: dateTimePickerPopup.close()
            onRejected: dateTimePickerPopup.close()

            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                flat: true
                onClicked: datetimepicker.selectedDate = new Date()
            }
        }
    }

    Popup {
        function show() {
            datetimepicker2.show("MONTH")
            dateTimePickerPopup2.open()
        }

        id: dateTimePickerPopup2
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 0

        FluidControls.DateTimePicker {
            id: datetimepicker2
            orientation: Qt.PortraitOrientation
            onAccepted: dateTimePickerPopup2.close()
            onRejected: dateTimePickerPopup2.close()

            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                height: parent.height - 5
                anchors.verticalCenter: parent.verticalCenter
                text: "Now"
                flat: true
                onClicked: datetimepicker2.selectedDate = new Date()
            }
        }
    }
}
