// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase
    name: "IconImageTests"
    when: windowShown
    visible: true
    width: 80
    height: 80

    readonly property url testSource: Qt.resolvedUrl("data/iconimage.svg")

    // grabImage captures the composited window; a black background lets RGB
    // assertions measure source alpha, tint alpha, and item opacity together.
    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    MD.IconImage {
        id: icon
        width: 40
        height: 40
        smooth: false
    }

    MD.IconImage {
        id: referenceIcon
        x: 40
        width: 40
        height: 40
        source: testCase.testSource
        sourceSize: Qt.size(40, 20)
        smooth: false
    }

    function init() {
        icon.asynchronous = false;
        icon.cache = true;
        icon.source = testSource;
        icon.sourceSize = Qt.size(40, 20);
        icon.color = "transparent";
        icon.opacity = 1;
        icon.mirror = false;
        icon.fillMode = Image.PreserveAspectFit;
        referenceIcon.color = "transparent";
        tryCompare(icon, "status", Image.Ready);
        tryCompare(referenceIcon, "status", Image.Ready);
    }

    function pixelAt(x, y, target = icon) {
        const image = grabImage(target);
        return image.pixel(Math.floor(x * image.width / target.width),
                           Math.floor(y * image.height / target.height));
    }

    function comparePixel(x, y, expected, target = icon) {
        const actual = pixelAt(x, y, target);
        fuzzyCompare(actual.r, expected.r, 0.01);
        fuzzyCompare(actual.g, expected.g, 0.01);
        fuzzyCompare(actual.b, expected.b, 0.01);
        fuzzyCompare(actual.a, expected.a, 0.01);
    }

    function test_original_colors_and_aspect_ratio() {
        tryVerify(() => pixelAt(5, 20).r > 0.99);
        comparePixel(5, 20, Qt.rgba(1, 0, 0, 1));
        comparePixel(15, 20, Qt.rgba(0, 0, 1, 1));
        comparePixel(25, 20, Qt.rgba(0, 0.5, 0, 1));
        comparePixel(35, 20, Qt.rgba(0, 0, 0, 1));
        comparePixel(5, 5, Qt.rgba(0, 0, 0, 1));
        compare(icon.paintedWidth, 40);
        compare(icon.paintedHeight, 20);
    }

    function test_tint_replaces_rgb_and_preserves_alpha() {
        icon.color = "#ffff00";
        tryVerify(() => pixelAt(15, 20).g > 0.99);
        comparePixel(5, 20, Qt.rgba(1, 1, 0, 1));
        comparePixel(15, 20, Qt.rgba(1, 1, 0, 1));
        comparePixel(25, 20, Qt.rgba(0.5, 0.5, 0, 1));
        comparePixel(35, 20, Qt.rgba(0, 0, 0, 1));
        comparePixel(5, 5, Qt.rgba(0, 0, 0, 1));

        icon.color = "#00ffff";
        tryVerify(() => pixelAt(5, 20).b > 0.99);
        comparePixel(5, 20, Qt.rgba(0, 1, 1, 1));

        icon.color = "transparent";
        tryVerify(() => pixelAt(5, 20).g === 0);
        comparePixel(5, 20, Qt.rgba(1, 0, 0, 1));
    }

    function test_tint_alpha_and_item_opacity() {
        icon.color = Qt.rgba(1, 0, 1, 0.5);
        icon.opacity = 0.5;
        tryVerify(() => Math.abs(pixelAt(5, 20).r - 0.25) < 0.01);
        comparePixel(5, 20, Qt.rgba(0.25, 0, 0.25, 1));
        comparePixel(25, 20, Qt.rgba(0.125, 0, 0.125, 1));
    }

    function test_mirror_and_fill_mode() {
        icon.color = "#ffff00";
        icon.mirror = true;
        tryVerify(() => pixelAt(5, 20).r === 0 && pixelAt(35, 20).g > 0.99);
        comparePixel(5, 20, Qt.rgba(0, 0, 0, 1));
        comparePixel(15, 20, Qt.rgba(0.5, 0.5, 0, 1));
        comparePixel(35, 20, Qt.rgba(1, 1, 0, 1));

        icon.fillMode = Image.Stretch;
        tryVerify(() => pixelAt(35, 5).g > 0.99);
    }

    function test_source_changes() {
        icon.color = "#ffff00";
        icon.source = "";
        tryCompare(icon, "status", Image.Null);
        tryVerify(() => pixelAt(5, 20).r === 0);
        icon.source = testSource;
        tryCompare(icon, "status", Image.Ready);
        tryVerify(() => pixelAt(5, 20).g > 0.99);
    }

    function test_shared_source_cache_is_not_tinted() {
        icon.color = "#ffff00";
        tryVerify(() => pixelAt(5, 20).g > 0.99);
        comparePixel(5, 20, Qt.rgba(1, 0, 0, 1), referenceIcon);
        comparePixel(15, 20, Qt.rgba(0, 0, 1, 1), referenceIcon);

        referenceIcon.color = "#00ffff";
        tryVerify(() => pixelAt(5, 20, referenceIcon).b > 0.99);
        comparePixel(5, 20, Qt.rgba(1, 1, 0, 1));
    }

    function test_asynchronous_loading_uses_latest_tint() {
        icon.source = "";
        icon.asynchronous = true;
        icon.cache = false;
        icon.source = testSource;
        icon.color = "#ffff00";
        tryCompare(icon, "status", Image.Ready);
        tryVerify(() => pixelAt(5, 20).g > 0.99);
        comparePixel(15, 20, Qt.rgba(1, 1, 0, 1));
    }
}
