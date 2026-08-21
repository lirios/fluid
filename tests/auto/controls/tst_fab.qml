// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 600
    height: 400

    Item {
        id: focusSink

        x: 560
        y: 360
        width: 20
        height: 20
        focus: true
    }

    MD.FAB {
        id: primaryFab

        x: 20
        y: 20
        text: "Add"
        icon.name: "add"
    }

    MD.FAB {
        id: sourceFab

        x: 160
        y: 20
        text: "Source action"
        icon.name: "search"
        icon.source: Qt.resolvedUrl(
                         "../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png")
    }

    MD.FAB {
        id: mirroredFab

        x: 300
        y: 20
        text: "Forward"
        icon.name: "arrow_forward"
        mirrorIconInRtl: true
        LayoutMirroring.enabled: true
    }

    MD.FAB {
        id: customFab

        x: 440
        y: 20
        text: "Custom"
        icon.name: "priority_high"
        containerColor: "#00ff00"
        contentColor: "#ff0000"
    }

    SignalSpy {
        id: clickedSpy
        target: primaryFab
        signalName: "clicked"
    }

    TestCase {
        id: testCase

        name: "FABTests"
        when: windowShown

        function init() {
            primaryFab.size = MD.FAB.Size.Default;
            primaryFab.variant = MD.FAB.Variant.Primary;
            primaryFab.lowered = false;
            primaryFab.enabled = true;
            primaryFab.icon.name = "add";
            primaryFab.icon.source = "";
            primaryFab.icon.color = "transparent";
            sourceFab.icon.source = Qt.resolvedUrl(
                        "../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
            mirroredFab.mirrorIconInRtl = true;
            testCase.forceActiveFocus();
            mouseMove(focusSink, focusSink.width / 2, focusSink.height / 2);
            clickedSpy.clear();
        }

        function test_defaults_and_accessibility_contract() {
            compare(primaryFab.size, MD.FAB.Size.Default);
            compare(primaryFab.variant, MD.FAB.Variant.Primary);
            verify(!primaryFab.lowered);
            compare(primaryFab.text, "Add");
            compare(primaryFab.Accessible.name, "Add");
            compare(primaryFab.focusPolicy, Qt.StrongFocus);
            compare(primaryFab.effectiveIconName, "add");
            compare(primaryFab.effectiveIconSource.toString(), "");
        }

        function test_sizes() {
            const sizes = [MD.FAB.Size.Default, MD.FAB.Size.Medium, MD.FAB.Size.Large];
            const containers = [56, 80, 96];
            const icons = [24, 28, 36];
            const shapes = [16, 20, 28];
            const symbol = findChild(primaryFab, "fabSymbol");
            verify(symbol !== null);

            for (let index = 0; index < sizes.length; ++index) {
                primaryFab.size = sizes[index];
                compare(primaryFab.implicitWidth, containers[index]);
                compare(primaryFab.implicitHeight, containers[index]);
                compare(primaryFab.background.implicitWidth, containers[index]);
                compare(primaryFab.background.implicitHeight, containers[index]);
                compare(primaryFab.background.width, containers[index]);
                compare(primaryFab.background.height, containers[index]);
                compare(primaryFab.background.radius, shapes[index]);
                compare(primaryFab.icon.width, icons[index]);
                compare(primaryFab.icon.height, icons[index]);
                compare(primaryFab.contentItem.implicitWidth, icons[index]);
                compare(primaryFab.contentItem.implicitHeight, icons[index]);
                compare(symbol.width, icons[index]);
                compare(symbol.height, icons[index]);
                compare(symbol.x, (primaryFab.contentItem.width - symbol.width) / 2);
                compare(symbol.y, (primaryFab.contentItem.height - symbol.height) / 2);
            }
        }

        function test_semantic_variants() {
            primaryFab.variant = MD.FAB.Variant.Surface;
            compare(primaryFab.effectiveContainerColor, MD.Style.surfaceContainerHighColor);
            compare(primaryFab.effectiveContentColor, MD.Style.primaryColor);
            primaryFab.lowered = true;
            compare(primaryFab.effectiveContainerColor, MD.Style.surfaceContainerLowColor);

            primaryFab.lowered = false;
            primaryFab.variant = MD.FAB.Variant.Primary;
            compare(primaryFab.effectiveContainerColor, MD.Style.primaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onPrimaryContainerColor);

            primaryFab.variant = MD.FAB.Variant.Secondary;
            compare(primaryFab.effectiveContainerColor, MD.Style.secondaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onSecondaryContainerColor);

            primaryFab.variant = MD.FAB.Variant.Tertiary;
            compare(primaryFab.effectiveContainerColor, MD.Style.tertiaryContainerColor);
            compare(primaryFab.effectiveContentColor, MD.Style.onTertiaryContainerColor);
        }

        function test_color_overrides() {
            compare(customFab.effectiveContainerColor, "#00ff00");
            compare(customFab.effectiveContentColor, "#ff0000");
            compare(customFab.effectiveIconColor, "#ff0000");
        }

        function test_elevation_and_state_layers() {
            const ripple = findChild(primaryFab, "fabRipple");
            verify(ripple !== null);
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

        function test_source_icon_precedence() {
            const sourceImage = findChild(sourceFab, "fabSourceImage");
            const symbol = findChild(sourceFab, "fabSymbol");
            verify(sourceImage !== null);
            verify(symbol !== null);
            compare(sourceFab.effectiveIconSource, sourceFab.icon.source);
            tryCompare(sourceImage, "status", Image.Ready);
            verify(sourceImage.visible);
            verify(!symbol.visible);

            sourceFab.icon.source = "";
            verify(!sourceImage.visible);
            verify(symbol.visible);
        }

        function test_rtl_icon_mirroring() {
            verify(mirroredFab.mirrored);
            verify(mirroredFab.effectiveIconMirrored);
            mirroredFab.mirrorIconInRtl = false;
            verify(!mirroredFab.effectiveIconMirrored);
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
    }
}
