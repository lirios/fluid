// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    name: "TypeScaleTokenTests"

    function propertyValue(token, propertyName) {
        return token[propertyName];
    }

    function standardMatrix() {
        return [
            ["displayLarge", MD.Style.TypeFace.Brand, 57, 64, Font.Normal, -0.2],
            ["displayMedium", MD.Style.TypeFace.Brand, 45, 52, Font.Normal, 0],
            ["displaySmall", MD.Style.TypeFace.Brand, 36, 44, Font.Normal, 0],
            ["headlineLarge", MD.Style.TypeFace.Brand, 32, 40, Font.Normal, 0],
            ["headlineMedium", MD.Style.TypeFace.Brand, 28, 36, Font.Normal, 0],
            ["headlineSmall", MD.Style.TypeFace.Brand, 24, 32, Font.Normal, 0],
            ["titleLarge", MD.Style.TypeFace.Brand, 22, 28, Font.Normal, 0],
            ["titleMedium", MD.Style.TypeFace.Plain, 16, 24, Font.Medium, 0.2],
            ["titleSmall", MD.Style.TypeFace.Plain, 14, 20, Font.Medium, 0.1],
            ["bodyLarge", MD.Style.TypeFace.Plain, 16, 24, Font.Normal, 0.5],
            ["bodyMedium", MD.Style.TypeFace.Plain, 14, 20, Font.Normal, 0.2],
            ["bodySmall", MD.Style.TypeFace.Plain, 12, 16, Font.Normal, 0.4],
            ["labelLarge", MD.Style.TypeFace.Plain, 14, 20, Font.Medium, 0.1],
            ["labelMedium", MD.Style.TypeFace.Plain, 12, 16, Font.Medium, 0.5],
            ["labelSmall", MD.Style.TypeFace.Plain, 11, 16, Font.Medium, 0.5]
        ];
    }

    function emphasizedMatrix() {
        return [
            ["displayLarge", MD.Style.TypeFace.Brand, 57, 64, Font.Medium, 0],
            ["displayMedium", MD.Style.TypeFace.Brand, 45, 52, Font.Medium, 0],
            ["displaySmall", MD.Style.TypeFace.Brand, 36, 44, Font.Medium, 0],
            ["headlineLarge", MD.Style.TypeFace.Brand, 32, 40, Font.Medium, 0],
            ["headlineMedium", MD.Style.TypeFace.Brand, 28, 36, Font.Medium, 0],
            ["headlineSmall", MD.Style.TypeFace.Brand, 24, 32, Font.Medium, 0],
            ["titleLarge", MD.Style.TypeFace.Brand, 22, 28, Font.Medium, 0],
            ["titleMedium", MD.Style.TypeFace.Plain, 16, 24, Font.Bold, 0.15],
            ["titleSmall", MD.Style.TypeFace.Plain, 14, 20, Font.Bold, 0.1],
            ["bodyLarge", MD.Style.TypeFace.Plain, 16, 24, Font.Medium, 0.15],
            ["bodyMedium", MD.Style.TypeFace.Plain, 14, 20, Font.Medium, 0.25],
            ["bodySmall", MD.Style.TypeFace.Plain, 12, 16, Font.Medium, 0.4],
            ["labelLarge", MD.Style.TypeFace.Plain, 14, 20, Font.Bold, 0.1],
            ["labelMedium", MD.Style.TypeFace.Plain, 12, 16, Font.Bold, 0.5],
            ["labelSmall", MD.Style.TypeFace.Plain, 11, 16, Font.Bold, 0.5]
        ];
    }

    function verifyMatrix(scale, matrix, name) {
        compare(matrix.length, 15, name + " matrix size");
        for (const expected of matrix) {
            const propertyName = expected[0];
            const value = scale[propertyName];
            const prefix = name + "." + propertyName;
            compare(value.face, expected[1], prefix + ".face");
            compare(value.fontSize, expected[2], prefix + ".fontSize");
            compare(value.lineHeight, expected[3], prefix + ".lineHeight");
            compare(value.fontWeight, expected[4], prefix + ".fontWeight");
            compare(value.tracking, expected[5], prefix + ".tracking");

            // Material Symbols axes are carried alongside every type-scale entry.
            compare(value.wght, expected[4], prefix + ".wght");
            compare(value.grad, 0, prefix + ".grad");
            compare(value.wdth, 100, prefix + ".wdth");
            compare(value.rond, 0, prefix + ".rond");
            compare(value.opsz, expected[2], prefix + ".opsz");
            compare(value.crsv, 0, prefix + ".crsv");
            compare(value.slnt, 0, prefix + ".slnt");
            compare(value.fill, 0, prefix + ".fill");
            compare(value.hexp, 0, prefix + ".hexp");
        }
    }

    function test_standardTypeScale() {
        verifyMatrix(propertyValue(MD.Tokens, "typescale"), standardMatrix(), "typescale");
    }

    function test_emphasizedTypeScale() {
        verifyMatrix(propertyValue(MD.Tokens, "emphasizedTypeScale"), emphasizedMatrix(),
                     "emphasizedTypeScale");
    }
}
