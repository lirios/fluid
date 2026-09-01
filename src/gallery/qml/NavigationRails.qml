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

    component Headline: MD.Label {
        typescale: MD.Tokens.typescale.headlineMedium
    }

    component LargeLabel: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
    }

    component RailHeader: Item {
        implicitWidth: 56
        implicitHeight: 56

        MD.IconButton {
            anchors.centerIn: parent
            icon.name: "menu"
            text: qsTr("Toggle rail")
        }
    }

    component DemoFrame: Rectangle {
        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 380
        implicitHeight: 520
        color: MD.Style.surfaceContainerLowColor
        topLeftRadius: MD.Tokens.shape.cornerLarge.topLeft
        topRightRadius: MD.Tokens.shape.cornerLarge.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerLarge.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerLarge.bottomRight
        clip: true
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            Headline {
                text: qsTr("Navigation Rails")
            }

            MD.Label {
                Layout.maximumWidth: 760
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: qsTr("Navigation rails are intended for Medium, Expanded, Large, and Extra Large windows. The application chooses when to show or expand them.")
            }

            MD.GroupBox {
                title: qsTr("Collapsed and expanded")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: page.sectionSpacing

                    ColumnLayout {
                        spacing: page.compactSpacing

                        DemoFrame {
                            implicitWidth: 220

                            MD.NavigationRail {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                header: RailHeader {}

                                MD.NavigationRailItem {
                                    text: qsTr("Home")
                                    icon.name: "home"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Explore")
                                    icon.name: "explore"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Favorites")
                                    icon.name: "favorite"
                                }
                            }
                        }

                        LargeLabel { text: qsTr("Collapsed") }
                    }

                    ColumnLayout {
                        spacing: page.compactSpacing

                        DemoFrame {
                            MD.NavigationRail {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                expanded: true
                                header: RailHeader {}

                                MD.NavigationRailItem {
                                    text: qsTr("Home")
                                    icon.name: "home"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Explore")
                                    icon.name: "explore"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Favorites")
                                    icon.name: "favorite"
                                }
                            }
                        }

                        LargeLabel { text: qsTr("Expanded") }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Arrangement and states")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: page.contentSpacing

                    Repeater {
                        model: [
                            { "label": qsTr("Top"), "arrangement": MD.NavigationRail.Arrangement.Top },
                            { "label": qsTr("Center"), "arrangement": MD.NavigationRail.Arrangement.Center },
                            { "label": qsTr("Bottom"), "arrangement": MD.NavigationRail.Arrangement.Bottom }
                        ]

                        delegate: ColumnLayout {
                            id: arrangementExample

                            required property var modelData
                            spacing: page.compactSpacing

                            DemoFrame {
                                implicitWidth: 280

                                MD.NavigationRail {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    arrangement: arrangementExample.modelData.arrangement

                                    MD.NavigationRailItem {
                                        text: qsTr("Inbox")
                                        icon.name: "inbox"
                                    }
                                    MD.NavigationRailItem {
                                        text: qsTr("Starred")
                                        icon.name: "star"
                                        enabled: false
                                    }
                                    MD.NavigationRailItem {
                                        text: ""
                                        icon.name: "settings"
                                        Accessible.name: qsTr("Settings")
                                    }
                                }
                            }

                            LargeLabel { text: arrangementExample.modelData.label }
                        }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Right-to-left")

                DemoFrame {
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true

                    MD.NavigationRail {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        expanded: true
                        header: RailHeader {}

                        MD.NavigationRailItem {
                            text: qsTr("Home")
                            icon.name: "home"
                        }
                        MD.NavigationRailItem {
                            text: qsTr("Messages")
                            icon.name: "chat"
                        }
                        MD.NavigationRailItem {
                            text: qsTr("Profile")
                            icon.name: "person"
                        }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Modal collapse behavior")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: page.sectionSpacing

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
                                anchors.fill: parent
                                expanded: true
                                hideOnCollapse: false
                                header: RailHeader {}

                                MD.NavigationRailItem {
                                    text: qsTr("Home")
                                    icon.name: "home"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Search")
                                    icon.name: "search"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Account")
                                    icon.name: "account_circle"
                                }
                            }
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter

                            LargeLabel { text: qsTr("Retain collapsed rail") }
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
                                anchors.fill: parent
                                expanded: true
                                hideOnCollapse: true
                                header: RailHeader {}

                                MD.NavigationRailItem {
                                    text: qsTr("Home")
                                    icon.name: "home"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Search")
                                    icon.name: "search"
                                }
                                MD.NavigationRailItem {
                                    text: qsTr("Account")
                                    icon.name: "account_circle"
                                }
                            }
                        }

                        LargeLabel { text: qsTr("Hide on collapse") }
                    }
                }
            }
        }
    }
}
