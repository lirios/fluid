// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

GalleryPage {
    headline: qsTr("Button groups")
    description: qsTr("Button groups arrange related actions or connected segmented choices with expressive shape and press motion.")

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Standard actions and sizes")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.ButtonGroup {
                MD.Button {
                    text: qsTr("Undo")
                    icon.name: MD.Symbols.undo
                }
                MD.Button {
                    text: qsTr("Redo")
                    icon.name: MD.Symbols.redo
                }
                MD.IconButton {
                    text: qsTr("Share")
                    icon.name: MD.Symbols.share
                }
            }
            MD.ButtonGroup {
                size: MD.ButtonGroup.ExtraSmall

                MD.Button {
                    text: qsTr("XS")
                }
                MD.Button {
                    text: qsTr("Action")
                }
            }
            MD.ButtonGroup {
                size: MD.ButtonGroup.Medium

                MD.Button {
                    text: qsTr("Medium")
                }
                MD.IconButton {
                    text: qsTr("Favorite")
                    icon.name: MD.Symbols.favorite
                }
            }
            MD.ButtonGroup {
                size: MD.ButtonGroup.Large
                shape: MD.ButtonGroup.Square

                MD.Button {
                    text: qsTr("Large")
                }
                MD.Button {
                    text: qsTr("Square")
                }
            }
            MD.ButtonGroup {
                size: MD.ButtonGroup.ExtraLarge

                MD.IconButton {
                    text: qsTr("Previous")
                    icon.name: MD.Symbols.skipPrevious
                }
                MD.IconButton {
                    text: qsTr("Next")
                    icon.name: MD.Symbols.skipNext
                }
            }
        }
    }

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Connected selection")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.ButtonGroup {
                variant: MD.ButtonGroup.Connected
                selectionMode: MD.ButtonGroup.SingleSelection

                MD.Button {
                    text: qsTr("Optional")
                }
                MD.Button {
                    text: qsTr("Single")
                }
                MD.IconButton {
                    text: qsTr("List")
                    icon.name: MD.Symbols.viewList
                }
            }
            MD.ButtonGroup {
                variant: MD.ButtonGroup.Connected
                selectionMode: MD.ButtonGroup.SingleSelection
                selectionRequired: true
                selectedIndexes: [1]
                shape: MD.ButtonGroup.Square

                MD.Button {
                    text: qsTr("Day")
                }
                MD.Button {
                    text: qsTr("Week")
                }
                MD.Button {
                    text: qsTr("Month")
                }
            }
            MD.ButtonGroup {
                variant: MD.ButtonGroup.Connected
                selectionMode: MD.ButtonGroup.MultiSelection
                selectedIndexes: [0, 2]

                MD.IconButton {
                    text: qsTr("Bold")
                    icon.name: MD.Symbols.formatBold
                }
                MD.IconButton {
                    text: qsTr("Italic")
                    icon.name: MD.Symbols.formatItalic
                }
                MD.IconButton {
                    text: qsTr("Underline")
                    icon.name: MD.Symbols.formatUnderlined
                }
            }
        }
    }
}
