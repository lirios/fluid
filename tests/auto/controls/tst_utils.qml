// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0
import Fluid as Fluid
import QtTest
import "../../../src/controls/qml/core/UiMetrics.js" as UiMetrics

TestCase {
    name: "UtilsTests"

    function test_scale() {
        compare(Fluid.Utils.scale(50, 0, 1), 0.5);
        compare(Fluid.Utils.scale(50, 0, 100), 50);
        compare(Fluid.Utils.scale(50, 50, 100), 75);
        compare(Fluid.Utils.scale(50, 1, 100), 50.5);
    }

    function test_resolveShapeRadius() {
        const full = Fluid.Tokens.shape.cornerValueFull;

        compare(UiMetrics.resolveShapeRadius(full, 40, 40), 20);
        compare(UiMetrics.resolveShapeRadius(full, 80, 40), 20);
        compare(UiMetrics.resolveShapeRadius(full, 40, 80), 20);
        compare(UiMetrics.resolveShapeRadius(full, 80, 0), 0);
        compare(UiMetrics.resolveShapeRadius(12, 80, 40), 12);
        compare(UiMetrics.resolveShapeRadius(12, 0, 40), 0);
    }
}
