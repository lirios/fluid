// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import QtQuick
import QtQuick.Layouts

Item {
    id: page

    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Menus")
        description: qsTr("Menus present temporary lists of actions with grouped, divided, contextual, and vibrant presentations.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Vertical menu grouping")

            GridLayout {
                width: parent.width
                columns: width >= 560 ? 4 : width >= 280 ? 2 : 1
                columnSpacing: page.contentSpacing
                rowSpacing: page.contentSpacing

                MD.Button {
                    text: qsTr("Standard")
                    onClicked: standardMenu.popup(this, 0, height)
                }

                MD.Button {
                    text: qsTr("With divider")
                    onClicked: dividerMenu.popup(this, 0, height)
                }

                MD.Button {
                    text: qsTr("With gap")
                    onClicked: gapMenu.popup(this, 0, height)
                }

                MD.Button {
                    text: qsTr("Vibrant groups")
                    onClicked: vibrantMenu.popup(this, 0, height)
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Context menu")

            Rectangle {
                id: contextArea

                anchors.centerIn: parent
                width: Math.min(480, parent.width)
                implicitHeight: 144
                radius: MD.Tokens.shape.cornerMedium.topLeft
                color: page.MD.Style.surfaceContainerColor

                MD.Label {
                    anchors.centerIn: parent
                    text: qsTr("Right-click anywhere in this area")
                    color: page.MD.Style.onSurfaceVariantColor
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: mouse => contextMenu.popup(contextArea, mouse.x, mouse.y)
                }
            }
        }
    }

    MD.Menu {
        id: standardMenu

        MD.Action {
            text: qsTr("Cut")
            icon.name: MD.Symbols.contentCut
        }
        MD.Action {
            text: qsTr("Copy")
            icon.name: MD.Symbols.contentCopy
        }
        MD.Action {
            text: qsTr("Paste")
            icon.name: MD.Symbols.contentPaste
        }
    }

    MD.Menu {
        id: dividerMenu

        MD.Action {
            text: qsTr("Cut")
            icon.name: MD.Symbols.contentCut
        }
        MD.Action {
            text: qsTr("Copy")
            icon.name: MD.Symbols.contentCopy
        }
        MD.MenuDivider {}
        MD.Action {
            text: qsTr("Select all")
            icon.name: MD.Symbols.selectAll
        }
    }

    MD.Menu {
        id: gapMenu

        MD.Action {
            text: qsTr("Cut")
            icon.name: MD.Symbols.contentCut
        }
        MD.Action {
            text: qsTr("Copy")
            icon.name: MD.Symbols.contentCopy
        }
        MD.Action {
            text: qsTr("Paste")
            icon.name: MD.Symbols.contentPaste
        }
        MD.MenuGap {}
        MD.MenuSectionLabel {
            text: qsTr("Sharing")
        }
        MD.Action {
            text: qsTr("Share")
            icon.name: MD.Symbols.share
        }
        MD.Action {
            text: qsTr("Download")
            icon.name: MD.Symbols.download
        }
    }

    MD.Menu {
        id: vibrantMenu
        colorStyle: MD.Menu.Vibrant

        MD.MenuSectionLabel {
            text: qsTr("Document")
        }
        MD.Action {
            text: qsTr("Edit")
            supportingText: qsTr("Open the document editor")
            icon.name: MD.Symbols.edit
            shortcut: "Meta+E"
        }
        MD.MenuDivider {}
        MD.Action {
            text: qsTr("Settings")
            icon.name: MD.Symbols.settings
            badgeContent: qsTr("New")
        }
    }

    MD.Menu {
        id: contextMenu

        MD.Action {
            text: qsTr("Copy")
            icon.name: MD.Symbols.contentCopy
            shortcut: StandardKey.Copy
        }
        MD.Action {
            text: qsTr("Paste")
            icon.name: MD.Symbols.contentPaste
            shortcut: StandardKey.Paste
        }
        MD.MenuGap {}
        MD.MenuSectionLabel {
            text: qsTr("File")
        }
        MD.Action {
            text: qsTr("Share")
            icon.name: MD.Symbols.share
        }
        MD.MenuDivider {}
        MD.Action {
            text: qsTr("Delete")
            icon.name: MD.Symbols.deleteIcon
            shortcut: StandardKey.Delete
        }
    }
}
