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
 import Fluid.Core 1.0

TestCase {
    name: "UtilsTests"

    function test_isDarkColor_should_return_true_for_dark_color() {
        compare(Utils.isDarkColor("#455A64"), true)
    }

    function test_isDarkColor_should_return_false_for_light_color() {
        compare(Utils.isDarkColor("#B0BEC5"), false)
    }
}
