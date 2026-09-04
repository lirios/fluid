// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "ButtonGroupTests"
    width: 900
    height: 500
    visible: true

    Component {
        id: groupComponent
        MD.ButtonGroup {
            MD.Button { text: "One" }
            MD.IconButton { text: "Two"; icon.name: MD.SymbolNames.symbolStar }
            MD.Button { text: "Three" }
        }
    }

    Component {
        id: textGroupComponent
        MD.ButtonGroup {
            MD.Button { text: "Previous action" }
            MD.Button { text: "Current action" }
            MD.Button { text: "Next action" }
        }
    }

    Component {
        id: buttonComponent
        MD.Button { text: "Inserted" }
    }

    function indexes(group) {
        return Array.from(group.selectedIndexes);
    }

    function test_defaultsAndTokens() {
        const group = createTemporaryObject(groupComponent, testCase);
        verify(group);
        compare(group.variant, MD.ButtonGroup.Standard);
        compare(group.selectionMode, MD.ButtonGroup.NoSelection);
        compare(group.selectionRequired, false);
        compare(group.size, MD.ButtonGroup.Small);
        compare(group.shape, MD.ButtonGroup.Round);
        compare(group.count, 3);
        compare(MD.Tokens.buttonGroup.standardSpacing, 12);
        compare(MD.Tokens.buttonGroup.connectedSpacing, 2);
        compare(MD.Tokens.buttonGroup.smallReferenceHeight, 40);
        compare(MD.Tokens.buttonGroup.connectedInnerCorner, 8);
        compare(MD.Tokens.buttonGroup.pressedInnerCorner, 4);
        compare(MD.Tokens.buttonGroup.selectedInnerCornerPercentage, 50);
        compare(MD.Tokens.buttonGroup.standardPressedExpansionRatio, 0.15);
        compare(group.itemAt(0).checkable, false);
    }

    function test_sizesAndTypography() {
        const group = createTemporaryObject(groupComponent, testCase);
        const scales = [MD.Tokens.typescale.labelLarge, MD.Tokens.typescale.labelLarge,
                        MD.Tokens.typescale.titleMedium, MD.Tokens.typescale.headlineSmall,
                        MD.Tokens.typescale.headlineLarge];
        for (let size = MD.ButtonGroup.ExtraSmall; size <= MD.ButtonGroup.ExtraLarge; ++size) {
            group.size = size;
            wait(0);
            for (let i = 0; i < group.count; ++i)
                compare(group.itemAt(i).size, size);
            compare(group.itemAt(0).typescale.fontSize, scales[size].fontSize);
        }
        group.itemAt(0).typescale = MD.Tokens.typescale.bodySmall;
        group.size = MD.ButtonGroup.Large;
        compare(group.itemAt(0).typescale.fontSize, MD.Tokens.typescale.bodySmall.fontSize);
    }

    function test_spacingAndGeometry() {
        const group = createTemporaryObject(groupComponent, testCase);
        wait(0);
        compare(group.itemAt(1).x - group.itemAt(0).x - group.itemAt(0).width, 12);
        compare(group.implicitWidth, group.itemAt(0).implicitWidth + group.itemAt(1).implicitWidth
                + group.itemAt(2).implicitWidth + 24);
        group.variant = MD.ButtonGroup.Connected;
        wait(0);
        compare(group.itemAt(1).x - group.itemAt(0).x - group.itemAt(0).width, 2);
    }

    function test_selectionNormalization() {
        const group = createTemporaryObject(groupComponent, testCase);
        group.selectionMode = MD.ButtonGroup.MultiSelection;
        group.selectedIndexes = [2, -1, 0, 2, 99];
        compare(indexes(group), [0, 2]);
        verify(group.itemAt(0).checked);
        verify(!group.itemAt(1).checked);
        verify(group.itemAt(2).checked);

        group.selectionMode = MD.ButtonGroup.SingleSelection;
        compare(indexes(group), [0]);
        group.itemAt(2).checked = true;
        compare(indexes(group), [2]);
        verify(!group.itemAt(0).checked);

        group.selectionRequired = true;
        group.itemAt(2).checked = false;
        compare(indexes(group), [0]);
        group.itemAt(0).enabled = false;
        group.selectedIndexes = [];
        compare(indexes(group), [1]);

        group.selectionMode = MD.ButtonGroup.NoSelection;
        compare(indexes(group), []);
        verify(!group.itemAt(0).checkable);
    }

    function test_connectedCornersAndRtl() {
        const group = createTemporaryObject(groupComponent, testCase, {
            variant: MD.ButtonGroup.Connected,
            selectionMode: MD.ButtonGroup.SingleSelection
        });
        wait(0);
        compare(group.itemAt(0).background.topRightRadius, 8);
        compare(group.itemAt(1).background.topLeftRadius, 8);
        group.LayoutMirroring.enabled = true;
        wait(0);
        verify(group.itemAt(0).x > group.itemAt(1).x);
        group.itemAt(1).checked = true;
        tryCompare(group.itemAt(1).background, "topLeftRadius",
                   group.itemAt(1).background.height / 2, 500);
    }

    function test_pressedWidthRedistribution() {
        const group = createTemporaryObject(textGroupComponent, testCase);
        wait(0);
        const first = group.itemAt(0);
        const second = group.itemAt(1);
        const third = group.itemAt(2);
        const initial = [first.width, second.width, third.width];
        const total = initial[0] + initial[1] + initial[2];

        mousePress(second, second.width / 2, second.height / 2, Qt.LeftButton);
        tryVerify(() => second.width > initial[1], 500);
        verify(first.width < initial[0]);
        verify(third.width < initial[2]);
        verify(Math.abs(first.width + second.width + third.width - total) < 0.5);
        mouseRelease(second, second.width / 2, second.height / 2, Qt.LeftButton);
        tryVerify(() => Math.abs(second.width - initial[1]) < 0.5, 500);

        group.variant = MD.ButtonGroup.Connected;
        wait(0);
        const connectedWidth = second.width;
        mousePress(second, second.width / 2, second.height / 2, Qt.LeftButton);
        wait(50);
        compare(second.width, connectedWidth);
        mouseRelease(second, second.width / 2, second.height / 2, Qt.LeftButton);
    }

    function test_shapeMorphFamilies() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectionMode: MD.ButtonGroup.MultiSelection
        });
        const button = group.itemAt(0);
        const iconButton = group.itemAt(1);
        button.checked = true;
        iconButton.checked = true;
        tryCompare(button.background, "topLeftRadius", 12, 500);
        tryCompare(iconButton.background, "topLeftRadius", 12, 500);

        group.shape = MD.ButtonGroup.Square;
        tryCompare(button.background, "topLeftRadius", button.background.height / 2, 500);
        tryCompare(iconButton.background, "topLeftRadius", iconButton.background.height / 2, 500);
    }

    function test_signalAndDynamicCollection() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectionMode: MD.ButtonGroup.MultiSelection,
            selectedIndexes: [1]
        });
        const spy = signalSpy.createObject(testCase, {
            target: group,
            signalName: "selectionChanged"
        });
        verify(spy);
        group.selectedIndexes = [2, 2, 0, -1];
        compare(indexes(group), [0, 2]);
        compare(spy.count, 1);
        group.selectedIndexes = [0, 2, 99];
        compare(spy.count, 1);

        group.selectedIndexes = [1];
        const selected = group.itemAt(1);
        const inserted = buttonComponent.createObject(testCase);
        group.insertItem(0, inserted);
        tryCompare(group, "count", 4);
        tryVerify(() => indexes(group).length === 1 && indexes(group)[0] === 2);
        compare(group.itemAt(2), selected);
        group.removeItem(inserted);
        tryCompare(group, "count", 3);
        tryVerify(() => indexes(group).length === 1 && indexes(group)[0] === 1);
    }

    function test_rovingFocusAndKeyboard() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectionMode: MD.ButtonGroup.SingleSelection
        });
        const first = group.itemAt(0);
        const second = group.itemAt(1);
        const third = group.itemAt(2);
        first.forceActiveFocus();
        verify(first.activeFocus);
        compare(first.focusPolicy, Qt.StrongFocus);
        compare(second.focusPolicy, Qt.ClickFocus);

        keyClick(Qt.Key_Right);
        verify(second.activeFocus);
        keyClick(Qt.Key_Space);
        compare(indexes(group), [1]);
        third.enabled = false;
        keyClick(Qt.Key_Right);
        verify(first.activeFocus);
        keyClick(Qt.Key_End);
        verify(second.activeFocus);
        keyClick(Qt.Key_Home);
        verify(first.activeFocus);

        compare(first.Accessible.role, Accessible.RadioButton);
        group.selectionMode = MD.ButtonGroup.MultiSelection;
        compare(first.Accessible.role, Accessible.CheckBox);
        verify(first.Accessible.checkable);
    }

    Component {
        id: signalSpy
        SignalSpy {}
    }
}
