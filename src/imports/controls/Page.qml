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

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid.Controls as FluidControls

Page {
    id: page

    default property alias data: content.data

    property alias appBar: appBar

    property alias actions: appBar.actions

    property alias leftAction: appBar.leftAction

    property bool canGoBack: false

    property alias customContent: appBar.customContent

    property Item rightSidebar: null

    signal goBack(var event)

    onRightSidebarChanged: {
        if (rightSidebar)
            rightSidebar.edge = Qt.RightEdge;
    }

    function pop(event, force) {
        if (StackView.view.currentItem !== page)
            return false;

        if (!event)
            event = {accepted: false};

        if (!force)
            goBack(event);

        if (event.accepted) {
            return true;
        } else {
            return StackView.view.pop();
        }
    }

    function forcePop() {
        pop(null, true);
    }

    function push(component, properties) {
        return StackView.view.push(component, properties);
    }

    Keys.onReleased: function (event) {
        // Catches the Android back button event and pops the page, if it isn't the top page
        if (event.key === Qt.Key_Back && StackView.view && StackView.view.depth > 1) {
            pop(event, false);
            event.accepted = true;
        }

        // Toggle overflow menu when the menu button is released
        if (event.key === Qt.Key_Menu) {
            appBar.toggleOverflowMenu();
            event.accepted = true;
        }
    }

    header: null
    footer: null

    contentWidth: content.childrenRect.width
    contentHeight: content.childrenRect.height

    FluidControls.AppBar {
        id: appBar

        Material.elevation: 0

        title: page.title

        leftAction: FluidControls.Action {
            icon.source: FluidControls.Utils.iconUrl("navigation/arrow_back")

            text: qsTr("Back")
            toolTip: qsTr("Go back")
            shortcut: StandardKey.Back
            visible: page.canGoBack

            onTriggered: page.pop()
        }
    }

    Item {
        id: content

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: rightSidebarContent.left
        anchors.bottom: parent.bottom
    }

    Item {
        id: rightSidebarContent

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        children: [rightSidebar]

        width: rightSidebar
               ? rightSidebar.width + rightSidebar.anchors.rightMargin
               : 0
    }
}
