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

import QtQuick 2.3
import QtQuick.Controls 2.1
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype DatePickerDialog
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Dialog with a picker to select dates

    A dialog that lets you selected dates.

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DatePickerDialog {
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

    property alias orientation: datePicker.orientation
    property alias dayOfWeekRowVisible: datePicker.dayOfWeekRowVisible
    property alias weekNumberVisible: datePicker.weekNumberVisible
    property alias selectedDate: datePicker.selectedDate
    property alias minDate: datePicker.minDate
    property alias maxDate: datePicker.maxDate
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

    FluidControls.DatePicker {
        id: datePicker
        footer: DialogButtonBox {
            id: buttonBox
            padding: 0
            standardButtons: dialog.standardButtons
            onAccepted: dialog.accept()
            onRejected: dialog.reject()
        }
    }
}
