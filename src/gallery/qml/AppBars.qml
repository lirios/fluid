// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \internal
    \brief Gallery page demonstrating Material 3 Expressive app bars.

    The page covers every public variant, logical alignment, launcher and
    editable search modes, action presentations, adaptive overflow, narrow and
    right-to-left layouts, and exit-until-collapsed scrolling.
*/
Flickable {
    id: gallery

    contentWidth: width
    contentHeight: examples.implicitHeight + examples.anchors.margins
    clip: true

    MD.AppBarAction {
        id: backAction
        text: qsTr("Back")
        icon.name: MD.SymbolNames.symbolArrowBack
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    MD.AppBarAction {
        id: favoriteAction
        text: qsTr("Favorite")
        icon.name: MD.SymbolNames.symbolFavorite
        checkable: true
        priority: 10
    }
    MD.AppBarAction {
        id: shareAction
        text: qsTr("Share")
        icon.name: MD.SymbolNames.symbolShare
        priority: 5
    }
    MD.AppBarAction {
        id: editAction
        text: qsTr("Edit")
        icon.name: MD.SymbolNames.symbolEdit
        presentation: MD.AppBarAction.FilledButton
        priority: 20
    }
    MD.AppBarAction {
        id: avatarAction
        text: qsTr("Account")
        icon.name: MD.SymbolNames.symbolAccountCircle
        presentation: MD.AppBarAction.Avatar
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    MD.AppBarAction {
        id: deleteAction
        text: qsTr("Delete")
        icon.name: MD.SymbolNames.symbolDelete
        enabled: false
        overflowPolicy: MD.AppBarAction.AlwaysOverflow
    }

    ColumnLayout {
        id: examples
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 16
        }
        spacing: 20

        MD.Label {
            text: qsTr("Material 3 Expressive app bars")
            typescale: MD.Tokens.typescale.headlineMedium
            color: MD.Style.onSurfaceColor
        }
        MD.Label {
            text: qsTr("Small · centered · icon, filled, avatar, priority overflow")
            typescale: MD.Tokens.typescale.titleMedium
        }
        MD.AppBar {
            Layout.fillWidth: true
            title: qsTr("Library")
            subtitle: qsTr("24 items")
            titleAlignment: MD.AppBar.Center
            navigationAction: backAction
            actions: [favoriteAction, editAction, avatarAction, shareAction, deleteAction]
        }

        MD.Label {
            text: qsTr("Medium flexible · start aligned")
            typescale: MD.Tokens.typescale.titleMedium
        }
        MD.AppBar {
            Layout.fillWidth: true
            variant: MD.AppBar.MediumFlexible
            title: qsTr("A flexible title that can wrap on compact screens")
            subtitle: qsTr("Scrolls until collapsed")
            navigationAction: backAction
            actions: [favoriteAction, shareAction]
        }

        MD.Label {
            text: qsTr("Large flexible · centered · RTL")
            typescale: MD.Tokens.typescale.titleMedium
        }
        Rectangle {
            Layout.fillWidth: true
            implicitHeight: rtlBar.implicitHeight
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true
            color: "transparent"
            MD.AppBar {
                id: rtlBar
                width: parent.width
                variant: MD.AppBar.LargeFlexible
                title: qsTr("عنوان تطبيقي")
                subtitle: qsTr("تخطيط من اليمين إلى اليسار")
                titleAlignment: MD.AppBar.Center
                navigationAction: backAction
                actions: [favoriteAction, shareAction, deleteAction]
            }
        }

        MD.Label {
            text: qsTr("Search · launcher and editable")
            typescale: MD.Tokens.typescale.titleMedium
        }
        MD.SearchAppBar {
            Layout.fillWidth: true
            placeholderText: qsTr("Search the gallery")
            navigationAction: backAction
            searchActions: [avatarAction]
            actions: [favoriteAction, shareAction]
        }
        MD.SearchAppBar {
            Layout.fillWidth: true
            mode: MD.SearchAppBar.Editable
            placeholderText: qsTr("Type a query")
            textAlignment: MD.SearchAppBar.Center
            searchActions: [favoriteAction, avatarAction, deleteAction]
        }

        MD.Label {
            text: qsTr("Adaptive narrow width and stable overflow")
            typescale: MD.Tokens.typescale.titleMedium
        }
        Rectangle {
            Layout.preferredWidth: Math.min(312, examples.width)
            implicitHeight: narrowBar.implicitHeight
            color: "transparent"
            MD.AppBar {
                id: narrowBar
                width: parent.width
                title: qsTr("Compact")
                navigationAction: backAction
                actions: [favoriteAction, shareAction, editAction, avatarAction, deleteAction]
            }
        }

        MD.Label {
            text: qsTr("Exit-until-collapsed scrolling")
            typescale: MD.Tokens.typescale.titleMedium
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 360
            color: MD.Style.surfaceContainerLowColor
            clip: true

            Flickable {
                id: demoFlickable
                anchors.fill: parent
                contentWidth: width
                contentHeight: demoContent.implicitHeight
                topMargin: scrollingBar.implicitHeight
                clip: true
                Column {
                    id: demoContent
                    width: parent.width
                    Repeater {
                        model: 18
                        delegate: MD.Label {
                            required property int index
                            width: demoContent.width
                            height: 48
                            leftPadding: 16
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr("Scrollable item %1").arg(index + 1)
                            color: MD.Style.onSurfaceColor
                        }
                    }
                }
            }

            MD.AppBar {
                id: scrollingBar
                width: parent.width
                z: 1
                variant: MD.AppBar.LargeFlexible
                title: qsTr("Scroll demo")
                subtitle: qsTr("Drag the content or the app bar")
                navigationAction: backAction
                actions: [favoriteAction]
                scrollTarget: demoFlickable
            }
        }
    }
}
