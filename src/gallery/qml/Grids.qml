// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \internal
    \brief Gallery page demonstrating Material 3 adaptive grids and spacing.

    The page summarizes every width breakpoint, provides an interactive
    reference-width control, and visualizes the columns, margins, gutters, and
    responsive spans produced by AdaptiveGrid.
*/
Item {
    id: page

    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    readonly property real spaciousSpacing: MD.Tokens.measurement.space400

    readonly property var breakpointEntries: [
        {
            "breakpoint": MD.Breakpoints.Compact,
            "name": qsTr("Compact"),
            "range": qsTr("0–599 dp"),
            "columns": 4,
            "spacing": qsTr("16 dp")
        },
        {
            "breakpoint": MD.Breakpoints.Medium,
            "name": qsTr("Medium"),
            "range": qsTr("600–839 dp"),
            "columns": 8,
            "spacing": qsTr("24 dp")
        },
        {
            "breakpoint": MD.Breakpoints.Expanded,
            "name": qsTr("Expanded"),
            "range": qsTr("840–1199 dp"),
            "columns": 8,
            "spacing": qsTr("24 dp")
        },
        {
            "breakpoint": MD.Breakpoints.Large,
            "name": qsTr("Large"),
            "range": qsTr("1200–1599 dp"),
            "columns": 12,
            "spacing": qsTr("24 dp")
        },
        {
            "breakpoint": MD.Breakpoints.ExtraLarge,
            "name": qsTr("Extra large"),
            "range": qsTr("1600+ dp"),
            "columns": 12,
            "spacing": qsTr("24 dp")
        }
    ]

    function breakpointName(breakpoint) {
        switch (breakpoint) {
        case MD.Breakpoints.Medium:
            return qsTr("Medium");
        case MD.Breakpoints.Expanded:
            return qsTr("Expanded");
        case MD.Breakpoints.Large:
            return qsTr("Large");
        case MD.Breakpoints.ExtraLarge:
            return qsTr("Extra large");
        default:
            return qsTr("Compact");
        }
    }

    component BreakpointCard: Rectangle {
        id: breakpointCard

        required property int breakpoint
        required property string breakpointLabel
        required property string breakpointRange
        required property int columnCount
        required property string gridSpacing

        readonly property bool active: previewGrid.breakpoint === breakpointCard.breakpoint

        Layout.fillWidth: true
        Layout.preferredWidth: 156
        implicitHeight: 116

        color: active ? page.MD.Style.primaryContainerColor
                      : page.MD.Style.surfaceContainerLowColor
        border.width: active ? 2 : 1
        border.color: active ? page.MD.Style.primaryColor
                             : page.MD.Style.outlineVariantColor
        topLeftRadius: MD.Tokens.shape.cornerMedium.topLeft
        topRightRadius: MD.Tokens.shape.cornerMedium.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerMedium.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerMedium.bottomRight

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: page.contentSpacing
            spacing: MD.Tokens.measurement.space50

            MD.Label {
                Layout.fillWidth: true
                text: breakpointCard.breakpointLabel
                typescale: MD.Tokens.typescale.titleMedium
                color: breakpointCard.active ? page.MD.Style.onPrimaryContainerColor
                                             : page.MD.Style.onSurfaceColor
            }

            MD.Label {
                Layout.fillWidth: true
                text: breakpointCard.breakpointRange
                color: breakpointCard.active ? page.MD.Style.onPrimaryContainerColor
                                             : page.MD.Style.onSurfaceVariantColor
            }

            MD.Label {
                Layout.fillWidth: true
                text: qsTr("%1 columns · %2 spacing")
                          .arg(breakpointCard.columnCount)
                          .arg(breakpointCard.gridSpacing)
                typescale: MD.Tokens.typescale.labelMedium
                color: breakpointCard.active ? page.MD.Style.onPrimaryContainerColor
                                             : page.MD.Style.onSurfaceVariantColor
            }
        }
    }

    component Metric: Rectangle {
        id: metric

        required property string metricLabel
        required property string metricValue

        Layout.fillWidth: true
        Layout.preferredWidth: 148
        implicitHeight: 72

        color: page.MD.Style.surfaceContainerColor
        topLeftRadius: MD.Tokens.shape.cornerSmall.topLeft
        topRightRadius: MD.Tokens.shape.cornerSmall.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerSmall.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerSmall.bottomRight

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: page.compactSpacing
            spacing: MD.Tokens.measurement.space25

            MD.Label {
                Layout.fillWidth: true
                text: metric.metricLabel
                typescale: MD.Tokens.typescale.labelMedium
            }

            MD.Label {
                Layout.fillWidth: true
                text: metric.metricValue
                typescale: MD.Tokens.typescale.titleMedium
                color: page.MD.Style.onSurfaceColor
            }
        }
    }

    component ContentBlock: Rectangle {
        id: contentBlock

        required property string blockLabel
        property bool emphasized: false

        implicitHeight: 72
        color: emphasized ? page.MD.Style.primaryColor
                          : page.MD.Style.secondaryContainerColor
        topLeftRadius: MD.Tokens.shape.cornerSmall.topLeft
        topRightRadius: MD.Tokens.shape.cornerSmall.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerSmall.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerSmall.bottomRight

        MD.Label {
            anchors.centerIn: parent
            width: Math.max(0, parent.width - page.contentSpacing)
            horizontalAlignment: Text.AlignHCenter
            text: contentBlock.blockLabel
            typescale: MD.Tokens.typescale.labelLarge
            color: contentBlock.emphasized ? page.MD.Style.onPrimaryColor
                                           : page.MD.Style.onSecondaryContainerColor
        }
    }

    MD.ScrollView {
        id: scrollView

        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            id: content

            x: page.sectionSpacing
            width: Math.max(0, scrollView.availableWidth - page.sectionSpacing * 2)
            spacing: page.spaciousSpacing

            ColumnLayout {
                Layout.fillWidth: true
                spacing: page.compactSpacing

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Adaptive grids and spacing")
                    typescale: MD.Tokens.typescale.headlineMedium
                    color: page.MD.Style.onSurfaceColor
                }

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Material layouts use equal columns, margins, and gutters that adapt as the available width crosses a breakpoint.")
                    typescale: MD.Tokens.typescale.bodyLarge
                    color: page.MD.Style.onSurfaceVariantColor
                    wrapMode: Text.WordWrap
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: page.contentSpacing

                MD.Label {
                    text: qsTr("Breakpoint reference")
                    typescale: MD.Tokens.typescale.titleLarge
                    color: page.MD.Style.onSurfaceColor
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: Math.max(1, Math.min(5, Math.floor(width / 168)))
                    columnSpacing: page.contentSpacing
                    rowSpacing: page.contentSpacing

                    Repeater {
                        model: page.breakpointEntries

                        delegate: BreakpointCard {
                            required property var modelData

                            breakpoint: modelData.breakpoint
                            breakpointLabel: modelData.name
                            breakpointRange: modelData.range
                            columnCount: modelData.columns
                            gridSpacing: modelData.spacing
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: widthControls.implicitHeight + page.sectionSpacing * 2

                color: page.MD.Style.surfaceContainerLowColor
                topLeftRadius: MD.Tokens.shape.cornerLarge.topLeft
                topRightRadius: MD.Tokens.shape.cornerLarge.topRight
                bottomLeftRadius: MD.Tokens.shape.cornerLarge.bottomLeft
                bottomRightRadius: MD.Tokens.shape.cornerLarge.bottomRight

                ColumnLayout {
                    id: widthControls

                    anchors.fill: parent
                    anchors.margins: page.sectionSpacing
                    spacing: page.contentSpacing

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: page.contentSpacing

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: MD.Tokens.measurement.space25

                            MD.Label {
                                text: qsTr("Simulated reference width")
                                typescale: MD.Tokens.typescale.titleMedium
                                color: page.MD.Style.onSurfaceColor
                            }

                            MD.Label {
                                Layout.fillWidth: true
                                text: qsTr("Drag through every breakpoint; the preview is fitted to the gallery pane.")
                                color: page.MD.Style.onSurfaceVariantColor
                                wrapMode: Text.WordWrap
                            }
                        }

                        MD.Label {
                            text: qsTr("%1 dp").arg(Math.round(referenceWidthSlider.value))
                            typescale: MD.Tokens.typescale.titleLarge
                            color: page.MD.Style.primaryColor
                        }
                    }

                    MD.Slider {
                        id: referenceWidthSlider

                        Layout.fillWidth: true
                        from: 320
                        to: 1800
                        stepSize: 10
                        value: 1024
                        labelBehavior: MD.Slider.LabelBehavior.Gone
                    }

                    RowLayout {
                        Layout.fillWidth: true

                        MD.Label {
                            text: qsTr("320 dp")
                            typescale: MD.Tokens.typescale.labelSmall
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        MD.Label {
                            text: qsTr("1800 dp")
                            typescale: MD.Tokens.typescale.labelSmall
                        }
                    }
                }
            }

            GridLayout {
                Layout.fillWidth: true
                columns: Math.max(1, Math.min(5, Math.floor(width / 160)))
                columnSpacing: page.contentSpacing
                rowSpacing: page.contentSpacing

                Metric {
                    metricLabel: qsTr("Breakpoint")
                    metricValue: page.breakpointName(previewGrid.breakpoint)
                }

                Metric {
                    metricLabel: qsTr("Reference width")
                    metricValue: qsTr("%1 dp").arg(Math.round(previewGrid.referenceWidth))
                }

                Metric {
                    metricLabel: qsTr("Columns")
                    metricValue: previewGrid.columns.toString()
                }

                Metric {
                    metricLabel: qsTr("Margins")
                    metricValue: qsTr("%1 dp").arg(previewGrid.margins)
                }

                Metric {
                    metricLabel: qsTr("Gutters")
                    metricValue: qsTr("%1 dp").arg(previewGrid.columnSpacing)
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: page.contentSpacing

                MD.Label {
                    text: qsTr("Live adaptive layout")
                    typescale: MD.Tokens.typescale.titleLarge
                    color: page.MD.Style.onSurfaceColor
                }

                MD.Label {
                    Layout.fillWidth: true
                    text: qsTr("Tinted guides show the equal columns. Content blocks use Layout.column, Layout.row, and Layout.columnSpan directly.")
                    color: page.MD.Style.onSurfaceVariantColor
                    wrapMode: Text.WordWrap
                }

                Rectangle {
                    id: preview

                    Layout.fillWidth: true
                    implicitHeight: 420
                    clip: true

                    color: page.MD.Style.surfaceContainerLowestColor
                    border.width: 1
                    border.color: page.MD.Style.outlineVariantColor
                    topLeftRadius: MD.Tokens.shape.cornerLarge.topLeft
                    topRightRadius: MD.Tokens.shape.cornerLarge.topRight
                    bottomLeftRadius: MD.Tokens.shape.cornerLarge.bottomLeft
                    bottomRightRadius: MD.Tokens.shape.cornerLarge.bottomRight

                    Repeater {
                        model: previewGrid.columns

                        delegate: Rectangle {
                            required property int index

                            x: previewGrid.columnLeft(index)
                            y: previewGrid.margins
                            width: Math.max(0, previewGrid.columnRight(index)
                                               - previewGrid.columnLeft(index))
                            height: Math.max(0, preview.height - previewGrid.margins * 2)
                            color: Qt.alpha(page.MD.Style.primaryContainerColor, 0.42)
                        }
                    }

                    MD.AdaptiveGrid {
                        id: previewGrid

                        anchors.fill: parent
                        referenceWidth: referenceWidthSlider.value
                        rowSpacing: page.contentSpacing

                        ContentBlock {
                            Layout.row: 0
                            Layout.column: 0
                            Layout.columnSpan: previewGrid.columns
                            blockLabel: qsTr("Header · %1 columns").arg(previewGrid.columns)
                            emphasized: true
                        }

                        ContentBlock {
                            Layout.row: 1
                            Layout.column: 0
                            Layout.columnSpan: previewGrid.columns >= 12 ? 8 : previewGrid.columns
                            implicitHeight: 112
                            blockLabel: previewGrid.columns >= 12
                                        ? qsTr("Main content · 8 columns")
                                        : qsTr("Main content · full span")
                        }

                        ContentBlock {
                            visible: previewGrid.columns >= 12
                            Layout.row: 1
                            Layout.column: 8
                            Layout.columnSpan: 4
                            implicitHeight: 112
                            blockLabel: qsTr("Side rail · 4 columns")
                        }

                        ContentBlock {
                            Layout.row: 2
                            Layout.column: 0
                            Layout.columnSpan: 4
                            blockLabel: qsTr("Card A · 4 columns")
                        }

                        ContentBlock {
                            Layout.row: previewGrid.columns === 4 ? 3 : 2
                            Layout.column: previewGrid.columns === 4 ? 0 : 4
                            Layout.columnSpan: 4
                            blockLabel: qsTr("Card B · 4 columns")
                        }

                        ContentBlock {
                            Layout.row: previewGrid.columns >= 12 ? 2
                                                                  : previewGrid.columns === 8 ? 3 : 4
                            Layout.column: previewGrid.columns >= 12 ? 8 : 0
                            Layout.columnSpan: 4
                            blockLabel: qsTr("Card C · 4 columns")
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                implicitHeight: page.sectionSpacing
            }
        }
    }
}
