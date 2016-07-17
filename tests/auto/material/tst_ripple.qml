/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtTest 1.0
import Fluid.Material 1.0

Ripple {
    id: ripple

    width: 100
    height: 100

    TestCase {
        name: "RippleTests"
        when: windowShown

        function test_mouse_press_shows_ripple() {
            compare(getRipples().length, 0)
            mousePress(ripple)
            compare(getRipples().length, 1)
            mouseRelease(ripple)
            wait(1000)
        }

        function test_mouse_up_hides_ripple() {
            mouseClick(ripple)
            compare(getRipples().length, 1)
            wait(1000)
            compare(getRipples().length, 0)
        }

        function test_focused_ripple_shows_focus_background() {
            var focusBackground = findChild(ripple, "focusBackground")
            compare(focusBackground.opacity, 0)

            ripple.focused = true
            wait(1000)

            compare(focusBackground.opacity, 1)

            ripple.focused = false
            wait(1000)
        }

        function test_focused_ripple_shows_focus_ripple() {
            var focusRipple = findChild(ripple, "focusRipple")
            compare(focusRipple.opacity, 0)

            ripple.focused = true
            wait(1000)

            compare(focusRipple.opacity, 1)

            ripple.focused = false
            wait(1000)
        }

        function getRipples() {
            return filteredChildren("tapRipple")
        }

        function filteredChildren(objectName) {
            var filtered = []

            for (var i = 0; i < ripple.children.length; i++) {
                var child = ripple.children[i]

                if (child.objectName == objectName) {
                    filtered.push(child)
                }
            }

            return filtered
        }
    }
}
