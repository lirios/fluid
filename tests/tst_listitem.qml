/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtTest 1.0
import Fluid.Controls 1.0

ListItem {
    id: listItem

    width: 200

    SignalSpy {
        id: clickedSpy
        target: listItem
        signalName: "clicked"
    }

    TestCase {
        name: "ListItemTests"
        when: windowShown

        function test_leftItem_shows_when_iconName_is_set() {
            var leftItem = findChild(listItem, "leftItem")

            compare(leftItem.showing, false)

            listItem.iconName = "action/settings"

            compare(leftItem.showing, true)
        }

        function test_click_isnt_eaten_by_ripple() {
            clickedSpy.clear()

            mouseClick(listItem)

            compare(clickedSpy.count, 1)
        }
    }
}
