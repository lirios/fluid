// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Fluid as Fluid

/*!
    \brief Input dialogs ask the user to input data with certain constraints.

    The dialog is automatically accepted when the Return or Enter key is pressed
    and the input in an acceptable state.

    For more information you can read the
    <a href="https://material.io/guidelines/components/dialogs.html">Material Design guidelines</a>.
*/
Dialog {
    id: dialog

    /*!
        Text field.
    */
    property alias textField: textField

    /*!
        Dialog text.
    */
    property alias text: dialogLabel.text

    focus: true
    modal: true
    standardButtons: Fluid.Dialog.Ok | Fluid.Dialog.Cancel

    ColumnLayout {
        anchors {
            left: parent.left
            top: parent.top
        }
        width: parent.width

        Fluid.DialogLabel {
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
