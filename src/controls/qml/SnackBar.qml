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
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
   \brief SnackBar provides a brief feedback about an operation.

   \code{.qml}
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
    <a href="https://material.io/guidelines/components/snackbars-toasts.html">Material Design guidelines</a>.
*/
Item {
    id: snackBar

    /*!
        Whether the snack bar is currently open or not.
    */
    readonly property bool opened: popup.visible

    /*!
        Amount of time (in ms) to keep the notification visible.
        The default is 2s.
    */
    property int duration: 2000

    /*!
        Whether the bar should take full screen width.
        The default depends on the device: full width only on phones and tablets.
    */
    property bool fullWidth: Fluid.Device.formFactor === Fluid.Device.Phone || Fluid.Device.formFactor === Fluid.Device.Phablet

    /*!
        This signal is emitted when the button is clicked.
        The handler is \c onClicked.
    */
    signal clicked()

    /*!
        Open the bar with the specified \a text and \a buttonText.
    */
    function open(text, buttonText) {
        snackText.text = text;
        snackButton.text = buttonText;
        snackButton.visible = buttonText !== "";
        popup.open();
        if (timer.running)
            timer.restart();
    }

    /*!
        Close the bar.
    */
    function close() {
        popup.close();
    }

    Timer {
        id: timer

        interval: snackBar.duration
        running: popup.visible

        onTriggered: popup.close()
    }

    Popup {
        id: popup

        property int offset: 0

        Material.theme: Material.Dark

        modal: false
        closePolicy: Popup.NoAutoClose

        x: snackBar.fullWidth ? 0 : (snackBar.parent.width - width) / 2
        y: snackBar.parent.height - offset

        width: snackBar.fullWidth ? snackBar.parent.width : snackLayout.implicitWidth
        height: snackLayout.implicitHeight

        enter: Transition {
            NumberAnimation { property: "offset"; from: 0; to: popup.height }
        }

        exit: Transition {
            NumberAnimation { property: "offset"; from: popup.height; to: 0 }
        }

        background: Rectangle {
            radius: snackBar.fullWidth ? 0 : 2
            color: Material.background

            layer.enabled: !snackBar.fullWidth
            layer.effect: Fluid.Elevation {
                elevation: 1
            }
        }

        contentItem: Item {
            implicitWidth: snackLayout.implicitWidth
            implicitHeight: snackLayout.implicitHeight

            RowLayout {
                id: snackLayout

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: snackBar.fullWidth ? parent.left : undefined
                    right: snackBar.fullWidth ? parent.right : undefined
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
                    Layout.minimumWidth: snackBar.fullWidth ? -1 : 288
                    Layout.maximumWidth: snackBar.fullWidth ? -1 : 568
                    Layout.preferredHeight: lineCount == 2 ? 80 : 48
                }

                Item {
                    id: middleSpacer
                    width: snackButton.text == "" ? 0 : (snackBar.fullWidth ? 24 : 48)
                }

                Button {
                    id: snackButton

                    flat: true
                    onClicked: snackBar.clicked()

                    Material.foreground: Material.accentColor
                }

                Item {
                    width: 24
                }
            }
        }
    }
}
