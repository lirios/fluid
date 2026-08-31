// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Templates as T
import QtTest

TestCase {
    id: testCase

    name: "MenuTests"
    width: 480
    height: 360
    visible: true
    when: windowShown

    Component {
        id: menuComponent

        MD.Menu {
            property alias plainAction: plainAction
            property alias checkedAction: checkedAction
            property alias disabledAction: disabledAction

            T.Action {
                id: plainAction
                text: "Copy"
                icon.name: MD.SymbolNames.symbolContentCopy
            }

            T.Action {
                id: checkedAction
                text: "Show formatting"
                checkable: true
                checked: true
            }

            T.Action {
                id: disabledAction
                text: "Unavailable"
                enabled: false
            }
        }
    }

    Component {
        id: scrollingMenuComponent

        MD.Menu {
            height: MD.Tokens.menu.itemHeight * 2

            T.Action {
                text: "One"
            }
            T.Action {
                text: "Two"
            }
            T.Action {
                text: "Three"
            }
            T.Action {
                text: "Four"
            }
            T.Action {
                text: "Five"
            }
        }
    }

    Component {
        id: longMenuComponent

        MD.Menu {
            T.Action {
                text: "A deliberately long menu action that must be constrained"
            }
        }
    }

    Component {
        id: alignedIconMenuComponent

        MD.Menu {
            T.Action {
                text: "Favorite"
                icon.name: MD.SymbolNames.symbolFavorite
                checkable: true
            }

            T.Action {
                text: "Share"
                icon.name: MD.SymbolNames.symbolShare
            }
        }
    }

    Component {
        id: standaloneMenuItemComponent

        MD.MenuItem {
            width: 200
            text: "Standalone item"
            icon.name: MD.SymbolNames.symbolShare
            checkable: true
            LayoutMirroring.enabled: true
        }
    }

    Component {
        id: menuGapComponent

        MD.MenuGap {}
    }

    Component {
        id: menuDividerComponent

        MD.MenuDivider {}
    }

    Component {
        id: menuSectionLabelComponent

        MD.MenuSectionLabel {
            text: "Clipboard"
        }
    }

    Component {
        id: rtlMenuComponent

        Item {
            property alias menu: menu

            width: 320
            height: 240
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.Menu {
                id: menu

                T.Action {
                    text: "Copy"
                    icon.name: MD.SymbolNames.symbolContentCopy
                }
            }
        }
    }

    function createMenu(component, properties) {
        return createTemporaryObject(component || menuComponent, testCase, properties || {});
    }

    function test_tokens() {
        const token = MD.Tokens.menu;
        compare(token.containerElevation, 3);
        compare(token.containerShape.topLeft, 4);
        compare(token.containerShape.topRight, 4);
        compare(token.containerShape.bottomLeft, 4);
        compare(token.containerShape.bottomRight, 4);
        compare(token.topPadding, 8);
        compare(token.bottomPadding, 8);
        compare(token.viewportMargin, 8);
        compare(token.minimumWidth, 112);
        compare(token.maximumWidth, 280);
        compare(token.itemHeight, 48);
        compare(token.itemHorizontalPadding, 16);
        compare(token.iconSize, 24);
        compare(token.iconLabelGap, 12);
        compare(token.hoverStateLayerOpacity, 0.08);
        compare(token.focusStateLayerOpacity, 0.10);
        compare(token.pressedStateLayerOpacity, 0.10);
        compare(token.disabledContentOpacity, 0.38);
    }

    function test_presentation_variants() {
        const menu = createMenu();
        verify(menu);
        compare(menu.variant, MD.Menu.Vertical);
        compare(menu.colorStyle, MD.Menu.Standard);

        menu.variant = MD.Menu.Baseline;
        compare(menu.variant, MD.Menu.Baseline);
        menu.colorStyle = MD.Menu.Vibrant;
        compare(menu.colorStyle, MD.Menu.Vibrant);
    }

    function test_defaults_and_action_delegates() {
        const menu = createMenu();
        verify(menu);
        tryCompare(menu, "count", 3);
        menu.variant = MD.Menu.Baseline;
        compare(menu.focus, true);
        compare(menu.topPadding, MD.Tokens.menu.topPadding);
        compare(menu.bottomPadding, MD.Tokens.menu.bottomPadding);
        verify(menu.implicitWidth >= MD.Tokens.menu.minimumWidth);
        verify(menu.implicitWidth <= MD.Tokens.menu.maximumWidth);
        tryCompare(menu, "implicitHeight",
                   MD.Tokens.menu.itemHeight * 3 + MD.Tokens.menu.topPadding
                   + MD.Tokens.menu.bottomPadding);

        const plainItem = menu.itemAt(0);
        const checkedItem = menu.itemAt(1);
        const disabledItem = menu.itemAt(2);
        verify(plainItem);
        verify(checkedItem);
        verify(disabledItem);
        compare(plainItem.text, menu.plainAction.text);
        compare(plainItem.implicitHeight, MD.Tokens.menu.itemHeight);
        compare(plainItem.leftPadding, MD.Tokens.menu.itemHorizontalPadding);
        compare(plainItem.rightPadding, MD.Tokens.menu.itemHorizontalPadding);
        compare(checkedItem.checked, true);
        compare(disabledItem.enabled, false);

        menu.popup(testCase, 0, 0);
        tryCompare(menu, "visible", true);

        const checkedSelection = findChild(checkedItem, "menuItemSelection");
        const plainIcon = findChild(plainItem, "menuItemIcon");
        const label = findChild(disabledItem, "menuItemLabel");
        verify(checkedSelection);
        verify(plainIcon);
        verify(label);
        compare(checkedSelection.visible, true);
        compare(plainIcon.visible, true);
        compare(label.text, menu.disabledAction.text);
        compare(label.opacity, MD.Tokens.menu.disabledContentOpacity);
    }

    function test_vertical_default_geometry() {
        const menu = createMenu();
        verify(menu);
        compare(menu.variant, MD.Menu.Vertical);
        compare(menu.topPadding, MD.Tokens.menu.verticalGroupPadding);
        compare(menu.bottomPadding, MD.Tokens.menu.verticalGroupPadding);
        compare(menu.leftPadding, MD.Tokens.menu.verticalGroupPadding);
        compare(menu.rightPadding, MD.Tokens.menu.verticalGroupPadding);
        tryCompare(menu, "count", 3);
        compare(menu.implicitHeight,
                MD.Tokens.menu.verticalItemHeight * 3
                + MD.Tokens.menu.verticalGroupPadding * 2
                + MD.Tokens.menu.verticalSegmentedGap * 2);

        menu.popup(testCase, 0, 0);
        tryCompare(menu, "visible", true);

        const list = findChild(menu, "menuListView");
        const background = findChild(menu, "menuBackground");
        verify(list);
        verify(background);
        compare(list.spacing, MD.Tokens.menu.verticalSegmentedGap);
        compare(background.topLeftRadius, MD.Tokens.menu.verticalContainerShape.topLeft);
        compare(background.topRightRadius, MD.Tokens.menu.verticalContainerShape.topRight);
        compare(background.bottomLeftRadius, MD.Tokens.menu.verticalContainerShape.bottomLeft);
        compare(background.bottomRightRadius, MD.Tokens.menu.verticalContainerShape.bottomRight);
        compare(menu.itemAt(0).groupPosition, MD.MenuItem.First);
        compare(menu.itemAt(1).groupPosition, MD.MenuItem.Middle);
        compare(menu.itemAt(2).groupPosition, MD.MenuItem.Last);
    }

    function test_adapts_to_compact_viewport_and_long_content() {
        const originalWidth = testCase.width;
        testCase.width = 96;

        const compactMenu = createMenu(longMenuComponent);
        verify(compactMenu);
        tryVerify(() => compactMenu.implicitWidth <= testCase.width - MD.Tokens.menu.viewportMargin * 2);

        testCase.width = originalWidth;
        const longMenu = createMenu(longMenuComponent);
        verify(longMenu);
        tryCompare(longMenu, "implicitWidth", MD.Tokens.menu.maximumWidth);
    }

    function test_checkable_icon_uses_aligned_leading_slot() {
        const menu = createMenu(alignedIconMenuComponent);
        verify(menu);
        tryCompare(menu, "count", 2);

        menu.popup(testCase, 0, 0);
        tryCompare(menu, "visible", true);

        const favoriteItem = menu.itemAt(0);
        const shareItem = menu.itemAt(1);
        const favoriteIcon = findChild(favoriteItem, "menuItemIcon");
        const shareIcon = findChild(shareItem, "menuItemIcon");
        const favoriteLabel = findChild(favoriteItem, "menuItemLabel");
        const shareLabel = findChild(shareItem, "menuItemLabel");
        verify(favoriteIcon);
        verify(shareIcon);
        verify(favoriteLabel);
        verify(shareLabel);
        tryCompare(shareIcon, "x", favoriteIcon.x);
        tryCompare(shareLabel, "x", favoriteLabel.x);
        tryVerify(() => Math.abs(favoriteIcon.mapToItem(favoriteItem, 0, favoriteIcon.height / 2).y
                                 - favoriteLabel.mapToItem(favoriteItem, 0,
                                                           favoriteLabel.height / 2).y) < 0.5);
        tryVerify(() => Math.abs(shareIcon.mapToItem(shareItem, 0, shareIcon.height / 2).y
                                 - shareLabel.mapToItem(shareItem, 0,
                                                        shareLabel.height / 2).y) < 0.5);

        favoriteItem.checked = true;
        const selection = findChild(favoriteItem, "menuItemSelection");
        verify(selection);
        compare(selection.visible, true);
        tryCompare(shareIcon, "x", favoriteIcon.x);
        tryCompare(shareLabel, "x", favoriteLabel.x);
    }

    function test_standalone_menu_item() {
        const item = createTemporaryObject(standaloneMenuItemComponent, testCase);
        verify(item);
        item.variant = MD.MenuItem.Baseline;
        compare(item.implicitHeight, MD.Tokens.menu.itemHeight);
        compare(item.leftPadding, MD.Tokens.menu.itemHorizontalPadding);
        compare(item.rightPadding, MD.Tokens.menu.itemHorizontalPadding);
        compare(item.focusPolicy, Qt.StrongFocus);
        compare(item.mirrored, true);

        const icon = findChild(item, "menuItemIcon");
        const label = findChild(item, "menuItemLabel");
        verify(icon);
        verify(label);
        compare(label.text, item.text);
        compare(label.horizontalAlignment, Text.AlignRight);
        tryVerify(() => Math.abs(icon.mapToItem(item, 0, icon.height / 2).y
                                 - label.mapToItem(item, 0, label.height / 2).y) < 0.5);
    }

    function test_menu_item_presentation_and_grouping_primitives() {
        const item = createTemporaryObject(standaloneMenuItemComponent, testCase);
        verify(item);
        compare(item.variant, MD.MenuItem.Vertical);
        compare(item.colorStyle, MD.MenuItem.Standard);
        compare(item.groupPosition, MD.MenuItem.Only);
        compare(item.background.topLeftRadius, MD.Tokens.menu.verticalOnlyItemShape.topLeft);
        compare(item.background.bottomRightRadius,
                MD.Tokens.menu.verticalOnlyItemShape.bottomRight);

        item.variant = MD.MenuItem.Baseline;
        item.colorStyle = MD.MenuItem.Vibrant;
        item.supportingText = "More detail";
        item.trailingText = "Shortcut";
        item.badgeContent = "New";
        item.groupPosition = MD.MenuItem.First;
        compare(item.variant, MD.MenuItem.Baseline);
        compare(item.colorStyle, MD.MenuItem.Vibrant);
        compare(item.supportingText, "More detail");
        compare(item.trailingText, "Shortcut");
        compare(item.badgeContent, "New");
        item.variant = MD.MenuItem.Vertical;
        compare(item.groupPosition, MD.MenuItem.First);
        compare(item.background.topLeftRadius, MD.Tokens.menu.verticalFirstItemShape.topLeft);
        compare(item.background.bottomRightRadius,
                MD.Tokens.menu.verticalFirstItemShape.bottomRight);

        item.groupPosition = MD.MenuItem.Middle;
        compare(item.groupPosition, MD.MenuItem.Middle);
        compare(item.background.topLeftRadius, MD.Tokens.menu.verticalMiddleItemShape.topLeft);
        item.groupPosition = MD.MenuItem.Last;
        compare(item.groupPosition, MD.MenuItem.Last);
        compare(item.background.bottomRightRadius, MD.Tokens.menu.verticalLastItemShape.bottomRight);
        item.checked = true;
        compare(item.background.topLeftRadius, MD.Tokens.menu.verticalSelectedItemShape.topLeft);
        compare(item.background.bottomRightRadius,
                MD.Tokens.menu.verticalSelectedItemShape.bottomRight);

        const stateLayer = findChild(item, "menuItemStateLayer");
        verify(stateLayer);
        compare(findChild(item, "menuItemFocusIndicator"), null);
        item.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(item, "visualFocus", true);
        compare(stateLayer.stateOpacity, MD.Tokens.menu.focusStateLayerOpacity);

        testCase.forceActiveFocus();
        mouseMove(item, item.width / 2, item.height / 2);
        tryCompare(item, "hovered", true);
        compare(stateLayer.stateOpacity, MD.Tokens.menu.hoverStateLayerOpacity);
        mousePress(item, item.width / 2, item.height / 2);
        tryCompare(item, "pressed", true);
        compare(stateLayer.stateOpacity, MD.Tokens.menu.pressedStateLayerOpacity);
        mouseRelease(item, item.width / 2, item.height / 2);
    }

    function test_menu_grouping_primitives() {
        const gap = createTemporaryObject(menuGapComponent, testCase);
        const divider = createTemporaryObject(menuDividerComponent, testCase);
        const sectionLabel = createTemporaryObject(menuSectionLabelComponent, testCase);
        verify(gap);
        verify(divider);
        verify(sectionLabel);
        compare(gap.implicitHeight, MD.Tokens.menu.verticalSegmentedGap);
        verify(!gap.focus);
        verify(divider.implicitHeight > 0);
        compare(divider.leadingInset, MD.Tokens.menu.verticalItemLeadingSpace);
        compare(divider.trailingInset, MD.Tokens.menu.verticalItemTrailingSpace);
        verify(!divider.focus);
        compare(sectionLabel.text, "Clipboard");
        compare(sectionLabel.implicitHeight, MD.Tokens.menu.verticalItemHeight);
        verify(!sectionLabel.focus);
    }

    function test_rtl_mirrors_items() {
        const wrapper = createTemporaryObject(rtlMenuComponent, testCase);
        verify(wrapper);
        const menu = wrapper.menu;
        tryCompare(menu, "count", 1);
        compare(menu.itemAt(0).mirrored, true);

        const label = findChild(menu.itemAt(0), "menuItemLabel");
        verify(label);
        compare(label.horizontalAlignment, Text.AlignRight);
    }

    function test_tall_menu_scrolls() {
        const menu = createMenu(scrollingMenuComponent);
        verify(menu);
        tryCompare(menu, "count", 5);

        const list = findChild(menu, "menuListView");
        verify(list);
        tryVerify(() => list.contentHeight > menu.height);
        compare(list.interactive, true);
        compare(list.clip, true);
        compare(list.boundsBehavior, Flickable.StopAtBounds);
    }

    function test_keyboard_focus_and_escape() {
        const menu = createMenu();
        verify(menu);
        menu.popup(testCase, 0, 0);
        tryCompare(menu, "visible", true);

        keyClick(Qt.Key_Down);
        tryVerify(() => menu.currentIndex >= 0);
        verify(menu.itemAt(menu.currentIndex).activeFocus);

        keyClick(Qt.Key_Escape);
        tryCompare(menu, "visible", false);
    }
}
