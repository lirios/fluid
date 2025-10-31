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

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
    \brief Dialog to select a single date.

    Dialog to select a single date from a calendar.

    \code{.qml}
    import QtQuick
    import Fluid as Fluid

    Item {
        width: 600
        height: 600

        Fluid.Button {
            anchors.centerIn: parent
            text: qsTr("Open")
            onClicked: datePickerDialog.open()
        }

        Fluid.DatePickerDialog {
            id: datePickerDialog
            onAccepted: {
                console.log(selectedDate);
            }
            standardButtons: Fluid.DialogButtonBox.Ok | Fluid.DialogButtonBox.Cancel
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/pickers.html">Material Design guidelines</a>.
*/
Dialog {
    id: dialog

    /*!
        This property holds the date picker orientation.
        The default value is automatically selected based on the device orientation.

        Possible values:
        \value DatePicker.Landscape The date picker is landscape.
        \value DatePicker.Portrait The date picker is portrait.
    */
    property alias orientation: datePicker.orientation

    /*!
        This property determines the visibility of the day of week row.
    */
    property alias dayOfWeekRowVisible: datePicker.dayOfWeekRowVisible

    /*!
        This property determines the visibility of the week number column.
    */
    property alias weekNumberVisible: datePicker.weekNumberVisible

    /*!
        This property holds the start date.
    */
    property alias from: datePicker.from

    /*!
        This property holds the end date.
    */
    property alias to: datePicker.to

    /*!
        This property holds the date that has been selected by the user.
        The default value is the current date.
    */
    property alias selectedDate: datePicker.selectedDate

    /*!
        This property allows you to place additional buttons alongside the standard buttons
        of the dialog, like in this example:

        \code{.qml}
        Fluid.DatePickerDialog {
            id: datePickerDialog
            standardButtons: Fluid.DialogButtonBox.Ok | Fluid.DialogButtonBox.Cancel
            standardButtonsContainer: Fluid.Button {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Today")
                flat: true
                onClicked: datePickerDialog.selectedDate = new Date()
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

    Fluid.DatePicker {
        id: datePicker
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
