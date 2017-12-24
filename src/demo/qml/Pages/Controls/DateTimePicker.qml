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
            onClicked: dateTimePickerPopup.show()
        }

        Button {
            text: qsTr("Portrait")
            onClicked: dateTimePickerPopup2.show()
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
            orientation: FluidControls.DateTimePicker.Landscape
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
            orientation: FluidControls.DateTimePicker.Portrait
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
