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
import QtQuick.Controls as QQC2
import QtQuick.Controls.impl as QQCImpl2
import QtQuick.Controls.Material
import QtQuick.Templates as T
import Fluid.Controls
import Fluid.Layouts as FluidLayouts


BottomSheet {
    id: bottomSheet

    property string title
    property list<Action> actions
    property alias columns: grid.columns
    property alias rows: grid.rows

    height: Math.min(implicitHeight, maxHeight)
    implicitHeight: listViewContainer.implicitHeight + (header.visible ? header.height : 0)

    Column {
        id: column

        anchors.fill: parent

        Subheader {
            id: header
            text: title
            visible: title !== ""
            height: 56
        }

        Item {
            id: listViewContainer

            width: parent.width
            height: title !== "" ? parent.height - header.height : parent.height

            implicitHeight: listView.contentHeight + listView.topMargin + listView.bottomMargin

            Flickable {
                id: listView

                clip: true

                width: parent.width
                height: parent.height

                interactive: bottomSheet.height < bottomSheet.implicitHeight

                topMargin: title !== "" ? 0 : 16
                bottomMargin: 24
                leftMargin: 16
                rightMargin: 16

                contentWidth: width
                contentHeight: grid.height

                QQC2.ScrollIndicator.vertical: QQC2.ScrollIndicator {}

                Grid {
                    id: grid

                    property int cellWidth: 96
                    property int cellHeight: 96

                    width: parent.width

                    spacing: 16

                    columns: Math.floor(width - listView.leftMargin - listView.rightMargin) / (cellWidth + spacing * 2)
                    rows: Math.ceil(actions.length / columns)

                    Repeater {
                        model: actions

                        delegate: QQC2.ItemDelegate {
                            id: item

                            icon.width: modelData.icon.width || 48
                            icon.height: modelData.icon.height || 48
                            icon.name: modelData.icon.name
                            icon.source: modelData.icon.source

                            Binding {
                                target: item
                                property: "icon.color"
                                value: item.enabled ? item.Material.iconColor : item.Material.iconDisabledColor
                                when: modelData.icon.color.a === 0
                            }

                            enabled: modelData.enabled
                            visible: modelData.visible

                            onClicked: {
                                bottomSheet.close();
                                modelData.triggered(item);
                            }

                            background.implicitWidth: grid.cellWidth
                            background.implicitHeight: grid.cellHeight

                            contentItem: QQCImpl2.IconLabel {
                                width: grid.cellWidth
                                height: grid.cellHeight

                                spacing: item.spacing
                                mirrored: item.mirrored
                                display: QQCImpl2.IconLabel.TextUnderIcon

                                icon: item.icon
                                text: modelData.text
                                font: item.font
                                color: item.enabled ? item.Material.foreground : item.Material.hintTextColor
                            }
                        }
                    }
                }
            }
        }
    }
}
