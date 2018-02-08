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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype InputDialog
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Input dialogs ask the user to input data with certain constraints.

    The dialog is automatically accepted when the Return or Enter key is pressed
    and the input in an acceptable state.

    For more information you can read the
    \l{https://material.io/guidelines/components/dialogs.html}{Material Design guidelines}.
*/
Dialog {
    id: dialog

    /*!
        \qmlproperty TextField textField

        Text field.
    */
    property alias textField: textField

    /*!
        \qmlproperty string text

        Dialog text.
    */
    property alias text: dialogLabel.text

    focus: true
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    ColumnLayout {
        anchors {
            left: parent.left
            top: parent.top
        }
        width: parent.width

        FluidControls.DialogLabel {
            id: dialogLabel
            wrapMode: Text.Wrap
            visible: text !== ""

            Layout.fillWidth: true
        }

        TextField {
            id: textField
            focus: true
            onAccepted: dialog.accept()

            Layout.fillWidth: true
        }
    }
}
