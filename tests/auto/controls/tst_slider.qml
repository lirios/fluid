// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Controls
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "SliderTests"
    width: 480
    height: 480
    visible: true
    when: windowShown

    Component {
        id: sliderComponent

        MD.Slider {
            width: 200
            from: 0
            to: 100
            value: 40
        }
    }

    Component {
        id: defaultSliderComponent

        MD.Slider {
            width: 200
            from: 0
            to: 100
        }
    }

    function createSlider(properties) {
        return createTemporaryObject(sliderComponent, testCase, properties || {});
    }

    function createDefaultSlider(properties) {
        return createTemporaryObject(defaultSliderComponent, testCase, properties || {});
    }

    function trackFor(slider) {
        return findChild(slider, "sliderTrack");
    }

    function handleFor(slider) {
        return findChild(slider.handle, "sliderHandle");
    }

    function indicatorFor(slider) {
        return findChild(slider.handle, "valueIndicator");
    }

    function tickRepeaterFor(slider) {
        return findChild(trackFor(slider), "tickRepeater");
    }

    function ticksFor(slider) {
        const track = trackFor(slider);
        const ticks = [];
        for (let i = 0; i < track.children.length; ++i) {
            const child = track.children[i];
            if (child.objectName === "sliderTick")
                ticks.push(child);
        }
        ticks.sort((a, b) => a.index - b.index);
        return ticks;
    }

    function compareReal(actual, expected, epsilon) {
        verify(Math.abs(actual - expected) <= (epsilon || 0.01),
               "actual " + actual + ", expected " + expected);
    }

    function verifyIndicatorIsWithinSlider(slider, indicator) {
        const point = indicator.mapToItem(slider, 0, 0);
        verify(point.x >= 0);
        verify(point.y >= 0);
        verify(point.x + indicator.width <= slider.width);
        verify(point.y + indicator.height <= slider.height);
    }

    function test_tokens() {
        const token = MD.Tokens.slider;

        compare(token.minimumInteractiveSize, 48);
        compare(token.defaultLength, 200);
        compare(token.handleWidth, 4);
        compare(token.pressedHandleWidth, 2);
        compare(token.focusHandleWidth, 2);
        compare(token.handleHeight, 44);
        compare(token.activeHandleLeadingSpace, 6);
        compare(token.handleTrackGap, 6);
        compare(token.tickSize, 4);
        compare(token.stopIndicatorSize, 4);
        compare(token.tickMinSpacing, 8);
        compare(token.trackInsideCornerRadius, 2);

        compare(token.activeTrackHeightExtraSmall, 16);
        compare(token.activeTrackHeightSmall, 24);
        compare(token.activeTrackHeightMedium, 40);
        compare(token.activeTrackHeightLarge, 56);
        compare(token.activeTrackHeightExtraLarge, 96);
        compare(token.activeTrackLeadingCornerRadiusExtraSmall, 8);
        compare(token.activeTrackLeadingCornerRadiusSmall, 8);
        compare(token.activeTrackLeadingCornerRadiusMedium, 12);
        compare(token.activeTrackLeadingCornerRadiusLarge, 16);
        compare(token.activeTrackLeadingCornerRadiusExtraLarge, 28);
        compare(token.activeHandleHeightExtraSmall, 44);
        compare(token.activeHandleHeightSmall, 44);
        compare(token.activeHandleHeightMedium, 44);
        compare(token.activeHandleHeightLarge, 68);
        compare(token.activeHandleHeightExtraLarge, 108);

        compare(token.trackIconSizeMedium, 24);
        compare(token.trackIconSizeLarge, 24);
        compare(token.trackIconSizeExtraLarge, 32);
        compare(token.trackIconPadding, 10);

        compare(token.visibleOpacity, 1);
        compare(token.hiddenOpacity, 0);
        compare(token.hoverStateLayerOpacity, 0.08);
        compare(token.focusStateLayerOpacity, 0.10);
        compare(token.pressedStateLayerOpacity, 0.10);
        compare(token.disabledActiveTrackOpacity, 0.38);
        compare(token.disabledInactiveTrackOpacity, 0.12);
        compare(token.disabledHandleOpacity, 0.38);

        compare(token.valueIndicatorMinWidth, 32);
        compare(token.valueIndicatorMinHeight, 32);
        compare(token.valueIndicatorHorizontalPadding, 16);
        compare(token.valueIndicatorVerticalPadding, 12);
        compare(token.valueIndicatorActiveBottomSpace, 12);
    }

    function test_defaults_and_public_api() {
        const slider = createDefaultSlider();
        verify(slider);

        compare(slider.labelBehavior, MD.Slider.LabelBehavior.Floating);
        compare(slider.tickVisibilityMode, MD.Slider.TickVisibilityMode.AutoLimit);
        compare(slider.size, MD.Slider.Size.ExtraSmall);
        compare(slider.snapMode, Slider.SnapAlways);
        compare(slider.centered, false);
        compare(slider.value, slider.from);
        compare(slider.valueIndicatorText,
                slider.value.toLocaleString(Qt.locale(), "f", 0));

        slider.centered = true;
        compare(slider.value, 50);

        const explicitValue = createSlider({ centered: true, value: 25 });
        compare(explicitValue.value, 25);

        slider.value = 12.5;
        compare(slider.valueIndicatorText,
                slider.value.toLocaleString(Qt.locale(), "f", 2));
        slider.valueIndicatorText = "Custom";
        compare(slider.valueIndicatorText, "Custom");

        slider.trackIconActiveStart = "volume_up";
        slider.trackIconActiveEnd = "add";
        slider.trackIconInactiveStart = "remove";
        slider.trackIconInactiveEnd = "volume_off";
        compare(slider.trackIconActiveStart, "volume_up");
        compare(slider.trackIconInactiveEnd, "volume_off");
    }

    function test_sizes_data() {
        return [
            { tag: "extraSmall", sliderSize: MD.Slider.Size.ExtraSmall,
              trackHeight: 16, handleHeight: 44, cornerRadius: 8, target: 48 },
            { tag: "small", sliderSize: MD.Slider.Size.Small,
              trackHeight: 24, handleHeight: 44, cornerRadius: 8, target: 48 },
            { tag: "medium", sliderSize: MD.Slider.Size.Medium,
              trackHeight: 40, handleHeight: 44, cornerRadius: 12, target: 48 },
            { tag: "large", sliderSize: MD.Slider.Size.Large,
              trackHeight: 56, handleHeight: 68, cornerRadius: 16, target: 68 },
            { tag: "extraLarge", sliderSize: MD.Slider.Size.ExtraLarge,
              trackHeight: 96, handleHeight: 108, cornerRadius: 28, target: 108 }
        ];
    }

    function test_sizes(data) {
        const slider = createSlider({ size: data.sliderSize });
        const track = trackFor(slider);
        const active = findChild(track, "activeTrack");
        const inactive = findChild(track, "inactiveTrackTrailing");

        compare(active.height, data.trackHeight);
        compare(inactive.height, data.trackHeight);
        compare(slider.handle.height, data.handleHeight);
        compare(handleFor(slider).height, data.handleHeight);
        compare(handleFor(slider).width, 4);
        compare(track.trackOuterCornerRadius, data.cornerRadius);
        compare(track.implicitHeight, data.target);
        compare(slider.implicitHeight, data.target);
        compare(active.topLeftRadius, data.cornerRadius);

        slider.orientation = Qt.Vertical;
        compare(active.width, data.trackHeight);
        compare(inactive.width, data.trackHeight);
        compare(slider.handle.width, data.handleHeight);
        tryCompare(handleFor(slider), "width", data.handleHeight);
        tryCompare(handleFor(slider), "height", 4);
        compare(track.implicitWidth, data.target);
        compare(slider.implicitWidth, data.target);
    }

    function test_handle_contracts_for_press_and_keyboard_focus() {
        const slider = createSlider();
        const handle = handleFor(slider);
        compare(handle.width, 4);

        mousePress(slider, slider.handle.x + slider.handle.width / 2,
                   slider.handle.y + slider.handle.height / 2);
        compare(trackFor(slider).effectiveHandleWidth, 2);
        tryCompare(handle, "width", 2);
        mouseRelease(slider, slider.handle.x + slider.handle.width / 2,
                     slider.handle.y + slider.handle.height / 2);
        tryCompare(handle, "width", 4);

        testCase.forceActiveFocus();
        slider.forceActiveFocus(Qt.TabFocusReason);
        tryVerify(() => slider.visualFocus);
        compare(trackFor(slider).effectiveHandleWidth, 2);
        tryCompare(handle, "width", 2);
    }

    function test_standard_geometry_data() {
        return [
            { tag: "minimum", value: 0, activeStart: 0, activeEnd: 0,
              inactiveStart: 16, inactiveEnd: 200 },
            { tag: "middle", value: 50, activeStart: 0, activeEnd: 92,
              inactiveStart: 108, inactiveEnd: 200 },
            { tag: "maximum", value: 100, activeStart: 0, activeEnd: 184,
              inactiveStart: 200, inactiveEnd: 200 }
        ];
    }

    function test_standard_geometry(data) {
        const slider = createSlider({ value: data.value });
        const track = trackFor(slider);
        compareReal(track.activeStart, data.activeStart);
        compareReal(track.activeEnd, data.activeEnd);
        compareReal(track.trailingInactiveStart, data.inactiveStart);
        compareReal(track.trailingInactiveEnd, data.inactiveEnd);

        slider.LayoutMirroring.enabled = true;
        compareReal(track.activeStart, 200 - data.activeEnd);
        compareReal(track.activeEnd, 200 - data.activeStart);
        compareReal(track.leadingInactiveStart, 200 - data.inactiveEnd);
        compareReal(track.leadingInactiveEnd, 200 - data.inactiveStart);

        slider.LayoutMirroring.enabled = false;
        slider.orientation = Qt.Vertical;
        slider.height = 200;
        compareReal(track.activeStart, data.activeStart);
        compareReal(track.activeEnd, data.activeEnd);
        const active = findChild(track, "activeTrack");
        compareReal(active.y, data.activeStart);
        compareReal(active.height, data.activeEnd - data.activeStart);
    }

    function test_centered_geometry_data() {
        return [
            { tag: "minimum", value: 0, activeStart: 16, activeEnd: 94,
              leadingEnd: 0, trailingStart: 106,
              startStopVisible: false, endStopVisible: true },
            { tag: "left", value: 25, activeStart: 62, activeEnd: 94,
              leadingEnd: 46, trailingStart: 106,
              startStopVisible: true, endStopVisible: true },
            { tag: "midpoint", value: 50, activeStart: 100, activeEnd: 100,
              leadingEnd: 92, trailingStart: 108,
              startStopVisible: true, endStopVisible: true },
            { tag: "right", value: 75, activeStart: 106, activeEnd: 138,
              leadingEnd: 94, trailingStart: 154,
              startStopVisible: true, endStopVisible: true },
            { tag: "maximum", value: 100, activeStart: 106, activeEnd: 184,
              leadingEnd: 94, trailingStart: 200,
              startStopVisible: true, endStopVisible: false }
        ];
    }

    function test_centered_geometry(data) {
        const slider = createSlider({ centered: true, value: data.value });
        const track = trackFor(slider);
        compareReal(track.activeStart, data.activeStart);
        compareReal(track.activeEnd, data.activeEnd);
        compareReal(track.leadingInactiveEnd, data.leadingEnd);
        compareReal(track.trailingInactiveStart, data.trailingStart);
        compare(findChild(track, "startStopIndicator").visible,
                data.startStopVisible);
        compare(findChild(track, "endStopIndicator").visible,
                data.endStopVisible);

        slider.orientation = Qt.Vertical;
        slider.height = 200;
        compareReal(track.activeStart, data.activeStart);
        compareReal(track.activeEnd, data.activeEnd);

        slider.orientation = Qt.Horizontal;
        slider.LayoutMirroring.enabled = true;
        compareReal(track.activeStart, 200 - data.activeEnd);
        compareReal(track.activeEnd, 200 - data.activeStart);
    }

    function test_ticks_stops_and_non_divisible_ranges() {
        const slider = createSlider({ to: 10, value: 6, stepSize: 3 });
        const track = trackFor(slider);
        compare(tickRepeaterFor(slider).count, 4);
        let ticks = ticksFor(slider);
        compare(ticks.length, 4);
        compareReal(ticks[3].x + ticks[3].width / 2, 173.6);
        compare(ticks[2].visible, false);

        slider.to = 12;
        compare(tickRepeaterFor(slider).count, 5);
        ticks = ticksFor(slider);
        compareReal(ticks[4].x + ticks[4].width / 2, 192);

        slider.to = 100;
        slider.value = 40;
        slider.stepSize = 1;
        compare(tickRepeaterFor(slider).count, 24);
        slider.tickVisibilityMode = MD.Slider.TickVisibilityMode.AutoHide;
        compare(tickRepeaterFor(slider).count, 0);
        slider.stepSize = 10;
        compare(tickRepeaterFor(slider).count, 11);
        slider.tickVisibilityMode = MD.Slider.TickVisibilityMode.Hidden;
        compare(tickRepeaterFor(slider).count, 0);

        slider.tickVisibilityMode = MD.Slider.TickVisibilityMode.AutoLimit;
        slider.centered = true;
        ticks = ticksFor(slider);
        compare(ticks[4].visible, false);
        compare(ticks[5].visible, false);

        slider.enabled = false;
        const endStop = findChild(track, "endStopIndicator");
        compare(endStop.color, slider.MD.Style.onSurfaceColor);
        compare(endStop.opacity, 1);
        tryCompare(findChild(track, "activeTrack"), "opacity", 0.38);
        tryCompare(findChild(track, "inactiveTrackTrailing"), "opacity", 0.12);
        tryCompare(handleFor(slider), "opacity", 0.38);
    }

    function test_vertical_and_rtl_tick_alignment() {
        const slider = createSlider({ stepSize: 10, orientation: Qt.Vertical,
                                      height: 200 });
        let ticks = ticksFor(slider);
        compare(ticks.length, 11);
        compareReal(ticks[0].x + ticks[0].width / 2,
                    trackFor(slider).width / 2);
        compareReal(ticks[0].y + ticks[0].height / 2, 8);
        compareReal(ticks[10].y + ticks[10].height / 2, 192);

        slider.orientation = Qt.Horizontal;
        slider.LayoutMirroring.enabled = true;
        ticks = ticksFor(slider);
        compareReal(ticks[0].x + ticks[0].width / 2, 192);
        compareReal(ticks[10].x + ticks[10].width / 2, 8);
        compare(ticks[4].visible, false);
    }

    function test_snap_always_interaction() {
        const slider = createSlider({ value: 0, stepSize: 10 });
        mousePress(slider, 73, slider.height / 2);
        compare(slider.value % slider.stepSize, 0);
        mouseMove(slider, 137, slider.height / 2);
        compare(slider.value % slider.stepSize, 0);
        mouseRelease(slider, 137, slider.height / 2);
    }

    function test_inset_icons() {
        const slider = createSlider({
            size: MD.Slider.Size.Medium,
            value: 50,
            trackIconActiveStart: "volume_up",
            trackIconActiveEnd: "add",
            trackIconInactiveStart: "remove",
            trackIconInactiveEnd: "volume_off"
        });
        const track = trackFor(slider);
        const activeStart = findChild(track, "activeStartIcon");
        const activeEnd = findChild(track, "activeEndIcon");
        const inactiveStart = findChild(track, "inactiveStartIcon");
        const inactiveEnd = findChild(track, "inactiveEndIcon");

        verify(activeStart.visible);
        verify(activeEnd.visible);
        verify(inactiveStart.visible);
        verify(inactiveEnd.visible);
        compare(activeStart.width, 24);
        compareReal(activeStart.x + activeStart.width / 2, 22);
        compareReal(activeEnd.x + activeEnd.width / 2, 70);
        compareReal(inactiveStart.x + inactiveStart.width / 2, 130);
        compareReal(inactiveEnd.x + inactiveEnd.width / 2, 178);
        compare(activeStart.color, slider.trackIconActiveColor);
        compare(inactiveStart.color, slider.trackIconInactiveColor);

        slider.LayoutMirroring.enabled = true;
        compareReal(activeStart.x + activeStart.width / 2, 178);
        compareReal(activeEnd.x + activeEnd.width / 2, 130);
        compareReal(inactiveStart.x + inactiveStart.width / 2, 70);
        compareReal(inactiveEnd.x + inactiveEnd.width / 2, 22);

        slider.orientation = Qt.Vertical;
        slider.LayoutMirroring.enabled = false;
        slider.height = 200;
        compareReal(activeStart.y + activeStart.height / 2, 22);
        compareReal(activeEnd.y + activeEnd.height / 2, 70);

        slider.orientation = Qt.Horizontal;
        slider.size = MD.Slider.Size.Small;
        verify(!activeStart.visible);
        slider.size = MD.Slider.Size.Medium;
        slider.stepSize = 10;
        verify(!activeStart.visible);
        slider.stepSize = 0;
        slider.centered = true;
        verify(!activeStart.visible);
        slider.centered = false;
        slider.value = 10;
        verify(!activeStart.visible);
        verify(inactiveStart.visible);

        slider.size = MD.Slider.Size.ExtraLarge;
        slider.value = 50;
        compare(activeStart.width, 32);
    }

    function test_value_indicator_behaviors_and_formatting() {
        const slider = createSlider();
        const indicator = indicatorFor(slider);

        compare(slider.valueIndicatorText,
                slider.value.toLocaleString(Qt.locale(), "f", 0));
        slider.value = 40.25;
        compare(slider.valueIndicatorText,
                slider.value.toLocaleString(Qt.locale(), "f", 2));

        slider.labelBehavior = MD.Slider.LabelBehavior.Floating;
        compare(slider.implicitHeight, 48);
        verify(!indicator.visible);
        mouseMove(slider, slider.handle.x + slider.handle.width / 2,
                  slider.handle.y + slider.handle.height / 2);
        tryVerify(() => indicator.visible);
        mouseMove(slider, slider.width + 20, slider.height + 20);

        slider.labelBehavior = MD.Slider.LabelBehavior.WithinBounds;
        compareReal(slider.implicitHeight,
                    48 + indicator.implicitHeight + MD.Tokens.slider.valueIndicatorActiveBottomSpace);
        verify(!indicator.visible);
        mouseMove(slider, slider.handle.x + slider.handle.width / 2,
                  slider.handle.y + slider.handle.height / 2);
        tryVerify(() => indicator.visible);
        compareReal(indicator.height, MD.Tokens.slider.valueIndicatorMinHeight);
        verify(indicator.width >= indicator.height);
        let point = indicator.mapToItem(slider, 0, 0);
        verify(point.y >= 0);
        verify(point.y + indicator.height <= slider.height);

        slider.value = slider.from;
        verifyIndicatorIsWithinSlider(slider, indicator);
        slider.value = slider.to;
        verifyIndicatorIsWithinSlider(slider, indicator);

        slider.orientation = Qt.Vertical;
        slider.width = 200;
        slider.height = 200;
        slider.LayoutMirroring.enabled = false;
        slider.value = slider.from;
        verifyIndicatorIsWithinSlider(slider, indicator);
        slider.value = slider.to;
        verifyIndicatorIsWithinSlider(slider, indicator);

        slider.LayoutMirroring.enabled = true;
        slider.value = slider.from;
        verifyIndicatorIsWithinSlider(slider, indicator);
        slider.value = slider.to;
        verifyIndicatorIsWithinSlider(slider, indicator);

        slider.orientation = Qt.Horizontal;
        slider.LayoutMirroring.enabled = false;

        slider.labelBehavior = MD.Slider.LabelBehavior.Visible;
        verify(indicator.visible);
        compareReal(slider.implicitHeight,
                    48 + indicator.implicitHeight + MD.Tokens.slider.valueIndicatorActiveBottomSpace);
        slider.enabled = false;
        verify(!indicator.visible);
        compareReal(slider.implicitHeight,
                    48 + indicator.implicitHeight + MD.Tokens.slider.valueIndicatorActiveBottomSpace);

        slider.enabled = true;
        slider.labelBehavior = MD.Slider.LabelBehavior.Gone;
        verify(!indicator.visible);
        compare(slider.implicitHeight, 48);

        slider.orientation = Qt.Vertical;
        slider.height = 200;
        slider.labelBehavior = MD.Slider.LabelBehavior.Visible;
        compareReal(slider.implicitWidth,
                    48 + indicator.implicitWidth
                    + MD.Tokens.slider.valueIndicatorActiveBottomSpace);
        point = indicator.mapToItem(slider, 0, 0);
        verify(point.x >= 0);

        slider.LayoutMirroring.enabled = true;
        point = indicator.mapToItem(slider, 0, 0);
        verify(point.x + indicator.width <= slider.width);
    }

    Component {
        id: rangeSliderComponent

        MD.RangeSlider {
            width: 200
            from: 0
            to: 100
            first.value: 25
            second.value: 75
        }
    }

    Component {
        id: defaultRangeSliderComponent

        MD.RangeSlider {
            width: 200
            from: 0
            to: 100
        }
    }

    function createRangeSlider(properties) {
        return createTemporaryObject(rangeSliderComponent, testCase, properties || {});
    }

    function test_range_defaults_and_geometry() {
        const slider = createRangeSlider();
        verify(slider);
        compare(slider.labelBehavior, MD.RangeSlider.LabelBehavior.Floating);
        compare(slider.tickVisibilityMode, MD.RangeSlider.TickVisibilityMode.AutoLimit);
        compare(slider.size, MD.RangeSlider.Size.ExtraSmall);
        compare(slider.snapMode, RangeSlider.SnapAlways);
        const defaultSlider = createTemporaryObject(defaultRangeSliderComponent, testCase);
        compare(defaultSlider.first.value, defaultSlider.from);
        compare(defaultSlider.second.value, defaultSlider.to);
        compare(slider.first.value, 25);
        compare(slider.second.value, 75);
        compare(slider.firstValueIndicatorText, "25");
        compare(slider.secondValueIndicatorText, "75");

        const track = trackFor(slider);
        compare(track.rangeMode, true);
        compareReal(track.activeStart, 62);
        compareReal(track.activeEnd, 138);
        compareReal(track.leadingInactiveEnd, 46);
        compareReal(track.trailingInactiveStart, 154);
        verify(findChild(track, "startStopIndicator").visible);
        verify(findChild(track, "endStopIndicator").visible);

        slider.LayoutMirroring.enabled = true;
        compareReal(track.activeStart, 62);
        compareReal(track.activeEnd, 138);

        slider.orientation = Qt.Vertical;
        slider.height = 200;
        compareReal(track.activeStart, 62);
        compareReal(track.activeEnd, 138);
    }

    function test_range_pointer_interaction_preserves_handle_order() {
        const slider = createRangeSlider({ stepSize: 10 });
        slider.first.value = 20;
        slider.second.value = 60;

        const firstHandle = slider.first.handle;
        mousePress(slider, firstHandle.x + firstHandle.width / 2,
                   firstHandle.y + firstHandle.height / 2);
        mouseMove(slider, 80, firstHandle.y + firstHandle.height / 2);
        mouseRelease(slider, 80, firstHandle.y + firstHandle.height / 2);
        verify(slider.first.value > 20);
        verify(slider.first.value <= slider.second.value);
    }

    function test_range_values_ticks_and_labels() {
        const slider = createRangeSlider({ stepSize: 10 });
        slider.first.value = 20;
        slider.second.value = 60;
        const track = trackFor(slider);
        const firstIndicator = findChild(slider.first.handle, "valueIndicator");
        const secondIndicator = findChild(slider.second.handle, "valueIndicator");

        compare(tickRepeaterFor(slider).count, 11);
        compareReal(track.activeStart, 52.8);
        compareReal(track.activeEnd, 110.4);
        slider.first.value = 80;
        verify(slider.first.value <= slider.second.value);

        slider.labelBehavior = MD.RangeSlider.LabelBehavior.Visible;
        verify(firstIndicator.visible);
        verify(secondIndicator.visible);
        slider.firstValueIndicatorText = "Minimum";
        slider.secondValueIndicatorText = "Maximum";
        compare(findChild(slider.first.handle, "valueIndicatorLabel").text, "Minimum");
        compare(findChild(slider.second.handle, "valueIndicatorLabel").text, "Maximum");

        slider.labelBehavior = MD.RangeSlider.LabelBehavior.WithinBounds;
        slider.first.value = slider.from;
        slider.second.value = slider.to;
        mouseMove(slider, slider.first.handle.x + slider.first.handle.width / 2,
                  slider.first.handle.y + slider.first.handle.height / 2);
        tryVerify(() => firstIndicator.visible);
        verifyIndicatorIsWithinSlider(slider, firstIndicator);
        mouseMove(slider, slider.second.handle.x + slider.second.handle.width / 2,
                  slider.second.handle.y + slider.second.handle.height / 2);
        tryVerify(() => secondIndicator.visible);
        verifyIndicatorIsWithinSlider(slider, secondIndicator);

        slider.enabled = false;
        tryCompare(findChild(slider.first.handle, "sliderHandle"), "opacity", 0.38);
        tryCompare(findChild(slider.second.handle, "sliderHandle"), "opacity", 0.38);
    }
}
