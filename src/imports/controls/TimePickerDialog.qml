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
    \qmltype TimePickerDialog
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Dialog with a picker to select time

    A dialog that lets you selected time.

    \code
    import QtQuick 2.0
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

    property alias prefer24Hour: timePicker.prefer24Hour
    property alias orientation: timePicker.orientation
    property alias selectedDate: timePicker.selectedDate

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
        standardButtons: dialog.standardButtons
        onAccepted: dialog.accept()
        onRejected: dialog.reject()
    }
}
