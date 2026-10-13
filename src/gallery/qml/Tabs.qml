// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QC
import Fluid as MD

GalleryPage {
    id: page

    headline: qsTr("Tabs")
    description: qsTr("Tabs organize related views at the same level. Primary tabs navigate between major sections; secondary tabs divide content within a section.")

    component Caption: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
        color: MD.Style.onSurfaceVariantColor
    }

    component ExampleFrame: Rectangle {
        Layout.fillWidth: true
        Layout.minimumWidth: 0
        Layout.maximumWidth: implicitWidth
        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 440
        implicitHeight: 210
        color: MD.Style.surfaceContainerLowColor
        topLeftRadius: MD.Tokens.shape.cornerLarge.topLeft
        topRightRadius: MD.Tokens.shape.cornerLarge.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerLarge.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerLarge.bottomRight
        clip: true
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Primary tabs")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 440)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: primaryFixedFrame
                    objectName: "tab-gallery-frame-primary-fixed"
                    implicitWidth: 460

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.topMargin: page.contentSpacing
                        spacing: page.contentSpacing

                        MD.TabBar {
                            id: primaryFixed
                            objectName: "tab-gallery-primary-fixed"
                            Layout.fillWidth: true
                            Accessible.name: qsTr("Primary destinations")
                            variant: MD.TabBar.Primary
                            layoutMode: MD.TabBar.Fixed

                            MD.TabButton { text: qsTr("Home"); icon.name: MD.Symbols.home }
                            MD.TabButton { text: qsTr("Search"); icon.name: MD.Symbols.search }
                            MD.TabButton { text: qsTr("Library"); icon.name: MD.Symbols.bookmark }
                        }

                        StackLayout {
                            objectName: "tab-gallery-stack"
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            currentIndex: primaryFixed.currentIndex

                            MD.Label { Layout.alignment: Qt.AlignHCenter; text: qsTr("Home content") }
                            MD.Label { Layout.alignment: Qt.AlignHCenter; text: qsTr("Search content") }
                            MD.Label { Layout.alignment: Qt.AlignHCenter; text: qsTr("Library content") }
                        }
                    }
                }

                Caption { text: qsTr("Fixed · stacked icon and label") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: primaryInlineFrame
                    objectName: "tab-gallery-frame-primary-inline"
                    implicitWidth: 460

                    MD.TabBar {
                        objectName: "tab-gallery-inline"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        Accessible.name: qsTr("Primary destinations, inline")
                        variant: MD.TabBar.Primary
                        layoutMode: MD.TabBar.Fixed

                        MD.TabButton { text: qsTr("Home"); icon.name: MD.Symbols.home; display: MD.TabButton.TextBesideIcon }
                        MD.TabButton { text: qsTr("Search"); icon.name: MD.Symbols.search; display: MD.TabButton.TextBesideIcon }
                        MD.TabButton {
                            text: qsTr("Library")
                            icon.name: MD.Symbols.bookmark
                            display: MD.TabButton.TextBesideIcon
                            badgeContent: 3
                            badgeAccessibleDescription: qsTr("3 saved items")
                        }
                    }
                }

                Caption { text: qsTr("Fixed · inline icon and label") }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Secondary tabs")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 440)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: secondaryFrame
                    objectName: "tab-gallery-frame-secondary"
                    implicitWidth: 460

                    MD.TabBar {
                        id: secondaryBar
                        objectName: "tab-gallery-secondary"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        Accessible.name: qsTr("Secondary sections")
                        variant: MD.TabBar.Secondary

                        MD.TabButton { text: qsTr("Details"); icon.name: MD.Symbols.info }
                        MD.TabButton { text: qsTr("Reviews"); icon.name: MD.Symbols.star }
                        MD.TabButton { text: qsTr("Related"); icon.name: MD.Symbols.widgets }
                    }
                }

                Caption { text: qsTr("Secondary · inline icon and label") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: secondaryTextFrame
                    objectName: "tab-gallery-frame-secondary-text-only"
                    implicitWidth: 460

                    MD.TabBar {
                        objectName: "tab-gallery-secondary-scrollable"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Secondary
                        layoutMode: MD.TabBar.Scrollable
                        MD.TabButton { text: qsTr("Details"); display: MD.TabButton.TextOnly }
                        MD.TabButton { text: qsTr("Reviews"); display: MD.TabButton.TextOnly }
                        MD.TabButton { text: qsTr("Related"); display: MD.TabButton.TextOnly }
                    }
                }

                Caption { text: qsTr("Text only") }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Scrollable, constrained, and disabled")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 440)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: scrollableFrame
                    objectName: "tab-gallery-frame-primary-scrollable"
                    implicitWidth: 460

                    MD.TabBar {
                        objectName: "tab-gallery-primary-scrollable"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        Accessible.name: qsTr("Scrollable primary destinations")
                        variant: MD.TabBar.Primary
                        layoutMode: MD.TabBar.Scrollable

                        MD.TabButton { text: qsTr("For you"); icon.name: MD.Symbols.home }
                        MD.TabButton { text: qsTr("Following"); icon.name: MD.Symbols.people }
                        MD.TabButton { text: qsTr("Downloads"); icon.name: MD.Symbols.download }
                        MD.TabButton { text: qsTr("History"); icon.name: MD.Symbols.history }
                        MD.TabButton { text: qsTr("Bookmarks"); icon.name: MD.Symbols.bookmark }
                    }
                }

                Caption { text: qsTr("Scrollable · natural destination widths") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: narrowFrame
                    objectName: "tab-gallery-frame-narrow"
                    implicitWidth: 180

                    MD.TabBar {
                        objectName: "tab-gallery-narrow"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        Accessible.name: qsTr("Narrow primary destinations")
                        variant: MD.TabBar.Primary
                        layoutMode: MD.TabBar.Fixed

                        MD.TabButton { text: qsTr("Overview"); icon.name: MD.Symbols.home }
                        MD.TabButton { text: qsTr("Activity"); icon.name: MD.Symbols.notifications }
                        MD.TabButton { text: qsTr("Saved"); icon.name: MD.Symbols.bookmark }
                        MD.TabButton { text: qsTr("Settings"); icon.name: MD.Symbols.settings }
                    }
                }

                Caption { text: qsTr("Fixed bar in a narrow width") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: disabledFrame
                    objectName: "tab-gallery-frame-disabled"
                    implicitWidth: 460

                    MD.TabBar {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Secondary
                        MD.TabButton { text: qsTr("Available") }
                        MD.TabButton { text: qsTr("Unavailable"); enabled: false }
                        MD.TabButton { text: qsTr("Also available") }
                    }
                }

                Caption { text: qsTr("Disabled destinations are skipped") }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Labels, badges, and accessibility")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 440)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: textAndIconFrame
                    objectName: "tab-gallery-frame-text-icon-only"
                    implicitWidth: 460

                    MD.TabBar {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Secondary
                        MD.TabButton { text: qsTr("Written label"); display: MD.TabButton.TextOnly }
                        MD.TabButton {
                            objectName: "tab-gallery-icon-only"
                            icon.name: MD.Symbols.settings
                            display: MD.TabButton.IconOnly
                            Accessible.name: qsTr("Settings")
                        }
                        MD.TabButton { text: qsTr("Long destination label that is elided") }
                    }
                }

                Caption { text: qsTr("Text-only, named icon-only, and elided") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: badgeFrame
                    objectName: "tab-gallery-frame-badges"
                    implicitWidth: 460

                    MD.TabBar {
                        objectName: "tab-gallery-badges"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Primary
                        MD.TabButton {
                            text: qsTr("Inbox")
                            icon.name: MD.Symbols.inbox
                            badgeContent: 8
                            badgeVariant: MD.Badge.Small
                            badgeAccessibleDescription: qsTr("8 unread messages")
                        }
                        MD.TabButton {
                            text: qsTr("Activity")
                            icon.name: MD.Symbols.notifications
                            badgeNotification: true
                            badgeAccessibleDescription: qsTr("New activity")
                        }
                        MD.TabButton {
                            text: qsTr("Updates")
                            icon.name: MD.Symbols.update
                            badgeContent: 1200
                            badgeVariant: MD.Badge.Large
                        }
                    }
                }

                Caption { text: qsTr("Count, notification, and large badge") }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Two-line labels and larger type")

        GridLayout {
            width: parent.width
            columns: width >= MD.Breakpoints.mediumLowerBound ? 2 : 1
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            MD.TabBar {
                id: twoLineBar
                objectName: "tab-gallery-frame-two-lines"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                variant: MD.TabBar.Primary

                MD.TabButton { text: qsTr("A longer destination label"); maximumLineCount: 2 }
                MD.TabButton { text: qsTr("Another section with a long name"); maximumLineCount: 2 }
                MD.TabButton { text: qsTr("Recent"); icon.name: MD.Symbols.history }
            }

            MD.TabBar {
                id: largeTypeBar
                objectName: "tab-gallery-frame-large-type"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                variant: MD.TabBar.Primary

                MD.TabButton {
                    text: qsTr("Large type")
                    icon.name: MD.Symbols.textFields
                    font.pixelSize: 22
                }
                MD.TabButton { text: qsTr("Default type"); icon.name: MD.Symbols.settings }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Right-to-left and local theme overrides")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 440)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: rtlFrame
                    objectName: "tab-gallery-frame-rtl"
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true
                    implicitWidth: 460

                    MD.TabBar {
                        objectName: "tab-gallery-rtl"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Primary
                        layoutMode: MD.TabBar.Scrollable
                        MD.TabButton { text: qsTr("Home"); icon.name: MD.Symbols.home }
                        MD.TabButton { text: qsTr("Explore"); icon.name: MD.Symbols.explore }
                        MD.TabButton { text: qsTr("Library"); icon.name: MD.Symbols.bookmark }
                    }
                }

                Caption { text: qsTr("Right-to-left · mirrored scroll origin") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: localLightFrame
                    objectName: "tab-gallery-frame-local-light-style"
                    implicitWidth: 460
                    MD.Style.theme: MD.Style.Light

                    MD.TabBar {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Secondary
                        MD.TabButton { text: qsTr("Light preview"); icon.name: MD.Symbols.lightMode }
                        MD.TabButton { text: qsTr("Inherited style"); icon.name: MD.Symbols.palette }
                    }
                }

                Caption { text: qsTr("Local light style inherited by descendants") }
            }

            ColumnLayout {
                spacing: page.compactSpacing

                ExampleFrame {
                    id: localStyleFrame
                    objectName: "tab-gallery-frame-local-style"
                    implicitWidth: 460
                    MD.Style.theme: MD.Style.Dark

                    MD.TabBar {
                        objectName: "tab-gallery-theme"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        variant: MD.TabBar.Secondary
                        MD.TabButton { text: qsTr("Dark preview"); icon.name: MD.Symbols.darkMode }
                        MD.TabButton { text: qsTr("Inherited style"); icon.name: MD.Symbols.palette }
                    }
                }

                Caption { text: qsTr("Local dark style inherited by descendants") }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Primary and secondary hierarchy · swipeable content")

        ColumnLayout {
            width: parent.width
            spacing: 0

            MD.TabBar {
                id: hierarchyPrimary
                objectName: "tab-gallery-primary-secondary"
                Layout.fillWidth: true
                variant: MD.TabBar.Primary
                MD.TabButton { text: qsTr("Overview"); icon.name: MD.Symbols.home }
                MD.TabButton { text: qsTr("Details"); icon.name: MD.Symbols.info }
            }

            MD.TabBar {
                id: hierarchySecondary
                objectName: "tab-gallery-secondary-in-hierarchy"
                Layout.fillWidth: true
                variant: MD.TabBar.Secondary
                currentIndex: pages.currentIndex
                onCurrentIndexChanged: pages.setCurrentIndex(currentIndex)
                MD.TabButton { text: qsTr("Summary") }
                MD.TabButton { text: qsTr("Reviews") }
                MD.TabButton { text: qsTr("Related") }
            }

            QC.SwipeView {
                id: pages
                objectName: "tab-gallery-swipe"
                clip: true
                Layout.fillWidth: true
                Layout.preferredHeight: 180

                MD.Label { Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter; text: qsTr("Summary page") }
                MD.Label { Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter; text: qsTr("Reviews page") }
                MD.Label { Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter; text: qsTr("Related page") }
            }
        }
    }
}
