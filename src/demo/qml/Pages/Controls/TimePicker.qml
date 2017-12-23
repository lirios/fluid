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
            onClicked: timePickerPopup.show()
        }

        Button {
            text: qsTr("Portrait")
            onClicked: timePickerPopup2.show()
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
}
