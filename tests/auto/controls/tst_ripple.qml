// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "RippleTests"
    width: 240
    height: 240
    visible: true
    when: windowShown

    Component {
        id: surfaceComponent
        Item {
            property alias ripple: ripple
            property alias input: input
            width: 100
            height: 100
            MD.Ripple {
                id: ripple
                anchors.fill: parent
                color: "#123456"
                pressed: input.pressed
                pressX: input.mouseX
                pressY: input.mouseY
            }
            MouseArea { id: input; anchors.fill: parent }
        }
    }

    function stateLayer(ripple) {
        return ripple.children.find(child => child instanceof Rectangle);
    }

    function test_press_and_release() {
        const surface = createTemporaryObject(surfaceComponent, testCase);
        const ripple = surface.ripple;
        compare(ripple._shaderOpacity, 0);
        mousePress(surface.input, 20, 30);
        verify(ripple.pressed);
        compare(ripple.pressX, 20);
        compare(ripple.pressY, 30);
        verify(ripple._shaderOpacity > 0);
        tryVerify(() => ripple._activeProgress > 0);

        mouseRelease(surface.input, 20, 30);
        verify(!ripple.pressed);
        tryCompare(ripple, "_shaderOpacity", 0);
        tryCompare(ripple, "_activeProgress", 0);
        compare(stateLayer(ripple).opacity, ripple.stateOpacity);
    }

    function test_state_layer_opacity() {
        const surface = createTemporaryObject(surfaceComponent, testCase);
        const ripple = surface.ripple;
        const background = stateLayer(ripple);
        compare(background.opacity, 0);
        compare(background.color, "#123456");
        ripple.stateOpacity = MD.Tokens.state.hoverStateLayerOpacity;
        compare(background.opacity, MD.Tokens.state.hoverStateLayerOpacity);
        ripple.stateOpacity = MD.Tokens.state.focusStateLayerOpacity;
        compare(background.opacity, MD.Tokens.state.focusStateLayerOpacity);
        ripple.stateOpacity = 0;
        compare(background.opacity, 0);
        compare(ripple._shaderOpacity, 0);
    }

    function test_repress_interrupts_release() {
        const surface = createTemporaryObject(surfaceComponent, testCase);
        const ripple = surface.ripple;
        mousePress(surface.input, 25, 25);
        mouseRelease(surface.input, 25, 25);
        mousePress(surface.input, 75, 75);
        wait(400);
        verify(ripple.pressed);
        verify(ripple._shaderOpacity > 0);
        compare(ripple.pressX, 75);
        compare(ripple.pressY, 75);
        mouseRelease(surface.input, 75, 75);
        tryCompare(ripple, "_shaderOpacity", 0);
    }

    function test_debug_values_remain_fixed() {
        const surface = createTemporaryObject(surfaceComponent, testCase);
        const ripple = surface.ripple;
        ripple.debugEnabled = true;
        ripple.debugProgress = 0.7;
        ripple.debugPhase = 3;
        ripple.debugTouchX = 12;
        ripple.debugTouchY = 34;
        ripple.debugBackOpacity = 0.2;
        mouseClick(surface.input, 50, 50);
        compare(ripple._activeProgress, 0.7);
        compare(ripple._activePhase, 3);
        compare(ripple._activeTouchX, 12);
        compare(ripple._activeTouchY, 34);
        compare(stateLayer(ripple).opacity, 0.2);
    }
}
