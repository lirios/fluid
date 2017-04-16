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
import QtQuick.Layouts 1.2
import Fluid.Controls 1.0

/*!
   \qmltype BaseListItem
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief A standard list item, with one or more lines of text and optional left and right items.
 */
BaseListItem {
    id: listItem

    implicitHeight: Math.max(subText != "" ? maximumLineCount == 2 ? 72 : 88
                                           : secondaryItem.showing ? secondaryItem.childrenRect.height + (label.visible ? Units.largeSpacing * 2 : Units.smallSpacing * 2) : 48,
                             leftItem.childrenRect.height + Units.smallSpacing * 2,
                             rightItem.childrenRect.height + Units.smallSpacing * 2)

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
        spacing: Units.smallSpacing * 2

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
                color: listItem.highlighted ? Material.primaryColor : enabled ? Material.iconColor : Material.iconDisabledColor
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true

            spacing: 0

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                visible: label.text != "" || valueLabel.text != ""
                spacing: Units.smallSpacing

                SubheadingLabel {
                    id: label
                    objectName: "textLabel"

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    // XXX: Hack to vertically center the label
                    Layout.topMargin: subLabel.visible ? 0 : ((listItem.height - height) / 2) - Units.smallSpacing

                    text: listItem.text
                    elide: Text.ElideRight
                    color: listItem.highlighted ? Material.primaryColor
                                                : Material.primaryTextColor
                    visible: text != ""
                }

                BodyLabel {
                    id: valueLabel
                    objectName: "valueLabel"

                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: visible ? implicitWidth : 0
                    Layout.preferredHeight: visible ? implicitHeight : 0

                    color: Material.secondaryTextColor
                    elide: Text.ElideRight

                    visible: text != ""
                }
            }

            BodyLabel {
                id: subLabel
                objectName: "subTextLabel"

                Layout.fillWidth: true
                Layout.preferredHeight: visible ? implicitHeight * maximumLineCount/lineCount : 0

                color: Material.secondaryTextColor
                elide: Text.ElideRight
                wrapMode: Text.WordWrap

                visible: text != "" && !contentItem.showing
                maximumLineCount: visible ? listItem.maximumLineCount - 1 : 0
            }

            Item {
                id: secondaryItem
                objectName: "secondaryItem"

                Layout.fillWidth: true
                Layout.preferredHeight: showing ? childrenRect.height + (label.visible ? Units.smallSpacing : Units.largeSpacing) : 0

                property bool showing: visibleChildren.length > 0
            }
        }

        Item {
            id: rightItem
            objectName: "rightItem"
            Layout.preferredWidth: showing ? childrenRect.width : 0
            Layout.preferredHeight: parent.height

            property bool showing: visibleChildren.length > 0
        }
    }
}
