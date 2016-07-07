/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.1
import Fluid.UI 1.0

/*!
   \qmltype BaseListItem
   \inqmlmodule Fluid.Controls 1.0

   \brief A standard list item, with one or more lines of text and optional left and right items.
 */
BaseListItem {
    id: listItem

    implicitHeight: subText != "" ? maximumLineCount == 2 ? 72 : 88
                                  : secondaryItem.showing ? 72 : 48

    dividerInset: leftItem.visible ? listItem.height : 0

    property int maximumLineCount: 2

    property alias subText: subLabel.text
    property alias valueText: valueLabel.text

    property alias iconName: icon.name
    property alias iconSource: icon.source

    property alias leftItem: leftItem.children
    property alias rightItem: rightItem.children
    property alias secondaryItem: secondaryItem.children

    contentItem: RowLayout {
        spacing: 16

        Item {
            id: leftItem
            objectName: "leftItem"

            Layout.preferredWidth: showing ? 40 : 0
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter

            property bool showing: visibleChildren.length > 0

            Icon {
                id: icon
                objectName: "icon"

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: icon.valid
                color: listItem.highlighted ? Material.primaryColor
                        : Material.theme == Material.Light ? FluidStyle.iconColorLight
                                                           : FluidStyle.iconColorDark
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true

            spacing: 3

            RowLayout {
                Layout.fillWidth: true

                spacing: 8

                Label {
                    id: label
                    objectName: "textLabel"

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    text: listItem.text
                    elide: Text.ElideRight
                    font: FluidStyle.subheadingFont
                    color: listItem.highlighted ? Material.primaryColor
                                                : Material.primaryTextColor
                }

                Label {
                    id: valueLabel
                    objectName: "valueLabel"

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: visible ? implicitWidth : 0

                    color: Material.secondaryTextColor
                    elide: Text.ElideRight
                    font: FluidStyle.body1Font

                    visible: text != ""
                }
            }

            Label {
                id: subLabel
                objectName: "subTextLabel"

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight * maximumLineCount/lineCount

                color: Material.secondaryTextColor
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                font: FluidStyle.body1Font

                visible: text != "" && !contentItem.showing
                maximumLineCount: listItem.maximumLineCount - 1
            }

            Item {
                id: secondaryItem
                objectName: "secondaryItem"

                Layout.fillWidth: true
                Layout.preferredHeight: showing ? subLabel.implicitHeight : 0

                property bool showing: visibleChildren.length > 0
            }
        }

        Item {
            id: rightItem
            objectName: "rightItem"

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: showing ? childrenRect.width : 0
            Layout.preferredHeight: parent.height

            property bool showing: visibleChildren.length > 0
        }
    }
}
