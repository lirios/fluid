// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "ListItemTests"
    width: 640
    height: 640
    visible: true
    when: windowShown

    Component {
        id: itemComponent
        MD.ListItem { width: 400; text: "Primary label" }
    }
    Component {
        id: leadingComponent
        Item { objectName: "leadingSlot"; implicitWidth: 32; implicitHeight: 40 }
    }
    Component {
        id: trailingComponent
        Item { objectName: "trailingSlot"; implicitWidth: 24; implicitHeight: 24 }
    }
    Component {
        id: tallComponent
        Item { objectName: "tallSlot"; implicitWidth: 32; implicitHeight: 100 }
    }
    Component {
        id: listComponent
        ListView {
            id: list
            width: 400
            height: 400
            model: 3
            delegate: MD.ListItem {
                required property int index
                width: list.width
                text: "Row " + index
                segmented: true
            }
        }
    }
    SignalSpy { id: clickedSpy; signalName: "clicked" }

    function test_line_heights() {
        const item = createTemporaryObject(itemComponent, testCase);
        verify(item);
        compare(item.implicitHeight, MD.Tokens.listItem.oneLineContainerHeight);
        item.supportingText = "Supporting text";
        compare(item.implicitHeight, MD.Tokens.listItem.twoLineContainerHeight);
        item.overline = "Overline";
        compare(item.implicitHeight, MD.Tokens.listItem.threeLineContainerHeight);
        item.supportingText = "";
        item.overline = "";
        compare(item.implicitHeight, MD.Tokens.listItem.oneLineContainerHeight);
    }

    function test_slots_data() {
        return [{ tag: "ltr", mirrored: false }, { tag: "rtl", mirrored: true }];
    }

    function test_slots(data) {
        const item = createTemporaryObject(itemComponent, testCase, {
            leading: leadingComponent, trailing: trailingComponent,
            "LayoutMirroring.enabled": data.mirrored,
            "LayoutMirroring.childrenInherit": true
        });
        verify(item);
        const leading = findChild(item, "leadingSlot");
        const trailing = findChild(item, "trailingSlot");
        verify(leading);
        verify(trailing);
        waitForPolish(item.Window.window);
        compare(leading.width, 32);
        compare(trailing.width, 24);
        const leadingPoint = leading.mapToItem(item, 0, 0);
        const trailingPoint = trailing.mapToItem(item, 0, 0);
        verify(data.mirrored ? leadingPoint.x > trailingPoint.x : leadingPoint.x < trailingPoint.x);
        verify(leadingPoint.x >= item.leftPadding);
        verify(trailingPoint.x + trailing.width <= item.width - item.rightPadding, "trailing right " + (trailingPoint.x + trailing.width) + ", item width " + item.width + ", padding " + item.rightPadding);

        item.leading = null;
        item.trailing = null;
        tryVerify(() => findChild(item, "leadingSlot") === null);
        tryVerify(() => findChild(item, "trailingSlot") === null);
        waitForPolish(item.Window.window);
        compare(item.implicitHeight, MD.Tokens.listItem.oneLineContainerHeight);
    }

    function test_tall_slot_expands_height() {
        const item = createTemporaryObject(itemComponent, testCase, { leading: tallComponent });
        verify(item);
        const slot = findChild(item, "tallSlot");
        waitForPolish(item.Window.window);
        verify(item.implicitHeight >= slot.implicitHeight + item.topPadding + item.bottomPadding);
        const point = slot.mapToItem(item, 0, 0);
        verify(point.y >= item.topPadding);
        verify(point.y + slot.height <= item.height - item.bottomPadding, "slot bottom " + (point.y + slot.height) + ", item height " + item.height + ", padding " + item.bottomPadding);
    }

    function test_click_reaches_delegate() {
        const item = createTemporaryObject(itemComponent, testCase);
        clickedSpy.target = item;
        clickedSpy.clear();
        mouseClick(item, item.width / 2, item.height / 2);
        compare(clickedSpy.count, 1);
    }

    function test_segmented_boundaries() {
        const list = createTemporaryObject(listComponent, testCase);
        verify(list);
        tryCompare(list, "count", 3);
        tryVerify(() => list.itemAtIndex(2) !== null);
        const first = list.itemAtIndex(0);
        const middle = list.itemAtIndex(1);
        const last = list.itemAtIndex(2);
        verify(first._first);
        verify(!first._last);
        verify(!middle._first && !middle._last);
        verify(last._last);
        verify(!last._first);
        const shape = MD.Tokens.listItem.selectedContainerExpressiveShape;
        tryCompare(first.background, "topLeftRadius", shape.topLeft);
        tryCompare(first.background, "bottomLeftRadius", 0);
        tryCompare(middle.background, "topLeftRadius", 0);
        tryCompare(middle.background, "bottomLeftRadius", 0);
        tryCompare(last.background, "bottomLeftRadius", shape.bottomLeft);
        compare(first.topInset, 0);
        compare(last.bottomInset, 0);
        compare(middle.topInset, MD.Tokens.listItem.segmentedGap);
        compare(middle.bottomInset, MD.Tokens.listItem.segmentedGap);

        list.model = 1;
        tryCompare(list, "count", 1);
        const only = list.itemAtIndex(0);
        tryVerify(() => only._first && only._last);
        tryCompare(only.background, "topLeftRadius", shape.topLeft);
        tryCompare(only.background, "bottomLeftRadius", shape.bottomLeft);
    }
}
