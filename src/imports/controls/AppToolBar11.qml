/*
 * This file is part of Fluid.
 *
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
import Fluid.Controls 1.1 as FluidControls

ToolBar {
    id: toolbar

    Material.elevation: page ? page.appBar.elevation : 2
    Material.background: page ? page.appBar.backgroundColor : toolbar.Material.primaryColor
    Material.theme: FluidControls.Color.isDarkColor(page ? page.appBar.backgroundColor : toolbar.Material.background) ? Material.Dark : Material.Light

    property Page page

    property int maxActionCount: 3

    property real appBarHeight: {
        if (!page || !page.appBar || !page.appBar.visible)
            return 0;

        var height = implicitHeight + page.appBar.extendedContentHeight;

        if (page.rightSidebar && page.rightSidebar.showing) {
            var sidebarHeight = implicitHeight + page.rightSidebar.appBar.extendedContentHeight;
            height = Math.max(height, sidebarHeight);
        }

        return height;
    }

    height: appBarHeight

    Behavior on height {
        NumberAnimation { duration: FluidControls.Units.mediumDuration }
    }

    function pop(page) {
        stack.pop(page.appBar, StackView.PopTransition);

        if (page.rightSidebar && page.rightSidebar.appBar)
            rightSidebarStack.pop(page.rightSidebar.appBar);
        else
            rightSidebarStack.pop(emptyRightSidebar);

        toolbar.page = page;
    }

    function push(page) {
        stack.push(page.appBar, {}, StackView.PushTransition);

        page.appBar.toolbar = toolbar;
        toolbar.page = page;

        if (page.rightSidebar && page.rightSidebar.appBar)
            rightSidebarStack.replace(page.rightSidebar.appBar);
        else
            rightSidebarStack.replace(emptyRightSidebar);
    }

    function replace(page) {
        stack.replace(page.appBar, {}, StackView.ReplaceTransition);

        page.appBar.toolbar = toolbar;
        toolbar.page = page;

        if (page.rightSidebar && page.rightSidebar.appBar)
            rightSidebarStack.replace(page.rightSidebar.appBar);
        else
            rightSidebarStack.replace(emptyRightSidebar);
    }

    StackView {
        id: stack

        anchors.left: parent.left
        anchors.right: page && page.rightSidebar ? rightSidebarStack.left : parent.right
        anchors.rightMargin: 0

        height: appBarHeight

        Behavior on height {
            NumberAnimation { duration: FluidControls.Units.mediumDuration }
        }

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

    StackView {
        id: rightSidebarStack

        anchors.right: parent.right
        anchors.rightMargin: page && page.rightSidebar ? page.rightSidebar.anchors.rightMargin : 0

        width: page && page.rightSidebar ? page.rightSidebar.width : 0
        height: appBarHeight

        Behavior on height {
            NumberAnimation { duration: FluidControls.Units.mediumDuration }
        }

        popEnter: Transition {
            NumberAnimation { property: "y"; from: 0.5 *  -rightSidebarStack.height; to: 0; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutCubic }
        }
        popExit: Transition {
            NumberAnimation { property: "y"; from: 0; to: 0.5 * rightSidebarStack.height; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutCubic }
        }

        pushEnter: Transition {
            NumberAnimation { property: "y"; from: 0.5 * rightSidebarStack.height; to: 0; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutCubic }
        }
        pushExit: Transition {
            NumberAnimation { property: "y"; from: 0; to: 0.5 * -rightSidebarStack.height; duration: 250; easing.type: Easing.OutCubic }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutCubic }
        }
    }

    Component {
        id: emptyRightSidebar

        Item {}
    }
}
