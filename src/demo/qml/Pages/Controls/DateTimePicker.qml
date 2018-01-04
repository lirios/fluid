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
import QtQuick.Controls 2.2
import Fluid.Controls 1.0 as FluidControls

ScrollView {
    Column {
        spacing: 16

        Button {
            text: qsTr("Landscape")
            onClicked: dateTimePickerDialogLandscape.open()
        }

        Button {
            text: qsTr("Portrait")
            onClicked: dateTimePickerDialogPortrait.open()
        }

        FluidControls.DisplayLabel {
            id: dateTimeLabel
            level: 2
            text: qsTr("n.a.")
        }

        Switch {
            id: prefer24HourSwitch
            text: qsTr("24 hour clock")
        }

        FluidControls.DateTimePicker {
            orientation: FluidControls.DateTimePicker.Landscape
        }

        FluidControls.DateTimePicker {
            orientation: FluidControls.DateTimePicker.Portrait
        }
    }

    FluidControls.DateTimePickerDialog {
        id: dateTimePickerDialogLandscape
        orientation: FluidControls.DateTimePicker.Landscape
        prefer24hView: prefer24HourSwitch.checked
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        standardButtonsContainer: Button {
            height: parent.height - 5
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Now")
            flat: true
            onClicked: dateTimePickerDialogLandscape.selectedDate = new Date()
        }
        onAccepted: dateTimeLabel.text = selectedDate.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm ap")
    }

    FluidControls.DateTimePickerDialog {
        id: dateTimePickerDialogPortrait
        orientation: FluidControls.DateTimePicker.Portrait
        prefer24hView: prefer24HourSwitch.checked
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        standardButtonsContainer: Button {
            height: parent.height - 5
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Now")
            flat: true
            onClicked: dateTimePickerDialogPortrait.selectedDate = new Date()
        }
        onAccepted: dateTimeLabel.text = selectedDate.toLocaleString(Qt.locale(), "yyyy-MM-dd  hh:mm ap")
    }
}
