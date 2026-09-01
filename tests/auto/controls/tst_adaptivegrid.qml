// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "AdaptiveGridTests"
    width: 1800
    height: 800
    visible: true
    when: windowShown

    Component {
        id: gridComponent

        MD.AdaptiveGrid {
            width: 400
            height: 200
        }
    }

    Component {
        id: populatedGridComponent

        MD.AdaptiveGrid {
            width: 400
            height: 100

            Rectangle {
                objectName: "leadingItem"
                implicitHeight: 40
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 2
                Layout.columnSpan: 2
                Layout.fillWidth: true
            }

            Rectangle {
                objectName: "trailingItem"
                implicitHeight: 40
                Layout.row: 0
                Layout.column: 2
                Layout.columnSpan: 2
                Layout.fillWidth: true
            }

            Rectangle {
                objectName: "secondRowItem"
                implicitHeight: 40
                Layout.row: 1
                Layout.column: 2
                Layout.columnSpan: 2
                Layout.fillWidth: true
            }
        }
    }

    function createGrid(properties, component) {
        return createTemporaryObject(component || gridComponent, testCase, properties || {});
    }

    function test_breakpointBounds() {
        compare(MD.Breakpoints.compactLowerBound, 0);
        compare(MD.Breakpoints.mediumLowerBound, 600);
        compare(MD.Breakpoints.expandedLowerBound, 840);
        compare(MD.Breakpoints.largeLowerBound, 1200);
        compare(MD.Breakpoints.extraLargeLowerBound, 1600);
    }

    function test_fromWidth_data() {
        return [
            { tag: "zero", width: 0, expected: MD.Breakpoints.Compact },
            { tag: "below-medium", width: 599, expected: MD.Breakpoints.Compact },
            { tag: "at-medium", width: 600, expected: MD.Breakpoints.Medium },
            { tag: "above-medium", width: 601, expected: MD.Breakpoints.Medium },
            { tag: "below-expanded", width: 839, expected: MD.Breakpoints.Medium },
            { tag: "at-expanded", width: 840, expected: MD.Breakpoints.Expanded },
            { tag: "above-expanded", width: 841, expected: MD.Breakpoints.Expanded },
            { tag: "below-large", width: 1199, expected: MD.Breakpoints.Expanded },
            { tag: "at-large", width: 1200, expected: MD.Breakpoints.Large },
            { tag: "above-large", width: 1201, expected: MD.Breakpoints.Large },
            { tag: "below-extra-large", width: 1599, expected: MD.Breakpoints.Large },
            { tag: "at-extra-large", width: 1600, expected: MD.Breakpoints.ExtraLarge },
            { tag: "above-extra-large", width: 1601, expected: MD.Breakpoints.ExtraLarge }
        ];
    }

    function test_fromWidth(data) {
        compare(MD.Breakpoints.fromWidth(data.width), data.expected);
    }

    function test_invalidWidthFallback_data() {
        return [
            { tag: "negative", width: -1 },
            { tag: "not-a-number", width: NaN },
            { tag: "positive-infinity", width: Infinity },
            { tag: "negative-infinity", width: -Infinity },
            { tag: "non-numeric-string", width: "wide" },
            { tag: "undefined", width: undefined }
        ];
    }

    function test_invalidWidthFallback(data) {
        compare(MD.Breakpoints.fromWidth(data.width), MD.Breakpoints.Compact);
    }

    function test_breakpointMetrics_data() {
        return [
            { tag: "compact", breakpoint: MD.Breakpoints.Compact, columns: 4, spacing: 16 },
            { tag: "medium", breakpoint: MD.Breakpoints.Medium, columns: 8, spacing: 24 },
            { tag: "expanded", breakpoint: MD.Breakpoints.Expanded, columns: 8, spacing: 24 },
            { tag: "large", breakpoint: MD.Breakpoints.Large, columns: 12, spacing: 24 },
            { tag: "extra-large", breakpoint: MD.Breakpoints.ExtraLarge, columns: 12,
              spacing: 24 }
        ];
    }

    function test_breakpointMetrics(data) {
        compare(MD.Breakpoints.columnCount(data.breakpoint), data.columns);
        compare(MD.Breakpoints.margin(data.breakpoint), data.spacing);
        compare(MD.Breakpoints.gutter(data.breakpoint), data.spacing);
    }

    function test_breakpointMetricsUseMeasurementTokens() {
        compare(MD.Breakpoints.margin(MD.Breakpoints.Compact), MD.Tokens.measurement.space200);
        compare(MD.Breakpoints.gutter(MD.Breakpoints.Compact), MD.Tokens.measurement.space200);
        compare(MD.Breakpoints.margin(MD.Breakpoints.Medium), MD.Tokens.measurement.space300);
        compare(MD.Breakpoints.gutter(MD.Breakpoints.Medium), MD.Tokens.measurement.space300);
    }

    function test_invalidBreakpointFallback_data() {
        return [
            { tag: "negative", breakpoint: -1 },
            { tag: "too-large", breakpoint: 99 },
            { tag: "not-a-number", breakpoint: NaN },
            { tag: "non-numeric-string", breakpoint: "compact" },
            { tag: "undefined", breakpoint: undefined }
        ];
    }

    function test_invalidBreakpointFallback(data) {
        compare(MD.Breakpoints.columnCount(data.breakpoint), 4);
        compare(MD.Breakpoints.margin(data.breakpoint), MD.Tokens.measurement.space200);
        compare(MD.Breakpoints.gutter(data.breakpoint), MD.Tokens.measurement.space200);
    }

    function test_gridDefaults() {
        const grid = createGrid();
        verify(grid);

        compare(grid.referenceWidth, grid.width);
        compare(grid.breakpoint, MD.Breakpoints.Compact);
        compare(grid.columns, 4);
        compare(grid.margins, MD.Tokens.measurement.space200);
        compare(grid.columnSpacing, MD.Tokens.measurement.space200);
        compare(grid.rowSpacing, 0);
        compare(grid.contentWidth, 368);
        compare(grid.columnWidth, 80);
        compare(grid.flow, GridLayout.LeftToRight);
        compare(grid.layoutDirection, Qt.LeftToRight);
    }

    function test_gridTracksWidthByDefault() {
        const grid = createGrid({ width: 599 });
        verify(grid);

        compare(grid.referenceWidth, 599);
        compare(grid.breakpoint, MD.Breakpoints.Compact);
        compare(grid.columns, 4);

        grid.width = 600;
        compare(grid.referenceWidth, 600);
        compare(grid.breakpoint, MD.Breakpoints.Medium);
        compare(grid.columns, 8);
        compare(grid.margins, MD.Tokens.measurement.space300);
        compare(grid.columnSpacing, MD.Tokens.measurement.space300);
    }

    function test_explicitReferenceWidth() {
        const grid = createGrid({ width: 400, referenceWidth: 840 });
        verify(grid);

        compare(grid.referenceWidth, 840);
        compare(grid.breakpoint, MD.Breakpoints.Expanded);
        compare(grid.columns, 8);
        compare(grid.margins, 24);
        compare(grid.columnSpacing, 24);
        compare(grid.contentWidth, 352);
        compare(grid.columnWidth, 23);

        grid.referenceWidth = 1200;
        compare(grid.breakpoint, MD.Breakpoints.Large);
        compare(grid.columns, 12);
        compare(grid.columnWidth, 7 + 1 / 3);
    }

    function test_spacingOverridesPersistAcrossBreakpoints() {
        const grid = createGrid({
            width: 1000,
            referenceWidth: 599,
            margins: 20,
            columnSpacing: 12,
            rowSpacing: 8
        });
        verify(grid);

        compare(grid.contentWidth, 960);
        compare(grid.columnWidth, 231);
        compare(grid.rowSpacing, 8);

        grid.referenceWidth = 600;
        compare(grid.columns, 8);
        compare(grid.margins, 20);
        compare(grid.columnSpacing, 12);
        compare(grid.rowSpacing, 8);
        compare(grid.contentWidth, 960);
        compare(grid.columnWidth, 109.5);
    }

    function test_rulerGeometryLtr() {
        const grid = createGrid();
        verify(grid);

        compare(grid.columnLeft(0), 16);
        compare(grid.columnRight(0), 96);
        compare(grid.columnLeft(1), 112);
        compare(grid.columnRight(1), 192);
        compare(grid.columnLeft(3), 304);
        compare(grid.columnRight(3), 384);
        compare(grid.spanWidth(1), 80);
        compare(grid.spanWidth(2), 176);
        compare(grid.spanWidth(4), 368);
    }

    function test_rulerGeometryRtl() {
        const grid = createGrid({ layoutDirection: Qt.RightToLeft });
        verify(grid);

        compare(grid.columnLeft(0), 304);
        compare(grid.columnRight(0), 384);
        compare(grid.columnLeft(1), 208);
        compare(grid.columnRight(1), 288);
        compare(grid.columnLeft(3), 16);
        compare(grid.columnRight(3), 96);
        compare(grid.spanWidth(2), 176);
    }

    function test_invalidRulerArguments() {
        const grid = createGrid();
        verify(grid);

        const invalidIndices = [-1, 4, 0.5, NaN, Infinity, "0", undefined];
        for (const index of invalidIndices) {
            verify(isNaN(grid.columnLeft(index)), "columnLeft accepted " + index);
            verify(isNaN(grid.columnRight(index)), "columnRight accepted " + index);
        }

        const invalidSpans = [-1, 0, 5, 1.5, NaN, Infinity, "1", undefined];
        for (const span of invalidSpans)
            verify(isNaN(grid.spanWidth(span)), "spanWidth accepted " + span);
    }

    function test_childrenUseGridLayoutAttachedProperties() {
        const grid = createGrid({}, populatedGridComponent);
        verify(grid);
        const leading = findChild(grid, "leadingItem");
        const trailing = findChild(grid, "trailingItem");
        const secondRow = findChild(grid, "secondRowItem");
        verify(leading);
        verify(trailing);
        verify(secondRow);

        tryCompare(leading, "width", grid.spanWidth(2));
        tryCompare(leading, "x", grid.columnLeft(0) - grid.margins);
        tryCompare(trailing, "x", grid.columnLeft(2) - grid.margins);
        tryCompare(trailing, "width", grid.spanWidth(2));
        compare(leading.Layout.row, 0);
        compare(leading.Layout.column, 0);
        compare(leading.Layout.rowSpan, 2);
        compare(leading.Layout.columnSpan, 2);
        compare(trailing.Layout.row, 0);
        compare(trailing.Layout.column, 2);
        compare(trailing.Layout.columnSpan, 2);
        compare(secondRow.Layout.row, 1);
        compare(secondRow.Layout.column, 2);
        compare(secondRow.Layout.columnSpan, 2);

        grid.layoutDirection = Qt.RightToLeft;
        tryCompare(leading, "x", grid.columnLeft(1) - grid.margins);
        tryCompare(trailing, "x", grid.columnLeft(3) - grid.margins);
    }

    function test_flowIsWritable() {
        const grid = createGrid();
        verify(grid);

        grid.flow = GridLayout.TopToBottom;
        compare(grid.flow, GridLayout.TopToBottom);
    }
}
