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
        Accessible.name: text.length > 0 ? text : qsTr("FAB action")
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Floating action buttons")
        description: qsTr("Floating action buttons emphasize a high-priority action with size, color, elevation, and extended-label options.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Icon-only sizes")

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
            title: qsTr("Icon-only color variants")

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
            title: qsTr("Labeled sizes")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 200)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                DemoFAB {
                    Layout.alignment: Qt.AlignHCenter
                    size: MD.FAB.Size.Default
                    text: qsTr("Create")
                    icon.name: MD.Symbols.add
                }

                DemoFAB {
                    Layout.alignment: Qt.AlignHCenter
                    size: MD.FAB.Size.Medium
                    text: qsTr("Create")
                    icon.name: MD.Symbols.add
                }

                DemoFAB {
                    Layout.alignment: Qt.AlignHCenter
                    size: MD.FAB.Size.Large
                    text: qsTr("Create")
                    icon.name: MD.Symbols.add
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Labeled color variants")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(4, Math.floor(width / 176)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                DemoFAB {
                    text: qsTr("Surface")
                    variant: MD.FAB.Variant.Surface
                    icon.name: MD.Symbols.edit
                }

                DemoFAB {
                    text: qsTr("Primary")
                    variant: MD.FAB.Variant.Primary
                    icon.name: MD.Symbols.edit
                }

                DemoFAB {
                    text: qsTr("Secondary")
                    variant: MD.FAB.Variant.Secondary
                    icon.name: MD.Symbols.edit
                }

                DemoFAB {
                    text: qsTr("Tertiary")
                    variant: MD.FAB.Variant.Tertiary
                    icon.name: MD.Symbols.edit
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Expansion")

            RowLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.Switch {
                    id: expandedSwitch

                    text: qsTr("Expanded")
                    checked: true
                }

                DemoFAB {
                    expanded: expandedSwitch.checked
                    text: qsTr("Compose")
                    icon.name: MD.Symbols.edit
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
            id: propertiesCard
            objectName: "fabPropertiesCard"
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Properties")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                RowLayout {
                    objectName: "fabPropertyControlsGrid"
                    Layout.fillWidth: true
                    spacing: page.compactSpacing

                    MD.Switch {
                        id: enabledSwitch
                        objectName: "fabEnabledSwitch"

                        text: qsTr("Enabled")
                        checked: true
                    }

                    MD.Switch {
                        id: loweredSwitch
                        objectName: "fabLoweredSwitch"

                        text: qsTr("Lowered")
                    }

                    DemoFAB {
                        id: interactiveFAB
                        objectName: "fabInteractiveExample"

                        enabled: enabledSwitch.checked
                        lowered: loweredSwitch.checked
                        icon.name: MD.Symbols.add

                        onClicked: page.clickCount++
                    }

                    LargeLabel {
                        objectName: "fabActivationCount"
                        Layout.fillWidth: true
                        text: qsTr("Activated %1 time(s)").arg(page.clickCount)
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                    }
                }

                GridLayout {
                    objectName: "fabPropertyExamplesGrid"
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
                        objectName: "fabCustomColorsExample"
                        Accessible.name: qsTr("Custom colors")
                        containerColor: MD.Style.errorContainerColor
                        contentColor: MD.Style.onErrorContainerColor
                        icon.name: MD.Symbols.priorityHigh
                    }

                    DemoFAB {
                        objectName: "fabSourceImageExample"
                        Accessible.name: qsTr("Source image")
                        icon.source: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                    }

                    DemoFAB {
                        objectName: "fabMirroredIconExample"
                        Accessible.name: qsTr("Forward")
                        mirrorIconInRtl: mirrorSwitch.checked
                        icon.name: MD.Symbols.arrowForward
                        LayoutMirroring.enabled: true
                    }

                    DemoFAB {
                        objectName: "fabLabeledSourceImageExample"
                        text: qsTr("Source image")
                        icon.source: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                    }

                    DemoFAB {
                        objectName: "fabRtlLabelExample"
                        text: qsTr("Forward")
                        icon.name: MD.Symbols.arrowForward
                        LayoutMirroring.enabled: true
                    }

                    DemoFAB {
                        objectName: "fabTextOnlyExample"
                        text: qsTr("Text only stays extended")
                        expanded: false
                    }

                    DemoFAB {
                        objectName: "fabDisabledExample"
                        text: qsTr("Disabled")
                        icon.name: MD.Symbols.block
                        enabled: false
                    }
                }
            }
        }
    }

    property int clickCount: 0
}
