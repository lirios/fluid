// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtTest

TestCase {
    id: testCase

    name: "FabMenuTests"
    width: 480
    height: 640
    visible: true
    when: windowShown

    function compareShape(actual, expected, name) {
        compare(actual.topLeft, expected.topLeft, name + ".topLeft");
        compare(actual.topRight, expected.topRight, name + ".topRight");
        compare(actual.bottomLeft, expected.bottomLeft, name + ".bottomLeft");
        compare(actual.bottomRight, expected.bottomRight, name + ".bottomRight");
    }

    function compareRectangleShape(rectangle, shape, name) {
        const full = MD.Tokens.shape.cornerValueFull;
        const maximum = Math.min(rectangle.width, rectangle.height) / 2;
        compare(rectangle.topLeftRadius,
                shape.topLeft === full ? maximum : shape.topLeft, name + ".topLeftRadius");
        compare(rectangle.topRightRadius,
                shape.topRight === full ? maximum : shape.topRight, name + ".topRightRadius");
        compare(rectangle.bottomLeftRadius,
                shape.bottomLeft === full ? maximum : shape.bottomLeft,
                name + ".bottomLeftRadius");
        compare(rectangle.bottomRightRadius,
                shape.bottomRight === full ? maximum : shape.bottomRight,
                name + ".bottomRightRadius");
    }

    Item {
        id: focusSink

        x: 460
        y: 620
        width: 20
        height: 20
        focus: true
    }

    SignalSpy {
        id: clickedSpy

        signalName: "clicked"
    }

    Component {
        id: menuComponent

        Item {
            id: host

            property alias menu: menu
            property alias firstItem: firstItem
            property alias secondItem: secondItem
            property alias thirdItem: thirdItem

            width: 360
            height: 520

            MD.FabMenu {
                id: menu

                anchors.fill: parent
                text: "Create"
                collapsedIconName: "add"
                expandedIconName: "close"

                MD.FabMenuItem {
                    id: firstItem
                    text: "New document"
                    icon.name: "description"
                }

                MD.FabMenuItem {
                    id: secondItem
                    text: "New folder"
                    icon.name: "folder"
                }

                MD.FabMenuItem {
                    id: thirdItem
                    text: "New label"
                    icon.name: "star"
                }
            }
        }
    }

    Component {
        id: disabledMenuComponent

        Item {
            id: host

            property alias menu: menu
            property alias firstItem: firstItem
            property alias secondItem: secondItem
            property alias thirdItem: thirdItem

            width: 360
            height: 520

            MD.FabMenu {
                id: menu

                anchors.fill: parent
                text: "Create"
                collapsedIconName: "add"
                expandedIconName: "close"

                MD.FabMenuItem {
                    id: firstItem
                    text: "New document"
                    icon.name: "description"
                }

                MD.FabMenuItem {
                    id: secondItem
                    text: "New folder"
                    icon.name: "folder"
                    enabled: false
                }

                MD.FabMenuItem {
                    id: thirdItem
                    text: "New label"
                    icon.name: "star"
                }
            }
        }
    }

    Component {
        id: rtlMenuComponent

        Item {
            id: host

            property alias menu: menu
            property alias firstItem: firstItem
            property alias secondItem: secondItem
            property alias thirdItem: thirdItem

            width: 360
            height: 520
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.FabMenu {
                id: menu

                anchors.fill: parent
                text: "Create"
                collapsedIconName: "add"
                expandedIconName: "close"

                MD.FabMenuItem {
                    id: firstItem
                    text: "New document"
                    icon.name: "description"
                }

                MD.FabMenuItem {
                    id: secondItem
                    text: "New folder"
                    icon.name: "folder"
                }

                MD.FabMenuItem {
                    id: thirdItem
                    text: "New label"
                    icon.name: "star"
                }
            }
        }
    }

    function createHost(component, properties) {
        return createTemporaryObject(component, testCase, properties || {});
    }

    // Waits for a menu opened with open() to settle: expanded propagates first,
    // then every given item finishes its staggered entrance (opacity, scale and
    // visibility all reach their steady expanded values).
    function expand(menu, items) {
        menu.open();
        tryCompare(menu, "expanded", true);
        for (let i = 0; i < items.length; ++i) {
            const item = items[i];
            tryVerify(() => item.visible && item.opacity === 1 && item.scale === 1);
        }
    }

    // The disabled content opacity may live on a leaf node (e.g. the label) or
    // on an inner child of a wrapping container (e.g. the icon slot), so this
    // multiplies through whichever visible child actually carries it.
    function contentOpacityOf(node) {
        let opacity = node.opacity;
        if (node.children) {
            for (let i = 0; i < node.children.length; ++i) {
                const child = node.children[i];
                if (child.visible)
                    opacity *= child.opacity;
            }
        }
        return opacity;
    }

    function init() {
        testCase.forceActiveFocus();
        mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
        clickedSpy.clear();
        clickedSpy.target = null;
    }

    function test_tokens() {
        const token = MD.Tokens.fabMenu;
        compare(token.closeButtonContainerWidth, 56);
        compare(token.closeButtonContainerHeight, 56);
        compareShape(token.closeButtonContainerShape, MD.Tokens.shape.cornerFull,
                     "closeButtonContainerShape");
        compare(token.closeButtonIconSize, 20);
        compare(token.closeButtonContainerElevation, MD.Tokens.elevation.level3);
        compare(token.closeButtonFocusContainerElevation, MD.Tokens.elevation.level3);
        compare(token.closeButtonHoverContainerElevation, MD.Tokens.elevation.level4);
        compare(token.closeButtonPressedContainerElevation, MD.Tokens.elevation.level3);
        compare(token.closeButtonBetweenSpace, 8);
        compareShape(token.listItemContainerShape, MD.Tokens.shape.cornerFull,
                     "listItemContainerShape");
        compare(token.listItemContainerElevation, MD.Tokens.elevation.level3);
        compare(token.listItemContainerHeight, 56);
        compare(token.listItemIconSize, 24);
        compare(token.listItemIconLabelSpace, 8);
        compare(token.listItemLeadingSpace, 24);
        compare(token.listItemTrailingSpace, 24);
        compare(token.listItemBetweenSpace, 4);
        compare(token.listItemStaggerDelay, 30);
        compare(token.hoverStateLayerOpacity, 0.08);
        compare(token.focusStateLayerOpacity, 0.10);
        compare(token.pressedStateLayerOpacity, 0.10);
        compare(token.disabledContentOpacity, 0.38);
        compare(token.scrimOpacity, 0.32);
        compare(token.containerMargin, 16);
    }

    function test_defaults() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        verify(menu);

        compare(menu.expanded, false);
        compare(menu.variant, MD.FabMenu.Variant.Primary);
        compare(menu.direction, MD.FabMenu.Direction.Up);
        compare(menu.alignment, Qt.AlignRight);
        compare(menu.scrim, true);
        compare(menu.margins, MD.Tokens.fabMenu.containerMargin);

        const button = menu.button;
        verify(button);
        compare(button, findChild(menu, "fabMenuButton"));
        compare(button.expanded, false);
        compare(button.size, MD.FabMenuButton.Size.Default);

        tryVerify(() => Math.abs((button.x + button.width) - (menu.width - menu.margins)) < 1);

        menu.alignment = Qt.AlignLeft;
        tryVerify(() => Math.abs(button.x - menu.margins) < 1);
    }

    function test_initiallyCollapsedWithoutAnimation() {
        const host = createHost(menuComponent);
        const items = [host.firstItem, host.secondItem, host.thirdItem];

        for (let i = 0; i < items.length; ++i) {
            const item = items[i];
            compare(item.state, "collapsed");
            compare(item.visible, false);
            compare(item.opacity, 0);
            compare(item.scale, item._collapsedScale);
            compare(item._entranceOffset, item._collapsedOffset);
        }
    }

    function test_openCloseToggle() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const items = [host.firstItem, host.secondItem, host.thirdItem];

        for (let i = 0; i < items.length; ++i) {
            compare(items[i].menu, menu);
            compare(items[i].staggerIndex, i);
        }

        menu.open();
        tryCompare(menu, "expanded", true);
        tryCompare(menu.button, "expanded", true);
        for (let i = 0; i < items.length; ++i)
            compare(items[i].menu.expanded, true);

        menu.close();
        tryCompare(menu, "expanded", false);
        tryCompare(menu.button, "expanded", false);

        menu.toggle();
        tryCompare(menu, "expanded", true);
        menu.toggle();
        tryCompare(menu, "expanded", false);
    }

    function test_toggleMorph() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const button = menu.button;
        const collapsedSymbol = findChild(button, "fabMenuButtonCollapsedSymbol");
        const expandedSymbol = findChild(button, "fabMenuButtonExpandedSymbol");
        verify(collapsedSymbol);
        verify(expandedSymbol);

        compare(button.implicitWidth, MD.Tokens.fab.containerWidth);
        compare(button.implicitHeight, MD.Tokens.fab.containerHeight);
        compareRectangleShape(button.background, MD.Tokens.fab.containerShape,
                              "collapsedButtonBackground");
        compare(button.effectiveElevation, MD.Tokens.fab.containerElevation);
        compare(collapsedSymbol.opacity, 1);
        compare(collapsedSymbol.visible, true);
        compare(expandedSymbol.opacity, 0);
        compare(expandedSymbol.visible, false);
        compare(collapsedSymbol.width, MD.Tokens.fab.iconSize);
        compare(collapsedSymbol.height, MD.Tokens.fab.iconSize);

        menu.open();
        tryCompare(menu, "expanded", true);
        wait(50);
        verify(Number.isFinite(button.background.topLeftRadius));
        verify(button.background.topLeftRadius < MD.Tokens.shape.cornerValueFull);
        tryCompare(button, "implicitWidth", MD.Tokens.fabMenu.closeButtonContainerWidth);
        tryCompare(button, "implicitHeight", MD.Tokens.fabMenu.closeButtonContainerHeight);
        const expandedRadius = Math.min(MD.Tokens.fabMenu.closeButtonContainerWidth,
                                        MD.Tokens.fabMenu.closeButtonContainerHeight) / 2;
        tryCompare(button.background, "topLeftRadius", expandedRadius);
        tryCompare(button.background, "topRightRadius", expandedRadius);
        tryCompare(button.background, "bottomLeftRadius", expandedRadius);
        tryCompare(button.background, "bottomRightRadius", expandedRadius);
        tryCompare(button, "effectiveElevation", MD.Tokens.fabMenu.closeButtonContainerElevation);
        tryCompare(collapsedSymbol, "opacity", 0);
        tryVerify(() => expandedSymbol.visible && expandedSymbol.opacity === 1);
        tryCompare(expandedSymbol, "width", MD.Tokens.fabMenu.closeButtonIconSize);
        tryCompare(expandedSymbol, "height", MD.Tokens.fabMenu.closeButtonIconSize);
    }

    function test_itemGeometry() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const items = [host.firstItem, host.secondItem, host.thirdItem];
        expand(menu, items);

        for (let i = 0; i < items.length; ++i) {
            const item = items[i];
            compare(item.height, MD.Tokens.fabMenu.listItemContainerHeight);
            compareRectangleShape(item.background, MD.Tokens.fabMenu.listItemContainerShape,
                                  "itemBackground" + i);
            compare(item.leftPadding, MD.Tokens.fabMenu.listItemLeadingSpace);
            compare(item.rightPadding, MD.Tokens.fabMenu.listItemTrailingSpace);

            const icon = findChild(item, "fabMenuItemIcon");
            const label = findChild(item, "fabMenuItemLabel");
            verify(icon);
            verify(label);

            const iconLeft = icon.mapToItem(item, 0, 0).x;
            verify(Math.abs(iconLeft - MD.Tokens.fabMenu.listItemLeadingSpace) < 1);

            const iconRight = icon.mapToItem(item, icon.width, 0).x;
            const labelLeft = label.mapToItem(item, 0, 0).x;
            verify(Math.abs((labelLeft - iconRight) - MD.Tokens.fabMenu.listItemIconLabelSpace) < 1);
        }

        const sorted = items.slice().sort((a, b) => a.mapToItem(menu, 0, 0).y - b.mapToItem(menu, 0, 0).y);
        for (let i = 0; i < sorted.length - 1; ++i) {
            const upper = sorted[i];
            const lower = sorted[i + 1];
            tryVerify(() => {
                const bottom = upper.mapToItem(menu, 0, upper.height).y;
                const top = lower.mapToItem(menu, 0, 0).y;
                return Math.abs((top - bottom) - MD.Tokens.fabMenu.listItemBetweenSpace) < 1;
            });
        }
    }

    function test_semanticVariantColors() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const firstItem = host.firstItem;

        const cases = [
            { variant: MD.FabMenu.Variant.Primary, containerColor: MD.Style.primaryContainerColor, contentColor: MD.Style.onPrimaryContainerColor },
            { variant: MD.FabMenu.Variant.Secondary, containerColor: MD.Style.secondaryContainerColor, contentColor: MD.Style.onSecondaryContainerColor },
            { variant: MD.FabMenu.Variant.Tertiary, containerColor: MD.Style.tertiaryContainerColor, contentColor: MD.Style.onTertiaryContainerColor }
        ];

        for (let i = 0; i < cases.length; ++i) {
            menu.variant = cases[i].variant;
            compare(menu.itemContainerColor, cases[i].containerColor);
            compare(menu.itemContentColor, cases[i].contentColor);
            compare(firstItem.effectiveContainerColor, cases[i].containerColor);
            compare(firstItem.effectiveContentColor, cases[i].contentColor);
        }
    }

    function test_stateLayers() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const button = menu.button;
        const buttonRipple = findChild(button, "fabMenuButtonRipple");
        verify(buttonRipple);

        compare(buttonRipple.stateOpacity, 0);

        mouseMove(button, button.width / 2, button.height / 2);
        tryCompare(button, "hovered", true);
        tryCompare(buttonRipple, "stateOpacity", MD.Tokens.fabMenu.hoverStateLayerOpacity);

        mousePress(button, button.width / 2, button.height / 2);
        tryCompare(buttonRipple, "stateOpacity", MD.Tokens.fabMenu.pressedStateLayerOpacity);
        mouseRelease(button, button.width / 2, button.height / 2);

        menu.close();
        mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
        // Drop focus first: forcing it on an item that already has it leaves the
        // previous focus reason in place, so visualFocus would stay false.
        testCase.forceActiveFocus();
        button.forceActiveFocus(Qt.TabFocusReason);
        tryVerify(() => button.visualFocus);
        tryCompare(buttonRipple, "stateOpacity", MD.Tokens.fabMenu.focusStateLayerOpacity);

        testCase.forceActiveFocus();
        mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);

        const item = host.firstItem;
        expand(menu, [item, host.secondItem, host.thirdItem]);

        const itemRipple = findChild(item, "fabMenuItemRipple");
        verify(itemRipple);
        compare(itemRipple.stateOpacity, 0);

        mouseMove(item, item.width / 2, item.height / 2);
        tryCompare(item, "hovered", true);
        tryCompare(itemRipple, "stateOpacity", MD.Tokens.fabMenu.hoverStateLayerOpacity);

        mousePress(item, item.width / 2, item.height / 2);
        tryCompare(itemRipple, "stateOpacity", MD.Tokens.fabMenu.pressedStateLayerOpacity);
        mouseRelease(item, item.width / 2, item.height / 2);

        mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
        // Same reason as above: clear focus so the tab reason is actually applied.
        testCase.forceActiveFocus();
        item.forceActiveFocus(Qt.TabFocusReason);
        tryVerify(() => item.visualFocus);
        tryCompare(itemRipple, "stateOpacity", MD.Tokens.fabMenu.focusStateLayerOpacity);
    }

    function test_scrim() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const items = [host.firstItem, host.secondItem, host.thirdItem];
        const scrim = findChild(menu, "fabMenuScrim");
        verify(scrim);

        tryCompare(scrim, "opacity", 0);
        tryVerify(() => !scrim.visible);

        menu.open();
        tryCompare(menu, "expanded", true);
        tryCompare(scrim, "opacity", MD.Tokens.fabMenu.scrimOpacity);
        verify(scrim.visible);

        mouseClick(scrim, 5, 5);
        tryCompare(menu, "expanded", false);

        menu.scrim = false;
        expand(menu, items);
        tryCompare(scrim, "opacity", 0);
    }

    function test_escapeClosesMenu() {
        const host = createHost(menuComponent);
        const menu = host.menu;

        menu.open();
        tryCompare(menu, "expanded", true);
        menu.button.forceActiveFocus();
        keyClick(Qt.Key_Escape);
        tryCompare(menu, "expanded", false);

        // Escape is a no-op while the menu is already collapsed.
        keyClick(Qt.Key_Escape);
        compare(menu.expanded, false);
    }

    function test_itemActivation() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const item = host.firstItem;
        clickedSpy.target = item;

        expand(menu, [item, host.secondItem, host.thirdItem]);

        mouseClick(item, item.width / 2, item.height / 2);
        tryCompare(clickedSpy, "count", 1);
        // Activating an item dismisses the menu.
        tryCompare(menu, "expanded", false);

        const disabledHost = createHost(disabledMenuComponent);
        const disabledMenu = disabledHost.menu;
        const disabledItem = disabledHost.secondItem;
        clickedSpy.target = disabledItem;
        clickedSpy.clear();

        expand(disabledMenu, [disabledHost.firstItem, disabledItem, disabledHost.thirdItem]);

        mouseClick(disabledItem, disabledItem.width / 2, disabledItem.height / 2);
        wait(50);
        compare(clickedSpy.count, 0);

        const icon = findChild(disabledItem, "fabMenuItemIcon");
        const label = findChild(disabledItem, "fabMenuItemLabel");
        verify(icon);
        verify(label);

        const contentItem = disabledItem.contentItem;
        compare(contentItem.opacity * contentOpacityOf(label), MD.Tokens.fabMenu.disabledContentOpacity);
        compare(contentItem.opacity * contentOpacityOf(icon), MD.Tokens.fabMenu.disabledContentOpacity);
    }

    function test_direction() {
        const host = createHost(menuComponent);
        const menu = host.menu;
        const items = [host.firstItem, host.secondItem, host.thirdItem];
        const button = menu.button;

        expand(menu, items);

        tryVerify(() => {
            const buttonTop = button.mapToItem(menu, 0, 0).y;
            return items.every(item => item.mapToItem(menu, 0, item.height).y <= buttonTop + 0.5);
        });

        let lowestItem = items[0];
        for (let i = 1; i < items.length; ++i) {
            if (items[i].mapToItem(menu, 0, items[i].height).y > lowestItem.mapToItem(menu, 0, lowestItem.height).y)
                lowestItem = items[i];
        }
        compare(lowestItem, host.thirdItem);

        menu.direction = MD.FabMenu.Direction.Down;
        tryVerify(() => {
            const buttonBottom = button.mapToItem(menu, 0, button.height).y;
            return items.every(item => item.mapToItem(menu, 0, 0).y >= buttonBottom - 0.5);
        });

        let highestItem = items[0];
        for (let i = 1; i < items.length; ++i) {
            if (items[i].mapToItem(menu, 0, 0).y < highestItem.mapToItem(menu, 0, 0).y)
                highestItem = items[i];
        }
        compare(highestItem, host.firstItem);
    }

    function test_rtlMirrorsMenu() {
        const host = createHost(rtlMenuComponent);
        const menu = host.menu;
        const button = menu.button;
        const items = [host.firstItem, host.secondItem, host.thirdItem];

        expand(menu, items);

        compare(menu.alignment, Qt.AlignRight);

        tryVerify(() => Math.abs(button.mapToItem(menu, 0, 0).x - menu.margins) < 1);
        for (let i = 0; i < items.length; ++i) {
            const item = items[i];
            tryVerify(() => Math.abs(item.mapToItem(menu, 0, 0).x - menu.margins) < 1);
        }

        const label = findChild(host.firstItem, "fabMenuItemLabel");
        verify(label);
        compare(label.horizontalAlignment, Text.AlignRight);
    }
}
