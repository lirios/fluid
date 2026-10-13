// SPDX-FileCopyrightText: 2018-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "TypographyTests"
    width: 200
    height: 200
    visible: true
    when: windowShown

    Component {
        id: labelComponent

        MD.Label {
            text: "Typography"
        }
    }

    function verifyTypeScale(label, scale) {
        compare(label.font.family, scale.face === MD.Style.TypeFace.Brand ? label.MD.Style.brandFontFamily : label.MD.Style.plainFontFamily);
        compare(label.font.pixelSize, scale.fontSize);
        compare(label.font.weight, scale.fontWeight);
        // QFont stores letter spacing with 1/64-pixel precision.
        fuzzyCompare(label.font.letterSpacing, scale.tracking, 1 / 64);
        compare(label.lineHeight, scale.lineHeight);
        compare(label.lineHeightMode, Text.FixedHeight);
    }

    function test_defaults() {
        const label = createTemporaryObject(labelComponent, testCase);
        verify(label);

        verifyTypeScale(label, MD.Tokens.typescale.labelMedium);
        compare(label.color, label.MD.Style.onSurfaceVariantColor);
        compare(label.textFormat, Text.PlainText);
        compare(label.wrapMode, Text.Wrap);
        compare(label.elide, Text.ElideRight);
    }

    function test_typeScale_data() {
        const names = ["displayLarge", "displayMedium", "displaySmall", "headlineLarge", "headlineMedium", "headlineSmall", "titleLarge", "titleMedium", "titleSmall", "bodyLarge", "bodyMedium", "bodySmall", "labelLarge", "labelMedium", "labelSmall"];
        const rows = [];
        for (const name of names) {
            rows.push({
                tag: name,
                scale: MD.Tokens.typescale[name]
            });
            rows.push({
                tag: "emphasized_" + name,
                scale: MD.Tokens.emphasizedTypeScale[name]
            });
        }
        return rows;
    }

    function test_typeScale(data) {
        const label = createTemporaryObject(labelComponent, testCase, {
            typescale: data.scale
        });
        verify(label);

        verifyTypeScale(label, data.scale);
    }

    function test_typeScaleChange() {
        const label = createTemporaryObject(labelComponent, testCase);
        verify(label);

        label.typescale = MD.Tokens.typescale.displayLarge;
        verifyTypeScale(label, MD.Tokens.typescale.displayLarge);

        label.typescale = MD.Tokens.emphasizedTypeScale.titleSmall;
        verifyTypeScale(label, MD.Tokens.emphasizedTypeScale.titleSmall);
    }
}
