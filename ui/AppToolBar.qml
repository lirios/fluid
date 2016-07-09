/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Core 1.0

ToolBar {
    id: toolbar

    Material.elevation: page ? page.appBar.elevation : 2
    Material.background: Material.primaryColor
    Material.theme: Utils.lightDark(Material.background, Material.Light, Material.Dark)

    property Page page
    property int maxActionCount: 3

    height: page ? page.appBar.height : 0

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

        width: parent.width
        height: parent.height
    }
}
