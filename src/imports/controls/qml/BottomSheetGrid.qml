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
import Fluid as Fluid

/*!
    \brief A sheet of paper with actions and an optional title that slides up from the bottom.

    A sheet of paper that displays actions in a grid and an optional title that slides up
    from the bottom edge of the screen and presents a set of clear and simple actions.

    \code{.qml}
    import QtQuick
    import QtQuick.Controls
    import Fluid as Fluid

    Item {
        Fluid.Button {
            anchors.centerIn: parent
            text: qsTr("Press Me")
            onClicked: gridBottomSheet.open()
        }

        Fluid.BottomSheetGrid {
            id: gridBottomSheet
            actions: [
                Fluid.Action {
                    text: qsTr("Folder")
                    icon.source: Fluid.Utils.iconUrl("file/folder")
                },
                Fluid.Action {
                    text: qsTr("New Folder")
                    icon.source: Fluid.Utils.iconUrl("file/create_new_folder")
                },
                Fluid.Action {
                    text: qsTr("Shared Folder")
                    icon.source: Fluid.Utils.iconUrl("file/folder_shared")
                },
                Fluid.Action {
                    text: qsTr("Cloud")
                    icon.source: Fluid.Utils.iconUrl("file/cloud")
                },
                Fluid.Action {
                    text: qsTr("Email Attachment")
                    icon.source: Fluid.Utils.iconUrl("file/attachment")
                },
                Fluid.Action {
                    text: qsTr("Upload")
                    icon.source: Fluid.Utils.iconUrl("file/file_upload")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 1")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 2")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 3")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 4")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 5")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 6")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 7")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 8")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 9")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 10")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 11")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 12")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 13")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 14")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 15")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 16")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 17")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 18")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 19")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                },
                Fluid.Action {
                    text: qsTr("Placeholder 20")
                    icon.source: Fluid.Utils.iconUrl("file/cloud_done")
                }
            ]
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/bottom-sheets.html">Material Design guidelines</a>.
*/
BottomSheet {
    id: bottomSheet

    /*!
        Title.
    */
    property string title

    /*!
        Actions to display in the bottom sheet.
    */
    property list<Fluid.Action> actions

    /*!
        Number of columns.
        By default it's set to fit the screen width.
    */
    property alias columns: grid.columns

    /*!
        Number of rows.
        By default it's set to fit the screen size based on the \l columns.
    */
    property alias rows: grid.rows

    height: Math.min(implicitHeight, maxHeight)
    implicitHeight: listViewContainer.implicitHeight + (header.visible ? header.height : 0)

    Column {
        id: column

        anchors.fill: parent

        Fluid.Subheader {
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
