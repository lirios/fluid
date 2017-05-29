/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

FluidControls.Page {
    id: page

    default property alias contents: swipeView.contentChildren

    property alias count: swipeView.count

    readonly property int currentIndex: __private.currentTabIndex

    /*!
       The currently selected tab.
     */
    readonly property Tab selectedTab: count > 0
                                       ? swipeView.contentChildren[currentIndex] : null

    onCurrentIndexChanged: swipeView.currentIndex = currentIndex

    QtObject {
        id: __private

        property alias currentTabIndex: tabBar.currentIndex
    }

    appBar.elevation: 0

    header: ToolBar {
        visible: tabBar.count > 0

        Material.elevation: 2

        TabBar {
            id: tabBar

            property bool fixed: true
            property bool centered: false

            anchors {
                top: centered ? undefined : parent.top
                left: centered ? undefined : parent.left
                right: centered ? undefined : parent.right
                leftMargin: centered ? 0 : appBar ? appBar.leftKeyline - 12 : 0
                horizontalCenter: centered ? parent.horizontalCenter : undefined
            }

            Material.accent: appBar.Material.foreground
            Material.background: "transparent"

            Repeater {
                model: swipeView.contentChildren
                delegate: TabButton {
                    text: modelData.title
                    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                                                         contentItem.implicitWidth +
                                                         (tabIcon.visible ? tabIcon.width : 0) +
                                                         (tabCloseButton.visible ? tabCloseButton.width : 0) +
                                                         leftPadding + rightPadding)
                    width: parent.fixed ? parent.width / parent.count : implicitWidth

                    // Active color
                    Material.accent: appBar.Material.foreground

                    // Unfocused color
                    Material.foreground: FluidCore.Utils.alpha(appBar.Material.foreground, 0.7)

                    FluidControls.Icon {
                        id: tabIcon

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        name: modelData.iconName
                        source: modelData.iconSource
                        visible: status == Image.Ready
                        color: contentItem.color
                    }

                    FluidControls.IconButton {
                        id: tabCloseButton

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: -rightPadding

                        iconName: "navigation/close"
                        iconColor: contentItem.color
                        visible: modelData.canRemove

                        onClicked: swipeView.removeItem(index)
                    }
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: __private.currentTabIndex

        onCurrentIndexChanged: __private.currentTabIndex = currentIndex
    }

    function addTab(tab) {
        swipeView.addItem(tab);
        __private.currentTabIndex = swipeView.count - 1;
    }
}
