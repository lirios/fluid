// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T

Item {
    id: page

    readonly property int contentSpacing: 16
    readonly property int sectionSpacing: 24

    component Headline: MD.Label {
        typescale: MD.Tokens.typescale.headlineMedium
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: page.sectionSpacing

            Headline {
                text: qsTr("Menus")
            }

            MD.GroupBox {
                title: qsTr("Vertical menu grouping")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: page.contentSpacing

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

            MD.GroupBox {
                title: qsTr("Context menu")

                Rectangle {
                    id: contextArea

                    anchors.centerIn: parent
                    implicitWidth: 480
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
    }

    MD.Menu {
        id: standardMenu

        T.Action { text: qsTr("Cut"); icon.name: MD.SymbolNames.symbolContentCut }
        T.Action { text: qsTr("Copy"); icon.name: MD.SymbolNames.symbolContentCopy }
        T.Action { text: qsTr("Paste"); icon.name: MD.SymbolNames.symbolContentPaste }
    }

    MD.Menu {
        id: dividerMenu

        T.Action { text: qsTr("Cut"); icon.name: MD.SymbolNames.symbolContentCut }
        T.Action { text: qsTr("Copy"); icon.name: MD.SymbolNames.symbolContentCopy }
        MD.MenuDivider {}
        T.Action { text: qsTr("Select all"); icon.name: MD.SymbolNames.symbolSelectAll }
    }

    MD.Menu {
        id: gapMenu

        T.Action { text: qsTr("Cut"); icon.name: MD.SymbolNames.symbolContentCut }
        T.Action { text: qsTr("Copy"); icon.name: MD.SymbolNames.symbolContentCopy }
        T.Action { text: qsTr("Paste"); icon.name: MD.SymbolNames.symbolContentPaste }
        MD.MenuGap {}
        MD.MenuSectionLabel { text: qsTr("Sharing") }
        T.Action { text: qsTr("Share"); icon.name: MD.SymbolNames.symbolShare }
        T.Action { text: qsTr("Download"); icon.name: MD.SymbolNames.symbolDownload }
    }

    MD.Menu {
        id: vibrantMenu
        colorStyle: MD.Menu.Vibrant

        MD.MenuSectionLabel { text: qsTr("Document") }
        MD.MenuItem {
            text: qsTr("Edit")
            supportingText: qsTr("Open the document editor")
            icon.name: MD.SymbolNames.symbolEdit
            trailingText: qsTr("⌘E")
        }
        MD.MenuDivider {}
        MD.MenuItem {
            text: qsTr("Settings")
            icon.name: MD.SymbolNames.symbolSettings
            badgeContent: qsTr("New")
        }
    }

    MD.Menu {
        id: contextMenu

        T.Action { text: qsTr("Copy"); icon.name: MD.SymbolNames.symbolContentCopy }
        T.Action { text: qsTr("Paste"); icon.name: MD.SymbolNames.symbolContentPaste }
        MD.MenuGap {}
        MD.MenuSectionLabel { text: qsTr("File") }
        T.Action { text: qsTr("Share"); icon.name: MD.SymbolNames.symbolShare }
        MD.MenuDivider {}
        T.Action { text: qsTr("Delete"); icon.name: MD.SymbolNames.symbolDelete }
    }
}
