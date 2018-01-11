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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype TimePickerDialog
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Dialog with a picker to select time

    A dialog that lets you selected time.

    \code
    import QtQuick 2.10
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.TimePickerDialog {
            onAccepted: {
                console.log(selectedDate);
            }
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/
Dialog {
    id: dialog

    /*!
        \qmlproperty enumeration Fluid.Controls::TimePickerDialog::orientation

        This property holds the picker orientation.
        The default value is automatically selected based on the device orientation.

        Possible values:
        \value TimePicker.Landscape The picker is landscape.
        \value TimePicker.Portrait The picker is portrait.
    */
    property alias orientation: timePicker.orientation

    /*!
        \qmlproperty bool Fluid.Controls::TimePickerDialog::prefer24Hour

        This property determines the visibility of the AM/PM switch.
    */
    property alias prefer24Hour: timePicker.prefer24Hour

    /*!
        \qmlproperty date Fluid.Controls::TimePickerDialog::selectedTime

        This property holds the time that has been selected by the user.
        The default value is the current time.
    */
    property alias selectedTime: timePicker.selectedTime

    /*!
        \qmlproperty list<Object> Fluid.Controls::TimePickerDialog::standardButtonsContainer

        This property allows you to place additional buttons alongside the standard buttons
        of the dialog, like in this example:

        \code
        FluidControls.TimePickerDialog {
            id: timePickerDialog
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            standardButtonsContainer: Button {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Now")
                flat: true
                onClicked: timePickerDialog.selectedTime = new Date()
            }
        }
        \endcode
    */
    property alias standardButtonsContainer: buttonBox.data

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    padding: 0
    margins: 0
    topMargin: 0
    topPadding: 0
    modal: true

    header.visible: false
    footer.visible: false

    FluidControls.TimePicker {
        id: timePicker
        footer: DialogButtonBox {
            id: buttonBox
            padding: 0
            standardButtons: dialog.standardButtons
            onAccepted: dialog.accept()
            onRejected: dialog.reject()

            Material.background: "transparent"
        }
    }
}
