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

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0 as FluidControls

Item {
    Column {
        anchors.centerIn: parent

        Button {
            text: qsTr("List-style BottomSheet")
            onClicked: listBottomSheet.open()
        }

        Button {
            text: qsTr("Long List-style BottomSheet")
            onClicked: longListBottomSheet.open()
        }

        Button {
            text: qsTr("Grid-style BottomSheet")
            onClicked: gridBottomSheet.open()
        }

        Button {
            text: qsTr("Custom BottomSheet")
            onClicked: customBottomSheet.open()
        }
    }

    FluidControls.BottomSheetList {
        id: listBottomSheet
        title: qsTr("Save As")
        actions: [
            FluidControls.Action {
                text: qsTr("Folder")
                icon.name: "file/folder"
            },
            FluidControls.Action {
                text: qsTr("New Folder")
                icon.name: "file/create_new_folder"
            },
            FluidControls.Action {
                text: qsTr("Shared Folder")
                icon.name: "file/folder_shared"
            },
            FluidControls.Action {
                text: qsTr("Cloud")
                icon.name: "file/cloud"
            },
            FluidControls.Action {
                text: qsTr("Email Attachment")
                icon.name: "file/attachment"
            },
            FluidControls.Action {
                text: qsTr("Upload")
                icon.name: "file/file_upload"
            },
            FluidControls.Action {
                text: qsTr("Warning (Disabled)")
                icon.name: "alert/warning"
                enabled: false
            }
        ]
    }

    FluidControls.BottomSheetList {
        id: longListBottomSheet
        title: qsTr("Save As")
        actions: [
            FluidControls.Action {
                text: qsTr("Folder")
                icon.name: "file/folder"
            },
            FluidControls.Action {
                text: qsTr("New Folder")
                icon.name: "file/create_new_folder"
            },
            FluidControls.Action {
                text: qsTr("Shared Folder")
                icon.name: "file/folder_shared"
            },
            FluidControls.Action {
                text: qsTr("Cloud")
                icon.name: "file/cloud"
            },
            FluidControls.Action {
                text: qsTr("Email Attachment")
                icon.name: "file/attachment"
            },
            FluidControls.Action {
                text: qsTr("Upload")
                icon.name: "file/file_upload"
            },
            FluidControls.Action {
                text: qsTr("Warning (Disabled)")
                icon.name: "alert/warning"
                enabled: false
                hasDividerAfter: true
            },
            FluidControls.Action {
                text: qsTr("Placeholder 1")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 2")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 3")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 4")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 5")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 6")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 7")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 8")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 9")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 10")
                icon.name: "file/cloud_done"
            }
        ]
    }

    FluidControls.BottomSheetGrid {
        id: gridBottomSheet
        actions: [
            FluidControls.Action {
                text: qsTr("Folder")
                icon.name: "file/folder"
            },
            FluidControls.Action {
                text: qsTr("New Folder")
                icon.name: "file/create_new_folder"
            },
            FluidControls.Action {
                text: qsTr("Shared Folder")
                icon.name: "file/folder_shared"
            },
            FluidControls.Action {
                text: qsTr("Cloud")
                icon.name: "file/cloud"
            },
            FluidControls.Action {
                text: qsTr("Email Attachment")
                icon.name: "file/attachment"
            },
            FluidControls.Action {
                text: qsTr("Upload")
                icon.name: "file/file_upload"
            },
            FluidControls.Action {
                text: qsTr("Warning (Disabled)")
                icon.name: "alert/warning"
                enabled: false
            },
            FluidControls.Action {
                text: qsTr("Placeholder 1")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 2")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 3")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 4")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 5")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 6")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 7")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 8")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 9")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 10")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 11")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 12")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 13")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 14")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 15")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 16")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 17")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 18")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 19")
                icon.name: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 20")
                icon.name: "file/cloud_done"
            }
        ]
    }

    FluidControls.BottomSheet {
        id: customBottomSheet

        Column {
            width: parent.width

            Pane {
                width: parent.width
                padding: 16

                Column {
                    spacing: 8

                    FluidControls.TitleLabel {
                        text: "freedom"
                    }

                    FluidControls.BodyLabel {
                        text: "/ˈfriːdəm/"
                        color: Material.secondaryTextColor
                    }
                }

                Material.background: Material.color(Material.Yellow, Material.Shade800)
            }

            Pane {
                width: parent.width
                implicitHeight: 100
                padding: 16

                Column {
                    FluidControls.SubheadingLabel {
                        text: "noun"
                        color: Material.secondaryTextColor
                    }

                    FluidControls.BodyLabel {
                        text: "the right to live in the way you want without being controlled by anyone else"
                    }
                }
            }
        }
    }
}
