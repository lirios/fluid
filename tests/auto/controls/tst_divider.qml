// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "DividerTests"
    width: 480
    height: 480
    visible: true
    when: windowShown

    Component {
        id: dividerComponent

        MD.Divider {}
    }

    function createDivider(properties) {
        return createTemporaryObject(dividerComponent, testCase, properties || {});
    }

    function lineFor(divider) {
        return findChild(divider, "dividerLine");
    }

    function test_tokens() {
        const token = MD.Tokens.divider;

        compare(token.thickness, 1);
        compare(token.inset, 16);
    }

    function test_defaults() {
        const divider = createDivider();
        verify(divider);

        compare(divider.orientation, Qt.Horizontal);
        compare(divider.leadingInset, 0);
        compare(divider.trailingInset, 0);
        compare(divider.height, MD.Tokens.divider.thickness);
    }

    function test_vertical_orientation() {
        const divider = createDivider({
            orientation: Qt.Vertical,
            height: 200
        });
        verify(divider);

        compare(divider.width, MD.Tokens.divider.thickness);
    }

    function test_horizontal_insets() {
        const divider = createDivider({
            leadingInset: 16,
            trailingInset: 8
        });
        const line = lineFor(divider);
        verify(line);

        compare(line.anchors.leftMargin, 16);
        compare(line.anchors.rightMargin, 8);
        compare(line.anchors.topMargin, 0);
        compare(line.anchors.bottomMargin, 0);
    }

    function test_vertical_insets() {
        const divider = createDivider({
            orientation: Qt.Vertical,
            height: 200,
            leadingInset: 16,
            trailingInset: 8
        });
        const line = lineFor(divider);
        verify(line);

        compare(line.anchors.topMargin, 16);
        compare(line.anchors.bottomMargin, 8);
        compare(line.anchors.leftMargin, 0);
        compare(line.anchors.rightMargin, 0);
    }

    function test_custom_color() {
        const divider = createDivider({
            color: "#ff0000"
        });
        const line = lineFor(divider);
        verify(line);

        compare(line.color, Qt.color("#ff0000"));
    }
}
