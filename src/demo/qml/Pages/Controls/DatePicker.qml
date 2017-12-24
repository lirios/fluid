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

Item {
    Column {
        anchors.centerIn: parent

        Button {
            text: qsTr("Landscape")
            onClicked: datePickerPopup.show()
        }

        Button {
            text: qsTr("Portrait")
            onClicked: datePickerPopup2.show()
        }
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
            orientation: FluidControls.DatePicker.Landscape
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
            orientation: FluidControls.DatePicker.Portrait
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
}
