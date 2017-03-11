/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtTest 1.0
import Fluid.Core 1.0

TestCase {
    name: "UtilsTests"

    function test_blendColors() {
        compare(Utils.blendColors("lightsteelblue", "#10FF0000", 0.5), "#80b5b8d0")
    }

    function test_luminance() {
        compare(Utils.luminance("lightsteelblue"), 0.7593254230563821)
    }

    function test_isDarkColor_should_return_true_for_dark_color() {
        compare(Utils.isDarkColor("#455A64"), true)
    }

    function test_isDarkColor_should_return_false_for_light_color() {
        compare(Utils.isDarkColor("#B0BEC5"), false)
    }
}
