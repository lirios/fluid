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
import QtQuick.Controls 2.3
import Fluid.Controls 1.1 as FluidControls
import "../.."

Item {
    FluidControls.NavigationListView {
        id: navListView

        autoHighlight: autoHighlightCheckBox.checked

        topContent: Image {
            width: parent.width
            height: 200
            source: "qrc:/images/materialbg.png"
        }

        actions: [
            FluidControls.Action {
                text: "Action 1"
            },
            FluidControls.Action {
                text: "Action 2"
            }
        ]
    }

    Column {
        anchors.centerIn: parent

        CheckBox {
            id: autoHighlightCheckBox
            text: qsTr("Auto highlight")
        }

        Button {
            text: navListView.opened ? qsTr("Close") : qsTr("Open")
            onClicked: navListView.opened ? navListView.close() : navListView.open()
        }
    }
}
