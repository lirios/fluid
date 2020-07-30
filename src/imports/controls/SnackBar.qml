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

Item {
    id: snackBar

    readonly property bool opened: popup.visible
    property int duration: 2000
    property bool fullWidth: FluidCore.Device.formFactor === FluidCore.Device.Phone || FluidCore.Device.formFactor === FluidCore.Device.Phablet

    signal clicked()

    function open(text, buttonText) {
        snackText.text = text;
        snackButton.text = buttonText;
        snackButton.visible = buttonText !== "";
        popup.open();
        if (timer.running)
            timer.restart();
    }

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
            layer.effect: FluidEffects.Elevation {
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
