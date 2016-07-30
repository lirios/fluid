/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0

FluidWindow {
    visible: true

    width: 800
    height: 800

    title: qsTr("Fluid Demo")

    Material.primary: Material.LightBlue
    Material.accent: Material.Blue

    Universal.accent: Universal.Cobalt

    initialPage: Page {
        header: ToolBar {
            TabBar {
                id: bar
                width: parent.width

                TabButton {
                    text: qsTr("Basic components")
                }

                TabButton {
                    text: qsTr("Compound components")
                }

                TabButton {
                    text: qsTr("Style")
                }
            }
        }

        StackLayout {
            anchors.fill: parent
            currentIndex: bar.currentIndex

            BasicComponents {}
            CompoundComponents {}
            Style {}
        }
    }
}
