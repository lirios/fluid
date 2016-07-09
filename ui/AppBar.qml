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
import QtQuick.Layouts 1.0
import Fluid.Core 1.0
import Fluid.UI 1.0

ToolBar {
    id: appBar

    Material.elevation: toolbar ? 0 : elevation
    Material.theme: toolbar ? toolbar.Material.theme : Material.Light

    /*!
       The back action to display to the left of the title in the action bar.
       When used with a page, this will pick up the page's back action, which
       by default is a back arrow when there is a page behind the current page
       on the page stack. However, you can customize this, for example, to show
       a navigation drawer at the root of your app.

       When using an action bar in a page, set the \l Page::backAction instead of
       directly setting this property.
     */
    property Action leftAction

    /*!
       A list of actions to show in the action bar. These actions will be shown
       anchored to the right, and will overflow if there are more than the
       maximum number of actions as defined in \l maxActionCount.

       When used with a page, the actions will be set to the page's \l Page::actions
       property, so set that instead of changing this directly.
     */
    property list<Action> actions

    /*!
       The elevation of the action bar. Set to 0 if you want have a header or some
       other view below the action bar that you want to appear as part of the action bar.
     */
    property int elevation: 2

    /*!
       \internal
       The size of the left icon and the action icons.
     */
    property int iconSize: Device.gridUnit <= 48 ? 20 : 24

    property alias leftKeyline: titleLabel.x

    /*!
       The maximum number of actions that can be displayed before they spill over
       into a drop-down menu. When using an action bar with a page, this inherits
       from the global \l Toolbar::maxActionCount. If you are using an action bar
       for custom purposes outside of a toolbar, this defaults to \c 3.
     */
    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    /*!
       The title displayed in the action bar. When used in a page, the title will
       be set to the title of the page, so set the \l Page::title property instead
       of changing this directly.
     */
    property alias title: titleLabel.text

    property AppToolBar toolbar

    height: Device.gridUnit

    IconButton {
        id: leftButton

        property bool showing: leftAction && leftAction.visible
        property int margin: (width - 24)/2

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftButton.showing ? 16 - leftButton.margin : -leftButton.width
        }

        iconSize: appBar.iconSize

        iconSource: leftAction ? leftAction.iconSource : ""
        visible: leftAction && leftAction.visible
        enabled: leftAction && leftAction.enabled
        onClicked: {
            if (leftAction)
                leftAction.triggered(leftButton)
        }
    }

    Label {
        id: titleLabel

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            right: actionsRow.left
            leftMargin: 16 + (leftButton.showing ? Device.gridUnit - leftButton.margin : 0)
            rightMargin: 16
        }

        textFormat: Text.PlainText
        font: FluidStyle.titleFont
        color: Material.primaryTextColor
        elide: Text.ElideRight
    }

    Row {
        id: actionsRow

        anchors {
            right: parent.right
            rightMargin: 16 - leftButton.margin
        }

        height: appBar.height

        spacing: 24 - 2 * leftButton.margin

        Repeater {
            model: appBar.actions
            delegate: IconButton {
                id: actionButton

                iconSize: appBar.iconSize

                iconSource: modelData.iconSource
                visible: modelData.visible
                enabled: modelData.enabled
                onClicked: modelData.triggered(actionButton)
            }
        }
    }
}
