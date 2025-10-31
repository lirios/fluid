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
    \brief Dialog with a picker to select dates and time.

    A dialog that lets you select dates and time.

    \code{.qml}
    import QtQuick
    import Fluid as Fluid

    Item {
        width: 600
        height: 600

        Fluid.DateTimePickerDialog {
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
        This property holds the picker orientation.
        The default value is automatically selected based on the device orientation.

        Possible values:
        \value DatePicker.Landscape The picker is landscape.
        \value DatePicker.Portrait The picker is portrait.
    */
    property alias orientation: dateTimePicker.orientation

    /*!
        This property determines the visibility of the day of week row.
    */
    property alias dayOfWeekRowVisible: dateTimePicker.dayOfWeekRowVisible

    /*!
        This property determines the visibility of the week number column.
    */
    property alias weekNumberVisible: dateTimePicker.weekNumberVisible

    /*!
        This property determines the visibility of the AM/PM switch.
    */
    property alias prefer24Hour: dateTimePicker.prefer24Hour

    /*!
        This property holds the start date.
    */
    property alias from: dateTimePicker.from

    /*!
        This property holds the end date.
    */
    property alias to: dateTimePicker.to

    /*!
        This property holds the date and time that has been selected by the user.
        The default value is the current date and time.
    */
    property alias selectedDateTime: dateTimePicker.selectedDateTime

    /*!
        This property allows you to place additional buttons alongside the standard buttons
        of the dialog, like in this example:

        \code{.qml}
        Fluid.DateTimePickerDialog {
            id: dateTimePickerDialog
            standardButtons: Fluid.DialogButtonBox.Ok | Fluid.DialogButtonBox.Cancel
            standardButtonsContainer: Fluid.Button {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Now")
                flat: true
                onClicked: dateTimePickerDialog.selectedDate = new Date()
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

    Fluid.DateTimePicker {
        id: dateTimePicker
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
