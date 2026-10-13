// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import Fluid as MD

GalleryPage {
    id: page

    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    property bool updatesUnread: true

    readonly property MD.AppBarAction searchAction: MD.AppBarAction {
        text: qsTr("Search")
        icon.name: MD.Symbols.search
        badgeNotification: true
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    readonly property MD.AppBarAction unreadAction: MD.AppBarAction {
        text: qsTr("Unread")
        icon.name: MD.Symbols.mail
        badgeContent: 1000
        badgeAccessibleDescription: qsTr("1000 unread messages")
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }
    readonly property MD.AppBarAction narrowUnreadAction: MD.AppBarAction {
        text: qsTr("Unread")
        icon.name: MD.Symbols.mail
        badgeContent: 1000
        overflowPolicy: MD.AppBarAction.NeverOverflow
    }

    headline: qsTr("Badges")
    description: qsTr("Badges show concise status and notification counts beside an icon or label. They are passive; the host control owns interaction and state.")

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Badge variants")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(4, Math.floor(width / 140)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.contentSpacing

            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { variant: MD.Badge.Small }
                MD.Label { text: qsTr("Small dot"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { variant: MD.Badge.Large }
                MD.Label { text: qsTr("Large empty"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { count: 7 }
                MD.Label { text: qsTr("Count"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { count: 1200 }
                MD.Label { text: qsTr("Overflow"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { text: qsTr("NEW") }
                MD.Label { text: qsTr("Status"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { text: qsTr("A👩‍👩‍👧‍👦BCD") }
                MD.Label { text: qsTr("Grapheme elision"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge { count: 0 }
                MD.Label { text: qsTr("Zero"); typescale: MD.Tokens.typescale.labelMedium }
            }
            ColumnLayout {
                spacing: page.compactSpacing
                MD.Badge {
                    text: qsTr("A much longer status")
                    typescale: MD.Tokens.typescale.titleLarge
                }
                MD.Label { text: qsTr("Larger type scale"); typescale: MD.Tokens.typescale.labelMedium }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Icon actions and navigation")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(2, Math.floor(width / 340)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.contentSpacing
                MD.IconButton {
                    objectName: "badge-unread-count-action"
                    icon.name: MD.Symbols.mail
                    text: qsTr("Inbox")
                    badgeContent: unreadMessages.checked ? 12 : ""
                    badgeAccessibleDescription: unreadMessages.checked ? qsTr("12 unread messages") : ""
                }
                MD.Switch {
                    id: unreadMessages
                    objectName: "badge-unread-count-toggle"
                    text: qsTr("Unread messages")
                    checked: true
                }
                MD.IconButton {
                    icon.name: MD.Symbols.notifications
                    text: qsTr("Notifications")
                    badgeNotification: true
                }
                MD.IconButton {
                    enabled: false
                    icon.name: MD.Symbols.mail
                    text: qsTr("Disabled inbox")
                    badgeContent: 3
                }
                MD.IconButton {
                    icon.name: MD.Symbols.shoppingCart
                    text: qsTr("Cart")
                    badgeContent: "NEW"
                    badgeVisible: visibleBadge.checked
                }
                MD.Switch {
                    id: updatesReset
                    objectName: "badge-updates-reset"
                    text: qsTr("New updates available")
                    checked: page.updatesUnread
                    onToggled: page.updatesUnread = checked
                }
                MD.Switch {
                    id: visibleBadge
                    objectName: "badge-status-visibility"
                    text: qsTr("Show the status badge")
                    checked: true
                }
            }

            MD.NavigationRail {
                Accessible.name: qsTr("Example navigation")
                expanded: false
                MD.NavigationRailItem {
                    text: qsTr("Messages")
                    icon.name: MD.Symbols.mail
                    badgeContent: 5
                    badgeAccessibleDescription: qsTr("5 unread messages")
                }
                MD.NavigationRailItem {
                    id: updatesDestination
                    objectName: "badge-updates-destination"
                    text: qsTr("Updates")
                    icon.name: MD.Symbols.notifications
                    badgeNotification: page.updatesUnread
                    onClicked: page.updatesUnread = false
                }
                MD.NavigationRailItem {
                    text: qsTr("Downloads")
                    icon.name: MD.Symbols.download
                    badgeContent: "NEW"
                    enabled: false
                }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Expanded navigation and tab composition")

        ColumnLayout {
            width: parent.width
            spacing: page.sectionSpacing

            MD.NavigationRail {
                Layout.preferredHeight: 380
                Accessible.name: qsTr("Expanded example navigation")
                expanded: true
                MD.NavigationRailItem {
                    text: qsTr("Messages")
                    icon.name: MD.Symbols.mail
                    badgeContent: 18
                }
                MD.NavigationRailItem {
                    text: qsTr("Downloads")
                    icon.name: MD.Symbols.download
                    badgeContent: 1000
                    enabled: false
                }
            }

            // A generic template composition; use MD.TabBar for tab navigation.
            RowLayout {
                id: sampleTabs
                Layout.fillWidth: true
                spacing: page.sectionSpacing

                T.TabButton {
                    id: mailTab
                    objectName: "badge-mail-tab"
                    text: qsTr("Mail")
                    Accessible.name: text + (mailTabBadge.visible && mailTabBadge.accessibleDescription.length > 0
                                            ? ", " + mailTabBadge.accessibleDescription : "")
                    // PageTab needs an explicit press action routed through the button template.
                    Accessible.onPressAction: mailTab.click()
                    padding: page.contentSpacing
                    implicitWidth: implicitContentWidth + leftPadding + rightPadding
                    implicitHeight: implicitContentHeight + topPadding + bottomPadding
                    contentItem: ColumnLayout {
                        spacing: page.compactSpacing
                        Item {
                            Layout.alignment: Qt.AlignHCenter
                            implicitWidth: tabIcon.implicitWidth
                            implicitHeight: tabIcon.implicitHeight
                            MD.Symbol {
                                id: tabIcon
                                objectName: "badge-mail-tab-icon"
                                anchors.centerIn: parent
                                name: MD.Symbols.mail
                            }
                            MD.BadgeOverlay {
                                id: mailTabBadge
                                objectName: "badge-mail-tab-overlay"
                                target: tabIcon
                                layoutMirrored: mailTab.mirrored
                                variant: MD.Badge.Small
                            }
                        }
                        MD.Label {
                            objectName: "badge-mail-tab-label"
                            Layout.alignment: Qt.AlignHCenter
                            text: mailTab.text
                            Accessible.ignored: true
                        }
                    }
                }
                T.TabButton {
                    id: activityTab
                    objectName: "badge-activity-tab"
                    text: qsTr("Activity")
                    Accessible.name: text + (activityTabBadge.visible && activityTabBadge.accessibleDescription.length > 0
                                            ? ", " + activityTabBadge.accessibleDescription : "")
                    Accessible.onPressAction: activityTab.click()
                    padding: page.contentSpacing
                    implicitWidth: implicitContentWidth + leftPadding + rightPadding
                    implicitHeight: implicitContentHeight + topPadding + bottomPadding
                    contentItem: RowLayout {
                        spacing: page.compactSpacing
                        MD.Label {
                            objectName: "badge-activity-tab-label"
                            text: activityTab.text
                            Accessible.ignored: true
                        }
                        MD.Badge {
                            id: activityTabBadge
                            objectName: "badge-activity-tab-trailing"
                            count: 4
                        }
                    }
                }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("Direction and theme")

        Flow {
            width: parent.width
            spacing: page.sectionSpacing

            Item {
                width: 160
                height: 72
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true

                MD.Symbol {
                    id: rtlIconBounds
                    x: 52
                    y: 24
                    name: MD.Symbols.mail
                }
                MD.BadgeOverlay {
                    target: rtlIconBounds
                    layoutMirrored: true
                    variant: MD.Badge.Small
                    Accessible.ignored: true
                }
            }

            MD.IconButton {
                MD.Style.theme: MD.Style.Light
                icon.name: MD.Symbols.notifications
                text: qsTr("Light theme")
                badgeContent: 3
            }
            MD.IconButton {
                MD.Style.theme: MD.Style.Dark
                icon.name: MD.Symbols.notifications
                text: qsTr("Dark theme")
                badgeContent: 8
            }
            Item {
                width: 70
                height: 56
                clip: true
                MD.BadgeOverlay {
                    target: clippedIconBounds
                    count: 99
                }
                MD.Symbol {
                    id: clippedIconBounds
                    x: 46
                    y: 16
                    name: MD.Symbols.download
                }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        fullWidth: true
        title: qsTr("App bar actions")

        ColumnLayout {
            width: parent.width
            spacing: page.sectionSpacing

            MD.AppBar {
                objectName: "badge-app-bar-wide"
                Layout.fillWidth: true
                title: qsTr("Inbox")
                actions: [page.searchAction, page.unreadAction]
            }

            MD.AppBar {
                objectName: "badge-app-bar-narrow"
                Layout.preferredWidth: Math.min(320, parent.width)
                title: qsTr("Narrow inbox")
                actions: [page.narrowUnreadAction]
            }
        }
    }
}
