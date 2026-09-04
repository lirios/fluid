// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 400
    height: 400

    MD.IconButton {
        id: standardButton

        text: "Search"
        type: MD.IconButton.Type.Standard
        icon.name: MD.Symbols.search
        checkable: true
    }

    MD.IconButton {
        id: sourceButton

        text: "Source action"
        icon.name: MD.Symbols.search
        icon.source: Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png")
    }

    MD.IconButton {
        id: outlinedButton

        text: "Favorite"
        type: MD.IconButton.Type.Outlined
        checkable: true
        icon.name: MD.Symbols.favorite
    }

    MD.IconButton {
        id: customButton

        text: "More options"
        type: MD.IconButton.Type.Standard
        icon.name: MD.Symbols.moreVert
        contentColor: "#ff0000"
        disabledContentColor: "#0000ff"
        containerColor: "#00ff00"
    }

    MD.IconButton {
        id: alternateIconButton

        text: "Mute"
        type: MD.IconButton.Type.Standard
        icon.name: MD.Symbols.volumeUp
        checkedIcon.name: MD.Symbols.volumeOff
        checkedIcon.color: "#ff0000"
        checkable: true
    }

    MD.IconButton {
        id: mirroredButton

        text: "Forward"
        type: MD.IconButton.Type.Standard
        icon.name: MD.Symbols.arrowForward
        mirrorIconInRtl: true
        LayoutMirroring.enabled: true
    }

    SignalSpy {
        id: toggledSpy
        target: alternateIconButton
        signalName: "toggled"
    }

    TestCase {
        name: "IconButtonTests"
        when: windowShown

        function init() {
            standardButton.checked = false;
            outlinedButton.checked = false;
            customButton.enabled = true;
            alternateIconButton.checked = false;
            sourceButton.tintSourceIcon = true;
            if (sourceButton.icon.source.toString().length === 0) {
                sourceButton.icon.source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
            }
            toggledSpy.clear();
        }

        function test_accessible_target_sizes() {
            standardButton.size = MD.IconButton.Size.ExtraSmall;
            standardButton.widthVariant = MD.IconButton.Width.Default;
            compare(standardButton.implicitWidth, 48);
            compare(standardButton.implicitHeight, 48);

            standardButton.size = MD.IconButton.Size.Small;
            standardButton.widthVariant = MD.IconButton.Width.Wide;
            compare(standardButton.implicitWidth, 52);
            compare(standardButton.implicitHeight, 48);

            standardButton.size = MD.IconButton.Size.Medium;
            standardButton.widthVariant = MD.IconButton.Width.Default;
            compare(standardButton.implicitWidth, 56);
            compare(standardButton.implicitHeight, 56);
        }

        function test_default_and_checked_colors() {
            compare(standardButton.contentColor, MD.Style.onSurfaceVariantColor);
            standardButton.checked = true;
            compare(standardButton.contentColor, MD.Style.primaryColor);
        }

        function test_semantic_color_overrides() {
            compare(customButton.effectiveContentColor, "#ff0000");
            compare(customButton.effectiveContainerColor, "#00ff00");

            customButton.enabled = false;
            compare(customButton.effectiveContentColor, "#0000ff");
            compare(customButton.effectiveContentOpacity, 0.38);
        }

        function test_source_icon_takes_precedence() {
            const sourceImage = findChild(sourceButton, "iconButtonSourceImage");
            const symbol = findChild(sourceButton, "iconButtonSymbol");
            verify(sourceImage !== null);
            verify(symbol !== null);
            compare(sourceButton.effectiveIconSource, sourceButton.icon.source);
            compare(sourceImage.source, sourceButton.effectiveIconSource);
            tryCompare(sourceImage, "status", Image.Ready);
            tryCompare(sourceImage, "visible", true);
            verify(!symbol.visible);
            compare(sourceImage.color, sourceButton.effectiveIconColor);

            sourceButton.tintSourceIcon = false;
            compare(sourceImage.color.a, 0);

            sourceButton.icon.source = "";
            verify(!sourceImage.visible);
            verify(symbol.visible);
        }

        function test_outlined_toggle_border() {
            compare(outlinedButton.background.border.width, 1);
            outlinedButton.checked = true;
            compare(outlinedButton.background.border.width, 0);
        }

        function test_checked_icon_and_symbol_fill_fallback() {
            const alternateSymbol = findChild(alternateIconButton, "iconButtonSymbol");
            const standardSymbol = findChild(standardButton, "iconButtonSymbol");

            compare(alternateIconButton.effectiveIconName, MD.Symbols.volumeUp);
            verify(!alternateIconButton.usingCheckedIcon);
            alternateIconButton.checked = true;
            verify(alternateIconButton.usingCheckedIcon);
            compare(alternateIconButton.effectiveIconName, MD.Symbols.volumeOff);
            compare(alternateIconButton.effectiveIconColor, "#ff0000");
            verify(!alternateSymbol.fill);

            standardButton.checked = true;
            verify(!standardButton.usingCheckedIcon);
            verify(standardSymbol.fill);
        }

        function test_rtl_icon_mirroring() {
            verify(mirroredButton.mirrored);
            verify(mirroredButton.effectiveIconMirrored);
            mirroredButton.mirrorIconInRtl = false;
            verify(!mirroredButton.effectiveIconMirrored);
            mirroredButton.mirrorIconInRtl = true;
        }

        function test_keyboard_toggle() {
            alternateIconButton.forceActiveFocus();
            verify(alternateIconButton.activeFocus);
            keyClick(Qt.Key_Space);
            verify(alternateIconButton.checked);
            compare(toggledSpy.count, 1);
        }
    }
}
