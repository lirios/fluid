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
import QtQuick.Controls.Material 2.3

Page {
    Material.theme: lightRadio.checked ? Material.Light : Material.Dark

    header: ToolBar {
        spacing: 16

        Material.background: Material.shade(Material.primary, Material.ShadeA700)
        Material.theme: Material.Dark

        Row {
            anchors.verticalCenter: parent.verticalCenter

            RadioButton {
                id: lightRadio
                text: qsTr("Light")
                checked: true
            }

            RadioButton {
                id: darkRadio
                text: qsTr("Dark")
            }
        }
    }
}
