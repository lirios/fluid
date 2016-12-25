/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Fluid.Core 1.0
import Fluid.Controls 1.0
import "../.."

GridLayout {
    id: grid

    property color whiteColor: Qt.rgba(255, 255, 255, 1)
    property color blackColor: Qt.rgba(0, 0, 0, 1)

    anchors.centerIn: parent
    columns: width / 300
    width: parent.width
    rowSpacing: Units.smallSpacing
    columnSpacing: Units.smallSpacing

    Repeater {
        model: ListModel {
            ListElement {
                paletteIndex: Material.Red
                name: "Red"
            }
            ListElement {
                paletteIndex: Material.Pink
                name: "Pink"
            }
            ListElement {
                paletteIndex: Material.Purple
                name: "Purple"
            }
            ListElement {
                paletteIndex: Material.DeepPurple
                name: "DeepPurple"
            }
            ListElement {
                paletteIndex: Material.Indigo
                name: "Indigo"
            }
            ListElement {
                paletteIndex: Material.Blue
                name: "Blue"
            }
            ListElement {
                paletteIndex: Material.LightBlue
                name: "LightBlue"
            }
            ListElement {
                paletteIndex: Material.Cyan
                name: "Cyan"
            }
            ListElement {
                paletteIndex: Material.Teal
                name: "Teal"
            }
            ListElement {
                paletteIndex: Material.Green
                name: "Green"
            }
            ListElement {
                paletteIndex: Material.LightGreen
                name: "LightGreen"
            }
            ListElement {
                paletteIndex: Material.Lime
                name: "Lime"
            }
            ListElement {
                paletteIndex: Material.Yellow
                name: "Yellow"
            }
            ListElement {
                paletteIndex: Material.Amber
                name: "Amber"
            }
            ListElement {
                paletteIndex: Material.Orange
                name: "Orange"
            }
            ListElement {
                paletteIndex: Material.DeepOrange
                name: "DeepOrange"
            }
            ListElement {
                paletteIndex: Material.Grey
                name: "Grey"
            }
            ListElement {
                paletteIndex: Material.BlueGrey
                name: "BlueGrey"
            }
            ListElement {
                paletteIndex: Material.Brown
                name: "Brown"
            }
        }

        PaletteSwatch {
            paletteIndex: model.paletteIndex
            paletteName: model.name
            paletteColor: Material.color(model.paletteIndex, Material.Shade500)
        }
    }
}
