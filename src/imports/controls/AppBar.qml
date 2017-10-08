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

import QtQml 2.2
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Fluid.Core 1.0
import Fluid.Controls 1.0 as FluidControls

/*!
   \qmltype AppBar
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Application tool bar.

    For more information you can read the
    \l{https://material.io/guidelines/layout/structure.html#structure-app-bar}{Material Design guidelines}.
 */
ToolBar {
    id: appBar

    Material.elevation: toolbar ? 0 : elevation
    Material.theme: toolbar ? toolbar.Material.theme : Material.Light

    /*!
        \qmlproperty Action leftAction

        The back action to display to the left of the title in the action bar.
        When used with a page, this will pick up the page's back action, which
        by default is a back arrow when there is a page behind the current page
        on the page stack. However, you can customize this, for example, to show
        a navigation drawer at the root of your app.

        When using an action bar in a page, set the \l Page::leftAction instead of
        directly setting this property.
    */
    property Action leftAction

    /*!
        \qmlproperty list<Action> actions

        A list of actions to show in the action bar. These actions will be shown
        anchored to the right, and will overflow if there are more than the
        maximum number of actions as defined in \l maxActionCount.

        When used with a page, the actions will be set to the page's \l Page::actions
        property, so set that instead of changing this directly.
    */
    property list<Action> actions

    /*!
        \qmlproperty int elevation

        The elevation of the action bar. Set to 0 if you want have a header or some
        other view below the action bar that you want to appear as part of the action bar.
    */
    property int elevation: 2

    /*!
       \internal
       The size of the left icon and the action icons.
    */
    property int iconSize: Device.gridUnit <= 48 ? 20 : 24

    /*!
        \qmlproperty real leftKeyline

        Keyline to align contents to the left to be visually appealing.
    */
    property alias leftKeyline: titleLabel.x

    /*!
        \qmlproperty int maxActionCount

        The maximum number of actions that can be displayed before they spill over
        into a drop-down menu. When using an action bar with a page, this inherits
        from the global \l AppToolBar::maxActionCount. If you are using an action bar
        for custom purposes outside of a toolbar, this defaults to \c 3.

        Set to \c 0 if you don't want to overflow actions.
    */
    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    /*!
        \qmlproperty string title

        The title displayed in the action bar. When used in a page, the title will
        be set to the title of the page, so set the \l Page::title property instead
        of changing this directly.
    */
    property alias title: titleLabel.text

    /*!
        \qmlproperty AppToolBar toolbar

        Tool bar.
    */
    property AppToolBar toolbar

    implicitHeight: Device.gridUnit

    IconButton {
        id: leftButton

        property bool showing: leftAction && leftAction.visible
        property int margin: (width - 24)/2

        ToolTip.visible: ToolTip.text != "" && (Device.isMobile ? pressed : hovered)
        ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
        ToolTip.text: leftAction ? leftAction.toolTip : ""

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftButton.showing ? 16 - leftButton.margin : -leftButton.width
        }

        iconSize: appBar.iconSize

        iconSource: leftAction ? leftAction.iconSource : ""
        visible: leftAction && leftAction.visible
        enabled: leftAction && leftAction.enabled
        hoverAnimation: leftAction && leftAction.hoverAnimation
        focusPolicy: Qt.TabFocus
        onClicked: {
            if (leftAction)
                leftAction.triggered(leftButton)
        }
    }

    FluidControls.TitleLabel {
        id: titleLabel

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            right: actionsRow.left
            leftMargin: 16 + (leftButton.showing ? Device.gridUnit - leftButton.margin : 0)
            rightMargin: 16
        }

        textFormat: Text.PlainText
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
            model: appBar.actions.length > appBar.maxActionCount && appBar.maxActionCount > 0
                   ? appBar.maxActionCount : appBar.actions.length
            delegate: FluidControls.IconButton {
                id: actionButton

                ToolTip.visible: ToolTip.text !== "" && !overflowMenu.visible && (Device.isMobile ? pressed : hovered)
                ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
                ToolTip.text: appBar.actions[index].toolTip

                anchors.verticalCenter: parent.verticalCenter

                iconSize: appBar.iconSize
                iconSource: appBar.actions[index].iconSource

                visible: appBar.actions[index].visible
                enabled: appBar.actions[index].enabled
                hoverAnimation: appBar.actions[index].hoverAnimation
                focusPolicy: Qt.TabFocus

                onClicked: appBar.actions[index].triggered(actionButton)
            }
        }

        FluidControls.IconButton {
            id: overflowButton

            anchors.verticalCenter: parent.verticalCenter

            iconSize: appBar.iconSize
            iconName: "navigation/more_vert"

            onClicked: overflowMenu.open()

            visible: appBar.actions.length > appBar.maxActionCount && appBar.maxActionCount > 0
            focusPolicy: Qt.TabFocus

            Menu {
                id: overflowMenu

                y: parent.topPadding
                transformOrigin: Menu.TopRight

                Instantiator {
                    model: appBar.actions.length > appBar.maxActionCount && appBar.maxActionCount > 0
                           ? appBar.actions.length - appBar.maxActionCount : 0
                    delegate: FluidControls.MenuItem {
                        id: overflowMenuItem

                        iconSource: appBar.actions[index + appBar.maxActionCount].iconSource
                        iconSize: appBar.iconSize

                        text: appBar.actions[index + appBar.maxActionCount].text

                        enabled: appBar.actions[index + appBar.maxActionCount].enabled
                        visible: appBar.actions[index + appBar.maxActionCount].visible

                        onTriggered: appBar.actions[index + appBar.maxActionCount].triggered(overflowMenuItem)
                    }
                    onObjectAdded: overflowMenu.addItem(object)
                    onObjectRemoved: overflowMenu.removeItem(index)
                }
            }
        }
    }
}
