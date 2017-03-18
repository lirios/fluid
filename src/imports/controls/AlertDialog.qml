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

/*!
    \qmltype AlertDialog
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Alert dialogs are urgent interruptions to inform the user about a situation.

    An alert dialog is used to interrupt the user's workflow to inform them about
    a situation that requires their acknowledgement.

    Most alert don't need a title and they summarize a decision in a sentence or two
    by either asking a question or making a statement related to the action buttons.

   Here is a short example of usage:

   \qml
   import QtQuick 2.4
   import QtQuick.Controls 2.1
   import Fluid.Controls 1.0 as FluidControls

   Item {
       FluidControls.AlertDialog {
           id: alertDialog
           title: "Use FooBar's localization service?"
           text: "Let FooBar help apps determine the location. " +
                 "This means sending anonymous location data to FooBar, " +
                 "even when no apps are running."
       }

       Button {
           anchors.centerIn: parent
           text: "Click me"
           onClicked: alertDialog.open()
       }
   }
   \endqml
*/
Dialog {
    /*!
        \internal
    */
    default property alias content: dialogContent.data

    /*!
        Informative text to display.
    */
    property alias text: dialogLabel.text

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    focus: true
    modal: true

    Column {
        id: dialogContent
        anchors {
            left: parent.left
            top: parent.top
        }
        spacing: FluidControls.Units.smallSpacing
        width: parent.width

        FluidControls.DialogLabel {
            id: dialogLabel
            wrapMode: Text.Wrap
            width: parent.width
            visible: text !== ""
        }
    }
}
