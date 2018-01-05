/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtTest 1.0
import Fluid.Core 1.0

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
        var text = "Hello World"

        clipboard.text = text

        compare(clipboard.text, text)
    }

    function tests_setting_text_should_fire_textChanged() {
        clipboard.text = ""

        textChangedSpy.clear()

        clipboard.text = "Random Text"

        compare(textChangedSpy.count, 1)
    }

    function test_clear_should_fire_textChanged() {
        clipboard.text = "Non empty text"

        textChangedSpy.clear()

        clipboard.clear()

        compare(textChangedSpy.count, 1)
    }
}
