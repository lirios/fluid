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
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import Fluid.Core as FluidCore
import Fluid.Controls as FluidControls
import Fluid.Effects as FluidEffects

RoundButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight) + topPadding + bottomPadding

    leftPadding: 6
    rightPadding: 6
    topPadding: 6
    bottomPadding: 6

    property bool mini: Screen.width < 460

    Material.elevation: 1

    background: Rectangle {
        implicitWidth: control.mini ? 40 : 56
        implicitHeight: implicitWidth

        anchors.centerIn: parent

        color: control.Material.buttonColor(control.Material.theme, control.Material.background,
                    control.Material.accent, control.enabled, control.flat, control.highlighted, false /*checked*/)
        radius: control.radius

        RectangularGlow {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: control.Material.elevation === 1 ? 1.5 : 1

            width: parent.width
            height: parent.height

            z: -1

            visible: control.enabled && control.Material.buttonColor.a > 0

            glowRadius: control.Material.elevation === 1 ? 0.75 : 0.3
            opacity: control.Material.elevation === 1 ? 0.6 : 0.3
            spread: control.Material.elevation === 1 ? 0.7 : 0.85
            color: "black"
            cornerRadius: height/2
        }

        FluidControls.Ripple {
            anchors.fill: parent
            control: control
            circular: true
        }
    }
}
