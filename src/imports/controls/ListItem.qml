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

import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.impl 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

ItemDelegate {
    id: listItem

    property int dividerInset: leftItem.showing ? listItem.height : 0
    property alias showDivider: divider.visible
    property int maximumLineCount: 2
    property alias subText: subLabel.text
    property alias valueText: valueLabel.text
    property alias leftItem: leftItem.children
    property alias rightItem: rightItem.children
    property alias secondaryItem: secondaryItem.children

    /*!
        \internal
    */
    readonly property bool __isIconEmpty: listItem.icon.name === "" && listItem.icon.source.toString() === ""

    icon.width: 24
    icon.height: 24
    icon.color: listItem.highlighted ? listItem.Material.primaryColor : enabled ? listItem.Material.iconColor : listItem.Material.iconDisabledColor

    leftPadding: FluidControls.Units.smallSpacing * 2
    rightPadding: FluidControls.Units.smallSpacing * 2
    topPadding: 0
    bottomPadding: 0

    width: parent ? parent.width : undefined

    implicitHeight: Math.max(48, Math.max(background ? background.implicitHeight : 0,
                                                       Math.max(contentItem.implicitHeight,
                                                                indicator ? indicator.implicitHeight : 0))) + topPadding + bottomPadding

    hoverEnabled: FluidCore.Device.hoverEnabled

    opacity: enabled ? 1.0 : 0.6

    Layout.fillWidth: true

    FluidControls.ThinDivider {
        id: divider

        x: dividerInset
        y: parent.height - height

        width: parent.width - x

        visible: false
    }

    contentItem: RowLayout {
        spacing: FluidControls.Units.smallSpacing * 2

        Item {
            id: leftItem

            readonly property bool showing: visibleChildren.length > 0

            objectName: "leftItem"

            Layout.preferredWidth: showing ? childrenRect.width : 0
            Layout.preferredHeight: showing ? childrenRect.height : 0
            Layout.alignment: Qt.AlignCenter

            IconLabel {
                objectName: "icon"

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                spacing: 16
                mirrored: listItem.mirrored
                display: IconLabel.IconOnly

                icon: listItem.icon
                color: listItem.enabled ? listItem.Material.foreground : listItem.Material.hintTextColor
                visible: !listItem.__isIconEmpty
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
                spacing: FluidControls.Units.smallSpacing

                FluidControls.SubheadingLabel {
                    id: label
                    objectName: "textLabel"

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    // XXX: Hack to vertically center the label
                    Layout.topMargin: subLabel.visible ? 0 : ((listItem.height - height) / 2) - FluidControls.Units.smallSpacing

                    text: listItem.text
                    elide: Text.ElideRight
                    color: listItem.highlighted ? Material.primaryColor
                                                : Material.primaryTextColor
                    visible: text != ""
                }

                FluidControls.BodyLabel {
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

            FluidControls.BodyLabel {
                id: subLabel
                objectName: "subTextLabel"

                Layout.fillWidth: true

                color: Material.secondaryTextColor
                elide: Text.ElideRight
                wrapMode: Text.WordWrap

                visible: text != "" && !contentItem.showing
                maximumLineCount: visible ? listItem.maximumLineCount : 0
            }

            Item {
                id: secondaryItem

                readonly property bool showing: visibleChildren.length > 0

                objectName: "secondaryItem"

                Layout.fillWidth: true
                Layout.preferredHeight: showing ? childrenRect.height + (FluidControls.Units.smallSpacing * 2) : 0
            }
        }

        Item {
            id: rightItem

            readonly property bool showing: visibleChildren.length > 0

            objectName: "rightItem"

            Layout.preferredWidth: showing ? childrenRect.width : 0
            Layout.preferredHeight: showing ? childrenRect.height + (FluidControls.Units.smallSpacing * 2) : 0
        }
    }
}
