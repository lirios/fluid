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

import QtQml 2.2
import QtQuick 2.10
import QtQuick.Controls 2.3 as QQC2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.1 as FluidControls

QQC2.ToolBar {
    id: appBar

    Material.elevation: toolbar ? 0 : elevation
    Material.background: toolbar ? toolbar.Material.background : backgroundColor
    Material.theme: FluidControls.Color.isDarkColor(Material.background) ? Material.Dark : Material.Light

    property FluidControls.Action leftAction

    property list<FluidControls.Action> actions

    property int elevation: 2

    property int __iconSize: FluidCore.Device.gridUnit <= 48 ? 20 : 24

    property color backgroundColor: appBar.Material.primaryColor

    readonly property alias overflowMenuVisible: overflowMenu.visible

    property color decorationColor: Material.shade(backgroundColor, Material.Shade700)

    property alias leftKeyline: titleLabel.x

    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    property alias title: titleLabel.text

    property alias customContent: customContentItem.data
    property alias extendedContent: extendedContentItem.data

    readonly property alias extendedContentHeight: extendedContentItem.height

    property FluidControls.AppToolBar toolbar

    implicitHeight: FluidCore.Device.gridUnit

    Behavior on backgroundColor {
        ColorAnimation { duration: FluidControls.Units.mediumDuration }
    }

    Behavior on decorationColor {
        ColorAnimation { duration: FluidControls.Units.mediumDuration }
    }

    FluidControls.ToolButton {
        id: leftButton

        property bool showing: leftAction && leftAction.visible
        property int margin: (width - 24)/2

        QQC2.ToolTip.visible: QQC2.ToolTip.text != "" && (FluidCore.Device.isMobile ? pressed : hovered)
        QQC2.ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
        QQC2.ToolTip.text: leftAction ? leftAction.toolTip : ""

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftButton.showing ? 16 - leftButton.margin : -leftButton.width
        }

        icon.width: appBar.__iconSize
        icon.height: appBar.__iconSize
        icon.name: leftAction ? leftAction.icon.name : ""
        icon.source: leftAction ? leftAction.icon.source : ""

        Binding {
            target: leftButton
            property: "icon.color"
            value: leftAction.icon.color
            when: leftAction && leftAction.icon.color.a > 0
        }

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
            leftMargin: 16 + (leftButton.showing ? FluidCore.Device.gridUnit - leftButton.margin : 0)
            rightMargin: 16
        }

        textFormat: Text.PlainText
        color: Material.primaryTextColor
        elide: Text.ElideRight
        visible: text !== "" && customContentItem.children.length === 0
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
            delegate: FluidControls.ToolButton {
                id: actionButton

                QQC2.ToolTip.visible: QQC2.ToolTip.text !== "" && !overflowMenu.visible && (FluidCore.Device.isMobile ? pressed : hovered)
                QQC2.ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
                QQC2.ToolTip.text: appBar.actions[index].toolTip

                anchors.verticalCenter: parent.verticalCenter

                icon.width: appBar.__iconSize
                icon.height: appBar.__iconSize
                icon.name: appBar.actions[index].icon.name
                icon.source: appBar.actions[index].icon.source

                Binding {
                    target: actionButton
                    property: "icon.color"
                    value: appBar.actions[index].icon.color
                    when: appBar.actions[index].icon.color.a > 0
                }

                visible: appBar.actions[index].visible
                enabled: appBar.actions[index].enabled
                hoverAnimation: appBar.actions[index].hoverAnimation
                focusPolicy: Qt.TabFocus

                onClicked: appBar.actions[index].triggered(actionButton)
            }
        }

        FluidControls.ToolButton {
            id: overflowButton

            anchors.verticalCenter: parent.verticalCenter

            icon.width: appBar.__iconSize
            icon.height: appBar.__iconSize
            icon.source: FluidControls.Utils.iconUrl("navigation/more_vert")

            onClicked: overflowMenu.open()

            visible: appBar.actions.length > appBar.maxActionCount && appBar.maxActionCount > 0
            focusPolicy: Qt.TabFocus

            QQC2.Menu {
                id: overflowMenu

                x: -width + overflowButton.width - overflowButton.rightPadding
                y: overflowButton.topPadding
                transformOrigin: QQC2.Menu.TopRight

                Instantiator {
                    model: appBar.actions.length > appBar.maxActionCount && appBar.maxActionCount > 0
                           ? appBar.actions.length - appBar.maxActionCount : 0
                    delegate: QQC2.MenuItem {
                        id: overflowMenuItem

                        icon.width: appBar.__iconSize
                        icon.height: appBar.__iconSize
                        icon.name: appBar.actions[index + appBar.maxActionCount].icon.name
                        icon.source: appBar.actions[index + appBar.maxActionCount].icon.source

                        Binding {
                            target: overflowMenuItem
                            property: "icon.color"
                            value: appBar.actions[index + appBar.maxActionCount].icon.color
                            when: appBar.actions[index + appBar.maxActionCount].icon.color.a > 0
                        }

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

    Item {
        id: customContentItem

        anchors.left: parent.left
        anchors.right: actionsRow.left
        anchors.leftMargin: 16 + (leftButton.showing ? FluidCore.Device.gridUnit - leftButton.margin : 0)
        anchors.rightMargin: 16
        anchors.verticalCenter: actionsRow.verticalCenter

        height: parent.height

        visible: children.length > 0
    }

    Item {
        id: extendedContentItem

        anchors.left: titleLabel.left
        anchors.top: actionsRow.bottom
        anchors.right: actionsRow.right
        anchors.rightMargin: 16

        height: childrenRect.height

        visible: children.length > 0
    }

    function toggleOverflowMenu() {
        if (!overflowButton.visible)
            return;

        if (overflowMenu.visible)
            overflowMenu.close();
        else
            overflowMenu.open();
    }
}
