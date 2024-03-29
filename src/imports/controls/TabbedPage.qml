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
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import Fluid.Controls as FluidControls

FluidControls.Page {
    id: page

    /*!
        \internal
    */
    default property alias contents: swipeView.contentData

    readonly property alias count: swipeView.count
    readonly property alias currentIndex: swipeView.currentIndex
    readonly property alias selectedTab: swipeView.currentItem
    readonly property alias tabBar: tabToolBar
    readonly property alias tabs: tabBar

    appBar.elevation: 0

    header: ToolBar {
        id: tabToolBar

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

            currentIndex: swipeView.currentIndex

            Material.accent: appBar.Material.foreground
            Material.background: "transparent"

            Repeater {
                model: swipeView.contentChildren.length
                delegate: TabButton {
                    id: tabButton

                    property var delegateData: swipeView.contentChildren[index]

                    icon.name: delegateData.icon.name
                    icon.source: delegateData.icon.source

                    text: delegateData.title

                    width: parent.fixed ? parent.width / parent.count : implicitWidth

                    // Active color
                    Material.accent: appBar.Material.foreground

                    // Unfocused color
                    Material.foreground: FluidControls.Color.transparent(appBar.Material.foreground, 0.7)

                    contentItem: RowLayout {
                        IconLabel {
                            id: tabIcon

                            spacing: tabButton.spacing
                            mirrored: tabButton.mirrored
                            display: tabButton.display

                            icon: tabButton.icon
                            text: tabButton.text
                            font: tabButton.font
                            color: tabButton.icon.color

                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        FluidControls.ToolButton {
                            id: tabCloseButton

                            icon.width: 16
                            icon.height: 16
                            icon.source: FluidControls.Utils.iconUrl("navigation/close")

                            focus: Qt.NoFocus
                            visible: delegateData.canRemove

                            onClicked: page.removeTab(index)

                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
    }

    /*!
        \qmlmethod void TabbedPage::addTab(Tab tab)

        Add a \a tab programmatically to the page.
     */
    function addTab(tab) {
        swipeView.addItem(tab);
        swipeView.setCurrentIndex(swipeView.count - 1);
    }

    /*!
        \qmlmethod void TabbedPage::removeTab(int index)

        Remove the tab with \a index programmatically.
    */
    function removeTab(index) {
        swipeView.removeItem(index);
        swipeView.decrementCurrentIndex();
    }

    /*!
        \qmlmethod Tab TabbedPage::getTab(int index)

        Return the tab with \a index.
    */
    function getTab(index) {
        return swipeView.itemAt(index);
    }

    /*!
        \qmlmethod void TabbedPage::setCurrentIndex(int index)

        Select the tab that correspond to \a index.
    */
    function setCurrentIndex(index) {
        swipeView.setCurrentIndex(index);
    }

    /*!
        \qmlmethod void TabbedPage::incrementCurrentIndex()

        Increment current index.

        \sa currentIndex
    */
    function incrementCurrentIndex() {
        swipeView.incrementCurrentIndex();
    }

    /*!
        \qmlmethod void TabbedPage::decrementCurrentIndex()

        Decrement current index.

        \sa currentIndex
    */
    function decrementCurrentIndex() {
        swipeView.decrementCurrentIndex();
    }
}
