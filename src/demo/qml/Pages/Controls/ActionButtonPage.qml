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
import "../.." as Components

Components.StyledPageTwoColumns {
    leftColumn: Column {
        anchors.centerIn: parent

        FluidControls.TitleLabel {
            text: qsTr("Enabled")
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("device/airplanemode_active")
            mini: false
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("navigation/check")
            highlighted: true
            mini: false
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("device/airplanemode_active")
            mini: true
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("navigation/check")
            highlighted: true
            mini: true
        }
    }

    rightColumn: Column {
        anchors.centerIn: parent

        FluidControls.TitleLabel {
            text: qsTr("Disabled")
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("device/airplanemode_active")
            mini: false
            enabled: false
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("navigation/check")
            highlighted: true
            mini: false
            enabled: false
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("device/airplanemode_active")
            mini: true
            enabled: false
        }

        FluidControls.FloatingActionButton {
            icon.source: FluidControls.Utils.iconUrl("navigation/check")
            highlighted: true
            mini: true
            enabled: false
        }
    }
}
