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

    function test_defaults_and_action_delegates() {
        const menu = createMenu();
        verify(menu);
        tryCompare(menu, "count", 3);
        compare(menu.focus, true);
        compare(menu.topPadding, MD.Tokens.menu.topPadding);
        compare(menu.bottomPadding, MD.Tokens.menu.bottomPadding);
        verify(menu.implicitWidth >= MD.Tokens.menu.minimumWidth);
        verify(menu.implicitWidth <= MD.Tokens.menu.maximumWidth);
        compare(menu.implicitHeight, MD.Tokens.menu.itemHeight * 3 + MD.Tokens.menu.topPadding + MD.Tokens.menu.bottomPadding);

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
        tryVerify(() => Math.abs(favoriteIcon.y + favoriteIcon.height / 2 - favoriteLabel.y - favoriteLabel.height / 2) < 0.5);
        tryVerify(() => Math.abs(shareIcon.y + shareIcon.height / 2 - shareLabel.y - shareLabel.height / 2) < 0.5);

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
        tryVerify(() => Math.abs(icon.y + icon.height / 2 - label.y - label.height / 2) < 0.5);
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
