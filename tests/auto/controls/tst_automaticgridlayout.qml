// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "AutomaticGridLayoutTests"
    width: 800
    height: 600
    visible: true
    when: windowShown

    Component {
        id: inferredGridComponent

        MD.AutomaticGridLayout {
            width: 350

            Rectangle {
                objectName: "firstItem"
                implicitWidth: 80
                implicitHeight: 20
            }

            Rectangle {
                objectName: "secondItem"
                implicitWidth: 60
                implicitHeight: 30
                Layout.preferredWidth: 100
                Layout.preferredHeight: 40
            }

            Rectangle {
                objectName: "thirdItem"
                implicitWidth: 120
                implicitHeight: 24
            }
        }
    }

    Component {
        id: fixedGridComponent

        MD.AutomaticGridLayout {
            width: 332
            height: 116
            cellWidth: 100
            cellHeight: 40

            Repeater {
                model: 6
                delegate: Rectangle {
                    required property int index
                    objectName: "item" + index
                    implicitWidth: 100
                    implicitHeight: 40
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }

    Component {
        id: groupBoxComponent

        MD.GroupBox {
            width: 300
            title: "Actions"

            MD.AutomaticGridLayout {
                objectName: "groupGrid"
                width: parent.width

                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                }
                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                }
                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                }
            }
        }
    }

    function createGrid(component, properties) {
        return createTemporaryObject(component, testCase, properties || {});
    }

    function item(grid, index) {
        return findChild(grid, "item" + index);
    }

    function test_defaultsAndInference() {
        const grid = createGrid(inferredGridComponent);
        verify(grid);

        compare(grid.cellWidth, 120);
        compare(grid.cellHeight, 40);
        compare(grid.columnSpacing, MD.Tokens.measurement.space200);
        compare(grid.rowSpacing, MD.Tokens.measurement.space200);
        compare(grid.flow, GridLayout.LeftToRight);
        compare(grid.layoutDirection, Qt.LeftToRight);
        compare(grid.columns, 2);
        compare(grid.rows, 1);
        compare(grid.uniformCellWidths, true);
        compare(grid.uniformCellHeights, true);
        compare(grid.implicitHeight, 96);
    }

    function test_explicitCellSizeOverridesInference() {
        const grid = createGrid(inferredGridComponent, {
            width: 216,
            height: 76,
            cellWidth: 100,
            cellHeight: 30
        });
        verify(grid);

        compare(grid.cellWidth, 100);
        compare(grid.cellHeight, 30);
        compare(grid.columns, 2);
    }

    function test_columnThresholds_data() {
        return [
            { tag: "below two", width: 215.99, columns: 1 },
            { tag: "at two", width: 216, columns: 2 },
            { tag: "above two", width: 216.01, columns: 2 },
            { tag: "below three", width: 331.99, columns: 2 },
            { tag: "at three", width: 332, columns: 3 },
            { tag: "above three", width: 332.01, columns: 3 },
            { tag: "clamped to children", width: 1000, columns: 3 }
        ];
    }

    function test_columnThresholds(data) {
        const grid = createGrid(inferredGridComponent, {
            width: data.width,
            cellWidth: 100
        });
        verify(grid);
        compare(grid.columns, data.columns);
    }

    function test_rowThresholds_data() {
        return [
            { tag: "below two", height: 95.99, rows: 1 },
            { tag: "at two", height: 96, rows: 2 },
            { tag: "above two", height: 96.01, rows: 2 },
            { tag: "below three", height: 151.99, rows: 2 },
            { tag: "at three", height: 152, rows: 3 },
            { tag: "above three", height: 152.01, rows: 3 },
            { tag: "clamped to children", height: 1000, rows: 3 }
        ];
    }

    function test_rowThresholds(data) {
        const grid = createGrid(inferredGridComponent, {
            flow: GridLayout.TopToBottom,
            height: data.height,
            cellHeight: 40
        });
        verify(grid);
        compare(grid.rows, data.rows);
    }

    function test_exactGapsAndEqualSurplusDistribution() {
        const grid = createGrid(fixedGridComponent);
        verify(grid);

        const first = item(grid, 0);
        const second = item(grid, 1);
        const third = item(grid, 2);
        const fourth = item(grid, 3);
        verify(first && second && third && fourth);

        tryCompare(first, "width", 100);
        compare(second.width, first.width);
        compare(third.width, first.width);
        compare(second.x - first.x - first.width, grid.columnSpacing);
        compare(third.x - second.x - second.width, grid.columnSpacing);

        compare(first.height, 50);
        compare(fourth.height, first.height);
        compare(fourth.y - first.y - first.height, grid.rowSpacing);

        grid.width = 362;
        grid.height = 136;
        tryCompare(first, "width", 110);
        compare(second.width, first.width);
        compare(third.width, first.width);
        compare(second.x - first.x - first.width, grid.columnSpacing);
        compare(first.height, 60);
        compare(fourth.height, first.height);
        compare(fourth.y - first.y - first.height, grid.rowSpacing);
    }

    function test_dynamicResizeAndHintChanges() {
        const resizedGrid = createGrid(inferredGridComponent, { cellWidth: 100 });
        verify(resizedGrid);

        resizedGrid.width = 331;
        compare(resizedGrid.columns, 2);
        resizedGrid.width = 332;
        compare(resizedGrid.columns, 3);
        resizedGrid.width = 215;
        compare(resizedGrid.columns, 1);

        const inferredGrid = createGrid(inferredGridComponent, { width: 216 });
        verify(inferredGrid);
        const third = findChild(inferredGrid, "thirdItem");
        verify(third);
        third.implicitWidth = 90;
        compare(inferredGrid.cellWidth, 100);
        compare(inferredGrid.columns, 2);
        third.implicitWidth = 140;
        compare(inferredGrid.cellWidth, 140);
        compare(inferredGrid.columns, 1);
    }

    function test_visibilityAndChildCollectionChanges() {
        const grid = createGrid(inferredGridComponent, { width: 250 });
        verify(grid);
        compare(grid.cellWidth, 120);
        compare(grid.columns, 1);

        const third = findChild(grid, "thirdItem");
        verify(third);
        third.visible = false;
        compare(grid.cellWidth, 100);
        compare(grid.columns, 2);

        const inserted = Qt.createQmlObject(
                    'import QtQuick; Rectangle { objectName: "insertedItem"; implicitWidth: 110; implicitHeight: 45 }',
                    grid);
        verify(inserted);
        compare(grid.cellWidth, 110);
        compare(grid.cellHeight, 45);
        compare(grid.columns, 2);

        inserted.destroy();
        tryCompare(grid, "cellWidth", 100);
        compare(grid.cellHeight, 40);
    }

    function test_columnMajorOverflowAndFlowChange() {
        const grid = createGrid(fixedGridComponent, {
            flow: GridLayout.TopToBottom,
            width: undefined,
            height: 96
        });
        verify(grid);

        compare(grid.rows, 2);
        compare(grid.columns, 1);
        compare(grid.implicitWidth, 332);

        grid.height = 40;
        compare(grid.rows, 1);
        tryCompare(grid, "implicitWidth", 680);

        grid.flow = GridLayout.LeftToRight;
        grid.width = 216;
        compare(grid.columns, 2);
        compare(grid.rows, 1);
        tryCompare(grid, "implicitHeight", 152);
    }

    function test_rightToLeftPlacement() {
        const grid = createGrid(fixedGridComponent, {
            height: 40,
            layoutDirection: Qt.RightToLeft
        });
        verify(grid);

        const first = item(grid, 0);
        const second = item(grid, 1);
        const third = item(grid, 2);
        verify(first && second && third);
        tryCompare(first, "x", 232);
        compare(second.x, 116);
        compare(third.x, 0);
    }

    function test_layoutAttachedPropertiesAndSpans() {
        const source = `
            import QtQuick
            import QtQuick.Layouts
            import Fluid as MD
            MD.AutomaticGridLayout {
                width: 332
                height: 40
                cellWidth: 100
                cellHeight: 40
                Rectangle {
                    objectName: "spanItem"
                    implicitWidth: 100
                    implicitHeight: 40
                    Layout.row: 0
                    Layout.column: 0
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 4
                    Layout.alignment: Qt.AlignCenter
                }
                Rectangle {
                    objectName: "positionedItem"
                    implicitWidth: 100
                    implicitHeight: 40
                    Layout.row: 0
                    Layout.column: 2
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    Layout.row: 1
                    Layout.column: 0
                }
            }`;
        const grid = Qt.createQmlObject(source, testCase);
        verify(grid);
        const spanItem = findChild(grid, "spanItem");
        const positionedItem = findChild(grid, "positionedItem");
        verify(spanItem && positionedItem);

        compare(spanItem.Layout.row, 0);
        compare(spanItem.Layout.column, 0);
        compare(spanItem.Layout.columnSpan, 2);
        compare(spanItem.Layout.fillWidth, true);
        compare(spanItem.Layout.margins, 4);
        tryCompare(spanItem, "x", 4);
        compare(spanItem.width, 208);
        compare(positionedItem.Layout.column, 2);
        compare(positionedItem.x, 232);
        grid.destroy();
    }

    function test_emptyAndInvalidSizesKeepSafeTrack() {
        const empty = Qt.createQmlObject(
                    'import QtQuick; import Fluid as MD; MD.AutomaticGridLayout { width: 400; height: 400 }',
                    testCase);
        verify(empty);
        compare(empty.cellWidth, 0);
        compare(empty.cellHeight, 0);
        compare(empty.columns, 1);
        compare(empty.rows, 1);

        empty.cellWidth = -1;
        empty.cellHeight = NaN;
        empty.flow = GridLayout.TopToBottom;
        compare(empty.columns, 1);
        compare(empty.rows, 1);
        empty.destroy();
    }

    function test_groupBoxIntegration() {
        const groupBox = createGrid(groupBoxComponent);
        verify(groupBox);
        const grid = findChild(groupBox, "groupGrid");
        verify(grid);

        compare(grid.width, groupBox.availableWidth);
        compare(grid.columns, 2);
        compare(grid.implicitHeight, 96);
        compare(groupBox.implicitContentHeight, grid.implicitHeight);
        compare(groupBox.implicitHeight,
                grid.implicitHeight + groupBox.topPadding + groupBox.bottomPadding);

        groupBox.width = 224;
        compare(grid.width, groupBox.availableWidth);
        compare(grid.columns, 1);
        tryCompare(grid, "implicitHeight", 152);
        compare(groupBox.implicitHeight,
                grid.implicitHeight + groupBox.topPadding + groupBox.bottomPadding);
    }
}
