// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    component Headline: MD.Label {
        typescale: MD.Tokens.typescale.headlineMedium
    }

    component LargeLabel: MD.Label {
        Layout.alignment: Qt.AlignHCenter
        typescale: MD.Tokens.typescale.labelLarge
    }

    component DemoFAB: MD.FAB {
        Layout.margins: MD.Tokens.spacingSmall
        text: icon.name.length > 0 ? icon.name.replace(/_/g, " ") : qsTr("FAB action")
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: MD.Tokens.spacingLarge

            Headline {
                text: qsTr("Floating Action Button")
            }

            MD.GroupBox {
                title: qsTr("Sizes")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: MD.Tokens.spacingLarge

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            size: MD.FAB.Size.Default
                            icon.name: "add"
                        }

                        LargeLabel {
                            text: qsTr("FAB")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            size: MD.FAB.Size.Medium
                            icon.name: "add"
                        }

                        LargeLabel {
                            text: qsTr("Medium FAB")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            size: MD.FAB.Size.Large
                            icon.name: "add"
                        }

                        LargeLabel {
                            text: qsTr("Large FAB")
                        }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Color variants")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: MD.Tokens.spacingLarge

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            variant: MD.FAB.Variant.Surface
                            icon.name: "edit"
                        }

                        LargeLabel {
                            text: qsTr("Surface")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            variant: MD.FAB.Variant.Primary
                            icon.name: "edit"
                        }

                        LargeLabel {
                            text: qsTr("Primary")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            variant: MD.FAB.Variant.Secondary
                            icon.name: "edit"
                        }

                        LargeLabel {
                            text: qsTr("Secondary")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            variant: MD.FAB.Variant.Tertiary
                            icon.name: "edit"
                        }

                        LargeLabel {
                            text: qsTr("Tertiary")
                        }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Elevation")

                RowLayout {
                    anchors.centerIn: parent
                    spacing: MD.Tokens.spacingLarge

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            icon.name: "navigation"
                        }

                        LargeLabel {
                            text: qsTr("Default")
                        }
                    }

                    ColumnLayout {
                        spacing: MD.Tokens.spacingSmall

                        DemoFAB {
                            Layout.alignment: Qt.AlignHCenter
                            lowered: true
                            icon.name: "navigation"
                        }

                        LargeLabel {
                            text: qsTr("Lowered")
                        }
                    }
                }
            }

            MD.GroupBox {
                title: qsTr("Properties")

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: MD.Tokens.spacingMedium

                    RowLayout {
                        spacing: MD.Tokens.spacingMedium

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
                            icon.name: "add"

                            onClicked: page.clickCount++
                        }

                        LargeLabel {
                            text: qsTr("Activated %1 time(s)").arg(page.clickCount)
                        }
                    }

                    RowLayout {
                        spacing: MD.Tokens.spacingMedium

                        MD.Switch {
                            id: mirrorSwitch

                            text: qsTr("Mirror icon in RTL")
                            checked: true
                        }

                        DemoFAB {
                            text: qsTr("Custom colors")
                            containerColor: MD.Style.errorContainerColor
                            contentColor: MD.Style.onErrorContainerColor
                            icon.name: "priority_high"
                        }

                        DemoFAB {
                            text: qsTr("Source image")
                            icon.source: "qrc:/icons/32x32/apps/io.liri.Fluid.Gallery.png"
                        }

                        DemoFAB {
                            text: qsTr("Forward")
                            mirrorIconInRtl: mirrorSwitch.checked
                            icon.name: "arrow_forward"
                            LayoutMirroring.enabled: true
                        }
                    }
                }
            }
        }
    }

    property int clickCount: 0
}
