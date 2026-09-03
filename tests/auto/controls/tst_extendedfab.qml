// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 1200
    height: 720

    Item {
        id: focusSink

        x: 1160
        y: 680
        width: 20
        height: 20
        focus: true
    }

    MD.ExtendedFAB {
        id: primaryFab

        x: 20
        y: 20
        text: "Create"
        icon.name: "add"
    }

    MD.ExtendedFAB {
        id: customFab

        x: 260
        y: 20
        text: "Custom"
        icon.name: "priority_high"
        containerColor: "#00ff00"
        contentColor: "#ff0000"
    }

    MD.ExtendedFAB {
        id: textOnlyFab

        x: 500
        y: 20
        text: "Text only"
        expanded: false
    }

    MD.ExtendedFAB {
        id: rtlFab

        x: 720
        y: 20
        text: "Forward"
        icon.name: "arrow_forward"
        LayoutMirroring.enabled: true
    }

    MD.ExtendedFAB {
        id: narrowFab

        x: 20
        y: 180
        width: 72
        text: "A deliberately long single-line label"
        icon.name: "edit"
    }

    MD.IconLabel {
        id: opacityLabel

        x: 20
        y: 340
        text: "Opacity"
        icon.name: "visibility"
        icon.width: 24
        icon.height: 24
    }

    SignalSpy {
        id: clickedSpy
        target: primaryFab
        signalName: "clicked"
    }

    TestCase {
        id: testCase

        name: "ExtendedFABTests"
        when: windowShown

        function init() {
            primaryFab.size = MD.ExtendedFAB.Size.Default;
            primaryFab.variant = MD.ExtendedFAB.Variant.Primary;
            primaryFab.lowered = false;
            primaryFab.expanded = true;
            primaryFab.enabled = true;
            primaryFab.text = "Create";
            primaryFab.icon.name = "add";
            primaryFab.icon.color = "transparent";
            opacityLabel.textOpacity = 1;
            testCase.forceActiveFocus();
            mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
            tryCompare(primaryFab.contentItem, "textOpacity", 1);
            clickedSpy.clear();
        }

        function fuzzyCompare(actual, expected, epsilon, message) {
            verify(Math.abs(actual - expected) <= epsilon,
                   (message || "values differ") + ": " + actual + " != " + expected);
        }

        function test_defaults_and_public_contract() {
            compare(primaryFab.size, MD.ExtendedFAB.Size.Default);
            compare(primaryFab.variant, MD.ExtendedFAB.Variant.Primary);
            verify(!primaryFab.lowered);
            verify(primaryFab.expanded);
            verify(primaryFab.hasIcon);
            compare(primaryFab.text, "Create");
            compare(primaryFab.focusPolicy, Qt.StrongFocus);
            verify(primaryFab.hoverEnabled);
            compare(primaryFab.effectiveIconName, "add");
            compare(primaryFab.effectiveIconColor, primaryFab.effectiveContentColor);
            compare(primaryFab.effectiveContainerColor, MD.Style.primaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onPrimaryContainerColor);
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.containerElevation);
        }

        function test_sizes_data() {
            return [
                {
                    tag: "default",
                    size: MD.ExtendedFAB.Size.Default,
                    container: 56,
                    icon: 24,
                    leading: 16,
                    trailing: 16,
                    spacing: 8,
                    radius: 16,
                    fontSize: 16,
                    fontWeight: Font.Medium
                },
                {
                    tag: "medium",
                    size: MD.ExtendedFAB.Size.Medium,
                    container: 80,
                    icon: 28,
                    leading: 26,
                    trailing: 26,
                    spacing: 12,
                    radius: 20,
                    fontSize: 22,
                    fontWeight: Font.Normal
                },
                {
                    tag: "large",
                    size: MD.ExtendedFAB.Size.Large,
                    container: 96,
                    icon: 32,
                    leading: 28,
                    trailing: 28,
                    spacing: 16,
                    radius: 28,
                    fontSize: 24,
                    fontWeight: Font.Normal
                }
            ];
        }

        function test_sizes(data) {
            primaryFab.size = data.size;
            const content = findChild(primaryFab, "extendedFabContent");
            const background = findChild(primaryFab, "extendedFabBackground");
            verify(content);
            verify(background);
            const expectedWidth = Math.max(data.container,
                                           data.leading + content.implicitWidth
                                           + data.trailing);
            tryCompare(primaryFab, "implicitWidth", expectedWidth);
            compare(primaryFab.implicitHeight, data.container);
            compare(background.implicitHeight, data.container);
            tryCompare(background, "implicitWidth", expectedWidth);
            compare(primaryFab.icon.width, data.icon);
            compare(primaryFab.icon.height, data.icon);
            compare(content.icon.width, data.icon);
            compare(content.icon.height, data.icon);
            compare(content.spacing, data.spacing);
            fuzzyCompare(primaryFab.leftPadding, data.leading, 0.01, "leading padding");
            fuzzyCompare(primaryFab.rightPadding, data.trailing, 0.01, "trailing padding");
            fuzzyCompare(background.topLeftRadius, data.radius, 0.01,
                         "top-left radius");
            fuzzyCompare(background.topRightRadius, data.radius, 0.01,
                         "top-right radius");
            fuzzyCompare(background.bottomLeftRadius, data.radius, 0.01,
                         "bottom-left radius");
            fuzzyCompare(background.bottomRightRadius, data.radius, 0.01,
                         "bottom-right radius");

            const label = findChild(primaryFab, "iconLabelText");
            const symbol = findChild(primaryFab, "iconLabelIcon");
            verify(label);
            verify(symbol);
            compare(symbol.width, data.icon);
            compare(symbol.height, data.icon);
            compare(label.font.pixelSize, data.fontSize);
            compare(label.font.weight, data.fontWeight);
        }

        function test_label_length_changes_natural_width() {
            primaryFab.text = "Go";
            const shortExpected = MD.Tokens.fab.leadingSpace
                    + primaryFab.contentItem.implicitWidth + MD.Tokens.fab.trailingSpace;
            tryCompare(primaryFab, "implicitWidth", Math.max(56, shortExpected));
            const shortWidth = primaryFab.implicitWidth;

            primaryFab.text = "Create a new document";
            const longExpected = MD.Tokens.fab.leadingSpace
                    + primaryFab.contentItem.implicitWidth + MD.Tokens.fab.trailingSpace;
            tryCompare(primaryFab, "implicitWidth", longExpected);
            verify(primaryFab.implicitWidth > shortWidth);
        }

        function test_collapse_and_reexpand_data() {
            return [
                { tag: "default", size: MD.ExtendedFAB.Size.Default, collapsed: 56 },
                { tag: "medium", size: MD.ExtendedFAB.Size.Medium, collapsed: 80 },
                { tag: "large", size: MD.ExtendedFAB.Size.Large, collapsed: 96 }
            ];
        }

        function test_collapse_and_reexpand(data) {
            primaryFab.size = data.size;
            const leading = [16, 26, 28][data.size];
            const trailing = [16, 26, 28][data.size];
            const expandedWidth = Math.max(data.collapsed,
                                           leading + primaryFab.contentItem.implicitWidth
                                           + trailing);
            tryCompare(primaryFab, "implicitWidth", expandedWidth);

            primaryFab.expanded = false;
            wait(40);
            verify(isFinite(primaryFab.implicitWidth));
            verify(isFinite(primaryFab.leftPadding));
            verify(isFinite(primaryFab.rightPadding));
            fuzzyCompare(primaryFab.background.width, primaryFab.width, 0.01,
                         "animated background width");
            tryCompare(primaryFab, "implicitWidth", data.collapsed);
            tryCompare(primaryFab.contentItem, "textOpacity", 0);

            const symbol = findChild(primaryFab, "iconLabelIcon");
            verify(symbol);
            fuzzyCompare(primaryFab.contentItem.x + symbol.x + symbol.width / 2,
                         primaryFab.width / 2, 0.5, "collapsed icon center");

            primaryFab.expanded = true;
            tryCompare(primaryFab, "implicitWidth", expandedWidth);
            tryCompare(primaryFab.contentItem, "textOpacity", 1);
            fuzzyCompare(primaryFab.background.width, primaryFab.width, 0.01,
                         "expanded background width");
        }

        function test_text_only_fallback_stays_extended() {
            const content = findChild(textOnlyFab, "extendedFabContent");
            verify(content);
            verify(!textOnlyFab.hasIcon);
            verify(!textOnlyFab.expanded);
            verify(textOnlyFab.implicitWidth > MD.Tokens.fab.containerWidth);
            compare(content.textOpacity, 1);
            compare(findChild(textOnlyFab, "iconLabelText").visible, true);
        }

        function test_long_label_and_explicit_narrow_width() {
            primaryFab.text = "A deliberately long single-line label that remains natural width";
            tryVerify(() => primaryFab.implicitWidth > 300);
            const naturalLabel = findChild(primaryFab, "iconLabelText");
            verify(naturalLabel);
            compare(naturalLabel.wrapMode, Text.NoWrap);
            compare(naturalLabel.lineCount, 1);

            compare(narrowFab.width, 72);
            verify(narrowFab.implicitWidth > narrowFab.width);
            verify(narrowFab.contentItem.clip);
            verify(narrowFab.contentItem.x >= 0);
            verify(narrowFab.contentItem.x + narrowFab.contentItem.width <= narrowFab.width);
            compare(findChild(narrowFab, "iconLabelText").lineCount, 1);
        }

        function test_rtl_reverses_order_without_flipping_glyph() {
            verify(rtlFab.mirrored);
            const icon = findChild(rtlFab, "iconLabelIcon");
            const label = findChild(rtlFab, "iconLabelText");
            verify(icon);
            verify(label);
            verify(icon.x > label.x);
            compare(icon.scale, 1);
        }

        function test_semantic_variants() {
            primaryFab.variant = MD.ExtendedFAB.Variant.Surface;
            compare(primaryFab.effectiveContainerColor, MD.Style.surfaceContainerHighColor);
            compare(primaryFab.effectiveContentColor, MD.Style.primaryColor);
            primaryFab.lowered = true;
            compare(primaryFab.effectiveContainerColor, MD.Style.surfaceContainerLowColor);

            primaryFab.lowered = false;
            primaryFab.variant = MD.ExtendedFAB.Variant.Primary;
            compare(primaryFab.effectiveContainerColor, MD.Style.primaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onPrimaryContainerColor);

            primaryFab.variant = MD.ExtendedFAB.Variant.Secondary;
            compare(primaryFab.effectiveContainerColor, MD.Style.secondaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onSecondaryContainerColor);

            primaryFab.variant = MD.ExtendedFAB.Variant.Tertiary;
            compare(primaryFab.effectiveContainerColor, MD.Style.tertiaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onTertiaryContainerColor);
        }

        function test_color_overrides() {
            compare(customFab.effectiveContainerColor, "#00ff00");
            compare(customFab.effectiveContentColor, "#ff0000");
            compare(customFab.effectiveIconColor, "#ff0000");
        }

        function test_elevation_and_state_layers() {
            const ripple = findChild(primaryFab, "extendedFabRipple");
            verify(ripple);
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.containerElevation);
            compare(ripple.stateOpacity, 0);

            mouseMove(primaryFab, primaryFab.width / 2, primaryFab.height / 2);
            tryCompare(primaryFab, "hovered", true);
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.hoverContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.hoverStateLayerOpacity);

            mousePress(primaryFab, primaryFab.width / 2, primaryFab.height / 2);
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.pressedContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.pressedStateLayerOpacity);
            mouseRelease(primaryFab, primaryFab.width / 2, primaryFab.height / 2);

            testCase.forceActiveFocus();
            primaryFab.forceActiveFocus(Qt.TabFocusReason);
            tryVerify(() => primaryFab.visualFocus);
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.focusContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.focusStateLayerOpacity);

            testCase.forceActiveFocus();
            mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
            primaryFab.lowered = true;
            compare(primaryFab.effectiveElevation, MD.Tokens.fab.loweredContainerElevation);

            mouseMove(primaryFab, primaryFab.width / 2, primaryFab.height / 2);
            tryCompare(primaryFab, "hovered", true);
            compare(primaryFab.effectiveElevation,
                    MD.Tokens.fab.loweredHoverContainerElevation);
        }

        function test_pointer_keyboard_and_disabled_activation() {
            mouseClick(primaryFab, primaryFab.width / 2, primaryFab.height / 2);
            compare(clickedSpy.count, 1);

            primaryFab.forceActiveFocus(Qt.TabFocusReason);
            keyClick(Qt.Key_Space);
            compare(clickedSpy.count, 2);

            primaryFab.enabled = false;
            mouseClick(primaryFab, primaryFab.width / 2, primaryFab.height / 2);
            keyClick(Qt.Key_Space);
            compare(clickedSpy.count, 2);
        }

        function test_icon_label_text_opacity() {
            const label = findChild(opacityLabel, "iconLabelText");
            verify(label);
            compare(opacityLabel.textOpacity, 1);
            compare(label.opacity, 1);
            verify(label.visible);

            opacityLabel.textOpacity = 0;
            compare(label.opacity, 0);
            verify(!label.visible);
        }
    }
}
