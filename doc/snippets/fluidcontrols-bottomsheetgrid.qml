/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
                iconName: "file/folder"
            },
            FluidControls.Action {
                text: qsTr("New Folder")
                iconName: "file/create_new_folder"
            },
            FluidControls.Action {
                text: qsTr("Shared Folder")
                iconName: "file/folder_shared"
            },
            FluidControls.Action {
                text: qsTr("Cloud")
                iconName: "file/cloud"
            },
            FluidControls.Action {
                text: qsTr("Email Attachment")
                iconName: "file/attachment"
            },
            FluidControls.Action {
                text: qsTr("Upload")
                iconName: "file/file_upload"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 1")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 2")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 3")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 4")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 5")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 6")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 7")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 8")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 9")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 10")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 11")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 12")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 13")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 14")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 15")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 16")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 17")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 18")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 19")
                iconName: "file/cloud_done"
            },
            FluidControls.Action {
                text: qsTr("Placeholder 20")
                iconName: "file/cloud_done"
            }
        ]
    }
}
//! [file]
