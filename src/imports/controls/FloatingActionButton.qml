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
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls
import Fluid.Effects 1.0 as FluidEffects


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

        color: !control.enabled ? control.Material.buttonDisabledColor
                                : control.checked || control.highlighted ? control.Material.highlightedButtonColor : control.Material.buttonColor
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
