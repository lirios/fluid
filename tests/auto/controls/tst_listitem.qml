/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtTest 1.0
import Fluid.Controls 1.0

Item {
    width: 400
    height: 400

    Column {
        anchors.fill: parent

        ListItem {
            id: listItem

            width: 200

            SignalSpy {
                id: clickedSpy
                target: listItem
                signalName: "clicked"
            }
        }

        ListItem {
            id: listItemWithSubtext1

            maximumLineCount: 2
            subText: "Random Text"
        }

        ListItem {
            id: listItemWithSubtext2

            maximumLineCount: 3
            subText: "Random Text"
        }

        ListItem {
            id: listItemWithSecondaryItem

            secondaryItem: Button {}
        }

        ListItem {
            id: listItemWithoutSecondaryItem
        }

        ListItem {
            id: listItemWithLeftItem

            iconName: "action/settings"
        }

        ListItem {
            id: listItemWithRightItem

            text: "Random Text"
            rightItem: ComboBox {
                anchors.centerIn: parent
                textRole: "text"
                model: ListModel {
                    ListElement { text: "One"; value: 1 }
                    ListElement { text: "Two"; value: 2 }
                }
            }
        }
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

        function test_implicit_height() {
            compare(listItemWithSubtext1.implicitHeight, 72)

            compare(listItemWithSubtext2.implicitHeight, 88)

            var secondaryItem = findChild(listItemWithSecondaryItem, "secondaryItem")
            compare(listItemWithSecondaryItem.implicitHeight, 64)

            compare(listItemWithoutSecondaryItem.implicitHeight, 48)

            var leftItem = findChild(listItemWithLeftItem, "leftItem")
            compare(listItemWithLeftItem.implicitHeight, 48)

            var rightItem = findChild(listItemWithRightItem, "rightItem")
            compare(listItemWithRightItem.implicitHeight, 56)
        }
    }
}
