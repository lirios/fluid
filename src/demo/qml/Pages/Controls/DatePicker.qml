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
            onClicked: datePickerDialogLandscape.open()
        }

        Button {
            text: qsTr("Portrait")
            onClicked: datePickerDialogPortrait.open()
        }

        FluidControls.DisplayLabel {
            id: dateLabel
            level: 2
            text: qsTr("n.a.")
        }

        FluidControls.DatePicker {
            orientation: FluidControls.DatePicker.Landscape
        }

        FluidControls.DatePicker {
            orientation: FluidControls.DatePicker.Portrait
        }
    }

    FluidControls.DatePickerDialog {
        id: datePickerDialogLandscape
        orientation: FluidControls.DatePicker.Landscape
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        standardButtonsContainer: Button {
            height: parent.height - 5
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Today")
            flat: true
            onClicked: datePickerDialogLandscape.selectedDate = new Date()
        }
        onAccepted: dateLabel.text = selectedDate.toLocaleString(Qt.locale(), "yyyy-MM-dd")
    }

    FluidControls.DatePickerDialog {
        id: datePickerDialogPortrait
        orientation: FluidControls.DatePicker.Portrait
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        standardButtonsContainer: Button {
            height: parent.height - 5
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Today")
            flat: true
            onClicked: datePickerDialogPortrait.selectedDate = new Date()
        }
        onAccepted: dateLabel.text = selectedDate.toLocaleString(Qt.locale(), "yyyy-MM-dd")
    }
}
