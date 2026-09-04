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
Item {
    id: page

    MD.AppBarAction {
        id: backAction
        text: qsTr("Back")
        icon.name: MD.Symbols.arrowBack
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    MD.AppBarAction {
        id: favoriteAction
        text: qsTr("Favorite")
        icon.name: MD.Symbols.favorite
        checkable: true
        priority: 10
    }
    MD.AppBarAction {
        id: shareAction
        text: qsTr("Share")
        icon.name: MD.Symbols.share
        priority: 5
    }
    MD.AppBarAction {
        id: editAction
        text: qsTr("Edit")
        icon.name: MD.Symbols.edit
        presentation: MD.AppBarAction.FilledButton
        priority: 20
    }
    MD.AppBarAction {
        id: avatarAction
        text: qsTr("Account")
        icon.name: MD.Symbols.accountCircle
        presentation: MD.AppBarAction.Avatar
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    MD.AppBarAction {
        id: deleteAction
        text: qsTr("Delete")
        icon.name: MD.Symbols.deleteIcon
        enabled: false
        overflowPolicy: MD.AppBarAction.AlwaysOverflow
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("App bars")
        description: qsTr("App bars organize navigation, titles, search, and key actions while adapting their presentation to available space.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Small · centered · icon, filled, avatar, priority overflow")

            MD.AppBar {
                width: parent.width
                title: qsTr("Library")
                subtitle: qsTr("24 items")
                titleAlignment: MD.AppBar.Center
                navigationAction: backAction
                actions: [favoriteAction, editAction, avatarAction, shareAction, deleteAction]
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Medium flexible · start aligned")

            MD.AppBar {
                width: parent.width
                variant: MD.AppBar.MediumFlexible
                title: qsTr("A flexible title that can wrap on compact screens")
                subtitle: qsTr("Scrolls until collapsed")
                navigationAction: backAction
                actions: [favoriteAction, shareAction]
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Large flexible · centered · RTL")

            Rectangle {
                width: parent.width
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
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Search · launcher and editable")

            ColumnLayout {
                width: parent.width
                spacing: galleryPage.contentSpacing

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
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Adaptive narrow width and stable overflow")

            Rectangle {
                width: Math.min(312, parent.width)
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
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Exit-until-collapsed scrolling")

            Rectangle {
                width: parent.width
                height: 360
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
                                leftPadding: MD.Tokens.measurement.space200
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
}
