// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0
import Fluid as Fluid

TestCase {
    name: "UtilsTests"

    function test_scale() {
        compare(Fluid.Utils.scale(50, 0, 1), 0.5);
        compare(Fluid.Utils.scale(50, 0, 100), 50);
        compare(Fluid.Utils.scale(50, 50, 100), 75);
        compare(Fluid.Utils.scale(50, 1, 100), 50.5);
    }
}
