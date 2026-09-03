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

    property int clickCount: 0

    component LargeLabel: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
    }

    component DemoExtendedFAB: MD.ExtendedFAB {
        Layout.alignment: Qt.AlignHCenter
        Layout.margins: page.compactSpacing
        text: qsTr("Create")
        icon.name: MD.SymbolNames.symbolAdd
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Extended floating action buttons")
        description: qsTr("Extended floating action buttons pair an icon with a label for a prominent action and can collapse when space is limited.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Sizes")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 200)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoExtendedFAB {
                        size: MD.ExtendedFAB.Size.Default
                    }

                    LargeLabel {
                        text: qsTr("Extended FAB")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoExtendedFAB {
                        size: MD.ExtendedFAB.Size.Medium
                    }

                    LargeLabel {
                        text: qsTr("Medium extended FAB")
                    }
                }

                ColumnLayout {
                    spacing: page.compactSpacing

                    DemoExtendedFAB {
                        size: MD.ExtendedFAB.Size.Large
                    }

                    LargeLabel {
                        text: qsTr("Large extended FAB")
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Color variants")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(4, Math.floor(width / 176)))
                columnSpacing: page.sectionSpacing
                rowSpacing: page.sectionSpacing

                DemoExtendedFAB {
                    text: qsTr("Surface")
                    variant: MD.ExtendedFAB.Variant.Surface
                    icon.name: MD.SymbolNames.symbolEdit
                }

                DemoExtendedFAB {
                    text: qsTr("Primary")
                    variant: MD.ExtendedFAB.Variant.Primary
                    icon.name: MD.SymbolNames.symbolEdit
                }

                DemoExtendedFAB {
                    text: qsTr("Secondary")
                    variant: MD.ExtendedFAB.Variant.Secondary
                    icon.name: MD.SymbolNames.symbolEdit
                }

                DemoExtendedFAB {
                    text: qsTr("Tertiary")
                    variant: MD.ExtendedFAB.Variant.Tertiary
                    icon.name: MD.SymbolNames.symbolEdit
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

                DemoExtendedFAB {
                    expanded: expandedSwitch.checked
                    text: qsTr("Compose")
                    icon.name: MD.SymbolNames.symbolEdit
                }
            }
        }

        GalleryCard {
            id: propertiesCard
            objectName: "extendedFabPropertiesCard"
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Properties")

            Column {
                width: propertiesCard.availableWidth
                spacing: page.contentSpacing

                RowLayout {
                    objectName: "extendedFabPropertyControlsGrid"

                    width: parent.width
                    spacing: page.compactSpacing

                    MD.Switch {
                        id: enabledSwitch
                        objectName: "extendedFabEnabledSwitch"

                        text: qsTr("Enabled")
                        checked: true
                    }

                    MD.Switch {
                        id: loweredSwitch
                        objectName: "extendedFabLoweredSwitch"

                        text: qsTr("Lowered")
                    }

                    DemoExtendedFAB {
                        objectName: "extendedFabInteractiveExample"
                        Layout.margins: 0
                        enabled: enabledSwitch.checked
                        lowered: loweredSwitch.checked

                        onClicked: page.clickCount++
                    }

                    LargeLabel {
                        objectName: "extendedFabActivationCount"
                        Layout.fillWidth: true
                        text: qsTr("Clicks: %1").arg(page.clickCount)
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                    }
                }

                GridLayout {
                    objectName: "extendedFabPropertyExamplesGrid"

                    width: parent.width
                    columns: Math.max(1, Math.floor(width / 220))
                    columnSpacing: page.contentSpacing
                    rowSpacing: page.contentSpacing

                    DemoExtendedFAB {
                        objectName: "extendedFabCustomColorsExample"
                        text: qsTr("Custom colors")
                        containerColor: MD.Style.errorContainerColor
                        contentColor: MD.Style.onErrorContainerColor
                        icon.name: MD.SymbolNames.symbolPriorityHigh
                    }

                    DemoExtendedFAB {
                        objectName: "extendedFabTextOnlyExample"
                        text: qsTr("Text only stays extended")
                        expanded: false
                        icon.name: ""
                    }

                    DemoExtendedFAB {
                        objectName: "extendedFabRtlExample"
                        text: qsTr("Forward")
                        icon.name: MD.SymbolNames.symbolArrowForward
                        LayoutMirroring.enabled: true
                    }
                }
            }
        }
    }
}
