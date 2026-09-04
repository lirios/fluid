// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    component LargeLabel: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
    }

    component DemoFAB: MD.FAB {
        Layout.margins: page.compactSpacing
        text: qsTr("FAB action")
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Floating action buttons")
        description: qsTr("Floating action buttons emphasize a high-priority action with size, color, elevation, and extended-label options.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Sizes")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 112)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        size: MD.FAB.Size.Default
                        icon.name: MD.Symbols.add
                    }

                    LargeLabel {
                        text: qsTr("FAB")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        size: MD.FAB.Size.Medium
                        icon.name: MD.Symbols.add
                    }

                    LargeLabel {
                        text: qsTr("Medium FAB")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        size: MD.FAB.Size.Large
                        icon.name: MD.Symbols.add
                    }

                    LargeLabel {
                        text: qsTr("Large FAB")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Color variants")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(4, Math.floor(width / 104)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        variant: MD.FAB.Variant.Surface
                        icon.name: MD.Symbols.edit
                    }

                    LargeLabel {
                        text: qsTr("Surface")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        variant: MD.FAB.Variant.Primary
                        icon.name: MD.Symbols.edit
                    }

                    LargeLabel {
                        text: qsTr("Primary")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        variant: MD.FAB.Variant.Secondary
                        icon.name: MD.Symbols.edit
                    }

                    LargeLabel {
                        text: qsTr("Secondary")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        variant: MD.FAB.Variant.Tertiary
                        icon.name: MD.Symbols.edit
                    }

                    LargeLabel {
                        text: qsTr("Tertiary")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Elevation")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(2, Math.floor(width / 112)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        icon.name: MD.Symbols.navigation
                    }

                    LargeLabel {
                        text: qsTr("Default")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoFAB {
                        Layout.alignment: Qt.AlignHCenter
                        lowered: true
                        icon.name: MD.Symbols.navigation
                    }

                    LargeLabel {
                        text: qsTr("Lowered")
                    }
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
                    columns: Math.max(1, Math.floor(width / 160))
                    columnSpacing: page.contentSpacing
                    rowSpacing: page.contentSpacing

                    MD.Switch {
                        id: enabledSwitch

                        text: qsTr("Enabled")
                        checked: true
                    }

                    MD.Switch {
                        id: loweredSwitch

                        text: qsTr("Lowered")
                    }

                    DemoFAB {
                        id: interactiveFAB

                        enabled: enabledSwitch.checked
                        lowered: loweredSwitch.checked
                        icon.name: MD.Symbols.add

                        onClicked: page.clickCount++
                    }

                    LargeLabel {
                        text: qsTr("Activated %1 time(s)").arg(page.clickCount)
                    }
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.floor(width / 160))
                    columnSpacing: page.contentSpacing
                    rowSpacing: page.contentSpacing

                    MD.Switch {
                        id: mirrorSwitch

                        text: qsTr("Mirror icon in RTL")
                        checked: true
                    }

                    DemoFAB {
                        text: qsTr("Custom colors")
                        containerColor: MD.Style.errorContainerColor
                        contentColor: MD.Style.onErrorContainerColor
                        icon.name: MD.Symbols.priorityHigh
                    }

                    DemoFAB {
                        text: qsTr("Source image")
                        icon.source: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                    }

                    DemoFAB {
                        text: qsTr("Forward")
                        mirrorIconInRtl: mirrorSwitch.checked
                        icon.name: MD.Symbols.arrowForward
                        LayoutMirroring.enabled: true
                    }
                }
            }
        }
    }

    property int clickCount: 0
}
