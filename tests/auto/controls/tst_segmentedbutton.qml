// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "SegmentedButtonTests"
    width: 900
    height: 600
    visible: true
    when: windowShown

    Component {
        id: groupComponent
        MD.SegmentedButtonGroup {
            MD.SegmentedButton { text: "Day" }
            MD.SegmentedButton { text: "Working week" }
            MD.SegmentedButton { text: "Month" }
        }
    }

    Component {
        id: emptyGroupComponent
        MD.SegmentedButtonGroup {}
    }

    Component {
        id: buttonComponent
        MD.SegmentedButton { text: "Inserted" }
    }

    Component {
        id: spyComponent
        SignalSpy {}
    }

    Component {
        id: focusComponent
        Item {
            width: 800
            height: 200
            property alias before: before
            property alias group: group
            property alias after: after
            MD.Button { id: before; text: "Before" }
            MD.SegmentedButtonGroup {
                id: group
                y: 60
                MD.SegmentedButton { text: "One" }
                MD.SegmentedButton { text: "Two" }
                MD.SegmentedButton { text: "Three" }
            }
            MD.Button { id: after; y: 120; text: "After" }
        }
    }

    function indexes(group) {
        return Array.from(group.selectedIndexes);
    }

    function spyFor(target, signalName) {
        const spy = createTemporaryObject(spyComponent, testCase, {
            target: target,
            signalName: signalName
        });
        verify(spy.valid);
        return spy;
    }

    function test_defaults() {
        const group = createTemporaryObject(groupComponent, testCase);
        compare(group.count, 3);
        compare(group.selectionMode, MD.SegmentedButtonGroup.SingleSelection);
        compare(group.selectionRequired, true);
        compare(indexes(group), [0]);
        compare(group.implicitHeight, 48);
        const button = group.itemAt(0);
        verify(button.checkable);
        verify(button.checked);
        verify(button.showCheckmark);
        compare(button.implicitHeight, 48);
        compare(button.background.height, 40);
        compare(button.background.y, 4);
        compare(button.typescale.fontSize, MD.Tokens.typescale.labelLarge.fontSize);

        group.selectionMode = MD.SegmentedButtonGroup.MultiSelection;
        compare(group.selectionRequired, false);
        group.selectedIndexes = [];
        compare(indexes(group), []);
        group.selectionMode = MD.SegmentedButtonGroup.SingleSelection;
        compare(group.selectionRequired, true);
        compare(indexes(group), [0]);
    }

    function test_initialSelectionAndNormalization() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectionMode: MD.SegmentedButtonGroup.MultiSelection,
            selectedIndexes: [2, -1, 0, 2, 99]
        });
        compare(indexes(group), [0, 2]);
        const spy = spyFor(group, "selectionChanged");
        group.selectedIndexes = [2, 0, 2, 99];
        compare(indexes(group), [0, 2]);
        compare(spy.count, 0);
        group.selectedIndexes = [1, 1, -2];
        compare(indexes(group), [1]);
        compare(spy.count, 1);
        compare(Array.from(spy.signalArguments[0][0]), [1]);
        verify(!group.itemAt(0).checked);
        verify(group.itemAt(1).checked);
        verify(!group.itemAt(2).checked);
        group.itemAt(2).checked = true;
        compare(indexes(group), [1, 2]);
        compare(spy.count, 2);
        group.selectionMode = MD.SegmentedButtonGroup.SingleSelection;
        compare(indexes(group), [1]);
        group.itemAt(2).checked = true;
        compare(indexes(group), [2]);
        verify(!group.itemAt(1).checked);
    }

    function test_requiredSelectionRetainsNonFirst() {
        const group = createTemporaryObject(groupComponent, testCase, { selectedIndexes: [2] });
        compare(indexes(group), [2]);
        const selected = group.itemAt(2);
        const spy = spyFor(group, "selectionChanged");
        const clicked = spyFor(selected, "clicked");
        mouseClick(selected, selected.width / 2, selected.height / 2);
        compare(indexes(group), [2]);
        verify(selected.checked);
        compare(spy.count, 0);
        compare(clicked.count, 1);
        selected.forceActiveFocus();
        keyClick(Qt.Key_Space);
        keyClick(Qt.Key_Return);
        compare(indexes(group), [2]);
        compare(spy.count, 0);
    }

    function test_optionalAndRequiredMultiSelection() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectionRequired: false,
            selectedIndexes: [1]
        });
        const second = group.itemAt(1);
        mouseClick(second, second.width / 2, second.height / 2);
        compare(indexes(group), []);
        group.selectionMode = MD.SegmentedButtonGroup.MultiSelection;
        group.selectionRequired = true;
        group.selectedIndexes = [1, 2];
        mouseClick(second, second.width / 2, second.height / 2);
        compare(indexes(group), [2]);
        const third = group.itemAt(2);
        mouseClick(third, third.width / 2, third.height / 2);
        compare(indexes(group), [2]);
    }

    function test_requiredFallback() {
        const group = createTemporaryObject(groupComponent, testCase, { selectionRequired: false });
        group.itemAt(0).enabled = false;
        group.itemAt(1).visible = false;
        group.selectedIndexes = [];
        group.selectionRequired = true;
        compare(indexes(group), [2]);
        group.itemAt(2).enabled = false;
        group.selectedIndexes = [];
        compare(indexes(group), [0]);
    }

    function test_dynamicIdentity() {
        const group = createTemporaryObject(groupComponent, testCase, { selectedIndexes: [2] });
        const selected = group.itemAt(2);
        const inserted = createTemporaryObject(buttonComponent, testCase);
        group.insertItem(0, inserted);
        tryCompare(group, "count", 4);
        tryCompare(group, "selectedIndexes", [3]);
        compare(group.itemAt(3), selected);
        group.moveItem(3, 1);
        tryCompare(group, "selectedIndexes", [1]);
        compare(group.itemAt(1), selected);
        verify(selected.checked);
        group.removeItem(inserted);
        tryCompare(group, "count", 3);
        tryCompare(group, "selectedIndexes", [0]);
        compare(group.itemAt(0), selected);
        group.removeItem(selected);
        tryCompare(group, "count", 2);
        tryCompare(group, "selectedIndexes", [0]);
        // The index is unchanged; wait for identity synchronization as well.
        tryCompare(group.itemAt(0), "checked", true);
    }

    function test_dynamicMultiSelectionAndEmptyGroup() {
        const group = createTemporaryObject(emptyGroupComponent, testCase);
        compare(group.count, 0);
        compare(indexes(group), []);
        const first = createTemporaryObject(buttonComponent, testCase);
        const second = createTemporaryObject(buttonComponent, testCase);
        group.addItem(first);
        tryCompare(group, "selectedIndexes", [0]);
        group.addItem(second);
        group.selectionMode = MD.SegmentedButtonGroup.MultiSelection;
        group.selectedIndexes = [0, 1];
        group.moveItem(0, 1);
        tryCompare(group, "selectedIndexes", [0, 1]);
        verify(first.checked && second.checked);
        group.removeItem(first);
        tryCompare(group, "selectedIndexes", [0]);
        compare(group.itemAt(0), second);
        group.removeItem(second);
        tryCompare(group, "count", 0);
        tryCompare(group, "selectedIndexes", []);
    }

    function test_collectionEditsFromSelectionChanged() {
        const group = createTemporaryObject(groupComponent, testCase, {
            selectedIndexes: [2],
            width: 300
        });
        const first = group.itemAt(0);
        const remaining = group.itemAt(1);
        const selected = group.itemAt(2);
        const inserted = createTemporaryObject(buttonComponent, testCase);
        let edited = false;
        group.selectionChanged.connect(function() {
            if (edited)
                return;
            edited = true;
            group.addItem(inserted);
            group.removeItem(first);
        });

        group.removeItem(selected);
        tryVerify(() => edited);
        tryCompare(group, "count", 2);
        tryCompare(inserted, "__segmentedButtonGroup", group);
        compare(group.itemAt(0), remaining);
        compare(group.itemAt(1), inserted);
        tryCompare(remaining, "checked", true);
        compare(indexes(group), [0]);
        verify(!inserted.checked);
        tryCompare(remaining, "width", 150);
        tryCompare(inserted, "width", 150);
        compare(inserted.x, remaining.x + remaining.width);
        mouseClick(inserted, inserted.width / 2, inserted.height / 2);
        compare(indexes(group), [1]);
        verify(inserted.checked);
        verify(!remaining.checked);
    }

    function test_mouseTouchAndDisabled() {
        const group = createTemporaryObject(groupComponent, testCase);
        const second = group.itemAt(1);
        const third = group.itemAt(2);
        mouseClick(second, second.width / 2, 2);
        compare(indexes(group), [1]);
        const touch = touchEvent(third);
        touch.press(0, third, third.width / 2, third.height - 2).commit();
        touch.release(0, third, third.width / 2, third.height - 2).commit();
        tryCompare(group, "selectedIndexes", [2]);
        second.enabled = false;
        const spy = spyFor(second, "clicked");
        mouseClick(second, second.width / 2, second.height / 2);
        compare(indexes(group), [2]);
        compare(spy.count, 0);
    }

    function test_keyboardFocusAndVisualOrder_data() {
        return [{ tag: "ltr", rtl: false }, { tag: "rtl", rtl: true }];
    }

    function test_keyboardFocusAndVisualOrder(data) {
        const group = createTemporaryObject(groupComponent, testCase);
        group.LayoutMirroring.enabled = data.rtl;
        const first = group.itemAt(0);
        const second = group.itemAt(1);
        const third = group.itemAt(2);
        first.forceActiveFocus();
        keyClick(data.rtl ? Qt.Key_Left : Qt.Key_Right);
        verify(second.activeFocus);
        compare(group.currentIndex, 1);
        compare(indexes(group), [0]);
        keyClick(Qt.Key_Return);
        compare(indexes(group), [1]);
        third.enabled = false;
        keyClick(data.rtl ? Qt.Key_Left : Qt.Key_Right);
        verify(first.activeFocus);
        keyClick(Qt.Key_End);
        verify(second.activeFocus);
        keyClick(Qt.Key_Home);
        verify(first.activeFocus);
        second.visible = false;
        keyClick(data.rtl ? Qt.Key_Right : Qt.Key_Left);
        verify(first.activeFocus);
        compare(indexes(group), [1]);
    }

    function test_oneTabStop() {
        const host = createTemporaryObject(focusComponent, testCase);
        host.before.forceActiveFocus();
        keyClick(Qt.Key_Tab);
        tryVerify(() => host.group.itemAt(host.group.currentIndex).activeFocus);
        keyClick(Qt.Key_Right);
        verify(host.group.itemAt(1).activeFocus);
        verifyOnlyTabStop(host.group, 1);
        keyClick(Qt.Key_Tab);
        verify(host.after.activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.group.itemAt(1).activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.before.activeFocus);
        keyClick(Qt.Key_Tab);
        verify(host.group.itemAt(1).activeFocus);
        keyClick(Qt.Key_Right);
        verifyOnlyTabStop(host.group, 2);
        keyClick(Qt.Key_Right);
        verifyOnlyTabStop(host.group, 0);
        keyClick(Qt.Key_Tab);
        verify(host.after.activeFocus);
    }

    function verifyOnlyTabStop(group, expectedIndex) {
        compare(group.currentIndex, expectedIndex);
        for (let i = 0; i < group.count; ++i) {
            compare(group.itemAt(i).activeFocusOnTab, i === expectedIndex,
                    "Tab participation for segment " + i);
            compare(group.itemAt(i).activeFocus, i === expectedIndex,
                    "Active focus for segment " + i);
        }
    }

    function test_programmaticCurrentIndexFocus() {
        const host = createTemporaryObject(focusComponent, testCase);
        const group = host.group;
        host.before.forceActiveFocus();
        group.currentIndex = 2;
        verify(host.before.activeFocus);
        for (let i = 0; i < group.count; ++i)
            compare(group.itemAt(i).activeFocusOnTab, i === 2);
        compare(indexes(group), [0]);
        keyClick(Qt.Key_Tab);
        verifyOnlyTabStop(group, 2);

        group.currentIndex = 1;
        verifyOnlyTabStop(group, 1);
        compare(indexes(group), [0]);
        group.currentIndex = 0;
        verifyOnlyTabStop(group, 0);
        compare(indexes(group), [0]);

        host.after.forceActiveFocus();
        group.currentIndex = 2;
        verify(host.after.activeFocus);
        for (let i = 0; i < group.count; ++i)
            compare(group.itemAt(i).activeFocusOnTab, i === 2);
        compare(indexes(group), [0]);
    }

    function test_accessibilityActivation() {
        const group = createTemporaryObject(groupComponent, testCase);
        const second = group.itemAt(1);
        compare(second.Accessible.role, Accessible.RadioButton);
        compare(second.Accessible.name, "Working week");
        verify(second.Accessible.checkable);
        verify(!second.Accessible.checked);
        const spy = spyFor(second, "clicked");
        second.Accessible.pressAction();
        compare(indexes(group), [1]);
        verify(second.Accessible.checked);
        compare(spy.count, 1);
        group.selectionMode = MD.SegmentedButtonGroup.MultiSelection;
        compare(second.Accessible.role, Accessible.CheckBox);
        second.Accessible.pressAction();
        compare(indexes(group), []);
        second.enabled = false;
        second.Accessible.pressAction();
        compare(indexes(group), []);
    }

    function test_themePropagationAndOverrides() {
        const group = createTemporaryObject(groupComponent, testCase);
        const selected = group.itemAt(0);
        const unselected = group.itemAt(1);
        group.MD.Style.theme = MD.Style.Light;
        compare(selected.containerColor, selected.MD.Style.secondaryContainerColor);
        compare(selected.contentColor, selected.MD.Style.onSecondaryContainerColor);
        compare(unselected.contentColor, unselected.MD.Style.onSurfaceColor);
        compare(unselected.outlineColor, unselected.MD.Style.outlineColor);
        const lightColor = selected.containerColor.toString();
        group.MD.Style.theme = MD.Style.Dark;
        compare(selected.containerColor, selected.MD.Style.secondaryContainerColor);
        verify(selected.containerColor.toString() !== lightColor);
        unselected.MD.Style.theme = MD.Style.Light;
        compare(unselected.MD.Style.theme, MD.Style.Light);
        selected.containerColor = "red";
        selected.contentColor = "blue";
        selected.outlineColor = "green";
        selected.stateLayerColor = "yellow";
        group.MD.Style.theme = MD.Style.Light;
        compare(selected.containerColor, "#ff0000");
        compare(selected.contentColor, "#0000ff");
        compare(selected.outlineColor, "#008000");
        compare(selected.stateLayerColor, "#ffff00");
    }

    function test_disabledSemanticColors() {
        const group = createTemporaryObject(groupComponent, testCase);
        for (let i = 0; i < 2; ++i) {
            const button = group.itemAt(i);
            button.enabled = false;
            compare(button.contentColor, Qt.alpha(button.MD.Style.onSurfaceColor, 0.38));
            compare(button.outlineColor, Qt.alpha(button.MD.Style.onSurfaceColor, 0.12));
            compare(button.background.stateLayerOpacity, 0);
        }
        compare(group.itemAt(0).containerColor, group.itemAt(0).MD.Style.secondaryContainerColor);
        compare(group.itemAt(1).containerColor, "#00000000");
    }

    function test_equalWidthsOutlinesAndEndpoints_data() {
        return [{ tag: "ltr", rtl: false }, { tag: "rtl", rtl: true }];
    }

    function test_equalWidthsOutlinesAndEndpoints(data) {
        const group = createTemporaryObject(groupComponent, testCase);
        group.LayoutMirroring.enabled = data.rtl;
        wait(0);
        const first = group.itemAt(0);
        const second = group.itemAt(1);
        const third = group.itemAt(2);
        const widest = Math.max(first.implicitWidth, second.implicitWidth, third.implicitWidth);
        compare(group.implicitWidth, widest * 3);
        group.selectedIndexes = [2];
        compare(group.implicitWidth, widest * 3);
        group.width = 360;
        wait(0);
        for (let i = 0; i < 3; ++i) {
            compare(group.itemAt(i).width, 120);
            compare(group.itemAt(i).background.outlineWidth, 1);
        }
        const left = data.rtl ? third : first;
        const right = data.rtl ? first : third;
        compare(left.x, 0);
        compare(second.x, left.x + left.width);
        compare(right.x, second.x + second.width);
        compare(left.background.leftRadius, 20);
        compare(left.background.rightRadius, 0);
        compare(second.background.leftRadius, 0);
        compare(second.background.rightRadius, 0);
        compare(right.background.rightRadius, 20);
        verify(left.background.drawLeftOutline);
        verify(!second.background.drawLeftOutline);
        verify(!right.background.drawLeftOutline);
        left.visible = false;
        wait(0);
        compare(second.width, 180);
        compare(second.background.leftRadius, 20);
        verify(second.background.drawLeftOutline);
        right.visible = false;
        wait(0);
        compare(second.width, 360);
        compare(second.background.leftRadius, 20);
        compare(second.background.rightRadius, 20);
    }

    function contentCombinations() {
        const source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
        return [
            { tag: "text", text: "Choice", icon: "", source: "" },
            { tag: "icon-text", text: "Choice", icon: MD.Symbols.star, source: "" },
            { tag: "icon-only", text: "", icon: MD.Symbols.star, source: "" },
            { tag: "source-text", text: "Choice", icon: "", source: source },
            { tag: "source-only", text: "", icon: "", source: source },
            { tag: "empty", text: "", icon: "", source: "" }
        ];
    }

    function test_indicatorAndStableNaturalSize_data() {
        return contentCombinations();
    }

    function test_indicatorAndStableNaturalSize(data) {
        const button = createTemporaryObject(buttonComponent, testCase, { text: data.text });
        button.icon.name = data.icon;
        button.icon.source = data.source;
        button.Accessible.name = "Choice";
        const hasIcon = data.icon.length > 0 || data.source.toString().length > 0;
        const naturalWidth = button.implicitWidth;
        const naturalHeight = button.implicitHeight;
        button.checked = true;
        compare(button.implicitWidth, naturalWidth);
        compare(button.implicitHeight, naturalHeight);
        verify(button.contentItem.checkVisible);
        compare(button.contentItem.labelVisible, data.text.length > 0);
        compare(button.contentItem.iconVisible, hasIcon && data.text.length === 0);
        const checkmark = findChild(button, "segmentedButtonCheckmark");
        verify(checkmark.Accessible.ignored);
        button.checked = false;
        compare(button.implicitWidth, naturalWidth);
        verify(!button.contentItem.checkVisible);
        compare(button.contentItem.iconVisible, hasIcon);
        button.showCheckmark = false;
        button.checked = true;
        verify(!button.contentItem.checkVisible);
        compare(button.contentItem.iconVisible, hasIcon);
        compare(button.Accessible.name, "Choice");
        compare(button.leftPadding, 12);
        compare(button.rightPadding, 12);
        compare(button.height, 48);
        compare(button.background.height, 40);
    }

    function test_displayHasNoEffect_data() {
        const rows = [];
        for (const content of contentCombinations()) {
            for (const rtl of [false, true])
                rows.push(Object.assign({}, content, { tag: content.tag + (rtl ? "-rtl" : "-ltr"), rtl: rtl }));
        }
        return rows;
    }

    function test_displayHasNoEffect(data) {
        const button = createTemporaryObject(buttonComponent, testCase, { text: data.text });
        button.icon.name = data.icon;
        button.icon.source = data.source;
        button.Accessible.name = "Choice";
        button.LayoutMirroring.enabled = data.rtl;
        const label = findChild(button, "segmentedButtonLabel");
        const symbol = findChild(button, "segmentedButtonSymbol");
        const sourceIcon = findChild(button, "segmentedButtonSourceIcon");
        const checkmark = findChild(button, "segmentedButtonCheckmark");
        if (data.source.toString().length > 0)
            tryCompare(sourceIcon, "status", Image.Ready);
        const option = data.source.toString().length > 0 ? sourceIcon : symbol;
        if (data.text.length > 0 && button.contentItem.iconVisible) {
            const iconPosition = option.mapToItem(button, 0, 0);
            const labelPosition = label.mapToItem(button, 0, 0);
            verify(data.rtl ? iconPosition.x >= labelPosition.x + label.width
                            : iconPosition.x + option.width <= labelPosition.x);
            fuzzyCompare(iconPosition.y + option.height / 2, labelPosition.y + label.height / 2, 0.01);
        }
        const snapshot = function() {
            const result = [button.implicitWidth, button.implicitHeight,
                            button.background.width, button.background.height,
                            button.contentItem.labelVisible, button.contentItem.iconVisible,
                            button.contentItem.checkVisible, label.truncated];
            for (const item of [label, symbol, sourceIcon, checkmark]) {
                const position = item.mapToItem(button, 0, 0);
                result.push(item.visible, position.x, position.y, item.width, item.height);
            }
            return result;
        };
        const displayValues = [MD.SegmentedButton.IconOnly, MD.SegmentedButton.TextOnly,
                               MD.SegmentedButton.TextBesideIcon, MD.SegmentedButton.TextUnderIcon];
        for (const width of [button.implicitWidth, 60]) {
            button.width = width;
            for (const showCheckmark of [true, false]) {
                button.showCheckmark = showCheckmark;
                for (const checked of [false, true]) {
                    button.checked = checked;
                    button.display = MD.SegmentedButton.TextBesideIcon;
                    const expected = snapshot();
                    for (const display of displayValues) {
                        button.display = display;
                        compare(button.display, display);
                        compare(snapshot(), expected);
                    }
                }
            }
        }
    }

    function test_visibleContentCentered_data() {
        return [
            { tag: "text-ltr", rtl: false, iconOnly: false },
            { tag: "text-rtl", rtl: true, iconOnly: false },
            { tag: "icon-ltr", rtl: false, iconOnly: true },
            { tag: "icon-rtl", rtl: true, iconOnly: true }
        ];
    }

    function test_visibleContentCentered(data) {
        const button = createTemporaryObject(buttonComponent, testCase, {
            text: data.iconOnly ? "" : "Week"
        });
        button.Accessible.name = "Week";
        button.LayoutMirroring.enabled = data.rtl;
        button.icon.name = data.iconOnly ? MD.Symbols.star : "";
        const naturalWidth = button.implicitWidth;
        const content = findChild(button, data.iconOnly ? "segmentedButtonSymbol" : "segmentedButtonLabel");
        const checkmark = findChild(button, "segmentedButtonCheckmark");
        for (const width of [naturalWidth, naturalWidth + 40, 60]) {
            button.width = width;
            for (const checked of [false, true, false]) {
                button.checked = checked;
                const contentLeft = content.mapToItem(button, 0, 0).x;
                const checkLeft = checkmark.mapToItem(button, 0, 0).x;
                const left = checked ? Math.min(contentLeft, checkLeft) : contentLeft;
                const right = checked ? Math.max(contentLeft + content.width, checkLeft + checkmark.width)
                                      : contentLeft + content.width;
                fuzzyCompare(left, button.width - right, 0.01);
                compare(button.implicitWidth, naturalWidth);
            }
        }
    }

    function test_sourceIconPreservesIconOnlyIdentity() {
        const button = createTemporaryObject(buttonComponent, testCase, {
            text: ""
        });
        button.icon.source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
        button.Accessible.name = "Gallery";
        const image = findChild(button, "segmentedButtonSourceIcon");
        tryCompare(image, "status", Image.Ready);
        const width = button.implicitWidth;
        button.checked = true;
        compare(button.implicitWidth, width);
        verify(button.contentItem.checkVisible);
        verify(button.contentItem.iconVisible);
        verify(image.visible);
        verify(image.Accessible.ignored);
        compare(button.Accessible.name, "Gallery");
        button.text = "Gallery";
        verify(!button.contentItem.iconVisible);
    }

    function test_constrainedLabelAndStateLayers() {
        const group = createTemporaryObject(groupComponent, testCase, { width: 210 });
        const button = group.itemAt(1);
        const label = findChild(button, "segmentedButtonLabel");
        verify(label);
        compare(label.elide, Text.ElideRight);
        verify(label.truncated);
        verify(label.Accessible.ignored);
        mouseMove(button, button.width / 2, button.height / 2);
        tryCompare(button.background, "stateLayerOpacity", MD.Tokens.segmentedButton.hoverStateLayerOpacity);
        button.forceActiveFocus(Qt.TabFocusReason);
        compare(button.background.stateLayerOpacity, MD.Tokens.segmentedButton.focusStateLayerOpacity);
        mousePress(button, button.width / 2, button.height / 2);
        compare(button.background.stateLayerOpacity, MD.Tokens.segmentedButton.pressedStateLayerOpacity);
        button.enabled = false;
        compare(button.background.stateLayerOpacity, 0);
        mouseRelease(button, button.width / 2, button.height / 2);
    }
}
