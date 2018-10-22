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

Rectangle {
    id: control

    readonly property bool opened: d.opened
    property int duration: 2000
    property bool fullWidth: FluidCore.Device.formFactor === FluidCore.Device.Phone || FluidCore.Device.formFactor === FluidCore.Device.Phablet

    signal clicked()

    function open(text, buttonText) {
        snackText.text = text;
        snackButton.text = buttonText;
        snackButton.visible = buttonText !== "";
        d.opened = true;
        timer.restart();
    }

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
