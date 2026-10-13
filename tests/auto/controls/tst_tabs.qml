// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "TabsTests"
    width: 960
    height: 720
    visible: true
    when: windowShown

    Component {
        id: barComponent
        MD.TabBar {
            width: 360
            MD.TabButton { text: "One" }
            MD.TabButton { text: "Working week" }
            MD.TabButton { text: "Three" }
        }
    }
    Component { id: emptyBarComponent; MD.TabBar {} }
    Component { id: buttonComponent; MD.TabButton { text: "Inserted" } }
    Component { id: spyComponent; SignalSpy {} }
    Component { id: sizedBackground; Rectangle { implicitWidth: 240; implicitHeight: 150 } }
    Component {
        id: nativeBarComponent
        T.TabBar {
            id: nativeBar
            contentItem: ListView { model: nativeBar.contentModel; currentIndex: -1 }
            T.TabButton { text: "One" }
            T.TabButton { text: "Working week" }
            T.TabButton { text: "Three" }
        }
    }
    Component { id: nativeButtonComponent; T.TabButton { text: "Inserted" } }
    Component {
        id: modelComponent
        MD.TabBar {
            id: modelBar
            width: 360
            property int destinations: 3
            Repeater {
                model: modelBar.destinations
                MD.TabButton { required property int index; text: "Destination " + index }
            }
        }
    }
    Component {
        id: nativeModelComponent
        T.TabBar {
            id: nativeModelBar
            property int destinations: 3
            contentItem: ListView { model: nativeModelBar.contentModel; currentIndex: -1 }
            Repeater {
                model: nativeModelBar.destinations
                T.TabButton { required property int index; text: "Destination " + index }
            }
        }
    }
    Component {
        id: focusComponent
        Item {
            width: 800
            height: 220
            property alias before: before
            property alias bar: bar
            property alias after: after
            MD.Button { id: before; text: "Before" }
            MD.TabBar {
                id: bar
                y: 60; width: 360
                MD.TabButton { text: "One" }
                MD.TabButton { text: "Two" }
                MD.TabButton { text: "Three" }
            }
            MD.Button { id: after; y: 150; text: "After" }
        }
    }
    Component {
        id: scrollComponent
        MD.TabBar {
            width: 200
            layoutMode: MD.TabBar.Scrollable
            Repeater {
                model: 8
                MD.TabButton {
                    required property int index
                    text: "Destination " + (index + 1)
                }
            }
        }
    }
    Component {
        id: syncComponent
        Item {
            width: 600; height: 300
            property alias bar: bar
            property alias pages: pages
            MD.TabBar {
                id: bar
                width: 360
                currentIndex: pages.currentIndex
                onCurrentIndexChanged: pages.currentIndex = currentIndex
                MD.TabButton { text: "One" }
                MD.TabButton { text: "Two" }
                MD.TabButton { text: "Three" }
            }
            StackLayout {
                id: pages
                y: 70; width: 360; height: 120
                currentIndex: 0
                Item {}
                Item {}
                Item {}
            }
        }
    }
    Component {
        id: actionComponent
        Item {
            id: actionFixture
            property alias action: action
            property alias button: button
            property int activations: 0
            MD.Action {
                id: action
                text: "Inbox"
                icon.name: MD.Symbols.mail
                badgeContent: 12
                badgeAccessibleDescription: "12 unread messages"
                onTriggered: ++actionFixture.activations
            }
            MD.TabButton { id: button; action: action }
        }
    }

    function bar(properties) {
        const result = createTemporaryObject(barComponent, testCase, properties || {});
        verify(result);
        return result;
    }
    function spyFor(target, signalName) {
        const spy = createTemporaryObject(spyComponent, testCase, {target: target, signalName: signalName});
        verify(spy.valid);
        return spy;
    }
    function directions() {
        return [{tag: "ltr", rtl: false}, {tag: "rtl", rtl: true}];
    }
    function labelPaintLeft(label) {
        return label.x + (label.width - Math.min(label.width, label.contentWidth)) / 2;
    }
    function labelPaintRight(label) {
        return labelPaintLeft(label) + Math.min(label.width, label.contentWidth);
    }
    function variantsAndLayouts() {
        const rows = [];
        for (const variant of [MD.TabBar.Primary, MD.TabBar.Secondary]) {
            for (const mode of [MD.TabBar.Fixed, MD.TabBar.Scrollable]) {
                for (const rtl of [false, true])
                    rows.push({tag: variant + "-" + mode + "-" + rtl, variant: variant, mode: mode, rtl: rtl});
            }
        }
        return rows;
    }
    function verifySelection(control, index) {
        compare(control.currentIndex, index);
        compare(control.currentItem, index >= 0 && index < control.count ? control.itemAt(index) : null);
        for (let i = 0; i < control.count; ++i)
            compare(control.itemAt(i).checked, i === index);
    }
    function verifyOnlyTabStop(control, index) {
        for (let i = 0; i < control.count; ++i)
            compare(control.itemAt(i).activeFocusOnTab, i === index, "Tab stop " + i);
    }
    function viewport(control) {
        const result = findChild(control, "tabViewport");
        verify(result);
        return result;
    }
    function fullyVisible(control, item) {
        const view = viewport(control);
        const position = item.mapToItem(view, 0, 0);
        if (view.itemAt(item.x + item.width / 2, item.y + item.height / 2) !== item)
            return false;
        return item.width <= view.width
            ? position.x >= -0.5 && position.x + item.width <= view.width + 0.5
            : position.x <= 0.5 && position.x + item.width >= view.width - 0.5;
    }
    function verifyFiniteScroll(control) {
        const view = viewport(control);
        verify(Number.isFinite(view.contentX));
        verify(Number.isFinite(view.contentWidth));
        // Qt's RTL ListView origin is the right viewport edge.
        let start = view.headerItem.x;
        let end = view.headerItem.x + view.headerItem.width;
        for (let i = 0; i < control.count; ++i) {
            const item = control.itemAt(i);
            if (item.visible) {
                start = Math.min(start, item.x);
                end = Math.max(end, item.x + item.width);
            }
        }
        const minimum = control.mirrored ? Math.min(start, end - view.width) : start;
        const maximum = control.mirrored ? end - view.width : Math.max(start, end - view.width);
        verify(view.contentX >= minimum - 0.5);
        verify(view.contentX <= maximum + 0.5);
    }

    function test_defaultsAndOwner() {
        const control = bar();
        compare(control.variant, MD.TabBar.Primary);
        compare(control.layoutMode, MD.TabBar.Fixed);
        compare(control.count, 3);
        verifySelection(control, 0);
        compare(control.implicitHeight, 48);
        const button = control.itemAt(0);
        compare(button.T.TabBar.tabBar, control);
        compare(button.effectiveVariant, MD.TabBar.Primary);
        compare(button.display, T.AbstractButton.TextUnderIcon);
        compare(button.maximumLineCount, 1);
        compare(button.typescale, MD.Tokens.typescale.titleSmall);
        compare(button.icon.width, 24);
        compare(button.icon.height, 24);
        compare(button.implicitHeight, 48);
        control.variant = MD.TabBar.Secondary;
        for (let i = 0; i < control.count; ++i) {
            compare(control.itemAt(i).effectiveVariant, MD.TabBar.Secondary);
            compare(control.itemAt(i).display, T.AbstractButton.TextBesideIcon);
        }
        const standalone = createTemporaryObject(buttonComponent, testCase);
        compare(standalone.T.TabBar.tabBar, null);
        compare(standalone.effectiveVariant, MD.TabBar.Primary);
    }

    function test_nativeSelectionEdges() {
        const control = bar();
        const native = createTemporaryObject(nativeBarComponent, testCase);
        function equivalent() {
            compare(control.count, native.count);
            compare(control.currentIndex, native.currentIndex);
            compare(control.currentItem ? control.currentItem.text : "", native.currentItem ? native.currentItem.text : "");
            for (let i = 0; i < control.count; ++i)
                compare(control.itemAt(i).checked, native.itemAt(i).checked);
        }
        equivalent();
        for (const index of [2, -1, 99, 1, 0]) {
            control.setCurrentIndex(index);
            native.setCurrentIndex(index);
            equivalent();
        }
        control.setCurrentIndex(2);
        native.setCurrentIndex(2);
        control.removeItem(control.itemAt(2));
        native.removeItem(native.itemAt(2));
        equivalent();
        compare(control.currentIndex, 1);
        control.setCurrentIndex(0);
        native.setCurrentIndex(0);
        control.removeItem(control.itemAt(0));
        native.removeItem(native.itemAt(0));
        equivalent();
        compare(control.currentIndex, 0);
        control.removeItem(control.itemAt(0));
        native.removeItem(native.itemAt(0));
        equivalent();
        compare(control.currentIndex, -1);
        const inserted = createTemporaryObject(buttonComponent, testCase);
        const nativeInserted = createTemporaryObject(nativeButtonComponent, testCase);
        control.insertItem(0, inserted);
        native.insertItem(0, nativeInserted);
        equivalent();
        compare(control.currentIndex, 0);
    }

    function test_implicitSizingHonorsTemplateOverrides() {
        const button = createTemporaryObject(buttonComponent, testCase,
                                             {topPadding: 20, bottomPadding: 20});
        verify(button);
        tryVerify(() => button.implicitHeight >= button.implicitContentHeight + 40);
        verify(button.contentItem.height >= button.implicitContentHeight);
        button.background = sizedBackground.createObject(button);
        button.leftInset = 7;
        button.rightInset = 9;
        button.topInset = 5;
        button.bottomInset = 11;
        tryCompare(button, "implicitWidth", 256);
        tryCompare(button, "implicitHeight", 166);

        const control = bar({topPadding: 20, bottomPadding: 20});
        tryCompare(control, "implicitHeight", 88);
        control.background = sizedBackground.createObject(control);
        control.leftInset = 7;
        control.rightInset = 9;
        control.topInset = 5;
        control.bottomInset = 11;
        tryCompare(control, "implicitHeight", 166);
        verify(control.implicitWidth >= 256);
        control.leftPadding = 200;
        control.rightPadding = 200;
        tryVerify(() => control.implicitWidth >= 400 + control._naturalWidth);
    }

    function test_dynamicIdentityAndModel() {
        const control = bar();
        const native = createTemporaryObject(nativeBarComponent, testCase);
        const fluidItems = [];
        const nativeItems = [];
        for (let i = 0; i < control.count; ++i) {
            fluidItems.push(control.itemAt(i));
            nativeItems.push(native.itemAt(i));
        }
        function equivalent() {
            compare(control.count, native.count);
            compare(control.currentIndex, native.currentIndex);
            const selected = nativeItems.indexOf(native.currentItem);
            verify(control.currentItem === (selected >= 0 ? fluidItems[selected] : null));
            for (let i = 0; i < control.count; ++i) {
                const identity = nativeItems.indexOf(native.itemAt(i));
                verify(control.itemAt(i) === fluidItems[identity]);
                compare(control.itemAt(i).checked, native.itemAt(i).checked);
            }
        }
        control.setCurrentIndex(2);
        native.setCurrentIndex(2);
        const inserted = createTemporaryObject(buttonComponent, testCase);
        const nativeInserted = createTemporaryObject(nativeButtonComponent, testCase);
        fluidItems.push(inserted);
        nativeItems.push(nativeInserted);
        control.insertItem(0, inserted);
        native.insertItem(0, nativeInserted);
        tryCompare(control, "count", 4);
        equivalent();
        control.moveItem(3, 1);
        native.moveItem(3, 1);
        equivalent();
        control.removeItem(inserted);
        native.removeItem(nativeInserted);
        tryCompare(control, "count", 3);
        equivalent();
        control.currentItem.checked = false;
        native.currentItem.checked = false;
        equivalent();
        // Native exclusivity governs checked state; activating another item selects it.
        control.itemAt(1).checked = true;
        native.itemAt(1).checked = true;
        equivalent();
        verifySelection(control, 1);
    }

    function test_pointerTouchAndUnavailable() {
        const control = bar();
        const second = control.itemAt(1);
        const third = control.itemAt(2);
        const secondSpy = spyFor(second, "clicked");
        const thirdSpy = spyFor(third, "clicked");
        mouseClick(second, second.width / 2, second.height / 2);
        verifySelection(control, 1);
        compare(secondSpy.count, 1);
        const touch = touchEvent(third);
        touch.press(0, third, third.width / 2, third.height / 2).commit();
        touch.release(0, third, third.width / 2, third.height / 2).commit();
        tryCompare(control, "currentIndex", 2);
        compare(thirdSpy.count, 1);
        second.enabled = false;
        mouseClick(second, second.width / 2, second.height / 2);
        second.Accessible.pressAction();
        compare(secondSpy.count, 1);
        verifySelection(control, 2);
        control.setCurrentIndex(1);
        verifySelection(control, 1);
        third.visible = false;
        third.Accessible.pressAction();
        compare(thirdSpy.count, 1);
        control.setCurrentIndex(2);
        verifySelection(control, 2);
    }

    function test_dynamicRepeaterUsesNativeSelection() {
        const control = createTemporaryObject(modelComponent, testCase);
        const native = createTemporaryObject(nativeModelComponent, testCase);
        tryCompare(control, "count", 3);
        tryCompare(native, "count", 3);
        control.setCurrentIndex(2);
        native.setCurrentIndex(2);
        for (const count of [2, 1, 0, 4]) {
            control.destinations = count;
            native.destinations = count;
            tryCompare(control, "count", count);
            tryCompare(native, "count", count);
            compare(control.currentIndex, native.currentIndex);
            compare(control.currentItem ? control.currentItem.text : "",
                    native.currentItem ? native.currentItem.text : "");
        }
        control.setCurrentIndex(99);
        native.setCurrentIndex(99);
        compare(control.currentIndex, native.currentIndex);
        compare(control.currentItem, null);
    }

    function test_manualKeyboard_data() { return directions(); }
    function test_manualKeyboard(data) {
        const control = bar();
        control.LayoutMirroring.enabled = data.rtl;
        const first = control.itemAt(0);
        const second = control.itemAt(1);
        const third = control.itemAt(2);
        const clicked = spyFor(second, "clicked");
        first.forceActiveFocus(Qt.TabFocusReason);
        keyClick(data.rtl ? Qt.Key_Left : Qt.Key_Right);
        verify(second.activeFocus);
        verifySelection(control, 0);
        keyClick(Qt.Key_Space);
        verifySelection(control, 1);
        compare(clicked.count, 1);
        keyClick(Qt.Key_Return);
        compare(clicked.count, 2);
        keyClick(Qt.Key_Enter);
        compare(clicked.count, 3);
        third.enabled = false;
        keyClick(data.rtl ? Qt.Key_Left : Qt.Key_Right);
        verify(first.activeFocus);
        verifySelection(control, 1);
        keyClick(Qt.Key_End);
        verify(second.activeFocus);
        keyClick(Qt.Key_Home);
        verify(first.activeFocus);
        second.visible = false;
        for (let i = 0; i < 6; ++i)
            keyClick(data.rtl ? Qt.Key_Right : Qt.Key_Left);
        verify(first.activeFocus);
        verifySelection(control, 1);
    }

    function test_keyboardLifecycle_data() {
        return [{tag: "space", key: Qt.Key_Space},
                {tag: "return", key: Qt.Key_Return},
                {tag: "enter", key: Qt.Key_Enter}];
    }
    function test_keyboardLifecycle(data) {
        const host = createTemporaryObject(focusComponent, testCase);
        const control = host.bar;
        const button = control.itemAt(1);
        const pressed = spyFor(button, "pressed");
        const released = spyFor(button, "released");
        const canceled = spyFor(button, "canceled");
        const clicked = spyFor(button, "clicked");
        button.forceActiveFocus(Qt.TabFocusReason);
        keyPress(data.key);
        verify(button.pressed);
        verify(button.down);
        compare(pressed.count, 1);
        compare(released.count, 0);
        compare(clicked.count, 0);
        verifySelection(control, 0);
        keyRelease(data.key);
        verify(!button.pressed && !button.down);
        compare(released.count, 1);
        compare(clicked.count, 1);
        verifySelection(control, 1);
        keyPress(data.key);
        verify(button.pressed && button.down);
        host.after.forceActiveFocus();
        tryVerify(() => !button.pressed && !button.down);
        compare(canceled.count, 1);
        keyRelease(data.key);
        compare(clicked.count, 1);
        compare(released.count, 1);
        button.forceActiveFocus(Qt.TabFocusReason);
        keyClick(data.key);
        compare(clicked.count, 2);
    }

    function test_tabEntryExitResetsToSelection() {
        const host = createTemporaryObject(focusComponent, testCase);
        host.before.forceActiveFocus();
        host.bar.setCurrentIndex(1);
        verify(host.before.activeFocus);
        keyClick(Qt.Key_Tab);
        tryVerify(() => host.bar.itemAt(1).activeFocus);
        verifyOnlyTabStop(host.bar, 1);
        keyClick(Qt.Key_Right);
        verify(host.bar.itemAt(2).activeFocus);
        verifySelection(host.bar, 1);
        keyClick(Qt.Key_Tab);
        verify(host.after.activeFocus);
        tryVerify(() => host.bar.itemAt(1).activeFocusOnTab);
        keyClick(Qt.Key_Backtab);
        tryVerify(() => host.bar.itemAt(1).activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.before.activeFocus);
        host.bar.itemAt(1).enabled = false;
        keyClick(Qt.Key_Tab);
        tryVerify(() => host.bar.itemAt(0).activeFocus);
        keyClick(Qt.Key_Tab);
        verify(host.after.activeFocus);
    }

    function test_externalIndexBindingSurvivesUserActivation() {
        const host = createTemporaryObject(syncComponent, testCase);
        host.pages.currentIndex = 2;
        tryCompare(host.bar, "currentIndex", 2);
        mouseClick(host.bar.itemAt(1), 20, 20);
        tryCompare(host.pages, "currentIndex", 1);
        host.pages.currentIndex = 0;
        tryCompare(host.bar, "currentIndex", 0);
        host.bar.setCurrentIndex(2);
        tryCompare(host.pages, "currentIndex", 2);
        host.pages.currentIndex = 1;
        tryCompare(host.bar, "currentIndex", 1);
    }

    function test_layoutAndTargets_data() { return variantsAndLayouts(); }
    function test_layoutAndTargets(data) {
        const control = bar({variant: data.variant, layoutMode: data.mode});
        control.LayoutMirroring.enabled = data.rtl;
        wait(0);
        for (let i = 0; i < control.count; ++i) {
            const button = control.itemAt(i);
            verify(button.width >= 48);
            verify(button.height >= 48);
            if (data.mode === MD.TabBar.Fixed)
                fuzzyCompare(button.width, 120, 0.5);
            else
                fuzzyCompare(button.width, button.implicitWidth, 0.5);
        }
        const first = control.itemAt(0);
        const last = control.itemAt(2);
        verify(data.rtl ? first.x > last.x : first.x < last.x);
        if (data.mode === MD.TabBar.Scrollable) {
            const view = viewport(control);
            const position = first.mapToItem(view, 0, 0);
            if (data.rtl)
                fuzzyCompare(view.width - position.x - first.width, 52, 0.5);
            else
                fuzzyCompare(position.x, 52, 0.5);
        }
        control.width = 80;
        tryVerify(() => control.itemAt(0).width >= 48);
        for (let i = 0; i < control.count; ++i)
            verify(control.itemAt(i).width >= 48);
        control.setCurrentIndex(2);
        tryVerify(() => fullyVisible(control, last));
        verifyFiniteScroll(control);
        control.width = 720;
        if (data.mode === MD.TabBar.Fixed)
            tryCompare(first, "width", 240);
        first.visible = false;
        if (data.mode === MD.TabBar.Fixed) {
            tryCompare(control.itemAt(1), "width", 360);
            tryCompare(last, "width", 360);
        }
    }

    function test_scrollRevealAndRestructure_data() { return directions(); }
    function test_scrollRevealAndRestructure(data) {
        const control = createTemporaryObject(scrollComponent, testCase);
        control.LayoutMirroring.enabled = data.rtl;
        tryCompare(control, "count", 8);
        const last = control.itemAt(7);
        control.setCurrentIndex(7);
        tryVerify(() => fullyVisible(control, last));
        verifyFiniteScroll(control);
        control.setCurrentIndex(0);
        tryVerify(() => fullyVisible(control, control.itemAt(0)));
        control.itemAt(0).forceActiveFocus(Qt.TabFocusReason);
        keyClick(Qt.Key_End);
        tryVerify(() => last.activeFocus && fullyVisible(control, last));
        verifySelection(control, 0);
        last.Accessible.pressAction();
        tryCompare(control, "currentIndex", 7);
        verify(fullyVisible(control, last));
        control.setCurrentIndex(0);
        tryVerify(() => fullyVisible(control, control.itemAt(0)));
        verify(last.activeFocus);
        control.setCurrentIndex(7);
        tryVerify(() => fullyVisible(control, last));
        control.width = 160;
        tryVerify(() => fullyVisible(control, last));
        const inserted = createTemporaryObject(buttonComponent, testCase);
        control.insertItem(0, inserted);
        tryCompare(control, "count", 9);
        tryVerify(() => fullyVisible(control, last));
        control.removeItem(control.itemAt(1));
        tryVerify(() => fullyVisible(control, last));
        verifyFiniteScroll(control);
    }

    function test_scrollDragCancelsActivation_data() { return directions(); }
    function test_scrollDragCancelsActivation(data) {
        const control = createTemporaryObject(scrollComponent, testCase);
        control.LayoutMirroring.enabled = data.rtl;
        tryCompare(control, "count", 8);
        control.setCurrentIndex(3);
        tryVerify(() => fullyVisible(control, control.itemAt(3)));
        const button = control.itemAt(3);
        const clicked = spyFor(button, "clicked");
        const view = viewport(control);
        wait(50);
        const initialX = view.contentX;
        const position = button.mapToItem(view, button.width / 2, button.height / 2);
        const endX = position.x + (data.rtl ? 80 : -80);
        const touch = touchEvent(view);
        touch.press(0, view, position.x, position.y).commit();
        wait(16);
        touch.move(0, view, (position.x + endX) / 2, position.y).commit();
        wait(16);
        touch.move(0, view, endX, position.y).commit();
        wait(16);
        touch.release(0, view, endX, position.y).commit();
        tryVerify(() => !view.moving);
        compare(clicked.count, 0);
        verifySelection(control, 3);
        verify(view.contentX !== initialX);
        verifyFiniteScroll(control);
    }

    function test_horizontalWheelBoundaries_data() { return directions(); }
    function test_horizontalWheelBoundaries(data) {
        const control = createTemporaryObject(scrollComponent, testCase);
        control.LayoutMirroring.enabled = data.rtl;
        tryCompare(control, "count", 8);
        const view = viewport(control);
        control.setCurrentIndex(3);
        tryVerify(() => fullyVisible(control, control.itemAt(3)));
        wait(50);
        const before = view.contentX;
        mouseWheel(view, view.width / 2, view.height / 2, -120, 0);
        wait(16);
        tryVerify(() => view.contentX !== before);
        for (let i = 0; i < 12; ++i)
            mouseWheel(view, view.width / 2, view.height / 2, -120, 0);
        tryVerify(() => !view.moving);
        verifyFiniteScroll(control);
        for (let i = 0; i < 12; ++i)
            mouseWheel(view, view.width / 2, view.height / 2, 120, 0);
        tryVerify(() => !view.moving);
        verifyFiniteScroll(control);
        verifySelection(control, 3);
    }
    function test_contentGeometry_data() {
        const rows = [];
        for (const variant of [MD.TabBar.Primary, MD.TabBar.Secondary]) {
            for (const display of [T.AbstractButton.TextOnly, T.AbstractButton.IconOnly,
                                   T.AbstractButton.TextUnderIcon, T.AbstractButton.TextBesideIcon]) {
                for (const rtl of [false, true])
                    rows.push({tag: variant + "-" + display + "-" + rtl,
                               variant: variant, display: display, rtl: rtl});
            }
        }
        return rows;
    }

    function test_contentGeometry(data) {
        const control = bar({variant: data.variant});
        control.LayoutMirroring.enabled = data.rtl;
        const button = control.itemAt(0);
        button.text = "Destination";
        button.icon.name = MD.Symbols.mail;
        button.display = data.display;
        button.Accessible.name = "Destination";
        const label = findChild(button, "tabLabel");
        const icon = findChild(button, "tabIconSlot");
        const group = findChild(button, "tabContentGroup");
        const indicator = findChild(control, "tabIndicator");
        const divider = findChild(control, "tabDivider");
        verify(label && icon && group && indicator && divider);
        const showLabel = data.display !== T.AbstractButton.IconOnly;
        const showIcon = data.display !== T.AbstractButton.TextOnly;
        const stacked = data.variant === MD.TabBar.Primary && data.display === T.AbstractButton.TextUnderIcon;
        tryCompare(control, "implicitHeight", stacked ? 64 : 48);
        compare(button.implicitHeight, stacked ? 64 : 48);
        compare(label.visible, showLabel);
        compare(icon.visible, showIcon);
        if (showIcon) {
            compare(icon.width, 24);
            compare(icon.height, 24);
        }
        if (showLabel && showIcon) {
            if (stacked)
                fuzzyCompare(label.y - icon.y - icon.height, 2, 0.5);
            else if (data.rtl)
                fuzzyCompare(icon.x - labelPaintRight(label), 8, 0.5);
            else
                fuzzyCompare(labelPaintLeft(label) - icon.x - icon.width, 8, 0.5);
        }
        fuzzyCompare(group.x + group.width / 2, button.contentItem.width / 2, 0.5);
        fuzzyCompare(group.y + group.height / 2, button.contentItem.height / 2, 0.5);
        const displayedLabel = showLabel ? Math.min(label.width, label.contentWidth) : 0;
        const contentWidth = stacked ? displayedLabel
            : (showIcon ? icon.width : 0) + (showIcon && showLabel ? 8 : 0) + displayedLabel;
        const expectedWidth = data.variant === MD.TabBar.Secondary ? button.width
            : Math.min(button.width, Math.max(24, contentWidth - 4));
        tryVerify(() => Math.abs(indicator.width - expectedWidth) < 0.5);
        const view = viewport(control);
        const position = button.mapToItem(view, 0, 0);
        tryVerify(() => Math.abs(indicator.x - position.x - (button.width - expectedWidth) / 2) < 0.5);
        compare(indicator.height, data.variant === MD.TabBar.Primary ? 3 : 2);
        compare(indicator.y + indicator.height, view.height);
        for (const corner of ["topLeftRadius", "topRightRadius", "bottomLeftRadius", "bottomRightRadius"])
            compare(indicator[corner], data.variant === MD.TabBar.Primary ? 1.5 : 0);
        compare(divider.height, 1);
        compare(divider.y + divider.height, control.height);
        compare(divider.width, control.width);
        control.width = 90;
        tryVerify(() => indicator.width <= button.width && indicator.width > 0);
        control.setCurrentIndex(2);
        tryVerify(() => indicator.width > 0 && indicator.width <= control.itemAt(2).width);
    }

    function test_labelsElideWrapAndGrow_data() {
        return [{tag: "primary", variant: MD.TabBar.Primary},
                {tag: "secondary", variant: MD.TabBar.Secondary}];
    }
    function test_labelsElideWrapAndGrow(data) {
        const control = bar({variant: data.variant, width: 360});
        const button = control.itemAt(0);
        button.text = "A very long localized destination label with several words";
        const label = findChild(button, "tabLabel");
        verify(label);
        tryVerify(() => label.truncated);
        compare(label.maximumLineCount, 1);
        compare(label.wrapMode, Text.NoWrap);
        compare(label.elide, Text.ElideRight);
        const baseline = button.implicitHeight;
        button.maximumLineCount = 2;
        tryVerify(() => label.lineCount === 2);
        verify(label.truncated);
        compare(label.wrapMode, Text.Wrap);
        tryVerify(() => button.implicitHeight > baseline && control.height >= button.implicitHeight);
        button.font.pixelSize = 40;
        tryVerify(() => control.height > 48);
        verify(button.height >= 48 && button.width >= 48);
        verify(button.contentItem.height >= label.contentHeight);
        const group = findChild(button, "tabContentGroup");
        verify(group.y >= -0.5);
        verify(group.y + group.height <= button.contentItem.height + 0.5);
        control.width = 600;
        tryVerify(() => label.width > 120 - 32);
    }

    function test_badgeGeometryAndIndicatorAnchors_data() { return test_contentGeometry_data(); }
    function test_badgeGeometryAndIndicatorAnchors(data) {
        const control = bar({variant: data.variant});
        control.LayoutMirroring.enabled = data.rtl;
        const button = control.itemAt(0);
        button.icon.name = MD.Symbols.mail;
        button.text = "WWW";
        button.display = data.display;
        const badge = findChild(button, "tabBadge");
        const icon = findChild(button, "tabIconSlot");
        const label = findChild(button, "tabLabel");
        const group = findChild(button, "tabContentGroup");
        const indicator = findChild(control, "tabIndicator");
        verify(badge && icon && label && group && indicator);
        const hasLabel = data.display !== T.AbstractButton.IconOnly;
        const hasIcon = data.display !== T.AbstractButton.TextOnly;
        const stacked = data.variant === MD.TabBar.Primary && data.display === T.AbstractButton.TextUnderIcon;
        const baselineContent = stacked ? Math.min(label.width, label.contentWidth)
            : (hasIcon ? 24 : 0) + (hasIcon && hasLabel ? 8 : 0)
              + (hasLabel ? Math.min(label.width, label.contentWidth) : 0);
        const baselineIndicator = data.variant === MD.TabBar.Secondary ? button.width
            : Math.min(button.width, Math.max(24, baselineContent - 4));
        tryVerify(() => Math.abs(indicator.width - baselineIndicator) < 0.5);
        const initialWidth = indicator.width;
        const naturalWidth = button.implicitWidth;
        button.badgeContent = "WWW";
        tryCompare(badge, "visible", true);
        const inline = data.display !== T.AbstractButton.IconOnly
            && !(data.variant === MD.TabBar.Primary && data.display === T.AbstractButton.TextUnderIcon);
        if (inline) {
            if (data.rtl)
                fuzzyCompare(labelPaintLeft(label) - badge.x - badge.width, 4, 0.5);
            else
                fuzzyCompare(badge.x - labelPaintRight(label), 4, 0.5);
            verify(button.implicitWidth > naturalWidth);
            if (data.variant === MD.TabBar.Primary)
                tryVerify(() => indicator.width > initialWidth);
        } else {
            verify(button.implicitWidth >= naturalWidth);
            tryVerify(() => Math.abs(indicator.width - initialWidth) < 0.5);
            if (data.rtl)
                fuzzyCompare(badge.x + badge.width - icon.x, 6, 0.5);
            else
                fuzzyCompare(icon.x + icon.width - badge.x, 6, 0.5);
            fuzzyCompare(badge.y + badge.height - icon.y, 6, 0.5);
        }
        verify(badge.Accessible.ignored);
        button.badgeNotification = true;
        compare(badge.effectiveVariant, MD.Badge.Small);
        compare(badge.width, 6);
        button.badgeVisible = false;
        tryCompare(badge, "visible", false);
        compare(button.Accessible.name, "WWW");
        button.badgeVisible = true;
        button.badgeNotification = false;
        button.badgeContent = "";
        tryCompare(badge, "visible", false);
        tryVerify(() => Math.abs(indicator.width - initialWidth) < 0.5);
        compare(button.Accessible.name, "WWW");
    }

    function test_actionBadgeDefaultsAndOverrides() {
        const fixture = createTemporaryObject(actionComponent, testCase);
        verify(fixture);
        const button = fixture.button;
        const badge = findChild(button, "tabBadge");
        verify(badge);
        compare(button.badgeContent, 12);
        compare(button.badgeNotification, false);
        compare(button.badgeVisible, true);
        compare(button.badgeVariant, MD.Badge.Auto);
        compare(button.Accessible.name, "Inbox, 12 unread messages");
        fixture.action.badgeContent = 1000;
        fixture.action.badgeAccessibleDescription = "1000 unread messages";
        compare(button.Accessible.name, "Inbox, 1000 unread messages");
        button.Accessible.name = "Explicit destination";
        fixture.action.badgeContent = "Updated";
        compare(button.Accessible.name, "Explicit destination");
        fixture.action.badgeVisible = false;
        tryCompare(badge, "visible", false);
        fixture.action.badgeVisible = true;
        fixture.action.badgeNotification = true;
        compare(badge.effectiveVariant, MD.Badge.Small);
        button.badgeVariant = MD.Badge.Large;
        fixture.action.badgeNotification = false;
        compare(badge.effectiveVariant, MD.Badge.Large);
        mouseClick(button, button.width / 2, button.height / 2);
        compare(fixture.activations, 1);
    }

    function test_elidedInlinePaintBounds_data() {
        const rows = [];
        for (const rtl of [false, true]) {
            for (const lines of [1, 2]) {
                for (const source of ["none", "symbol", "image"]) {
                    rows.push({tag: rtl + "-" + lines + "-" + source,
                               rtl: rtl, lines: lines, source: source});
                }
            }
        }
        return rows;
    }
    function test_elidedInlinePaintBounds(data) {
        const control = createTemporaryObject(emptyBarComponent, testCase, {width: 210});
        control.LayoutMirroring.enabled = data.rtl;
        const button = buttonComponent.createObject(control, {
            text: "A long localized destination label with many words to truncate",
            display: T.AbstractButton.TextBesideIcon,
            maximumLineCount: data.lines,
            badgeContent: 12
        });
        control.addItem(button);
        if (data.source === "image")
            button.icon.source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
        else if (data.source === "symbol")
            button.icon.name = MD.Symbols.mail;
        const label = findChild(button, "tabLabel");
        const badge = findChild(button, "tabBadge");
        const icon = findChild(button, "tabIconSlot");
        const group = findChild(button, "tabContentGroup");
        tryVerify(() => label.truncated && label.lineCount === data.lines);
        // Exercise the slack between Text's allocation and its rendered bounds.
        for (let width = 210; width < 250
                && label.width - Math.min(label.width, label.contentWidth) < 1; ++width) {
            control.width = width;
            wait(0);
        }
        verify(label.width - Math.min(label.width, label.contentWidth) >= 1);
        if (data.rtl) {
            fuzzyCompare(labelPaintLeft(label) - badge.x - badge.width, 4, 0.5);
            if (icon.visible)
                fuzzyCompare(icon.x - labelPaintRight(label), 8, 0.5);
        } else {
            fuzzyCompare(badge.x - labelPaintRight(label), 4, 0.5);
            if (icon.visible)
                fuzzyCompare(labelPaintLeft(label) - icon.x - icon.width, 8, 0.5);
        }
        const left = Math.min(icon.visible ? icon.x : Infinity, badge.x, labelPaintLeft(label));
        const right = Math.max(icon.visible ? icon.x + icon.width : 0,
                               badge.x + badge.width, labelPaintRight(label));
        fuzzyCompare(group.x + (left + right) / 2, button.contentItem.width / 2, 0.5);
    }

    function test_overlayBadgePaintContainment_data() {
        const rows = [];
        for (const rtl of [false, true]) {
            for (const size of [14, 40]) {
                for (const display of [T.AbstractButton.TextUnderIcon, T.AbstractButton.IconOnly]) {
                    for (const mode of [MD.TabBar.Fixed, MD.TabBar.Scrollable]) {
                        for (const text of ["I", "Destination"]) {
                            rows.push({tag: rtl + "-" + size + "-" + display + "-" + mode + "-" + text,
                                       rtl: rtl, size: size, display: display, mode: mode, text: text});
                        }
                    }
                }
            }
        }
        return rows;
    }
    function test_overlayBadgePaintContainment(data) {
        const control = createTemporaryObject(emptyBarComponent, testCase,
                                             {width: 360, layoutMode: data.mode});
        control.LayoutMirroring.enabled = data.rtl;
        const button = buttonComponent.createObject(control, {text: data.text, display: data.display});
        button.font.pixelSize = data.size;
        button.icon.name = MD.Symbols.mail;
        control.addItem(button);
        const badge = findChild(button, "tabBadge");
        const icon = findChild(button, "tabIconSlot");
        const indicator = findChild(control, "tabIndicator");
        tryCompare(indicator, "width", button._primaryIndicatorWidth);
        const anchorWidth = indicator.width;
        button.badgeContent = 1000;
        button.badgeVariant = MD.Badge.Large;
        tryCompare(badge, "visible", true);
        if (data.mode === MD.TabBar.Fixed && data.text === "I")
            control.width = control._minimumTabWidth;
        tryVerify(() => fullyVisible(control, button));
        const view = viewport(control);
        const bounds = badge.mapToItem(view, 0, 0);
        verify(bounds.x >= -0.5);
        verify(bounds.x + badge.width <= view.width + 0.5);
        verify(bounds.y >= -0.5);
        verify(bounds.y + badge.height <= view.height + 0.5);
        const ownBounds = badge.mapToItem(button, 0, 0);
        verify(ownBounds.x >= -0.5 && ownBounds.x + badge.width <= button.width + 0.5);
        verify(ownBounds.y >= -0.5 && ownBounds.y + badge.height <= button.height + 0.5);
        fuzzyCompare(badge.y + badge.height - icon.y, 6, 0.5);
        tryVerify(() => Math.abs(indicator.width - anchorWidth) < 0.5);
    }

    function test_sourceIconGeometryTintAndSemantics() {
        const control = bar();
        const button = control.itemAt(0);
        button.text = "Destination";
        button.icon.source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
        const image = findChild(button, "tabSourceImage");
        const symbol = findChild(button, "tabSymbol");
        verify(image && symbol);
        tryCompare(image, "status", Image.Ready);
        verify(image.visible);
        verify(!symbol.visible);
        compare(image.width, 24);
        compare(image.height, 24);
        compare(image.color, button.contentColor);
        verify(image.Accessible.ignored);
        button.icon.color = "red";
        compare(image.color, "#ff0000");
        button.tintSourceIcon = false;
        compare(image.color, "#00000000");
        button.display = T.AbstractButton.IconOnly;
        button.Accessible.name = "Destination";
        compare(button.Accessible.name, "Destination");
        tryCompare(button, "implicitHeight", 48);
        control.LayoutMirroring.enabled = true;
        tryVerify(() => button.mirrored);
        const group = findChild(button, "tabContentGroup");
        fuzzyCompare(group.x + group.width / 2, button.contentItem.width / 2, 0.5);
    }

    function test_semanticThemesAndOverrides_data() {
        return [{tag: "primary", variant: MD.TabBar.Primary},
                {tag: "secondary", variant: MD.TabBar.Secondary}];
    }
    function test_semanticThemesAndOverrides(data) {
        const control = bar({variant: data.variant});
        const active = control.itemAt(0);
        const inactive = control.itemAt(1);
        mouseMove(testCase, 900, 650);
        for (const theme of [MD.Style.Light, MD.Style.Dark]) {
            control.MD.Style.theme = theme;
            compare(active.MD.Style.theme, theme);
            compare(inactive.MD.Style.theme, theme);
            compare(control.containerColor, control.MD.Style.surfaceColor);
            compare(control.indicatorColor, control.MD.Style.primaryColor);
            compare(control.dividerColor, control.MD.Style.outlineVariantColor);
            compare(active.contentColor, data.variant === MD.TabBar.Primary
                    ? active.MD.Style.primaryColor : active.MD.Style.onSurfaceColor);
            compare(inactive.contentColor, inactive.MD.Style.onSurfaceVariantColor);
            compare(findChild(control, "tabIndicator").color, control.indicatorColor);
            compare(findChild(control, "tabDivider").color, control.dividerColor);
        }
        inactive.MD.Style.theme = MD.Style.Light;
        compare(inactive.MD.Style.theme, MD.Style.Light);
        mouseMove(inactive, inactive.width / 2, inactive.height / 2);
        tryCompare(inactive, "hovered", true);
        compare(inactive.contentColor, inactive.MD.Style.onSurfaceColor);
        const state = findChild(inactive, "tabStateLayer");
        verify(state);
        compare(state.stateOpacity, MD.Tokens.tab.hoverStateLayerOpacity);
        mouseMove(testCase, 900, 650);
        inactive.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(inactive, "visualFocus", true);
        compare(inactive.contentColor, inactive.MD.Style.onSurfaceColor);
        compare(state.stateOpacity, MD.Tokens.tab.focusStateLayerOpacity);
        verifySelection(control, 0);
        mousePress(inactive, inactive.width / 2, inactive.height / 2);
        compare(inactive.contentColor, inactive.MD.Style.onSurfaceColor);
        compare(state.stateOpacity, MD.Tokens.tab.pressedStateLayerOpacity);
        mouseRelease(inactive, inactive.width / 2, inactive.height / 2);
        verifySelection(control, 1);
        inactive.enabled = false;
        compare(state.stateOpacity, 0);
        compare(inactive.contentColor, data.variant === MD.TabBar.Primary
                ? inactive.MD.Style.primaryColor : inactive.MD.Style.onSurfaceColor);
        control.containerColor = "red";
        control.indicatorColor = "green";
        control.dividerColor = "blue";
        active.contentColor = "yellow";
        active.stateLayerColor = "cyan";
        control.MD.Style.theme = MD.Style.Light;
        compare(control.containerColor, "#ff0000");
        compare(control.indicatorColor, "#008000");
        compare(control.dividerColor, "#0000ff");
        compare(active.contentColor, "#ffff00");
        compare(active.stateLayerColor, "#00ffff");
    }
}
