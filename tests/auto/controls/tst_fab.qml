// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 1200
    height: 720

    readonly property url testIconSource: Qt.resolvedUrl(
                                              "../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png")

    Item {
        id: focusSink
        x: 1160
        y: 680
        width: 20
        height: 20
        focus: true
    }

    MD.FAB {
        id: iconOnlyFab
        x: 20
        y: 20
        Accessible.name: "Add"
        icon.name: MD.Symbols.add
    }

    MD.FAB {
        id: labeledFab
        x: 140
        y: 20
        text: "Create"
        icon.name: MD.Symbols.add
    }

    MD.FAB {
        id: sourceFab
        x: 380
        y: 20
        Accessible.name: "Source action"
        icon.name: MD.Symbols.search
        icon.source: testIconSource
    }

    MD.FAB {
        id: labeledSourceFab
        x: 500
        y: 20
        text: "Source action"
        icon.name: MD.Symbols.search
        icon.source: testIconSource
    }

    MD.FAB {
        id: mirroredFab
        x: 740
        y: 20
        Accessible.name: "Forward"
        icon.name: MD.Symbols.arrowForward
        mirrorIconInRtl: true
        LayoutMirroring.enabled: true
    }

    MD.FAB {
        id: rtlLabeledFab
        x: 860
        y: 20
        text: "Forward"
        icon.name: MD.Symbols.arrowForward
        LayoutMirroring.enabled: true
    }

    MD.FAB {
        id: customFab
        x: 20
        y: 160
        text: "Custom"
        icon.name: MD.Symbols.priorityHigh
        containerColor: "#00ff00"
        contentColor: "#ff0000"
    }

    MD.FAB {
        id: textOnlyFab
        x: 260
        y: 160
        text: "Text only"
        expanded: false
    }

    MD.FAB {
        id: narrowFab
        x: 500
        y: 160
        width: 72
        text: "A deliberately long single-line label"
        icon.name: MD.Symbols.edit
    }

    MD.IconLabel {
        id: opacityLabel
        x: 20
        y: 340
        text: "Opacity"
        icon.name: MD.Symbols.visibility
        icon.width: 24
        icon.height: 24
    }

    SignalSpy {
        id: clickedSpy
        target: labeledFab
        signalName: "clicked"
    }

    TestCase {
        id: testCase
        name: "FABTests"
        when: windowShown

        function init() {
            iconOnlyFab.size = MD.FAB.Size.Default;
            iconOnlyFab.variant = MD.FAB.Variant.Primary;
            iconOnlyFab.lowered = false;
            iconOnlyFab.enabled = true;
            iconOnlyFab.icon.name = MD.Symbols.add;
            iconOnlyFab.icon.source = "";
            iconOnlyFab.icon.color = "transparent";

            labeledFab.size = MD.FAB.Size.Default;
            labeledFab.variant = MD.FAB.Variant.Primary;
            labeledFab.lowered = false;
            labeledFab.expanded = true;
            labeledFab.enabled = true;
            labeledFab.text = "Create";
            labeledFab.icon.name = MD.Symbols.add;
            labeledFab.icon.source = "";
            labeledFab.icon.color = "transparent";

            sourceFab.icon.source = testIconSource;
            labeledSourceFab.icon.source = testIconSource;
            mirroredFab.mirrorIconInRtl = true;
            opacityLabel.textOpacity = 1;
            testCase.forceActiveFocus();
            mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
            tryCompare(labeledFab.contentItem, "textOpacity", 1);
            clickedSpy.clear();
        }

        function fuzzyCompare(actual, expected, epsilon, message) {
            verify(Math.abs(actual - expected) <= epsilon,
                   (message || "values differ") + ": " + actual + " != " + expected);
        }

        function test_defaults_and_accessibility_contract() {
            compare(iconOnlyFab.size, MD.FAB.Size.Default);
            compare(iconOnlyFab.variant, MD.FAB.Variant.Primary);
            verify(!iconOnlyFab.lowered);
            verify(iconOnlyFab.expanded);
            verify(iconOnlyFab.hasIcon);
            compare(iconOnlyFab.text, "");
            compare(iconOnlyFab.Accessible.name, "Add");
            compare(iconOnlyFab.focusPolicy, Qt.StrongFocus);
            verify(iconOnlyFab.hoverEnabled);
            compare(iconOnlyFab.effectiveIconName, MD.Symbols.add);
            compare(iconOnlyFab.effectiveIconSource.toString(), "");

            compare(labeledFab.text, "Create");
            compare(labeledFab.Accessible.name, "Create");
            compare(labeledFab.effectiveIconColor, labeledFab.effectiveContentColor);
            compare(labeledFab.effectiveContainerColor, MD.Style.primaryContainerColor);
            compare(labeledFab.effectiveContentColor, MD.Style.onPrimaryContainerColor);
            compare(labeledFab.effectiveElevation, MD.Tokens.fab.containerElevation);
        }

        function test_sizes_data() {
            return [
                { tag: "default", size: MD.FAB.Size.Default, container: 56,
                  icon: 24, leading: 16, trailing: 16, spacing: 8, radius: 16,
                  fontSize: 16, fontWeight: Font.Medium },
                { tag: "medium", size: MD.FAB.Size.Medium, container: 80,
                  icon: 28, leading: 26, trailing: 26, spacing: 12, radius: 20,
                  fontSize: 22, fontWeight: Font.Normal },
                { tag: "large", size: MD.FAB.Size.Large, container: 96,
                  icon: 32, leading: 28, trailing: 28, spacing: 16, radius: 28,
                  fontSize: 24, fontWeight: Font.Normal }
            ];
        }

        function test_sizes(data) {
            iconOnlyFab.size = data.size;
            labeledFab.size = data.size;

            compare(iconOnlyFab.implicitWidth, data.container);
            compare(iconOnlyFab.implicitHeight, data.container);
            compare(iconOnlyFab.background.implicitWidth, data.container);
            compare(iconOnlyFab.background.implicitHeight, data.container);
            compare(iconOnlyFab.icon.width, data.icon);
            compare(iconOnlyFab.icon.height, data.icon);
            compare(iconOnlyFab.contentItem.effectiveDisplay, MD.IconLabel.IconOnly);
            compare(iconOnlyFab.contentItem.implicitWidth, data.icon);
            compare(iconOnlyFab.contentItem.implicitHeight, data.icon);

            const content = findChild(labeledFab, "fabContent");
            const expectedWidth = Math.max(data.container,
                                           data.leading + content.implicitWidth
                                           + data.trailing);
            tryCompare(labeledFab, "implicitWidth", expectedWidth);
            compare(labeledFab.implicitHeight, data.container);
            compare(labeledFab.icon.width, data.icon);
            compare(content.spacing, data.spacing);
            fuzzyCompare(labeledFab.leftPadding, data.leading, 0.01, "leading padding");
            fuzzyCompare(labeledFab.rightPadding, data.trailing, 0.01, "trailing padding");
            fuzzyCompare(labeledFab.background.topLeftRadius, data.radius, 0.01,
                         "top-left radius");

            const label = findChild(labeledFab, "iconLabelText");
            const icon = findChild(labeledFab, "iconLabelIcon");
            verify(label);
            verify(icon);
            compare(icon.width, data.icon);
            compare(icon.height, data.icon);
            compare(label.font.pixelSize, data.fontSize);
            compare(label.font.weight, data.fontWeight);
        }

        function test_all_size_variant_combinations() {
            const sizes = [MD.FAB.Size.Default, MD.FAB.Size.Medium, MD.FAB.Size.Large];
            const variants = [MD.FAB.Variant.Surface, MD.FAB.Variant.Primary,
                              MD.FAB.Variant.Secondary, MD.FAB.Variant.Tertiary];
            for (const size of sizes) {
                for (const variant of variants) {
                    iconOnlyFab.size = size;
                    iconOnlyFab.variant = variant;
                    labeledFab.size = size;
                    labeledFab.variant = variant;
                    compare(iconOnlyFab.implicitWidth, iconOnlyFab.implicitHeight);
                    tryVerify(() => labeledFab.implicitWidth >= labeledFab.implicitHeight);
                    compare(iconOnlyFab.effectiveContainerColor,
                            labeledFab.effectiveContainerColor);
                    compare(iconOnlyFab.effectiveContentColor,
                            labeledFab.effectiveContentColor);
                }
            }
        }

        function test_label_length_changes_natural_width() {
            labeledFab.text = "Go";
            const shortExpected = MD.Tokens.fab.leadingSpace
                    + labeledFab.contentItem.implicitWidth + MD.Tokens.fab.trailingSpace;
            tryCompare(labeledFab, "implicitWidth", Math.max(56, shortExpected));
            const shortWidth = labeledFab.implicitWidth;

            labeledFab.text = "Create a new document";
            const longExpected = MD.Tokens.fab.leadingSpace
                    + labeledFab.contentItem.implicitWidth + MD.Tokens.fab.trailingSpace;
            tryCompare(labeledFab, "implicitWidth", longExpected);
            verify(labeledFab.implicitWidth > shortWidth);
        }

        function test_collapse_and_reexpand_data() {
            return [
                { tag: "default", size: MD.FAB.Size.Default, collapsed: 56 },
                { tag: "medium", size: MD.FAB.Size.Medium, collapsed: 80 },
                { tag: "large", size: MD.FAB.Size.Large, collapsed: 96 }
            ];
        }

        function test_collapse_and_reexpand(data) {
            labeledFab.size = data.size;
            const leading = [16, 26, 28][data.size];
            const trailing = [16, 26, 28][data.size];
            const expandedWidth = Math.max(data.collapsed,
                                           leading + labeledFab.contentItem.implicitWidth
                                           + trailing);
            tryCompare(labeledFab, "implicitWidth", expandedWidth);

            labeledFab.expanded = false;
            wait(40);
            verify(isFinite(labeledFab.implicitWidth));
            verify(isFinite(labeledFab.leftPadding));
            verify(isFinite(labeledFab.rightPadding));
            fuzzyCompare(labeledFab.background.width, labeledFab.width, 0.01,
                         "animated background width");
            tryCompare(labeledFab, "implicitWidth", data.collapsed);
            tryCompare(labeledFab.contentItem, "textOpacity", 0);

            const icon = findChild(labeledFab, "iconLabelIcon");
            verify(icon);
            fuzzyCompare(labeledFab.contentItem.x + icon.x + icon.width / 2,
                         labeledFab.width / 2, 0.5, "collapsed icon center");

            labeledFab.expanded = true;
            tryCompare(labeledFab, "implicitWidth", expandedWidth);
            tryCompare(labeledFab.contentItem, "textOpacity", 1);
        }

        function test_text_only_fallback_stays_extended() {
            verify(!textOnlyFab.hasIcon);
            verify(!textOnlyFab.expanded);
            verify(textOnlyFab.implicitWidth > MD.Tokens.fab.containerWidth);
            compare(textOnlyFab.contentItem.textOpacity, 1);
            compare(findChild(textOnlyFab, "iconLabelText").visible, true);
        }

        function test_long_label_and_explicit_narrow_width() {
            labeledFab.text = "A deliberately long single-line label that remains natural width";
            tryVerify(() => labeledFab.implicitWidth > 300);
            const naturalLabel = findChild(labeledFab, "iconLabelText");
            compare(naturalLabel.wrapMode, Text.NoWrap);
            compare(naturalLabel.lineCount, 1);

            compare(narrowFab.width, 72);
            verify(narrowFab.implicitWidth > narrowFab.width);
            verify(narrowFab.contentItem.clip);
            verify(narrowFab.contentItem.x >= 0);
            verify(narrowFab.contentItem.x + narrowFab.contentItem.width <= narrowFab.width);
            compare(findChild(narrowFab, "iconLabelText").lineCount, 1);
        }

        function verifySourceIcon(fab) {
            const sourceImage = findChild(fab, "iconLabelSourceImage");
            const symbol = findChild(fab, "iconLabelSymbol");
            verify(sourceImage);
            verify(symbol);
            compare(fab.effectiveIconSource, fab.icon.source);
            tryCompare(sourceImage, "status", Image.Ready);
            verify(sourceImage.visible);
            verify(!symbol.visible);
        }

        function test_source_icon_precedence_icon_only_and_labeled() {
            verifySourceIcon(sourceFab);
            verifySourceIcon(labeledSourceFab);

            sourceFab.icon.source = "";
            verify(!findChild(sourceFab, "iconLabelSourceImage").visible);
            verify(findChild(sourceFab, "iconLabelSymbol").visible);
        }

        function test_rtl_icon_mirroring_and_label_order() {
            verify(mirroredFab.mirrored);
            verify(mirroredFab.effectiveIconMirrored);
            const mirrorTransform = findChild(mirroredFab, "iconLabelMirrorTransform");
            compare(mirrorTransform.xScale, -1);
            mirroredFab.mirrorIconInRtl = false;
            verify(!mirroredFab.effectiveIconMirrored);
            compare(mirrorTransform.xScale, 1);

            verify(rtlLabeledFab.mirrored);
            const icon = findChild(rtlLabeledFab, "iconLabelIcon");
            const label = findChild(rtlLabeledFab, "iconLabelText");
            verify(icon.x > label.x);
            compare(findChild(rtlLabeledFab, "iconLabelMirrorTransform").xScale, 1);
        }

        function test_semantic_variants_and_color_overrides() {
            labeledFab.variant = MD.FAB.Variant.Surface;
            compare(labeledFab.effectiveContainerColor, MD.Style.surfaceContainerHighColor);
            compare(labeledFab.effectiveContentColor, MD.Style.primaryColor);
            labeledFab.lowered = true;
            compare(labeledFab.effectiveContainerColor, MD.Style.surfaceContainerLowColor);

            labeledFab.lowered = false;
            labeledFab.variant = MD.FAB.Variant.Primary;
            compare(labeledFab.effectiveContainerColor, MD.Style.primaryContainerColor);
            labeledFab.variant = MD.FAB.Variant.Secondary;
            compare(labeledFab.effectiveContainerColor, MD.Style.secondaryContainerColor);
            labeledFab.variant = MD.FAB.Variant.Tertiary;
            compare(labeledFab.effectiveContainerColor, MD.Style.tertiaryContainerColor);

            compare(customFab.effectiveContainerColor, "#00ff00");
            compare(customFab.effectiveContentColor, "#ff0000");
            compare(customFab.effectiveIconColor, "#ff0000");
        }

        function test_elevation_and_state_layers() {
            const ripple = findChild(labeledFab, "fabRipple");
            verify(ripple);
            compare(labeledFab.effectiveElevation, MD.Tokens.fab.containerElevation);
            compare(ripple.stateOpacity, 0);

            mouseMove(labeledFab, labeledFab.width / 2, labeledFab.height / 2);
            tryCompare(labeledFab, "hovered", true);
            compare(labeledFab.effectiveElevation, MD.Tokens.fab.hoverContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.hoverStateLayerOpacity);

            mousePress(labeledFab, labeledFab.width / 2, labeledFab.height / 2);
            compare(labeledFab.effectiveElevation, MD.Tokens.fab.pressedContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.pressedStateLayerOpacity);
            mouseRelease(labeledFab, labeledFab.width / 2, labeledFab.height / 2);

            testCase.forceActiveFocus();
            labeledFab.forceActiveFocus(Qt.TabFocusReason);
            tryVerify(() => labeledFab.visualFocus);
            compare(labeledFab.effectiveElevation, MD.Tokens.fab.focusContainerElevation);
            compare(ripple.stateOpacity, MD.Tokens.fab.focusStateLayerOpacity);
        }

        function test_pointer_keyboard_and_disabled_activation() {
            mouseClick(labeledFab, labeledFab.width / 2, labeledFab.height / 2);
            compare(clickedSpy.count, 1);

            labeledFab.forceActiveFocus(Qt.TabFocusReason);
            keyClick(Qt.Key_Space);
            compare(clickedSpy.count, 2);

            labeledFab.enabled = false;
            mouseClick(labeledFab, labeledFab.width / 2, labeledFab.height / 2);
            keyClick(Qt.Key_Space);
            compare(clickedSpy.count, 2);
        }

        function test_icon_label_text_opacity() {
            const label = findChild(opacityLabel, "iconLabelText");
            verify(label);
            compare(label.opacity, 1);
            verify(label.visible);

            opacityLabel.textOpacity = 0;
            compare(label.opacity, 0);
            verify(!label.visible);
        }
    }
}
