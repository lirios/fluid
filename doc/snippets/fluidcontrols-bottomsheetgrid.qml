/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:FDL$
 *
 * Permission is granted to copy, distribute and/or modify this document
 * under the terms of the GNU Free Documentation License, Version 1.3
 * or any later version published by the Free Software Foundation;
 * with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
 * A copy of the license is included in the section entitled "GNU
 * Free Documentation License".
 *
 * $END_LICENSE$
 ***************************************************************************/

//! [file]
import QtQuick 2.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls

Item {
    Button {
        anchors.centerIn: parent
        text: qsTr("Press Me")
        onClicked: gridBottomSheet.open()
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
}
//! [file]
