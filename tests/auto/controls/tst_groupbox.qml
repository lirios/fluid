// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "GroupBoxTests"
    width: 480
    height: 480
    visible: true
    when: windowShown

    Component {
        id: groupBoxComponent

        MD.GroupBox {
            width: 240
            title: "Options"

            Rectangle {
                implicitWidth: 120
                implicitHeight: 40
            }
        }
    }

    function createGroupBox(properties) {
        return createTemporaryObject(groupBoxComponent, testCase, properties || {});
    }

    function test_defaults() {
        const groupBox = createGroupBox();
        verify(groupBox);

        compare(groupBox.spacing, MD.Tokens.measurement.space75);
        compare(groupBox.padding, MD.Tokens.measurement.space150);
        compare(groupBox.radius, MD.Tokens.shape.cornerValueMedium);
        compare(groupBox.topPadding,
                groupBox.padding + groupBox.implicitLabelHeight);
        compare(groupBox.label.text, groupBox.title);
        compare(groupBox.label.color, groupBox.MD.Style.onSurfaceVariantColor);

        const background = groupBox.background;
        compare(background.color.a, 0);
        compare(background.radius, groupBox.radius);
        compare(background.border.width, 1);
        compare(background.border.color, groupBox.MD.Style.outlineVariantColor);
        compare(background.y, groupBox.topPadding - groupBox.bottomPadding);
        compare(background.height,
                groupBox.height - groupBox.topPadding + groupBox.bottomPadding);
    }

    function test_customRadius() {
        const groupBox = createGroupBox({ radius: 20 });
        verify(groupBox);

        compare(groupBox.radius, 20);
        compare(groupBox.background.radius, 20);
    }

    function test_emptyTitleUsesRegularPadding() {
        const groupBox = createGroupBox({ title: "" });
        verify(groupBox);

        compare(groupBox.implicitLabelWidth, 0);
        compare(groupBox.topPadding, groupBox.padding);
    }

    function test_outlineTracksTheme() {
        const groupBox = createGroupBox();
        verify(groupBox);

        groupBox.MD.Style.theme = MD.Style.Dark;
        compare(groupBox.background.border.color, MD.Tokens.dark.outlineVariant);

        groupBox.MD.Style.theme = MD.Style.Light;
        compare(groupBox.background.border.color, MD.Tokens.light.outlineVariant);
    }
}
