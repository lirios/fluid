// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "BadgeTests"
    width: 800
    height: 600
    visible: true
    when: windowShown

    Component { id: badgeComponent; MD.Badge {} }
    Component { id: targetComponent; Item { width: 24; height: 24 } }
    Component { id: backgroundComponent; Rectangle { implicitWidth: 80; implicitHeight: 60 } }
    Component {
        id: themedComponent
        Item {
            property alias badge: badge
            MD.Style.theme: MD.Style.Light
            MD.Badge { id: badge; count: 1; MD.Style.theme: MD.Style.Dark }
        }
    }
    Component {
        id: overlayComponent
        Item {
            width: 80; height: 80; clip: true
            property alias target: target
            property alias badge: badge
            Rectangle { id: target; x: 20; y: 20; width: 24; height: 24 }
            MD.BadgeOverlay { id: badge; target: target }
        }
    }
    Component {
        id: hostComponent
        Item {
            id: hostFixture
            width: 400; height: 100
            property alias host: host
            property alias action: action
            property int activations: 0
            property bool clearOnActivation: false
            MD.Action {
                id: action
                text: "Inbox"
                icon.name: MD.Symbols.mail
                onTriggered: {
                    ++hostFixture.activations;
                    if (hostFixture.clearOnActivation)
                        badgeContent = "";
                }
            }
            MD.IconButton { id: host; x: 40; y: 20; action: action }
        }
    }

    function badge(properties) {
        const result = createTemporaryObject(badgeComponent, testCase, properties || {});
        verify(result);
        return result;
    }

    function test_defaults_and_passivity() {
        const control = badge();
        compare(control.variant, MD.Badge.Auto);
        compare(control.effectiveVariant, MD.Badge.Small);
        compare(control.count, -1);
        compare(control.text, "");
        compare(control.displayText, "");
        compare(control.implicitWidth, 6);
        compare(control.implicitHeight, 6);
        compare(control.focusPolicy, Qt.NoFocus);
        compare(control.enabled, false);
        compare(control.hoverEnabled, false);
        compare(control.wheelEnabled, false);
        verify(control.Accessible.ignored);
        compare(control.accessibleDescription, qsTr("New notification"));
        compare(control.typescale, MD.Tokens.typescale.labelSmall);
        compare(control.font.pixelSize, MD.Tokens.typescale.labelSmall.fontSize);
    }

    function test_content_data() {
        return [
            {tag: "zero", count: 0, text: "", display: "0", full: "0", large: true},
            {tag: "one", count: 1, text: "", display: "1", full: "1", large: true},
            {tag: "two-digits", count: 10, text: "", display: "10", full: "10", large: true},
            {tag: "maximum", count: 999, text: "", display: "999", full: "999", large: true},
            {tag: "overflow", count: 1000, text: "", display: "999+", full: "1000", large: true},
            {tag: "text-wins", count: 999, text: "New", display: "New", full: "New", large: true},
            {tag: "four-graphemes", count: -1, text: "Done", display: "Done", full: "Done", large: true},
            {tag: "status", count: -1, text: "Updated", display: "Upd…", full: "Updated", large: true},
            {tag: "combining", count: -1, text: "áb́ćd́é", display: "áb́ć…", full: "áb́ćd́é", large: true},
            {tag: "emoji", count: -1, text: "👩‍💻👨‍👩‍👧‍👦🇮🇹👍🏽🎉", display: "👩‍💻👨‍👩‍👧‍👦🇮🇹…", full: "👩‍💻👨‍👩‍👧‍👦🇮🇹👍🏽🎉", large: true},
            {tag: "flag-at-elision", count: -1, text: "AB🇮🇹CD", display: "AB🇮🇹…", full: "AB🇮🇹CD", large: true},
            {tag: "flag-with-combining", count: -1, text: "AB🇮🇹́CD", display: "AB🇮🇹́…", full: "AB🇮🇹́CD", large: true},
            {tag: "flag-with-variation-selector", count: -1, text: "AB🇮🇹\uFE0FCD", display: "AB🇮🇹\uFE0F…", full: "AB🇮🇹\uFE0FCD", large: true},
            {tag: "flag-with-skin-modifier", count: -1, text: "AB🇮🇹🏽CD", display: "AB🇮🇹🏽…", full: "AB🇮🇹🏽CD", large: true},
            {tag: "flag-with-spacing-mark", count: -1, text: "AB🇮🇹\u093ECD", display: "AB🇮🇹\u093E…", full: "AB🇮🇹\u093ECD", large: true},
            {tag: "flag-with-zwj", count: -1, text: "AB🇮🇹\u200DCD", display: "AB🇮🇹\u200D…", full: "AB🇮🇹\u200DCD", large: true},
            {tag: "skin-modifier-at-elision", count: -1, text: "AB👍🏽CD", display: "AB👍🏽…", full: "AB👍🏽CD", large: true},
            {tag: "four-flags", count: -1, text: "🇮🇹🇫🇷🇩🇪🇪🇸", display: "🇮🇹🇫🇷🇩🇪🇪🇸", full: "🇮🇹🇫🇷🇩🇪🇪🇸", large: true},
            {tag: "five-flags", count: -1, text: "🇮🇹🇫🇷🇩🇪🇪🇸🇬🇧", display: "🇮🇹🇫🇷🇩🇪…", full: "🇮🇹🇫🇷🇩🇪🇪🇸🇬🇧", large: true},
            {tag: "consecutive-flags-after-zwj", count: -1, text: "👩‍💻🇮🇹🇩🇪🇫🇷🇪🇸", display: "👩‍💻🇮🇹🇩🇪…", full: "👩‍💻🇮🇹🇩🇪🇫🇷🇪🇸", large: true},
            {tag: "odd-regional-indicators", count: -1, text: "🇦🇧🇨🇩🇪", display: "🇦🇧🇨🇩🇪", full: "🇦🇧🇨🇩🇪", large: true},
            {tag: "odd-regional-indicator-overflow", count: -1, text: "🇦🇧🇨🇩🇪🇫🇬🇭🇮", display: "🇦🇧🇨🇩🇪🇫…", full: "🇦🇧🇨🇩🇪🇫🇬🇭🇮", large: true},
            {tag: "negative", count: -2, text: "", display: "", full: qsTr("New notification"), large: false},
            {tag: "fraction", count: 1.5, text: "", display: "", full: qsTr("New notification"), large: false},
            {tag: "nan", count: NaN, text: "", display: "", full: qsTr("New notification"), large: false},
            {tag: "infinity", count: Infinity, text: "", display: "", full: qsTr("New notification"), large: false},
            {tag: "largest-safe", count: 9007199254740991, text: "", display: "999+", full: "", large: true},
            {tag: "unsafe", count: 9007199254740992, text: "", display: "", full: qsTr("New notification"), large: false}
        ];
    }

    function test_content(data) {
        const control = badge({count: data.count, text: data.text, locale: Qt.locale("en_US")});
        compare(control.displayText, data.display);
        // Numeric full values may contain grouping; compare against the locale's own formatting.
        const full = data.count >= 0 && Number.isSafeInteger(data.count) && data.text === ""
                   ? data.count.toLocaleString(control.locale, 'f', 0) : data.full;
        compare(control.accessibleDescription, full);
        compare(control.effectiveVariant, data.large ? MD.Badge.Large : MD.Badge.Small);
    }

    function test_variants_preserve_full_information() {
        const control = badge({count: 1000, variant: MD.Badge.Small});
        compare(control.displayText, "");
        compare(control.implicitWidth, 6);
        compare(control.implicitHeight, 6);
        verify(control.accessibleDescription.indexOf("1") !== -1);
        control.text = "Updated";
        compare(control.accessibleDescription, "Updated");
        control.variant = MD.Badge.Large;
        compare(control.displayText, "Upd…");
        control.text = "";
        control.count = -1;
        compare(control.effectiveVariant, MD.Badge.Large);
        compare(control.implicitWidth, 16);
        compare(control.implicitHeight, 16);
    }

    function test_geometry_font_and_shape() {
        const control = badge({count: 999});
        const label = findChild(control, "badgeLabel");
        const background = findChild(control, "badgeBackground");
        verify(label && background);
        compare(control.implicitHeight, 16);
        compare(control.implicitWidth, Math.max(control.implicitHeight, label.implicitWidth + 8));
        compare(label.lineHeight, 16);
        for (const corner of ["topLeftRadius", "topRightRadius", "bottomLeftRadius", "bottomRightRadius"])
            compare(background[corner], Math.min(background.width, background.height) / 2);
        control.text = "WWW";
        control.font.pixelSize = 40;
        tryVerify(() => control.implicitHeight > 16 && control.implicitWidth > 34);
        verify(control.implicitHeight >= label.implicitHeight);
        verify(control.implicitWidth >= label.implicitWidth + 8);
        verify(!label.truncated);
        verify(label.Accessible.ignored && background.Accessible.ignored);
    }

    function test_locale() {
        const control = badge({count: 999, locale: Qt.locale("ar_EG")});
        compare(control.displayText, Number(999).toLocaleString(control.locale, 'f', 0));
        control.count = 1000;
        compare(control.displayText, Number(999).toLocaleString(control.locale, 'f', 0) + "+");
        compare(control.accessibleDescription, Number(1000).toLocaleString(control.locale, 'f', 0));
    }

    function test_typescale_selection() {
        const control = badge({text: "WWW"});
        const label = findChild(control, "badgeLabel");
        verify(label);
        for (const scale of [MD.Tokens.typescale.labelSmall, MD.Tokens.typescale.labelMedium,
                             MD.Tokens.typescale.titleLarge, MD.Tokens.typescale.labelSmall]) {
            control.typescale = scale;
            compare(control.font.family, scale.face === MD.Style.TypeFace.Brand
                    ? control.MD.Style.brandFontFamily : control.MD.Style.plainFontFamily);
            compare(control.font.pixelSize, scale.fontSize);
            compare(control.font.weight, scale.fontWeight);
            compare(control.font.letterSpacing, scale.tracking);
            verify(label.lineHeight >= scale.lineHeight);
            verify(control.implicitHeight >= label.implicitHeight);
            verify(control.implicitWidth >= label.implicitWidth + 8);
        }
    }

    function test_padding_background_and_insets_data() {
        return [{tag: "small", variant: MD.Badge.Small},
                {tag: "large", variant: MD.Badge.Large}];
    }

    function test_padding_background_and_insets(data) {
        const control = badge({variant: data.variant, count: 99,
                               topPadding: 7, bottomPadding: 9,
                               leftPadding: 10, rightPadding: 12});
        const contentHeight = data.variant === MD.Badge.Small ? 0 : control.implicitContentHeight;
        const contentWidth = data.variant === MD.Badge.Small ? 0 : control.implicitContentWidth;
        const minimum = data.variant === MD.Badge.Small ? 6 : 16;
        compare(control.implicitHeight, Math.max(minimum, contentHeight + 16));
        compare(control.implicitWidth, Math.max(control.implicitHeight, contentWidth + 22));
        const background = createTemporaryObject(backgroundComponent, control);
        verify(background);
        control.background = background;
        control.leftInset = 3;
        control.rightInset = 5;
        control.topInset = 4;
        control.bottomInset = 6;
        compare(control.implicitHeight, 70);
        compare(control.implicitWidth, 88);
        verify(control.availableHeight >= contentHeight);
        verify(control.availableWidth >= contentWidth);
    }

    function luminance(color) {
        function linear(value) { return value <= 0.04045 ? value / 12.92 : Math.pow((value + 0.055) / 1.055, 2.4); }
        return 0.2126 * linear(color.r) + 0.7152 * linear(color.g) + 0.0722 * linear(color.b);
    }

    function test_theme_defaults_and_overrides() {
        const control = badge({count: 9});
        for (const theme of [MD.Style.Light, MD.Style.Dark]) {
            control.MD.Style.theme = theme;
            compare(control.containerColor, control.MD.Style.errorColor);
            compare(control.contentColor, control.MD.Style.onErrorColor);
            const first = luminance(control.containerColor);
            const second = luminance(control.contentColor);
            verify((Math.max(first, second) + 0.05) / (Math.min(first, second) + 0.05) >= 3);
        }
        control.containerColor = "#123456";
        control.contentColor = "#abcdef";
        compare(control.containerColor, "#123456");
        compare(control.contentColor, "#abcdef");
        const first = luminance(control.containerColor);
        const second = luminance(control.contentColor);
        verify((Math.max(first, second) + 0.05) / (Math.min(first, second) + 0.05) >= 3);
    }

    function test_local_theme_overrides_parent() {
        const fixture = createTemporaryObject(themedComponent, testCase);
        verify(fixture);
        compare(fixture.MD.Style.theme, MD.Style.Light);
        compare(fixture.badge.MD.Style.theme, MD.Style.Dark);
        compare(fixture.badge.containerColor, MD.Tokens.dark.error);
        compare(fixture.badge.contentColor, MD.Tokens.dark.onError);
        fixture.MD.Style.theme = MD.Style.Dark;
        fixture.badge.MD.Style.theme = MD.Style.Light;
        compare(fixture.badge.containerColor, MD.Tokens.light.error);
        compare(fixture.badge.contentColor, MD.Tokens.light.onError);
    }

    function test_overlay_anchor_data() {
        return [{tag: "ltr", rtl: false}, {tag: "rtl", rtl: true}];
    }

    function test_overlay_anchor(data) {
        const fixture = createTemporaryObject(overlayComponent, testCase);
        verify(fixture);
        const control = fixture.badge;
        control.layoutMirrored = data.rtl;
        function assertPosition(horizontal, vertical) {
            compare(control.x, data.rtl ? fixture.target.x + horizontal - control.width
                                      : fixture.target.x + fixture.target.width - horizontal);
            compare(control.y, fixture.target.y + vertical - control.height);
        }
        assertPosition(6, 6);
        control.count = 1;
        assertPosition(12, 14);
        const anchor = data.rtl ? control.x + control.width : control.x;
        control.count = 1000;
        compare(data.rtl ? control.x + control.width : control.x, anchor);
        fixture.target.x += 13;
        fixture.target.y += 9;
        assertPosition(12, 14);
        fixture.target.x = 75;
        assertPosition(12, 14);
        verify(fixture.clip);
        fixture.target.visible = false;
        tryCompare(control, "visible", false);
        fixture.target.visible = true;
        tryCompare(control, "visible", true);
        fixture.target.width = 0;
        tryCompare(control, "visible", false);
        control.target = null;
        tryCompare(control, "visible", false);
    }

    function test_host_content_data() {
        const rows = [];
        for (const value of ["", null, undefined, -1, 1.2, NaN, Infinity, 9007199254740992, {}, true])
            rows.push({tag: "unset-" + rows.length, value: value, visible: false, display: ""});
        rows.push({tag: "zero", value: 0, visible: true, display: "0"});
        rows.push({tag: "overflow", value: 1000, visible: true, display: "999+"});
        rows.push({tag: "status", value: "Updated", visible: true, display: "Upd…"});
        return rows;
    }

    function test_host_content(data) {
        const fixture = createTemporaryObject(hostComponent, testCase);
        verify(fixture);
        fixture.action.badgeContent = data.value;
        const overlay = findChild(fixture.host, "iconButtonBadge");
        verify(overlay);
        tryCompare(overlay, "visible", data.visible);
        if (data.visible) compare(overlay.displayText, data.display);
        else compare(fixture.host.Accessible.name, "Inbox");
        fixture.action.badgeNotification = true;
        tryCompare(overlay, "visible", true);
        compare(overlay.effectiveVariant, MD.Badge.Small);
        compare(overlay.displayText, "");
        fixture.action.badgeAccessibleDescription = "Unread messages";
        compare(fixture.host.Accessible.name, "Inbox, Unread messages");
        fixture.action.badgeVisible = false;
        tryCompare(overlay, "visible", false);
        compare(fixture.host.Accessible.name, "Inbox");
    }

    function test_host_geometry_and_activation() {
        const fixture = createTemporaryObject(hostComponent, testCase);
        verify(fixture);
        const host = fixture.host;
        const slot = findChild(host, "iconButtonIconSlot");
        verify(slot);
        const initial = [host.implicitWidth, host.implicitHeight, host.baselineOffset,
                         slot.x, slot.y, slot.width, slot.height];
        fixture.action.badgeContent = "Updated";
        compare([host.implicitWidth, host.implicitHeight, host.baselineOffset,
                 slot.x, slot.y, slot.width, slot.height], initial);
        mouseClick(host, host.width / 2, host.height / 2);
        compare(fixture.activations, 1);
        compare(fixture.action.badgeContent, "Updated");
        host.forceActiveFocus(Qt.TabFocusReason);
        keyClick(Qt.Key_Space);
        compare(fixture.activations, 2);
        fixture.action.enabled = false;
        mouseClick(host, host.width / 2, host.height / 2);
        compare(fixture.activations, 2);
        fixture.action.enabled = true;
        fixture.clearOnActivation = true;
        const sequence = touchEvent(host);
        sequence.press(0, host, host.width / 2, host.height / 2).commit();
        sequence.release(0, host, host.width / 2, host.height / 2).commit();
        tryCompare(fixture, "activations", 3);
        compare(fixture.action.badgeContent, "");
        compare(host.Accessible.name, "Inbox");
    }
    function test_explicit_accessible_name_and_rtl_artwork() {
        const fixture = createTemporaryObject(hostComponent, testCase);
        verify(fixture);
        const host = fixture.host;
        fixture.action.badgeContent = 8;
        host.Accessible.name = "Application supplied full name";
        fixture.action.badgeContent = 9;
        compare(host.Accessible.name, "Application supplied full name");
        host.LayoutMirroring.enabled = true;
        host.mirrorIconInRtl = true;
        const overlay = findChild(host, "iconButtonBadge");
        const slot = findChild(host, "iconButtonIconSlot");
        verify(overlay && slot);
        compare(overlay.layoutMirrored, true);
        compare(overlay.x + overlay.width, slot.x + MD.Tokens.badge.largeHorizontalOffset);
        host.mirrorIconInRtl = false;
        compare(overlay.x + overlay.width, slot.x + MD.Tokens.badge.largeHorizontalOffset);
        fixture.action.icon.name = "";
        tryCompare(overlay, "visible", false);
    }

    function test_destroyed_overlay_target() {
        const fixture = createTemporaryObject(overlayComponent, testCase);
        verify(fixture);
        const target = createTemporaryObject(targetComponent, fixture);
        verify(target);
        fixture.badge.target = target;
        tryCompare(fixture.badge, "visible", true);
        target.destroy();
        tryCompare(fixture.badge, "target", null);
        compare(fixture.badge.visible, false);
    }

    function test_overlay_passes_pointer_and_touch_to_host() {
        const fixture = createTemporaryObject(hostComponent, testCase);
        verify(fixture);
        fixture.action.badgeContent = 9;
        const host = fixture.host;
        const overlay = findChild(host, "iconButtonBadge");
        verify(overlay && overlay.visible);
        compare(overlay.enabled, false);
        const point = overlay.mapToItem(host, overlay.width / 2, overlay.height / 2);
        verify(point.x >= 0 && point.x < host.width && point.y >= 0 && point.y < host.height);
        mouseClick(host, point.x, point.y);
        compare(fixture.activations, 1);
        const sequence = touchEvent(host);
        sequence.press(0, host, point.x, point.y).commit();
        sequence.release(0, host, point.x, point.y).commit();
        tryCompare(fixture, "activations", 2);
        compare(fixture.action.badgeContent, 9);
    }

}
