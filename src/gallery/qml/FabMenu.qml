// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \internal
    \brief Gallery page demonstrating the Material 3 Expressive FAB menu.

    The page covers every color variant, both expand directions, logical
    alignment including right-to-left mirroring, item states such as disabled,
    image sourced and custom colored items, and an interactive group that drives
    the menu through its own \c toggle() method.

    A FAB menu fills its host and expands into it, so every example lives in a
    fixed size framed host rather than filling the page.
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

    component DemoFrame: Rectangle {
        Layout.alignment: Qt.AlignHCenter

        implicitWidth: 240
        implicitHeight: 300

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
        headline: qsTr("FAB menus")
        description: qsTr("FAB menus expand a floating action button into related actions with configurable color, direction, alignment, and state.")

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Color variants")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 260)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            variant: MD.FabMenu.Variant.Primary
                            text: qsTr("Primary actions")

                            MD.FabMenuItem {
                                text: qsTr("Share")
                                icon.name: "share"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Edit")
                                icon.name: "edit"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Delete")
                                icon.name: "delete"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Primary")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            variant: MD.FabMenu.Variant.Secondary
                            text: qsTr("Secondary actions")

                            MD.FabMenuItem {
                                text: qsTr("Share")
                                icon.name: "share"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Edit")
                                icon.name: "edit"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Delete")
                                icon.name: "delete"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Secondary")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            variant: MD.FabMenu.Variant.Tertiary
                            text: qsTr("Tertiary actions")

                            MD.FabMenuItem {
                                text: qsTr("Share")
                                icon.name: "share"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Edit")
                                icon.name: "edit"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Delete")
                                icon.name: "delete"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Tertiary")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Expand direction")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(2, Math.floor(width / 260)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            direction: MD.FabMenu.Direction.Up
                            text: qsTr("Expand upwards")

                            MD.FabMenuItem {
                                text: qsTr("Photo")
                                icon.name: "photo_camera"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Video")
                                icon.name: "videocam"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Audio")
                                icon.name: "mic"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Up")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            direction: MD.FabMenu.Direction.Down
                            text: qsTr("Expand downwards")

                            MD.FabMenuItem {
                                text: qsTr("Photo")
                                icon.name: "photo_camera"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Video")
                                icon.name: "videocam"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Audio")
                                icon.name: "mic"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Down")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Alignment and layout direction")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 260)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            alignment: Qt.AlignRight
                            text: qsTr("Aligned to the end")

                            MD.FabMenuItem {
                                text: qsTr("Reply")
                                icon.name: "reply"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Forward")
                                icon.name: "forward"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Right aligned")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        MD.FabMenu {
                            anchors.fill: parent

                            alignment: Qt.AlignLeft
                            text: qsTr("Aligned to the start")

                            MD.FabMenuItem {
                                text: qsTr("Reply")
                                icon.name: "reply"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Forward")
                                icon.name: "forward"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Left aligned")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFrame {
                        LayoutMirroring.enabled: true
                        LayoutMirroring.childrenInherit: true

                        MD.FabMenu {
                            anchors.fill: parent

                            alignment: Qt.AlignRight
                            text: qsTr("Mirrored actions")

                            MD.FabMenuItem {
                                text: qsTr("Reply")
                                icon.name: "reply"
                            }

                            MD.FabMenuItem {
                                text: qsTr("Forward")
                                icon.name: "forward"
                            }
                        }
                    }

                    LargeLabel {
                        text: qsTr("Right to left")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Item states")

            ColumnLayout {
                anchors.centerIn: parent
                spacing: page.compactSpacing

                DemoFrame {
                    implicitHeight: 360

                    MD.FabMenu {
                        anchors.fill: parent

                        variant: MD.FabMenu.Variant.Secondary
                        text: qsTr("Item states")

                        MD.FabMenuItem {
                            text: qsTr("Enabled")
                            icon.name: "check_circle"
                        }

                        MD.FabMenuItem {
                            text: qsTr("Disabled")
                            icon.name: "block"
                            enabled: false
                        }

                        MD.FabMenuItem {
                            text: qsTr("Source image")
                            icon.source: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                        }

                        MD.FabMenuItem {
                            text: qsTr("Custom colors")
                            icon.name: "priority_high"
                            containerColor: MD.Style.errorContainerColor
                            contentColor: MD.Style.onErrorContainerColor
                        }
                    }
                }

                LargeLabel {
                    text: qsTr("Disabled, image sourced and custom colored items")
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Properties")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.floor(width / 144))
                    columnSpacing: page.contentSpacing
                    rowSpacing: page.contentSpacing

                    MD.Switch {
                        id: enabledSwitch

                        text: qsTr("Enabled")
                        checked: true
                    }

                    MD.Switch {
                        id: scrimSwitch

                        text: qsTr("Scrim")
                        checked: true
                    }

                    MD.Switch {
                        id: downSwitch

                        text: qsTr("Expand down")
                    }

                    MD.Switch {
                        id: expandedSwitch

                        text: qsTr("Expanded")

                        // clicked is user-only: toggled also fires when the
                        // menu writes its state back, which would reopen it.
                        onClicked: interactiveMenu.expanded = expandedSwitch.checked
                    }
                }

                DemoFrame {
                    MD.FabMenu {
                        id: interactiveMenu

                        anchors.fill: parent

                        enabled: enabledSwitch.checked
                        scrim: scrimSwitch.checked
                        direction: downSwitch.checked ? MD.FabMenu.Direction.Down : MD.FabMenu.Direction.Up
                        text: qsTr("Interactive actions")

                        onExpandedChanged: expandedSwitch.checked = expanded

                        MD.FabMenuItem {
                            text: qsTr("Activate")
                            icon.name: "add"

                            onClicked: page.clickCount++
                        }

                        MD.FabMenuItem {
                            text: qsTr("Edit")
                            icon.name: "edit"
                        }

                        MD.FabMenuItem {
                            text: qsTr("Share")
                            icon.name: "share"
                        }
                    }
                }

                LargeLabel {
                    text: qsTr("Activated %1 time(s)").arg(page.clickCount)
                }
            }
        }
    }

    property int clickCount: 0
}
