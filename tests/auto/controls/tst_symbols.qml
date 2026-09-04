// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    TestCase {
        name: "SymbolsTests"

        function test_names() {
            compare(MD.Symbols.add, "add");
            compare(MD.Symbols.tenK, "10k");
            compare(MD.Symbols.fiftyMp, "50mp");
            compare(MD.Symbols.eighteenUpRating, "18_up_rating");
            compare(MD.Symbols.threeDRotation, "3d_rotation");
            compare(MD.Symbols.formatItalic, "format_italic");
            compare(MD.Symbols.oneTwoThree, "123");
            compare(MD.Symbols.threeSixty, "360");
            compare(MD.Symbols.deleteIcon, "delete");
            compare(MD.Symbols.classIcon, "class");
            compare(MD.Symbols.functionIcon, "function");
            compare(MD.Symbols.tryIcon, "try");
        }
    }
}
