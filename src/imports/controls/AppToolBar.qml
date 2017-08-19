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
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
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

    /*!
        \internal
     */
    property Page page

    /*!
        \qmlproperty int maxActionCount

        Maximum actions to be available on this tool bar.
     */
    property int maxActionCount: 3

    /*!
        \qmlmethod void AppToolBar::pop(Page page)

        Pop the \l AppBar that belongs to \a page from the stack.
     */
    function pop(page) {
        stack.pop(page.appBar, StackView.PopTransition);
        toolbar.page = page;
    }

    /*!
        \qmlmethod void AppToolBar::push(Page page)

        Push the \l AppBar that belongs to \a page to the stack.
     */
    function push(page) {
        stack.push(page.appBar, {}, StackView.PushTransition);
        page.appBar.toolbar = toolbar;
        toolbar.page = page;
    }

    /*!
        \qmlmethod void AppToolBar::replace(Page page)

        Replace current \l AppBar with the one that belongs to \a page.
     */
    function replace(page) {
        stack.replace(page.appBar, {}, StackView.ReplaceTransition);
        page.appBar.toolbar = toolbar;
        toolbar.page = page;
    }

    StackView {
        id: stack

        anchors.fill: parent

        popEnter: Transition {
            NumberAnimation { property: "y"; from: 0.5 *  -stack.height; to: 0; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutCubic }
        }
        popExit: Transition {
            NumberAnimation { property: "y"; from: 0; to: 0.5 * stack.height; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutCubic }
        }

        pushEnter: Transition {
            NumberAnimation { property: "y"; from: 0.5 * stack.height; to: 0; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutCubic }
        }
        pushExit: Transition {
            NumberAnimation { property: "y"; from: 0; to: 0.5 * -stack.height; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutCubic }
        }
    }
}
