// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \internal
    \brief Gallery page demonstrating Material 3 Expressive navigation rails.

    The examples cover collapsed and expanded rails, all destination
    arrangements, header content, disabled and icon-only destinations,
    right-to-left mirroring, and both modal collapse behaviors.
*/
Item {
    id: page

    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    component LargeLabel: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
    }

    component RailHeader: Item {
        implicitWidth: 56
        implicitHeight: 56

        MD.IconButton {
            anchors.centerIn: parent
            icon.name: MD.Symbols.menu
            text: qsTr("Toggle rail")
        }
    }

    component DemoFrame: Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.minimumWidth: 0
        Layout.maximumWidth: implicitWidth
        implicitWidth: 380
        implicitHeight: 520
        color: MD.Style.surfaceContainerLowColor
        topLeftRadius: MD.Tokens.shape.cornerLarge.topLeft
        topRightRadius: MD.Tokens.shape.cornerLarge.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerLarge.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerLarge.bottomRight
        clip: true
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Navigation rails")
        description: qsTr("Navigation rails provide access to primary destinations on medium and larger layouts, with collapsed, expanded, and modal behavior.")

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Collapsed and expanded")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(2, Math.floor(width / 400)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        implicitWidth: 220

                        MD.NavigationRail {
                            Accessible.name: qsTr("Primary navigation")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            header: RailHeader {}

                            MD.NavigationRailItem {
                                text: qsTr("Home")
                                icon.name: MD.Symbols.home
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Explore")
                                icon.name: MD.Symbols.explore
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Favorites")
                                icon.name: MD.Symbols.favorite
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Collapsed")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.NavigationRail {
                            Accessible.name: qsTr("Primary navigation")
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            expanded: true
                            header: RailHeader {}

                            MD.NavigationRailItem {
                                text: qsTr("Home")
                                icon.name: MD.Symbols.home
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Explore")
                                icon.name: MD.Symbols.explore
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Favorites")
                                icon.name: MD.Symbols.favorite
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Expanded")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Arrangement and states")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 300)))
                columnSpacing: page.contentSpacing
                rowSpacing: page.contentSpacing

                Repeater {
                    model: [
                        {
                            "label": qsTr("Top"),
                            "arrangement": MD.NavigationRail.Arrangement.Top
                        },
                        {
                            "label": qsTr("Center"),
                            "arrangement": MD.NavigationRail.Arrangement.Center
                        },
                        {
                            "label": qsTr("Bottom"),
                            "arrangement": MD.NavigationRail.Arrangement.Bottom
                        }
                    ]

                    delegate: ColumnLayout {
                        id: arrangementExample

                        required property var modelData
                        spacing: page.compactSpacing

                        DemoFrame {
                            implicitWidth: 280

                            MD.NavigationRail {
                                Accessible.name: qsTr("Primary navigation")
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                arrangement: arrangementExample.modelData.arrangement

                                MD.NavigationRailItem {
                                    text: qsTr("Inbox")
                                    icon.name: MD.Symbols.inbox
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Starred")
                                    icon.name: MD.Symbols.star
                                    enabled: false
                                }
                                MD.NavigationRailItem {
                                    text: ""
                                    icon.name: MD.Symbols.settings
                                    Accessible.name: qsTr("Settings")
                                }
                            }
                        }

                        LargeLabel {
                            text: arrangementExample.modelData.label
                        }
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Right-to-left")

            DemoFrame {
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true

                MD.NavigationRail {
                    Accessible.name: qsTr("Primary navigation")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    expanded: true
                    header: RailHeader {}

                    MD.NavigationRailItem {
                        text: qsTr("Home")
                        icon.name: MD.Symbols.home
                    }
                    MD.NavigationRailItem {
                        text: qsTr("Messages")
                        icon.name: MD.Symbols.chat
                    }
                    MD.NavigationRailItem {
                        text: qsTr("Profile")
                        icon.name: MD.Symbols.person
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Modal collapse behavior")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(2, Math.floor(width / 480)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        implicitWidth: 460

                        MD.Label {
                            anchors.centerIn: parent
                            text: qsTr("Page content")
                        }

                        MD.ModalNavigationRail {
                            id: retainedModal
                            Accessible.name: qsTr("Primary navigation")
                            anchors.fill: parent
                            expanded: true
                            hideOnCollapse: false
                            header: RailHeader {}

                            MD.NavigationRailItem {
                                text: qsTr("Home")
                                icon.name: MD.Symbols.home
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Search")
                                icon.name: MD.Symbols.search
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Account")
                                icon.name: MD.Symbols.accountCircle
                            }
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter

                        LargeLabel {
                            text: qsTr("Retain collapsed rail")
                        }
                        MD.Button {
                            text: retainedModal.expanded ? qsTr("Collapse") : qsTr("Expand")
                            onClicked: retainedModal.toggle()
                        }
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        implicitWidth: 460

                        MD.Label {
                            anchors.centerIn: parent
                            text: qsTr("Page content")
                        }

                        MD.Button {
                            anchors.centerIn: parent
                            text: qsTr("Open rail")
                            onClicked: dismissibleModal.expand()
                        }

                        MD.ModalNavigationRail {
                            id: dismissibleModal
                            Accessible.name: qsTr("Primary navigation")
                            anchors.fill: parent
                            expanded: true
                            hideOnCollapse: true
                            header: RailHeader {}

                            MD.NavigationRailItem {
                                text: qsTr("Home")
                                icon.name: MD.Symbols.home
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Search")
                                icon.name: MD.Symbols.search
                            }
                            MD.NavigationRailItem {
                                text: qsTr("Account")
                                icon.name: MD.Symbols.accountCircle
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Hide on collapse")
                    }
                }
            }
        }
    }
}
