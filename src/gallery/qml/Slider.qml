// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

MD.ScrollView {
    id: scrollView

    readonly property int contentSpacing: 16
    readonly property int sectionSpacing: 24

    Flow {
        id: flow

        x: scrollView.sectionSpacing
        y: scrollView.sectionSpacing
        width: scrollView.availableWidth - scrollView.sectionSpacing * 2
        spacing: scrollView.sectionSpacing

        readonly property int minCardWidth: 420
        readonly property int columns: Math.max(1, Math.floor((width + spacing) / (minCardWidth + spacing)))
        readonly property real cardWidth: (width - spacing * (columns - 1)) / columns

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Standard, Centered, and Range")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                Repeater {
                    model: [
                        {
                            label: qsTr("Continuous"),
                            step: 0,
                            centered: false
                        },
                        {
                            label: qsTr("Stops"),
                            step: 10,
                            centered: false
                        },
                        {
                            label: qsTr("Centered below midpoint"),
                            step: 0,
                            centered: true,
                            value: 25
                        },
                        {
                            label: qsTr("Centered above midpoint"),
                            step: 0,
                            centered: true,
                            value: 75
                        }
                    ]

                    delegate: RowLayout {
                        id: variantRow

                        required property var modelData

                        Layout.fillWidth: true
                        spacing: scrollView.sectionSpacing

                        MD.Label {
                            Layout.preferredWidth: 200
                            text: variantRow.modelData.label
                        }

                        MD.Slider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: variantRow.modelData.value ?? 40
                            stepSize: variantRow.modelData.step
                            centered: variantRow.modelData.centered
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: scrollView.sectionSpacing

                    MD.Label {
                        Layout.preferredWidth: 200
                        text: qsTr("Range")
                    }

                    MD.RangeSlider {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        first.value: 25
                        second.value: 75
                    }
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("All Sizes")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                Repeater {
                    model: [
                        {
                            label: qsTr("Extra Small"),
                            sliderSize: MD.Slider.Size.ExtraSmall
                        },
                        {
                            label: qsTr("Small"),
                            sliderSize: MD.Slider.Size.Small
                        },
                        {
                            label: qsTr("Medium"),
                            sliderSize: MD.Slider.Size.Medium
                        },
                        {
                            label: qsTr("Large"),
                            sliderSize: MD.Slider.Size.Large
                        },
                        {
                            label: qsTr("Extra Large"),
                            sliderSize: MD.Slider.Size.ExtraLarge
                        }
                    ]

                    delegate: RowLayout {
                        id: sizeRow

                        required property var modelData

                        Layout.fillWidth: true
                        spacing: scrollView.sectionSpacing

                        MD.Label {
                            Layout.preferredWidth: 200
                            text: sizeRow.modelData.label
                        }

                        MD.Slider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 40
                            size: sizeRow.modelData.sliderSize
                        }
                    }
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Inset Track Icons")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                Repeater {
                    model: [
                        {
                            label: qsTr("Medium"),
                            sliderSize: MD.Slider.Size.Medium
                        },
                        {
                            label: qsTr("Large"),
                            sliderSize: MD.Slider.Size.Large
                        },
                        {
                            label: qsTr("Extra Large"),
                            sliderSize: MD.Slider.Size.ExtraLarge
                        }
                    ]

                    delegate: RowLayout {
                        id: iconRow

                        required property var modelData

                        Layout.fillWidth: true
                        spacing: scrollView.sectionSpacing

                        MD.Label {
                            Layout.preferredWidth: 200
                            text: iconRow.modelData.label
                        }

                        MD.Slider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 50
                            size: iconRow.modelData.sliderSize
                            trackIconActiveStart: MD.SymbolNames.symbolVolumeUp
                            trackIconActiveEnd: MD.SymbolNames.symbolAdd
                            trackIconInactiveStart: MD.SymbolNames.symbolRemove
                            trackIconInactiveEnd: MD.SymbolNames.symbolVolumeOff
                        }
                    }
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Value Indicator Behaviors")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                Repeater {
                    model: [
                        {
                            label: qsTr("Floating"),
                            behavior: MD.Slider.LabelBehavior.Floating
                        },
                        {
                            label: qsTr("Within Bounds"),
                            behavior: MD.Slider.LabelBehavior.WithinBounds
                        },
                        {
                            label: qsTr("Visible"),
                            behavior: MD.Slider.LabelBehavior.Visible
                        },
                        {
                            label: qsTr("Gone"),
                            behavior: MD.Slider.LabelBehavior.Gone
                        }
                    ]

                    delegate: RowLayout {
                        id: labelRow

                        required property var modelData

                        Layout.fillWidth: true
                        spacing: scrollView.sectionSpacing

                        MD.Label {
                            Layout.preferredWidth: 200
                            text: labelRow.modelData.label
                        }

                        MD.Slider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 42.5
                            labelBehavior: labelRow.modelData.behavior
                        }
                    }
                }
            }
        }

        MD.GroupBox {
            width: flow.width
            title: qsTr("Orientation, Direction, and State")

            GridLayout {
                width: parent.width
                columns: 4
                columnSpacing: scrollView.sectionSpacing
                rowSpacing: scrollView.contentSpacing

                MD.Label {
                    text: qsTr("LTR")
                }

                MD.Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 40
                    stepSize: 10
                }

                MD.Label {
                    text: qsTr("RTL")
                }

                MD.Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 40
                    stepSize: 10
                    LayoutMirroring.enabled: true
                }

                MD.Label {
                    text: qsTr("Vertical LTR")
                }

                MD.Slider {
                    Layout.preferredHeight: 200
                    orientation: Qt.Vertical
                    from: 0
                    to: 100
                    value: 35
                    centered: true
                    labelBehavior: MD.Slider.LabelBehavior.Visible
                }

                MD.Label {
                    text: qsTr("Vertical RTL")
                }

                MD.Slider {
                    Layout.preferredHeight: 200
                    orientation: Qt.Vertical
                    from: 0
                    to: 100
                    value: 65
                    centered: true
                    labelBehavior: MD.Slider.LabelBehavior.Visible
                    LayoutMirroring.enabled: true
                }

                MD.Label {
                    text: qsTr("Disabled")
                }

                MD.Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 40
                    stepSize: 10
                    enabled: false
                }

                MD.Label {
                    text: qsTr("Disabled Centered")
                }

                MD.Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 75
                    centered: true
                    enabled: false
                }
            }
        }

        MD.GroupBox {
            width: flow.cardWidth
            title: qsTr("Tick Visibility")

            ColumnLayout {
                width: parent.width
                spacing: scrollView.contentSpacing

                Repeater {
                    model: [
                        {
                            label: qsTr("Auto Limit"),
                            mode: MD.Slider.TickVisibilityMode.AutoLimit,
                            step: 1
                        },
                        {
                            label: qsTr("Auto Hide"),
                            mode: MD.Slider.TickVisibilityMode.AutoHide,
                            step: 1
                        },
                        {
                            label: qsTr("Hidden"),
                            mode: MD.Slider.TickVisibilityMode.Hidden,
                            step: 10
                        }
                    ]

                    delegate: RowLayout {
                        id: tickRow

                        required property var modelData

                        Layout.fillWidth: true
                        spacing: scrollView.sectionSpacing

                        MD.Label {
                            Layout.preferredWidth: 200
                            text: tickRow.modelData.label
                        }

                        MD.Slider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 40
                            stepSize: tickRow.modelData.step
                            tickVisibilityMode: tickRow.modelData.mode
                        }
                    }
                }
            }
        }
    }
}
