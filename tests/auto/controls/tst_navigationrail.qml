// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtTest

TestCase {
    id: testCase

    name: "NavigationRailTests"
    width: 960
    height: 720
    visible: true
    when: windowShown

    function compareShape(actual, expected, name) {
        compare(actual.topLeft, expected.topLeft, name + ".topLeft");
        compare(actual.topRight, expected.topRight, name + ".topRight");
        compare(actual.bottomLeft, expected.bottomLeft, name + ".bottomLeft");
        compare(actual.bottomRight, expected.bottomRight, name + ".bottomRight");
    }

    Component {
        id: railComponent

        Item {
            property alias rail: rail
            property alias firstItem: firstItem
            property alias secondItem: secondItem
            property alias thirdItem: thirdItem

            width: 480
            height: 640

            MD.NavigationRail {
                id: rail
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                header: Component {
                    Rectangle {
                        objectName: "testRailHeader"
                        implicitWidth: 56
                        implicitHeight: 56
                        color: "transparent"
                    }
                }

                MD.NavigationRailItem {
                    id: firstItem
                    text: "Home"
                    icon.name: MD.Symbols.home
                }

                MD.NavigationRailItem {
                    id: secondItem
                    text: "Disabled"
                    icon.name: MD.Symbols.block
                    enabled: false
                }

                MD.NavigationRailItem {
                    id: thirdItem
                    text: "Profile"
                    icon.name: MD.Symbols.person
                }
            }
        }
    }

    Component {
        id: rtlRailComponent

        Item {
            property alias rail: rail
            property alias firstItem: firstItem

            width: 480
            height: 640
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.NavigationRail {
                id: rail
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                expanded: true

                MD.NavigationRailItem {
                    id: firstItem
                    text: "Home"
                    icon.name: MD.Symbols.home
                }

                MD.NavigationRailItem {
                    text: "Profile"
                    icon.name: MD.Symbols.person
                }
            }
        }
    }

    Component {
        id: iconOnlyRailComponent

        MD.NavigationRail {
            height: 480

            MD.NavigationRailItem {
                text: ""
                icon.name: MD.Symbols.settings
            }
        }
    }

    Component {
        id: dynamicItemComponent

        MD.NavigationRailItem {
            text: "Dynamic"
            icon.name: MD.Symbols.add
        }
    }

    Component {
        id: modalComponent

        Item {
            property alias modal: modal
            property alias firstItem: firstItem
            property alias secondItem: secondItem
            property alias thirdItem: thirdItem

            width: 720
            height: 640

            Rectangle {
                id: focusSink
                objectName: "modalFocusSink"
                width: 40
                height: 40
                focus: true
            }

            MD.ModalNavigationRail {
                id: modal
                anchors.fill: parent

                MD.NavigationRailItem {
                    id: firstItem
                    text: "Home"
                    icon.name: MD.Symbols.home
                }

                MD.NavigationRailItem {
                    id: secondItem
                    text: "Disabled"
                    icon.name: MD.Symbols.block
                    enabled: false
                }

                MD.NavigationRailItem {
                    id: thirdItem
                    text: "Profile"
                    icon.name: MD.Symbols.person
                }
            }
        }
    }

    Component {
        id: signalSpyComponent

        SignalSpy {
            signalName: "clicked"
        }
    }

    function createHost(component, properties) {
        return createTemporaryObject(component, testCase, properties || {});
    }

    function test_tokens() {
        const token = MD.Tokens.navigationRail;

        compare(token.containerElevation, MD.Tokens.elevation.level0);
        compareShape(token.containerShape, MD.Tokens.shape.cornerNone, "containerShape");
        compare(token.collapsedContainerWidth, 96);
        compare(token.expandedContainerWidthMinimum, 220);
        compare(token.expandedContainerWidthMaximum, 360);
        compare(token.modalContainerElevation, MD.Tokens.elevation.level2);
        compareShape(token.modalContainerShape, MD.Tokens.shape.cornerLarge,
                     "modalContainerShape");
        compare(token.topSpace, 44);
        compare(token.collapsedItemVerticalSpace, 4);
        compare(token.itemContainerHeight, 64);
        compareShape(token.itemContainerShape, MD.Tokens.shape.cornerNone,
                     "itemContainerShape");
        compare(token.itemContainerVerticalSpace, 6);
        compare(token.headerSpaceMinimum, 40);
        compare(token.iconSize, 24);
        compareShape(token.activeIndicatorShape, MD.Tokens.shape.cornerFull,
                     "activeIndicatorShape");
        compare(token.activeIndicatorIconLabelSpace, 8);
        compare(token.activeIndicatorLeadingSpace, 16);
        compare(token.activeIndicatorTrailingSpace, 16);
        compare(token.verticalActiveIndicatorHeight, 32);
        compare(token.verticalActiveIndicatorWidth, 56);
        compare(token.verticalIconLabelSpace, 4);
        compare(token.verticalLeadingSpace, 16);
        compare(token.verticalTrailingSpace, 16);
        compare(token.horizontalActiveIndicatorHeight, 56);
        compare(token.horizontalFullWidthLeadingSpace, 16);
        compare(token.horizontalFullWidthTrailingSpace, 16);
        compare(token.horizontalIconLabelSpace, 8);
        compare(token.horizontalLeadingSpace, 16);
        compare(token.itemHorizontalPadding, 20);
        compare(token.hoverStateLayerOpacity, MD.Tokens.state.hoverStateLayerOpacity);
        compare(token.focusStateLayerOpacity, MD.Tokens.state.focusStateLayerOpacity);
        compare(token.pressedStateLayerOpacity, MD.Tokens.state.pressedStateLayerOpacity);
        compare(token.disabledContentOpacity, 0.38);
        compare(token.modalScrimOpacity, 0.32);
    }

    function test_defaults_and_items() {
        const host = createHost(railComponent);
        verify(host);
        const rail = host.rail;

        compare(rail.expanded, false);
        compare(rail.arrangement, MD.NavigationRail.Arrangement.Top);
        compare(rail.currentIndex, 0);
        compare(rail.count, 3);
        compare(rail.containerColor, rail.MD.Style.surfaceColor);
        compare(rail.itemAt(0), host.firstItem);
        compare(rail.itemAt(1), host.secondItem);
        compare(rail.itemAt(2), host.thirdItem);
        compare(rail.itemAt(-1), null);
        compare(rail.itemAt(rail.count), null);

        verify(host.firstItem.checkable);
        verify(host.firstItem.autoExclusive);
        verify(host.firstItem.checked);
        verify(!host.secondItem.checked);
        verify(!host.thirdItem.checked);
        compare(host.firstItem.tintSourceIcon, true);
        compare(host.firstItem.selectedIconColor,
                host.firstItem.MD.Style.onSecondaryContainerColor);
        compare(host.firstItem.selectedLabelColor, host.firstItem.MD.Style.secondaryColor);
        compare(host.firstItem.selectedIndicatorColor,
                host.firstItem.MD.Style.secondaryContainerColor);
        compare(host.firstItem.unselectedIconColor,
                host.firstItem.MD.Style.onSurfaceVariantColor);
        compare(host.firstItem.unselectedLabelColor,
                host.firstItem.MD.Style.onSurfaceVariantColor);
    }

    function test_expand_collapse_and_width_bounds() {
        const host = createHost(railComponent);
        const rail = host.rail;
        host.firstItem.text = "A destination label wide enough to exceed the minimum rail width";

        tryCompare(rail, "width", MD.Tokens.navigationRail.collapsedContainerWidth);
        rail.expand();
        compare(rail.expanded, true);
        tryVerify(() => rail.width >= MD.Tokens.navigationRail.expandedContainerWidthMinimum
                            && rail.width <= MD.Tokens.navigationRail.expandedContainerWidthMaximum);
        const expandedWidth = rail.width;

        rail.collapse();
        compare(rail.expanded, false);
        fuzzyCompare(rail.width, expandedWidth, 1);
        tryCompare(rail, "width", MD.Tokens.navigationRail.collapsedContainerWidth);

        rail.toggle();
        compare(rail.expanded, true);
        rail.toggle();
        compare(rail.expanded, false);
    }

    function test_selection_and_activation() {
        const host = createHost(railComponent);
        const rail = host.rail;

        rail.currentIndex = 2;
        compare(host.firstItem.checked, false);
        compare(host.thirdItem.checked, true);

        rail.currentIndex = -1;
        compare(host.firstItem.checked, false);
        compare(host.thirdItem.checked, false);

        const clickedSpy = createTemporaryObject(signalSpyComponent, host.thirdItem,
                                                  { "target": host.thirdItem });
        mouseClick(host.thirdItem, host.thirdItem.width / 2, host.thirdItem.height / 2);
        compare(clickedSpy.count, 1);
        compare(rail.currentIndex, 2);

        mouseClick(host.secondItem, host.secondItem.width / 2, host.secondItem.height / 2);
        compare(rail.currentIndex, 2);
    }

    function test_dynamic_items() {
        const host = createHost(railComponent);
        const rail = host.rail;
        compare(rail.count, 3);

        const dynamicItem = dynamicItemComponent.createObject(rail);
        verify(dynamicItem);
        tryCompare(rail, "count", 4);
        compare(rail.itemAt(3), dynamicItem);

        dynamicItem.destroy();
        tryCompare(rail, "count", 3);
    }

    function test_arrangements_keep_header_at_top() {
        const host = createHost(railComponent);
        const rail = host.rail;
        const header = findChild(rail, "testRailHeader");
        verify(header);

        rail.arrangement = MD.NavigationRail.Arrangement.Top;
        wait(0);
        const topItemY = host.firstItem.mapToItem(rail, 0, 0).y;
        const headerY = header.mapToItem(rail, 0, 0).y;
        verify(topItemY >= headerY + header.height);

        rail.arrangement = MD.NavigationRail.Arrangement.Center;
        wait(0);
        const centerItemY = host.firstItem.mapToItem(rail, 0, 0).y;
        verify(centerItemY > topItemY);
        compare(header.mapToItem(rail, 0, 0).y, headerY);

        rail.arrangement = MD.NavigationRail.Arrangement.Bottom;
        wait(0);
        const bottomItemY = host.firstItem.mapToItem(rail, 0, 0).y;
        verify(bottomItemY > centerItemY);
        compare(header.mapToItem(rail, 0, 0).y, headerY);
        verify(host.thirdItem.mapToItem(rail, 0, 0).y + host.thirdItem.height <= rail.height);
    }

    function test_collapsed_and_expanded_item_geometry() {
        const host = createHost(railComponent);
        const rail = host.rail;
        const item = host.firstItem;
        const indicator = findChild(item, "navigationRailItemIndicator");
        const icon = findChild(item, "navigationRailItemIcon");
        const label = findChild(item, "navigationRailItemLabel");
        verify(indicator);
        verify(icon);
        verify(label);

        compare(indicator.height, MD.Tokens.navigationRail.verticalActiveIndicatorHeight);
        compare(indicator.width, MD.Tokens.navigationRail.verticalActiveIndicatorWidth);
        verify(label.y > icon.y);

        rail.expanded = true;
        tryCompare(indicator, "height", MD.Tokens.navigationRail.horizontalActiveIndicatorHeight);
        tryVerify(() => icon.x < label.x);
        tryVerify(() => indicator.width
                            >= MD.Tokens.navigationRail.expandedContainerWidthMinimum
                               - MD.Tokens.navigationRail.itemHorizontalPadding * 2);
    }

    function test_item_layout_transition_has_no_slow_rearrangement() {
        const host = createHost(railComponent);
        const rail = host.rail;
        const item = host.firstItem;
        const content = findChild(item, "navigationRailItemContent");
        const indicator = findChild(item, "navigationRailItemIndicator");
        const icon = findChild(item, "navigationRailItemIcon");
        const label = findChild(item, "navigationRailItemLabel");
        verify(content);
        verify(indicator);
        verify(icon);
        verify(label);

        // AndroidX coordinates the rearrangement through one progress value
        // and hides the label while its row/column placement changes. Avoid
        // depending on the private adapter's precise duration or curve.
        const transitionTimeout = 500;
        const lerp = (start, end, progress) => start + (end - start) * progress;
        verify(indicator.x > 0);
        compare(label.opacity, 1);

        rail.expanded = true;
        tryVerify(() => label.opacity <= 0.25, transitionTimeout);

        let progress = item._positionProgress;
        verify(progress > 0 && progress < 1);
        fuzzyCompare(label.opacity, Math.pow(progress * 2 - 1, 2), 0.05);
        fuzzyCompare(indicator.x,
                     lerp(content.collapsedIndicatorX, 0, progress), 1);
        fuzzyCompare(indicator.y,
                     lerp(content.collapsedIndicatorY,
                          content.expandedIndicatorY, progress), 1);
        fuzzyCompare(indicator.width,
                     lerp(MD.Tokens.navigationRail.verticalActiveIndicatorWidth,
                          content.width, progress), 1);
        fuzzyCompare(icon.x,
                     lerp(content.collapsedIconX, content.expandedIconX, progress), 1);
        fuzzyCompare(icon.y,
                     lerp(content.collapsedIconY, content.expandedIconY, progress), 1);

        tryCompare(item, "_positionProgress", 1, transitionTimeout);

        // A toggle must finish icon, label, indicator, and full-shape geometry
        // as one coordinated transition, with no independently trailing lag.
        fuzzyCompare(indicator.x, 0, 0.5);
        fuzzyCompare(indicator.y, 0, 0.5);
        fuzzyCompare(indicator.width, content.width, 0.5);
        fuzzyCompare(indicator.height,
                     MD.Tokens.navigationRail.horizontalActiveIndicatorHeight, 0.5);
        fuzzyCompare(indicator.topLeftRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.topRightRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.bottomLeftRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.bottomRightRadius, indicator.height / 2, 0.5);
        fuzzyCompare(icon.x, MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace, 0.5);
        fuzzyCompare(icon.y, (content.height - icon.height) / 2, 0.5);
        fuzzyCompare(label.x,
                     icon.x + icon.width + MD.Tokens.navigationRail.horizontalIconLabelSpace,
                     0.5);
        fuzzyCompare(label.y, (content.height - label.height) / 2, 0.5);
        fuzzyCompare(label.opacity, 1, 0.01);

        rail.expanded = false;
        tryVerify(() => label.opacity <= 0.25, transitionTimeout);

        progress = item._positionProgress;
        verify(progress > 0 && progress < 1);
        fuzzyCompare(label.opacity, Math.pow(progress * 2 - 1, 2), 0.05);
        fuzzyCompare(indicator.x,
                     lerp(content.collapsedIndicatorX, 0, progress), 1);
        fuzzyCompare(indicator.y,
                     lerp(content.collapsedIndicatorY,
                          content.expandedIndicatorY, progress), 1);
        fuzzyCompare(indicator.width,
                     lerp(MD.Tokens.navigationRail.verticalActiveIndicatorWidth,
                          content.width, progress), 1);
        fuzzyCompare(icon.x,
                     lerp(content.collapsedIconX, content.expandedIconX, progress), 1);
        fuzzyCompare(icon.y,
                     lerp(content.collapsedIconY, content.expandedIconY, progress), 1);

        tryCompare(item, "_positionProgress", 0, transitionTimeout);

        fuzzyCompare(indicator.x, (content.width - indicator.width) / 2, 0.5);
        fuzzyCompare(indicator.y, 0, 0.5);
        fuzzyCompare(indicator.width,
                     MD.Tokens.navigationRail.verticalActiveIndicatorWidth, 0.5);
        fuzzyCompare(indicator.height,
                     MD.Tokens.navigationRail.verticalActiveIndicatorHeight, 0.5);
        fuzzyCompare(indicator.topLeftRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.topRightRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.bottomLeftRadius, indicator.height / 2, 0.5);
        fuzzyCompare(indicator.bottomRightRadius, indicator.height / 2, 0.5);
        fuzzyCompare(icon.x, (content.width - icon.width) / 2, 0.5);
        fuzzyCompare(icon.y, (indicator.height - icon.height) / 2, 0.5);
        fuzzyCompare(label.x, (content.width - label.width) / 2, 0.5);
        fuzzyCompare(label.y,
                     indicator.height + MD.Tokens.navigationRail.verticalIconLabelSpace,
                     0.5);
        fuzzyCompare(label.opacity, 1, 0.01);
    }

    function test_icon_only_geometry() {
        const rail = createHost(iconOnlyRailComponent);
        const item = rail.itemAt(0);
        const icon = findChild(item, "navigationRailItemIcon");
        const label = findChild(item, "navigationRailItemLabel");
        verify(icon);
        verify(label);
        verify(!label.visible || label.text === "");
        fuzzyCompare(icon.x + icon.width / 2, item.width / 2, 1);

        rail.expanded = true;
        tryVerify(() => Math.abs(icon.x + icon.width / 2 - item.width / 2) <= 1);
    }

    function test_keyboard_navigation_skips_disabled_items() {
        const host = createHost(railComponent);
        const rail = host.rail;
        host.firstItem.forceActiveFocus();
        verify(host.firstItem.activeFocus);
        rail.currentIndex = 0;

        keyClick(Qt.Key_Down);
        compare(rail.currentIndex, 2);
        keyClick(Qt.Key_Down);
        compare(rail.currentIndex, 0);
        keyClick(Qt.Key_Up);
        compare(rail.currentIndex, 2);
        keyClick(Qt.Key_Home);
        compare(rail.currentIndex, 0);
        keyClick(Qt.Key_End);
        compare(rail.currentIndex, 2);
    }

    function test_rtl_expanded_geometry() {
        const host = createHost(rtlRailComponent);
        const rail = host.rail;
        const item = host.firstItem;
        const icon = findChild(item, "navigationRailItemIcon");
        const label = findChild(item, "navigationRailItemLabel");
        verify(rail.mirrored);
        verify(item.mirrored);
        verify(icon);
        verify(label);
        tryVerify(() => icon.x > label.x);
        tryVerify(() => Math.abs(rail.x + rail.width - host.width) <= 1);
    }

    function test_custom_item_colors_and_tint() {
        const host = createHost(railComponent);
        const item = host.firstItem;
        item.tintSourceIcon = false;
        item.selectedIconColor = "#ff0000";
        item.selectedLabelColor = "#00ff00";
        item.selectedIndicatorColor = "#0000ff";
        item.unselectedIconColor = "#ffff00";
        item.unselectedLabelColor = "#00ffff";

        compare(item.tintSourceIcon, false);
        compare(item.selectedIconColor, Qt.color("#ff0000"));
        compare(item.selectedLabelColor, Qt.color("#00ff00"));
        compare(item.selectedIndicatorColor, Qt.color("#0000ff"));
        compare(item.unselectedIconColor, Qt.color("#ffff00"));
        compare(item.unselectedLabelColor, Qt.color("#00ffff"));
    }

    function test_item_selection_disabled_and_pointer_states() {
        const host = createHost(railComponent);
        const selectedIndicator = findChild(host.firstItem,
                                            "navigationRailItemIndicator");
        const disabledIcon = findChild(host.secondItem, "navigationRailItemIcon");
        const disabledLabel = findChild(host.secondItem, "navigationRailItemLabel");
        verify(selectedIndicator);
        verify(disabledIcon);
        verify(disabledLabel);

        tryCompare(selectedIndicator, "color", host.firstItem.selectedIndicatorColor);
        compare(disabledIcon.opacity, MD.Tokens.navigationRail.disabledContentOpacity);
        compare(disabledLabel.opacity, MD.Tokens.navigationRail.disabledContentOpacity);

        mouseMove(testCase, testCase.width - 2, testCase.height - 2);
        mouseMove(host.firstItem, host.firstItem.width / 2, host.firstItem.height / 2);
        tryCompare(selectedIndicator, "stateLayerOpacity",
                   MD.Tokens.navigationRail.hoverStateLayerOpacity);
        mousePress(host.firstItem, host.firstItem.width / 2, host.firstItem.height / 2);
        tryCompare(selectedIndicator, "stateLayerOpacity",
                   MD.Tokens.navigationRail.pressedStateLayerOpacity);
        mouseRelease(host.firstItem, host.firstItem.width / 2, host.firstItem.height / 2);

        host.thirdItem.checked = true;
        tryCompare(selectedIndicator, "color", Qt.color("transparent"));
    }

    function test_modal_defaults_and_shared_api() {
        const host = createHost(modalComponent);
        const modal = host.modal;
        compare(modal.expanded, false);
        compare(modal.hideOnCollapse, false);
        compare(modal.currentIndex, 0);
        compare(modal.arrangement, MD.NavigationRail.Arrangement.Top);
        compare(modal.count, 3);
        compare(modal.itemAt(0), host.firstItem);
        compare(modal.itemAt(2), host.thirdItem);
        compare(modal.containerColor, modal.MD.Style.surfaceContainerColor);
        compare(modal.scrimColor, modal.MD.Style.scrimColor);

        modal.expand();
        compare(modal.expanded, true);
        mouseClick(host.thirdItem, host.thirdItem.width / 2, host.thirdItem.height / 2);
        compare(modal.currentIndex, 2);
        compare(host.thirdItem.checked, true);
        compare(modal.expanded, true);
        modal.collapse();
        compare(modal.expanded, false);
        modal.toggle();
        compare(modal.expanded, true);
    }

    function test_modal_scrim_and_escape_dismissal() {
        const host = createHost(modalComponent);
        const modal = host.modal;
        const scrim = findChild(modal, "modalNavigationRailScrim");
        verify(scrim);

        modal.expand();
        tryCompare(scrim, "opacity", MD.Tokens.navigationRail.modalScrimOpacity);
        verify(scrim.visible);
        mouseClick(scrim, scrim.width - 10, scrim.height / 2);
        tryCompare(modal, "expanded", false);

        modal.expand();
        modal.forceActiveFocus();
        keyClick(Qt.Key_Escape);
        tryCompare(modal, "expanded", false);
    }

    function test_modal_restores_focus() {
        const host = createHost(modalComponent);
        const modal = host.modal;
        const focusSink = findChild(host, "modalFocusSink");
        verify(focusSink);
        focusSink.forceActiveFocus();
        verify(focusSink.activeFocus);

        modal.expand();
        tryVerify(() => !focusSink.activeFocus);
        modal.collapse();
        tryVerify(() => focusSink.activeFocus);
    }

    function test_modal_drag_settlement_and_dismissal() {
        const host = createHost(modalComponent);
        const modal = host.modal;
        const surface = findChild(modal, "modalNavigationRailSurface");
        verify(surface);
        modal.expand();
        tryCompare(surface, "x", 0);

        // A short drag toward logical start settles back to the expanded rail.
        mousePress(modal, surface.width - 8, modal.height - 8);
        mouseMove(modal, surface.width - 30, modal.height - 8);
        mouseMove(modal, surface.width * 0.75, modal.height - 8);
        mouseRelease(modal, surface.width * 0.75, modal.height - 8);
        tryCompare(modal, "expanded", true);
        tryCompare(surface, "x", 0);

        // Crossing half the surface width dismisses it.
        mousePress(modal, surface.width - 8, modal.height - 8);
        mouseMove(modal, surface.width - 30, modal.height - 8);
        mouseMove(modal, 1, modal.height - 8);
        mouseRelease(modal, 1, modal.height - 8);
        tryCompare(modal, "expanded", false);
    }

    function test_modal_hide_on_collapse_and_rtl() {
        const host = createHost(modalComponent);
        const modal = host.modal;
        const surface = findChild(modal, "modalNavigationRailSurface");
        verify(surface);

        modal.hideOnCollapse = true;
        modal.expand();
        tryCompare(surface, "x", 0);
        modal.collapse();
        tryVerify(() => surface.x + surface.width <= 0);

        host.LayoutMirroring.enabled = true;
        host.LayoutMirroring.childrenInherit = true;
        modal.expand();
        tryVerify(() => Math.abs(surface.x + surface.width - modal.width) <= 1);
        modal.collapse();
        tryVerify(() => surface.x >= modal.width);
    }
}
