// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls as QQC
import QtQuick.Templates as T
import QtTest
import Fluid as MD
import "../../../src/controls/qml/internal/MotionAnimation.js" as MotionAnimation

TestCase {
    id: testCase
    name: "SplitButtonTests"
    width: 1000
    height: 800
    visible: true
    when: windowShown

    readonly property var suffixes: ["ExtraSmall", "Small", "Medium", "Large", "ExtraLarge"]
    readonly property url sourceIcon: Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png")

    Component {
        id: buttonComponent
        MD.SplitButton { text: "Save"; x: 100; y: 100 }
    }
    Component {
        id: actionComponent
        MD.Action { text: "Save"; icon.name: MD.Symbols.save }
    }
    Component {
        id: menuComponent
        MD.Menu {
            MD.Action { text: "Unavailable"; enabled: false }
            MD.Action { text: "Save as" }
            MD.Action { text: "Export" }
        }
    }
    Component {
        id: focusComponent
        Item {
            property alias before: before
            property alias split: split
            property alias after: after
            width: testCase.width
            height: testCase.height
            MD.Button { id: before; text: "Before"; x: 20; y: 20 }
            MD.SplitButton { id: split; text: "Save"; x: 100; y: 100 }
            MD.Button { id: after; text: "After"; x: 600; y: 20 }
        }
    }
    Component {
        id: customPopupComponent
        Item {
            property alias split: split
            property alias popup: popup
            width: testCase.width
            height: testCase.height
            MD.SplitButton {
                id: split
                text: "Save"
                expanded: popup.visible
                onSecondaryClicked: popup.visible ? popup.close() : popup.open()
            }
            QQC.Popup { id: popup; x: 200; y: 200; width: 100; height: 100 }
        }
    }
    Component { id: spyComponent; SignalSpy {} }
    Component { id: backgroundComponent; Item {} }

    function makeButton(properties) {
        const button = createTemporaryObject(buttonComponent, testCase, properties || {});
        verify(button);
        wait(0);
        return button;
    }
    function spyFor(target, signal) {
        const spy = createTemporaryObject(spyComponent, testCase, {target: target, signalName: signal});
        verify(spy.valid);
        return spy;
    }
    function background(button, trailing) {
        const item = findChild(button, trailing ? "splitButtonTrailingBackground" : "splitButtonLeadingBackground");
        verify(item);
        return item;
    }
    function content(button, trailing) {
        const item = findChild(button, trailing ? "splitButtonTrailingContent" : "splitButtonLeadingContent");
        verify(item);
        return item;
    }
    function attachMenu(button, properties) {
        const menu = createTemporaryObject(menuComponent, testCase, properties || {});
        verify(menu);
        button.menu = menu;
        return menu;
    }
    function click(item) {
        mouseClick(item, item.width / 2, item.height / 2);
    }
    function near(actual, expected, message) {
        verify(Math.abs(actual - expected) <= 0.5, message + ": " + actual + " vs " + expected);
    }
    function surfaceRect(button, trailing) {
        const item = background(button, trailing);
        const point = item.mapToItem(testCase, 0, 0);
        return {x: point.x, y: point.y, width: item.width, height: item.height};
    }
    function menuRect(menu) {
        const point = menu.contentItem.mapToItem(testCase, -menu.leftPadding, -menu.topPadding);
        return {x: point.x, y: point.y, width: menu.width, height: menu.height};
    }

    function test_standardSpringCurveNativeContract_data() {
        return [
            {tag: "spatial", spring: MD.Tokens.motion.spring.standardFastSpatial},
            {tag: "effects", spring: MD.Tokens.motion.spring.standardFastEffects}
        ];
    }
    function test_standardSpringCurveNativeContract(data) {
        const curve = MotionAnimation.standardSpringCurve(data.spring);
        verify(curve.length > 0);
        compare(curve.length % 6, 0);
        // QEasingCurve::BezierEase stores at most ten cubic segments internally.
        verify(curve.length / 6 <= 10, "curve exceeds Qt's native easing capacity");
        compare(curve[curve.length - 2], 1);
        compare(curve[curve.length - 1], 1);
        let start = 0;
        for (let index = 0; index < curve.length; index += 6) {
            for (let offset = 0; offset < 6; ++offset)
                verify(isFinite(curve[index + offset]), "curve has non-finite coordinates");
            verify(start < curve[index]);
            verify(curve[index] < curve[index + 2]);
            verify(curve[index + 2] < curve[index + 4]);
            verify(curve[index + 4] <= 1);
            start = curve[index + 4];
        }
    }

    function test_defaultsAndAliases() {
        const button = makeButton();
        compare(button.type, MD.SplitButton.Filled);
        compare(button.size, MD.SplitButton.Small);
        compare(button.display, T.AbstractButton.TextBesideIcon);
        compare(button.menu, null);
        verify(!button.expanded);
        verify(button.primaryEnabled && button.secondaryEnabled);
        verify(button.secondaryText.length > 0);
        verify(button.leadingButton !== button.trailingButton);
        compare(button.leadingButton.text, "Save");
        button.text = "Export";
        button.icon.name = MD.Symbols.save;
        compare(button.leadingButton.text, "Export");
        compare(button.leadingButton.icon.name, MD.Symbols.save);
        compare(button.leadingButton.focusPolicy, Qt.StrongFocus);
        compare(button.trailingButton.focusPolicy, Qt.StrongFocus);
        button.openMenu();
        button.closeMenu();
        button.toggleMenu();
        verify(!button.expanded);
    }

    function test_variants_data() {
        const rows = [];
        for (let type = MD.SplitButton.Filled; type <= MD.SplitButton.Outlined; ++type) {
            for (let size = MD.SplitButton.ExtraSmall; size <= MD.SplitButton.ExtraLarge; ++size) {
                for (const theme of [MD.Style.Light, MD.Style.Dark])
                    rows.push({tag: type + "-" + size + "-" + theme, type: type, size: size, theme: theme});
            }
        }
        return rows;
    }
    function test_variants(data) {
        const button = makeButton({type: data.type, size: data.size});
        button.MD.Style.theme = data.theme;
        const token = MD.Tokens.splitButton;
        const suffix = suffixes[data.size];
        const leading = button.leadingButton;
        const trailing = button.trailingButton;
        const first = background(button, false);
        const second = background(button, true);
        compare(first.height, token["containerHeight" + suffix]);
        compare(second.height, first.height);
        near(surfaceRect(button, true).x - surfaceRect(button, false).x - first.width, 2, "visible gap");
        compare(button.implicitHeight, Math.max(48, first.height));
        verify(leading.width >= 48 && leading.height >= 48);
        verify(trailing.width >= 48 && trailing.height >= 48);
        compare(trailing.width, [48, 48, 56, 96, 136][data.size]);
        near(first.mapToItem(leading, 0, 0).y, (leading.height - first.height) / 2, "centered leading surface");
        near(second.mapToItem(trailing, 0, 0).y, (trailing.height - second.height) / 2, "centered trailing surface");
        compare(findChild(button, "splitButtonTrailingSymbol").width, token["trailingIconSize" + suffix]);
        const style = button.MD.Style;
        const containers = [style.primaryColor, style.secondaryContainerColor, style.surfaceContainerLowColor, Qt.rgba(0, 0, 0, 0)];
        const colors = [style.onPrimaryColor, style.onSecondaryContainerColor, style.primaryColor, style.onSurfaceVariantColor];
        compare(first.containerColor, containers[data.type]);
        compare(second.containerColor, containers[data.type]);
        compare(content(button, false).contentColor, colors[data.type]);
        compare(content(button, true).contentColor, colors[data.type]);
        compare(first.outlineWidth, data.type === MD.SplitButton.Outlined ? MD.Tokens.button["outlinedOutlineWidth" + suffix] : 0);
        if (data.type === MD.SplitButton.Outlined)
            compare(first.outlineColor, style.outlineVariantColor);
        const scales = [MD.Tokens.typescale.labelLarge, MD.Tokens.typescale.labelLarge,
                        MD.Tokens.typescale.titleMedium, MD.Tokens.typescale.headlineSmall,
                        MD.Tokens.typescale.headlineLarge];
        compare(button.typescale.fontSize, scales[data.size].fontSize);
        button.expanded = true;
        compare(first.containerColor, containers[data.type]);
        compare(second.containerColor, containers[data.type]);
    }

    function test_contentAndImplicitSize_data() {
        const rows = [];
        for (let size = 0; size < 5; ++size) {
            for (const mode of ["label", "symbol", "source", "combined"])
                rows.push({tag: suffixes[size] + "-" + mode, size: size, mode: mode});
        }
        return rows;
    }
    function test_contentAndImplicitSize(data) {
        const button = makeButton({size: data.size});
        if (data.mode !== "label")
            button.icon.name = MD.Symbols.save;
        if (data.mode === "source")
            button.icon.source = sourceIcon;
        if (data.mode === "symbol" || data.mode === "source") {
            button.text = "";
            button.leadingButton.Accessible.name = "Save document";
        }
        const suffix = suffixes[data.size];
        const leadingContent = content(button, false);
        const label = findChild(button, "splitButtonLabel");
        const symbol = findChild(button, "splitButtonSymbol");
        const image = findChild(button, "splitButtonSourceIcon");
        verify(label && symbol && image);
        compare(label.visible, data.mode === "label" || data.mode === "combined");
        compare(symbol.visible, data.mode === "symbol" || data.mode === "combined");
        compare(image.visible, data.mode === "source");
        if (data.mode === "source") {
            tryCompare(image, "status", Image.Ready);
            compare(image.source, sourceIcon);
        }
        const iconWidth = data.mode === "label" ? 0 : MD.Tokens.button["iconSize" + suffix];
        const labelWidth = label.visible ? label.implicitWidth : 0;
        const gap = data.mode === "combined" ? MD.Tokens.button["iconLabelSpace" + suffix] : 0;
        compare(leadingContent.implicitWidth, iconWidth + labelWidth + gap);
        const primaryWidth = Math.max(48, leadingContent.implicitWidth
                                     + MD.Tokens.splitButton["leadingButtonLeadingSpace" + suffix]
                                     + MD.Tokens.splitButton["leadingButtonTrailingSpace" + suffix]);
        near(button.leadingButton.width, primaryWidth, "content-derived primary width");
        near(button.implicitWidth, primaryWidth + button.trailingButton.width + 2, "combined implicit width");
        button.typescale = MD.Tokens.typescale.bodySmall;
        button.size = MD.SplitButton.Large;
        compare(button.typescale.fontSize, MD.Tokens.typescale.bodySmall.fontSize);
    }

    function test_availableWidthHeightAndClamping() {
        const button = makeButton({text: "A long primary action that must be elided"});
        const trailingWidth = button.trailingButton.width;
        const originalLeading = button.leadingButton.width;
        button.width = button.implicitWidth + 100;
        wait(0);
        compare(button.trailingButton.width, trailingWidth);
        near(button.leadingButton.width, originalLeading + 100, "extra width belongs to primary");
        button.height = 120;
        wait(0);
        compare(button.leadingButton.height, 120);
        compare(button.trailingButton.height, 120);
        compare(background(button, false).height, 40);
        near(background(button, false).mapToItem(button, 0, 0).y, 40, "explicit-height surface centering");
        button.width = 100;
        wait(0);
        compare(button.trailingButton.width, trailingWidth);
        verify(button.leadingButton.width >= 48);
        const label = findChild(button, "splitButtonLabel");
        compare(label.elide, Text.ElideRight);
        verify(label.width < label.implicitWidth);
        button.width = 30;
        wait(0);
        verify(button.leadingButton.width >= 0);
        verify(button.trailingButton.width >= 0);
        for (const trailing of [false, true]) {
            const surface = background(button, trailing);
            const limit = Math.min(surface.width, surface.height) / 2;
            for (const property of ["topLeftRadius", "topRightRadius", "bottomLeftRadius", "bottomRightRadius"])
                verify(surface[property] >= 0 && surface[property] <= limit);
        }
    }

    function test_implicitBackgroundInsetsAndPadding_data() {
        return suffixes.map((suffix, size) => ({tag: suffix, size: size}));
    }
    function test_implicitBackgroundInsetsAndPadding(data) {
        const button = makeButton({size: data.size});
        const contentWidth = button.implicitContentWidth;
        const contentHeight = button.implicitContentHeight;
        const customBackground = createTemporaryObject(backgroundComponent, button, {
            implicitWidth: contentWidth + 100,
            implicitHeight: contentHeight + 60
        });
        verify(customBackground);
        button.background = customBackground;
        button.leftInset = 7;
        button.rightInset = 11;
        button.topInset = 5;
        button.bottomInset = 13;
        button.leftPadding = 9;
        button.rightPadding = 15;
        button.topPadding = 3;
        button.bottomPadding = 4;
        compare(button.implicitWidth, customBackground.implicitWidth + 18);
        compare(button.implicitHeight, customBackground.implicitHeight + 18);
        customBackground.implicitWidth = 1;
        customBackground.implicitHeight = 1;
        compare(button.implicitWidth, contentWidth + 24);
        compare(button.implicitHeight, contentHeight + 7);
        wait(0);
        verify(button.leadingButton.width >= 48 && button.trailingButton.width >= 48);
        verify(button.leadingButton.height >= 48 && button.trailingButton.height >= 48);
    }

    function test_nativeDisplayAndIconAliases() {
        const button = makeButton();
        button.icon.name = MD.Symbols.save;
        button.icon.color = "#d03412";
        compare(button.leadingButton.icon.color, "#d03412");
        const body = content(button, false);
        const label = findChild(body, "splitButtonLabel");
        const symbol = findChild(body, "splitButtonSymbol");
        button.display = T.AbstractButton.TextOnly;
        compare(button.leadingButton.display, T.AbstractButton.TextOnly);
        verify(label.visible && !symbol.visible);
        near(body.implicitWidth, label.implicitWidth, "text-only display width");
        button.display = T.AbstractButton.IconOnly;
        button.leadingButton.Accessible.name = "Save document";
        verify(symbol.visible && !label.visible);
        compare(body.implicitWidth, button.icon.width);
        button.display = T.AbstractButton.TextUnderIcon;
        verify(symbol.visible && label.visible);
        near(body.implicitWidth, Math.max(button.icon.width, label.implicitWidth), "stacked display width");
        near(body.implicitHeight, button.icon.height + label.implicitHeight + MD.Tokens.button.iconLabelSpaceSmall,
             "stacked display height");
    }

    function test_targetsOutsideVisibleSurfaces_data() {
        return [{tag: "extra-small", size: MD.SplitButton.ExtraSmall},
                {tag: "small", size: MD.SplitButton.Small}];
    }
    function test_targetsOutsideVisibleSurfaces(data) {
        const button = makeButton({size: data.size});
        const primary = spyFor(button, "clicked");
        const secondary = spyFor(button, "secondaryClicked");
        compare(button.leadingButton.height, 48);
        compare(button.trailingButton.height, 48);
        verify(background(button, false).mapToItem(button.leadingButton, 0, 0).y > 2);
        mouseClick(button.leadingButton, button.leadingButton.width / 2, 2);
        compare(primary.count, 1);
        compare(secondary.count, 0);
        const trailing = button.trailingButton;
        const touch = touchEvent(trailing);
        touch.press(0, trailing, trailing.width / 2, trailing.height - 2).commit();
        touch.release(0, trailing, trailing.width / 2, trailing.height - 2).commit();
        tryCompare(secondary, "count", 1);
        compare(primary.count, 1);
    }

    function test_independentSignalsActionsAndInput_data() {
        return [{tag: "mouse", mode: "mouse"}, {tag: "touch", mode: "touch"},
                {tag: "space", mode: "space"}, {tag: "enter", mode: "enter"}];
    }
    function activate(item, mode) {
        if (mode === "mouse") {
            click(item);
        } else if (mode === "touch") {
            const touch = touchEvent(item);
            touch.press(0, item, item.width / 2, 2).commit();
            touch.release(0, item, item.width / 2, 2).commit();
        } else {
            item.forceActiveFocus(Qt.TabFocusReason);
            keyClick(mode === "space" ? Qt.Key_Space : Qt.Key_Return);
        }
    }
    function test_independentSignalsActionsAndInput(data) {
        const button = makeButton();
        const action = createTemporaryObject(actionComponent, testCase);
        button.action = action;
        const primary = spyFor(button, "clicked");
        const secondary = spyFor(button, "secondaryClicked");
        const triggered = spyFor(action, "triggered");
        activate(button.leadingButton, data.mode);
        tryCompare(primary, "count", 1);
        compare(triggered.count, 1);
        compare(secondary.count, 0);
        activate(button.trailingButton, data.mode);
        tryCompare(secondary, "count", 1);
        compare(primary.count, 1);
        compare(triggered.count, 1);
        verify(!button.expanded);
        action.enabled = false;
        verify(!button.leadingButton.enabled);
        verify(button.trailingButton.enabled);
        activate(button.leadingButton, data.mode);
        compare(primary.count, 1);
        compare(triggered.count, 1);
        activate(button.trailingButton, data.mode);
        compare(secondary.count, 2);
        button.secondaryEnabled = false;
        activate(button.trailingButton, data.mode);
        compare(secondary.count, 2);
        action.enabled = true;
        button.primaryEnabled = false;
        verify(!button.leadingButton.enabled);
        button.primaryEnabled = true;
        button.secondaryEnabled = true;
        button.enabled = false;
        verify(!button.leadingButton.enabled && !button.trailingButton.enabled);
        activate(button.leadingButton, data.mode);
        activate(button.trailingButton, data.mode);
        compare(primary.count, 1);
        compare(secondary.count, 2);
    }

    function test_focusOrder_data() {
        return [{tag: "ltr", rtl: false}, {tag: "rtl", rtl: true}];
    }
    function test_focusOrder(data) {
        const host = createTemporaryObject(focusComponent, testCase);
        host.split.LayoutMirroring.enabled = data.rtl;
        host.before.forceActiveFocus();
        keyClick(Qt.Key_Tab);
        tryVerify(() => host.split.leadingButton.activeFocus);
        keyClick(Qt.Key_Right);
        verify(host.split.leadingButton.activeFocus);
        keyClick(Qt.Key_Tab);
        verify(host.split.trailingButton.activeFocus);
        keyClick(Qt.Key_Tab);
        verify(host.after.activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.split.trailingButton.activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.split.leadingButton.activeFocus);
        keyClick(Qt.Key_Backtab);
        verify(host.before.activeFocus);
    }

    function test_managedMenuLifecycle() {
        const button = makeButton();
        const menu = attachMenu(button);
        const secondary = spyFor(button, "secondaryClicked");
        const opened = spyFor(menu, "opened");
        click(button.trailingButton);
        tryCompare(menu, "opened", true);
        compare(button.expanded, true);
        compare(secondary.count, 1);
        compare(opened.count, 1);
        click(button.trailingButton);
        tryCompare(menu, "visible", false);
        verify(!button.expanded);
        compare(secondary.count, 2);
        button.expanded = true;
        tryCompare(menu, "opened", true);
        button.expanded = false;
        tryCompare(menu, "visible", false);
        button.openMenu();
        tryCompare(menu, "opened", true);
        button.closeMenu();
        tryCompare(menu, "visible", false);
        button.toggleMenu();
        tryCompare(menu, "opened", true);
        menu.close();
        tryCompare(button, "expanded", false);
        tryCompare(menu, "visible", false);
        menu.popup(button.trailingButton, 0, button.trailingButton.height);
        tryCompare(button, "expanded", true);
        menu.close();
        tryCompare(button, "expanded", false);
        compare(secondary.count, 2);
        button.openMenu();
        tryCompare(menu, "opened", true);
        const replacement = attachMenu(button);
        tryCompare(menu, "visible", false);
        tryCompare(button, "expanded", false);
        menu.popup(testCase, 0, 0);
        tryCompare(menu, "opened", true);
        verify(!button.expanded);
        menu.close();
        button.openMenu();
        tryCompare(replacement, "opened", true);
        replacement.destroy();
        tryCompare(button, "menu", null);
        tryCompare(button, "expanded", false);
    }

    function test_trailingPressDismissalDoesNotReopen_data() {
        return [
            {tag: "mouse-animated", touch: false, animated: true},
            {tag: "mouse-no-exit", touch: false, animated: false},
            {tag: "touch-animated", touch: true, animated: true},
            {tag: "touch-no-exit", touch: true, animated: false}
        ];
    }
    function test_trailingPressDismissalDoesNotReopen(data) {
        const button = makeButton();
        const menu = attachMenu(button, data.animated ? {} : {exit: null});
        const policy = menu.closePolicy;
        const secondary = spyFor(button, "secondaryClicked");
        const opened = spyFor(menu, "opened");
        button.openMenu();
        tryCompare(menu, "opened", true);
        const trailing = button.trailingButton;
        const touch = data.touch ? touchEvent(trailing) : null;
        if (data.touch)
            touch.press(0, trailing, trailing.width / 2, trailing.height / 2).commit();
        else
            mousePress(trailing, trailing.width / 2, trailing.height / 2);
        // Let the exit finish while the native template is still pressed.
        tryCompare(menu, "visible", false);
        wait(20);
        compare(secondary.count, 0);
        if (data.touch)
            touch.release(0, trailing, trailing.width / 2, trailing.height / 2).commit();
        else
            mouseRelease(trailing, trailing.width / 2, trailing.height / 2);
        tryCompare(secondary, "count", 1);
        wait(0);
        verify(!menu.visible && !button.expanded);
        compare(opened.count, 1);
        compare(menu.closePolicy, policy);
        click(trailing);
        tryCompare(menu, "opened", true);
        compare(secondary.count, 2);
        menu.close();
    }

    function test_disabledOrHiddenClosesMenu_data() {
        return [{tag: "disabled", property: "enabled"}, {tag: "hidden", property: "visible"},
                {tag: "secondary-disabled", property: "secondaryEnabled"}];
    }
    function test_disabledOrHiddenClosesMenu(data) {
        const button = makeButton();
        const menu = attachMenu(button);
        button.openMenu();
        tryCompare(menu, "opened", true);
        button[data.property] = false;
        tryCompare(menu, "visible", false);
        verify(!button.expanded);
    }

    function test_keyboardMenuEntrySelectionEscapeAndFocus() {
        const host = createTemporaryObject(focusComponent, testCase);
        const button = host.split;
        const menu = attachMenu(button);
        const primary = spyFor(button, "clicked");
        const secondary = spyFor(button, "secondaryClicked");
        const action = spyFor(menu.itemAt(1).action, "triggered");
        button.trailingButton.forceActiveFocus(Qt.TabFocusReason);
        keyClick(Qt.Key_Space);
        tryCompare(menu, "opened", true);
        tryCompare(menu, "currentIndex", 1);
        verify(menu.itemAt(1).activeFocus);
        keyClick(Qt.Key_Escape);
        tryCompare(button, "expanded", false);
        tryVerify(() => button.trailingButton.activeFocus);
        keyClick(Qt.Key_Return);
        tryCompare(menu, "opened", true);
        keyClick(Qt.Key_Return);
        tryCompare(menu, "visible", false);
        compare(action.count, 1);
        compare(primary.count, 0);
        compare(secondary.count, 2);
        compare(button.text, "Save");
        tryVerify(() => button.trailingButton.activeFocus);
        keyClick(Qt.Key_Space);
        tryCompare(menu, "opened", true);
        click(host.after);
        tryCompare(menu, "visible", false);
        tryVerify(() => host.after.activeFocus);
        verify(!button.trailingButton.activeFocus);
    }

    function test_menuFocusRestorationAfterNonKeyboardOpen_data() {
        return [
            {tag: "programmatic-animated", animated: true},
            {tag: "programmatic-no-exit", animated: false}
        ];
    }
    function test_menuFocusRestorationAfterNonKeyboardOpen(data) {
        const host = createTemporaryObject(focusComponent, testCase);
        const button = host.split;
        const menu = attachMenu(button, data.animated ? {} : {exit: null});
        host.before.forceActiveFocus(Qt.TabFocusReason);
        verify(host.before.activeFocus);
        button.openMenu();
        tryCompare(menu, "opened", true);
        menu.currentIndex = 1;
        menu.itemAt(1).forceActiveFocus(Qt.PopupFocusReason);
        verify(menu.itemAt(1).activeFocus);
        menu.close();
        tryCompare(menu, "visible", false);
        tryVerify(() => button.trailingButton.activeFocus);

        host.before.forceActiveFocus(Qt.TabFocusReason);
        button.openMenu();
        tryCompare(menu, "opened", true);
        menu.itemAt(1).forceActiveFocus(Qt.PopupFocusReason);
        click(host.after);
        tryCompare(menu, "visible", false);
        tryVerify(() => host.after.activeFocus);
        verify(!button.trailingButton.activeFocus);

        button.openMenu();
        tryCompare(menu, "opened", true);
        menu.itemAt(1).forceActiveFocus(Qt.PopupFocusReason);
        host.before.forceActiveFocus(Qt.TabFocusReason);
        wait(0);
        menu.close();
        tryCompare(menu, "visible", false);
        tryVerify(() => host.before.activeFocus);
        verify(!button.trailingButton.activeFocus);
    }

    function test_customPopupBindingAndAccessibility() {
        const host = createTemporaryObject(customPopupComponent, testCase);
        const button = host.split;
        const secondary = spyFor(button, "secondaryClicked");
        click(button.trailingButton);
        tryCompare(host.popup, "opened", true);
        compare(button.expanded, true);
        verify(button.trailingButton.Accessible.expandable);
        verify(button.trailingButton.Accessible.expanded);
        compare(secondary.count, 1);
        host.popup.close();
        tryCompare(button, "expanded", false);
        verify(!button.trailingButton.Accessible.expanded);
        host.popup.open();
        tryCompare(button, "expanded", true);
        host.popup.close();
        tryCompare(button, "expanded", false);
        click(button.trailingButton);
        tryCompare(button, "expanded", true);
        compare(secondary.count, 2);
        host.popup.close();
    }

    function test_independentStatesAndOpticalGeometry_data() {
        const rows = [];
        for (let size = 0; size < 5; ++size) {
            for (const rtl of [false, true])
                rows.push({tag: suffixes[size] + (rtl ? "-rtl" : "-ltr"), size: size, rtl: rtl});
        }
        return rows;
    }
    function assertOpticalGeometry(button, trailing, rtl) {
        const surface = background(button, trailing);
        const body = content(button, trailing);
        const start = rtl ? (surface.topRightRadius + surface.bottomRightRadius) / 2
                          : (surface.topLeftRadius + surface.bottomLeftRadius) / 2;
        const end = rtl ? (surface.topLeftRadius + surface.bottomLeftRadius) / 2
                        : (surface.topRightRadius + surface.bottomRightRadius) / 2;
        const expected = Math.max(-body.startPadding, Math.min(body.endPadding, 0.11 * (start - end)));
        near(surface.opticalOffset, expected, "optical offset follows current animated radii");
        near(body.opticalOffset, expected, "content follows optical shape offset");
        const naturalCenter = (rtl ? body.endPadding : body.startPadding)
                            + (body.availableWidth - body.rowWidth) / 2;
        near(body.rowX - naturalCenter, rtl ? -expected : expected, "physical optical direction");
    }
    function test_independentStatesAndOpticalGeometry(data) {
        const button = makeButton({size: data.size});
        button.LayoutMirroring.enabled = data.rtl;
        mouseMove(testCase, width - 2, height - 2);
        testCase.forceActiveFocus();
        const first = background(button, false);
        const second = background(button, true);
        const leading = button.leadingButton;
        const trailing = button.trailingButton;
        const innerProperty = data.rtl ? "topLeftRadius" : "topRightRadius";
        const trailingInner = data.rtl ? "topRightRadius" : "topLeftRadius";
        const outerProperty = data.rtl ? "topRightRadius" : "topLeftRadius";
        const resting = [4, 4, 4, 8, 12][data.size];
        const interactive = [8, 12, 12, 20, 20][data.size];
        tryCompare(first, innerProperty, resting);
        tryCompare(second, trailingInner, resting);
        verify(data.rtl ? leading.x > trailing.x : leading.x < trailing.x);
        near(first[outerProperty], Math.min(first.width, first.height) / 2, "full outer radius");
        assertOpticalGeometry(button, false, data.rtl);
        assertOpticalGeometry(button, true, data.rtl);
        mouseMove(leading, leading.width / 2, leading.height / 2);
        tryCompare(leading, "hovered", true);
        compare(first.stateOpacity, MD.Tokens.state.hoverStateLayerOpacity);
        compare(second.stateOpacity, 0);
        tryCompare(first, innerProperty, interactive);
        tryCompare(second, trailingInner, resting);
        leading.forceActiveFocus(Qt.TabFocusReason);
        compare(first.stateOpacity, MD.Tokens.state.focusStateLayerOpacity);
        mousePress(leading, leading.width / 2, leading.height / 2);
        compare(first.stateOpacity, MD.Tokens.state.pressedStateLayerOpacity);
        compare(second.stateOpacity, 0);
        mouseRelease(leading, leading.width / 2, leading.height / 2);
        testCase.forceActiveFocus();
        mouseMove(testCase, width - 2, height - 2);
        tryCompare(first, innerProperty, resting);
        button.expanded = true;
        tryCompare(second, trailingInner, Math.min(second.width, second.height) / 2);
        compare(second.stateOpacity, 0.10);
        compare(first.stateOpacity, 0);
        near(second.opticalOffset, 0, "expanded symmetrical trailing surface");
        trailing.forceActiveFocus(Qt.TabFocusReason);
        mouseMove(trailing, trailing.width / 2, trailing.height / 2);
        compare(second.stateOpacity, MD.Tokens.splitButton.trailingSelectedStateLayerOpacity);
        mousePress(trailing, trailing.width / 2, trailing.height / 2);
        compare(second.stateOpacity, MD.Tokens.state.pressedStateLayerOpacity);
        mouseRelease(trailing, trailing.width / 2, trailing.height / 2);
        button.secondaryEnabled = false;
        compare(second.stateOpacity, 0);
        compare(first.stateOpacity, 0);
        button.expanded = false;
        tryCompare(second, trailingInner, resting);
    }

    function test_disabledColorsAndElevation_data() {
        return test_variants_data();
    }
    function test_disabledColorsAndElevation(data) {
        const button = makeButton({type: data.type, size: data.size});
        button.MD.Style.theme = data.theme;
        mouseMove(testCase, width - 2, height - 2);
        testCase.forceActiveFocus();
        const first = background(button, false);
        const second = background(button, true);
        const normal = data.type === MD.SplitButton.Elevated ? MD.Tokens.elevation.level1 : MD.Tokens.elevation.level0;
        const hovered = data.type === MD.SplitButton.Outlined ? MD.Tokens.elevation.level0
                      : data.type === MD.SplitButton.Elevated ? MD.Tokens.elevation.level2 : MD.Tokens.elevation.level1;
        compare(first.elevation, normal);
        compare(second.elevation, normal);
        mouseMove(button.leadingButton, button.leadingButton.width / 2, button.leadingButton.height / 2);
        tryCompare(button.leadingButton, "hovered", true);
        tryCompare(first, "elevation", hovered);
        compare(second.elevation, normal);
        button.primaryEnabled = false;
        compare(first.stateOpacity, 0);
        tryCompare(first, "elevation", MD.Tokens.elevation.level0);
        compare(second.elevation, normal);
        compare(content(button, false).contentColor, button.MD.Style.onSurfaceVariantColor);
        compare(content(button, false).opacity, 0.38);
        compare(content(button, true).opacity, 1);
        if (data.type === MD.SplitButton.Outlined) {
            compare(first.color.a, 0);
            compare(first.outlineColor, button.MD.Style.outlineVariantColor);
        } else {
            compare(first.color, Qt.alpha(button.MD.Style.onSurfaceColor, 0.10));
        }
        button.enabled = false;
        compare(second.stateOpacity, 0);
        tryCompare(second, "elevation", MD.Tokens.elevation.level0);
        compare(content(button, true).contentColor, button.MD.Style.onSurfaceVariantColor);
        compare(content(button, true).opacity, 0.38);
    }

    function test_menuPlacement_data() {
        return [
            {tag: "preferred-ltr", x: 100, y: 100, width: 200, menuWidth: 180, rtl: false, edge: "leading"},
            {tag: "side-fallback-ltr", x: 780, y: 100, width: 200, menuWidth: 180, rtl: false, edge: "trailing"},
            {tag: "whole-fallback-ltr", x: 100, y: 100, width: 448, menuWidth: 600, rtl: false, edge: "whole-leading"},
            {tag: "preferred-rtl", x: 300, y: 100, width: 250, menuWidth: 180, rtl: true, edge: "leading"},
            {tag: "side-fallback-rtl", x: 20, y: 100, width: 250, menuWidth: 180, rtl: true, edge: "trailing"},
            {tag: "whole-fallback-rtl", x: 500, y: 100, width: 400, menuWidth: 600, rtl: true, edge: "whole-leading"},
            {tag: "above", x: 100, y: 720, width: 200, menuWidth: 180, rtl: false, edge: "leading", above: true}
        ];
    }
    function test_menuPlacement(data) {
        const button = makeButton({x: data.x, y: data.y, width: data.width});
        button.LayoutMirroring.enabled = data.rtl;
        const menu = attachMenu(button, {width: data.menuWidth});
        button.openMenu();
        tryCompare(menu, "opened", true);
        const surface = surfaceRect(button, true);
        const popup = menuRect(menu);
        const expected = data.edge === "whole-leading"
                       ? (data.rtl ? button.x + button.width - popup.width : button.x)
                       : data.edge === "leading"
                         ? (data.rtl ? surface.x + surface.width - popup.width : surface.x)
                         : (data.rtl ? surface.x : surface.x + surface.width - popup.width);
        near(popup.x, expected, "logical edge alignment");
        if (data.above)
            near(surface.y - popup.y - popup.height, 4, "above visible surface gap");
        else
            near(popup.y - surface.y - surface.height, 4, "below visible surface gap");
        verify(popup.x >= 0 && popup.x + popup.width <= width);
        verify(popup.y >= 0 && popup.y + popup.height <= height);
        menu.close();
    }

    function test_menuViewportOverflow() {
        const button = makeButton();
        const menu = attachMenu(button);
        for (let index = 0; index < 30; ++index) {
            const action = createTemporaryObject(actionComponent, menu, {text: "Item " + index});
            menu.addAction(action);
        }
        button.openMenu();
        tryCompare(menu, "opened", true);
        const popup = menuRect(menu);
        verify(popup.y >= 0 && popup.y + popup.height <= height);
        const list = findChild(menu, "menuListView");
        verify(list && list.clip && list.interactive);
        verify(list.contentHeight > list.height);
        menu.close();
    }

    function test_interruptedAnimations_data() {
        return [{tag: "ltr", rtl: false}, {tag: "rtl", rtl: true}];
    }
    function test_interruptedAnimations(data) {
        const button = makeButton({size: MD.SplitButton.Medium});
        button.LayoutMirroring.enabled = data.rtl;
        const surface = background(button, true);
        const symbol = findChild(button, "splitButtonTrailingSymbol");
        const innerProperty = data.rtl ? "topRightRadius" : "topLeftRadius";
        const direction = data.rtl ? -1 : 1;
        for (let cycle = 0; cycle < 4; ++cycle) {
            button.expanded = true;
            wait(35);
            const radius = surface[innerProperty];
            const rotation = symbol.rotation;
            verify(direction * rotation >= 0 && direction * rotation <= 180);
            assertOpticalGeometry(button, true, data.rtl);
            button.expanded = false;
            near(surface[innerProperty], radius, "shape has no instantaneous interruption jump");
            near(symbol.rotation, rotation, "rotation has no instantaneous interruption jump");
            wait(20);
        }
        button.expanded = true;
        tryCompare(surface, innerProperty, 28, 2000);
        tryCompare(symbol, "rotation", direction * 180, 2000);
        near(surface.opticalOffset, 0, "expanded endpoint optical symmetry");
        button.expanded = false;
        tryCompare(surface, innerProperty, 4, 2000);
        tryCompare(symbol, "rotation", 0, 2000);
        assertOpticalGeometry(button, true, data.rtl);
    }
}
