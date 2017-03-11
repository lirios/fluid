/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
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
import Fluid.Core 1.0

/*!
   \qmltype AppToolBar
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Application tool bar.
 */
ToolBar {
    id: toolbar

    Material.elevation: page ? page.appBar.elevation : 2
    Material.background: Material.primaryColor
    Material.theme: Utils.lightDark(Material.background, Material.Light, Material.Dark)

    property Page page
    property int maxActionCount: 3

    function pop(page) {
        stack.pop(page.appBar)

        toolbar.page = page
    }

    function push(page) {
        stack.push(page.appBar)

        page.appBar.toolbar = toolbar
        toolbar.page = page
    }

    function replace(page) {
        toolbar.page = page

        stack.replace(page.appBar)
    }

    StackView {
        id: stack

        anchors.fill: parent
    }
}
