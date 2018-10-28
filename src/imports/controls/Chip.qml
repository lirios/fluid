/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.1 as FluidControls
import Fluid.Effects 1.0 as FluidEffects

AbstractButton {
    id: control

    property bool expandable: false
    property alias model: listView.model
    property alias delegate: listView.delegate
    readonly property alias selectedItem: listView.currentItem
    property alias iconItem: iconItem.children
    property bool deletable: false

    signal deleted()

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight) + topPadding + bottomPadding

    font.pixelSize: expandable ? 14 : 13

    leftPadding: 12
    rightPadding: 12
    spacing: 8

    icon.width: 24
    icon.height: 24

    hoverEnabled: true

    Material.elevation: control.pressed ? 2 : 0
    Material.background: Material.color(Material.Grey, control.checked || control.hovered ? Material.Shade700 : Material.Shade300)

    onClicked: {
        if (control.expandable)
            popup.open();
    }

    background: Rectangle {
        implicitHeight: 32
        radius: 16
        color: control.Material.backgroundColor

        layer.enabled: control.Material.elevation > 0
        layer.effect: FluidEffects.Elevation {
            elevation: control.Material.elevation
        }
    }

    contentItem: RowLayout {
        spacing: control.spacing

        Material.theme: control.hovered ? Material.Dark : Material.Light

        FluidControls.Icon {
            id: actualIcon

            Layout.alignment: Qt.AlignVCenter

            name: control.icon.name
            source: control.icon.source
            size: control.icon.width
            color: bodyLabel.color

            visible: !iconItem.visible && (name || source.toString())
        }

        Item {
            id: iconItem

            Layout.alignment: Qt.AlignVCenter

            objectName: "iconItem"

            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height

            visible: visibleChildren.length > 0
        }

        Label {
            id: bodyLabel

            Layout.alignment: Qt.AlignVCenter

            text: control.text
            font: control.font
            color: FluidControls.Color.transparent(control.checked || control.hovered ? Material.primaryHighlightedTextColor : Material.primaryTextColor, 0.87)
        }

        FluidControls.Icon {
            id: deleteIcon

            Layout.alignment: Qt.AlignVCenter

            implicitWidth: control.icon.width
            implicitHeight: control.icon.height

            source: FluidControls.Utils.iconUrl("navigation/cancel")
            color: control.hovered ? Material.primaryHighlightedTextColor : Material.iconColor
            colorize: true

            opacity: control.hovered ? 1.0 : 0.54

            visible: control.deletable

            MouseArea {
                anchors.fill: parent
                enabled: control.deletable
                onClicked: control.deleted()
            }
        }
    }

    Popup {
        id: popup

        width: 400

        padding: 0

        Material.elevation: 8

        ScrollView {
            anchors.fill: parent

            clip: true

            ListView {
                id: listView
                currentIndex: 0
                delegate: FluidControls.ListItem {
                    readonly property string label: model.label
                    readonly property string value: model.value
                    readonly property url imageSource: model.imageSource

                    text: listView.currentIndex === index ? model.label : ""
                    subText: model.value
                    highlighted: ListView.isCurrentItem
                    leftItem: FluidControls.CircleImage {
                        anchors.centerIn: parent
                        source: model.imageSource
                        width: 40
                        height: width
                    }
                    rightItem: FluidControls.Icon {
                        anchors.centerIn: parent
                        source: FluidControls.Utils.iconUrl("navigation/cancel")
                        visible: listView.currentIndex === index

                        MouseArea {
                            anchors.fill: parent
                            onClicked: popup.close()
                        }
                    }
                    onClicked: {
                        listView.currentIndex = index;
                        popup.close();
                    }
                }
            }
        }
    }
}
