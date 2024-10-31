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

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
    \brief Chips represent complex entities in small blocks, such as a contact.

    For more information you can read the
    <a href="https://material.io/guidelines/components/chips.html">Material Design guidelines</a>.
*/
AbstractButton {
    id: control

    /*!
        This property holds whether this chip can expand to show
        more information or options.

        \sa Fluid::Chip::model
        \sa Fluid::Chip::delegate
        \sa Fluid::Chip::selectedItem
    */
    property bool expandable: false

    /*!
        Expandable chips show a popup with a list view when clicked.

        This property holds the model providing data for said list view.

        The following roles are expected to be present:

        \list
        \li label - Description of the option
        \li value - Actual value of the option
        \li imageSource - URL with the image source for the option
        \endlist

        \sa Fluid::Chip::expandable
        \sa Fluid::Chip::delegate
        \sa Fluid::Chip::selectedItem
    */
    property alias model: listView.model

    /*!
        Expandable chips show a popup with a list view when clicked.

        The delegate provides a template defining each item instantiated
        by the list view.

        By default the delegate is a \ref ListItem.

        \sa Fluid::Chip::expandable
        \sa Fluid::Chip::model
        \sa Fluid::Chip::selectedItem
    */
    property alias delegate: listView.delegate

    /*!
        Expandable chips show a popup with a list view when clicked.

        This property holds the currently selected item.

        By default the delegate is a \ref ListItem and the
        selected item contains the following properties:

        \list
        \li string label - Description of the option
        \li string value - Actual value of the option
        \li url imageSource - URL with the image source for the option
        \endlist

        \sa Fluid::Chip::expandable
        \sa Fluid::Chip::model
        \sa Fluid::Chip::delegate
    */
    readonly property alias selectedItem: listView.currentItem

    property alias iconItem: iconItem.children

    /*!
        This property holds whether the chip can be deleted.
        The default value is \c false.
    */
    property bool deletable: false

    /*!
        Emitted when the user wants to delete the chip.
    */
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
        layer.effect: Fluid.Elevation {
            elevation: control.Material.elevation
        }
    }

    contentItem: RowLayout {
        spacing: control.spacing

        Material.theme: control.hovered ? Material.Dark : Material.Light

        Fluid.Icon {
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
            color: Fluid.Color.transparent(control.checked || control.hovered ? Material.primaryHighlightedTextColor : Material.primaryTextColor, 0.87)
        }

        Fluid.Icon {
            id: deleteIcon

            Layout.alignment: Qt.AlignVCenter

            implicitWidth: control.icon.width
            implicitHeight: control.icon.height

            source: Fluid.Utils.iconUrl("navigation/cancel")
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
                delegate: Fluid.ListItem {
                    readonly property string label: model.label
                    readonly property string value: model.value
                    readonly property url imageSource: model.imageSource

                    text: listView.currentIndex === index ? model.label : ""
                    subText: model.value
                    highlighted: ListView.isCurrentItem
                    leftItem: Fluid.CircleImage {
                        anchors.centerIn: parent
                        source: model.imageSource
                        width: 40
                        height: width
                    }
                    rightItem: Fluid.Icon {
                        anchors.centerIn: parent
                        source: Fluid.Utils.iconUrl("navigation/cancel")
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
