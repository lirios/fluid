/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.Page {
    id: page

    default property alias contents: swipeView.contentChildren

    property alias count: swipeView.count

    readonly property int currentIndex: appBar.currentTabIndex

    /*!
       The currently selected tab.
     */
    readonly property Tab selectedTab: count > 0
            ? swipeView.contentChildren[currentIndex] : null

    onCurrentIndexChanged: swipeView.currentIndex = currentIndex

    appBar.tabs: Repeater {
        model: swipeView.contentChildren
        delegate: TabButton {
            text: modelData.title

            FluidControls.Icon {
                id: tabIcon

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: FluidControls.Units.smallSpacing

                name: modelData.iconName
                source: modelData.iconSource
                visible: status == Image.Ready
            }

            FluidControls.IconButton {
                id: tabCloseButton

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: FluidControls.Units.smallSpacing

                iconName: "navigation/close"
                visible: modelData.canRemove

                onClicked: swipeView.removeItem(swipeView.currentIndex)
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: appBar.currentTabIndex

        onCurrentIndexChanged: appBar.currentTabIndex = currentIndex
    }

    function addTab(tab) {
        // TODO: Instantiate tab if it's a component
        appBar.currentTabIndex = swipeView.count - 1
    }
}
