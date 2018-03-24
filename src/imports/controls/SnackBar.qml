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
import QtQuick.Controls.Material 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Effects 1.0 as FluidEffects

/*!
   \qmltype SnackBar
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief SnackBar provides a brief feedback about an operation.

   \code
   Page {
       title: qsTr("Send a message")

       Button {
           anchors.centerIn: parent
           text: qsTr("Send Message")
           onClicked: snackBar.open(qsTr("Message sent"))
       }

       SnackBar {
           id: snackBar
       }
   }
   \endcode

    SnackBar provides a brief feedback about an operation through a
    message at the bottom of the screen.

    It contains a single line of text directly related to the operation performed.
    There can be a text action, but no icons.

    For more information you can read the
    \l{https://material.io/guidelines/components/snackbars-toasts.html}{Material Design guidelines}.
*/
Rectangle {
    id: control

    /*!
        \qmlproperty bool opened

        Whether the snack bar is currently open or not.
    */
    readonly property bool opened: d.opened

    /*!
        \qmlproperty int duration

        Amount of time (in ms) to keep the notification visible.
        The default is 2s.
    */
    property int duration: 2000

    /*!
        \qmlproperty bool fullWidth

        Whether the bar should take full screen width.
        The default depends on the device: full width only on phones and tablets.
    */
    property bool fullWidth: FluidCore.Device.type === FluidCore.Device.phone || FluidCore.Device.type === FluidCore.Device.phablet

    /*!
        \qmlsignal clicked()

        This signal is emitted when the button is clicked.
        The handler is \c onClicked.
    */
    signal clicked()

    /*!
        \qmlmethod void SnackBar::open(string text, string buttonText = "")

        Open the bar with the specified \a text and \a buttonText.
    */
    function open(text, buttonText) {
        snackText.text = text;
        snackButton.text = buttonText;
        snackButton.visible = buttonText !== "";
        d.opened = true;
        timer.restart();
    }

    /*!
        \qmlmethod void SnackBar::close()

        Close the bar.
    */
    function close() {
        d.opened = false;
    }

    states: [
        State {
            name: "fullWidth"
            when: fullWidth

            AnchorChanges {
                target: control
                anchors.left: parent.left
                anchors.right: parent.right
            }
        },
        State {
            name: "normalWidth"
            when: !fullWidth

            PropertyChanges {
                target: control
                width: snackLayout.implicitWidth
            }
            AnchorChanges {
                target: control
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    ]

    anchors.bottom: parent.bottom
    anchors.bottomMargin: d.opened ? 0 : -control.height

    Behavior on anchors.bottomMargin {
        NumberAnimation { duration: 300 }
    }

    radius: fullWidth ? 0 : 2
    color: Material.background
    height: snackLayout.implicitHeight
    z: 10000

    layer.enabled: !fullWidth
    layer.effect: FluidEffects.Elevation {
        elevation: 1
    }

    Material.theme: Material.Dark

    QtObject {
        id: d

        property bool opened: false
    }

    Timer {
        id: timer

        interval: control.duration

        onTriggered: {
            if (!running)
                d.opened = false;
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    RowLayout {
        id: snackLayout

        anchors {
            verticalCenter: parent.verticalCenter
            left: control.fullWidth ? parent.left : undefined
            right: control.fullWidth ? parent.right : undefined
        }

        spacing: 0

        Item {
            width: 24
        }

        Label {
            id: snackText

            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 2
            wrapMode: Text.Wrap
            elide: Text.ElideRight

            Layout.fillWidth: true
            Layout.minimumWidth: control.fullWidth ? -1 : 288
            Layout.maximumWidth: control.fullWidth ? -1 : 568
            Layout.preferredHeight: lineCount == 2 ? 80 : 48
        }

        Item {
            id: middleSpacer
            width: snackButton.text == "" ? 0 : (control.fullWidth ? 24 : 48)
        }

        Button {
            id: snackButton

            flat: true
            onClicked: control.clicked()

            Material.foreground: Material.accentColor
        }

        Item {
            width: 24
        }
    }
}
