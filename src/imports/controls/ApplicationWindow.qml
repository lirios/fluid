/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
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
import Fluid.Controls 1.0 as FluidControls
import Fluid.Controls.Private 1.0 as FluidControlsPrivate

ApplicationWindow {
    id: window

    property alias decorationColor: windowDecoration.color

    property alias decorationTheme: windowDecoration.theme

    property alias appBar: appBar

    property alias initialPage: pageStack.initialItem

    property alias pageStack: pageStack

    header: FluidControls.AppToolBar {
        id: appBar
    }

    FluidControls.PageStack {
        id: pageStack

        anchors.fill: parent

        onPushed: appBar.push(page)
        onPopped: appBar.pop(page)
        onReplaced: appBar.replace(page)
    }

    FluidControlsPrivate.WindowDecoration {
        id: windowDecoration
        window: window
        color: Material.shade(window.Material.primaryColor, Material.Shade700)
    }
}
