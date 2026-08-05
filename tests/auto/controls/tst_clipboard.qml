// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid

TestCase {
    name: "ClipboardTests"

    Clipboard {
        id: clipboard
    }

    SignalSpy {
        id: textChangedSpy
        target: clipboard
        signalName: "textChanged"
    }

    function test_clipboard_works() {
        var text = "Hello World";

        clipboard.text = text;

        compare(clipboard.text, text);
    }

    function tests_setting_text_should_fire_textChanged() {
        clipboard.text = "";

        textChangedSpy.clear();

        clipboard.text = "Random Text";

        compare(textChangedSpy.count, 1);
    }

    function test_clear_should_fire_textChanged() {
        clipboard.text = "Non empty text";

        textChangedSpy.clear();

        clipboard.clear();

        compare(textChangedSpy.count, 1);
    }
}
