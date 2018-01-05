/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQml 2.2
import QtQuick 2.10
import QtTest 1.0
import Fluid.Core 1.0

TestCase {
    name: "DateTests"

    property var defaultLocale: Qt.locale("C")
    property date today: new Date()
    property string todayDOW: today.toLocaleDateString(defaultLocale, "dddd")
    property date tomorrow: {
        var newDate = new Date();
        newDate.setDate(today.getDate() + 1);
        return newDate;
    }
    property string tomorrowDOW: tomorrow.toLocaleDateString(defaultLocale, "dddd")
    property date date: new Date(2012, 11, 21)
    property date dateTime: new Date(2012, 11, 21, 13, 37)

    function test_formattedDate() {
        compare(DateUtils.formattedDate(today), "Today (%1)".arg(todayDOW));
        compare(DateUtils.formattedDate(tomorrow), "Tomorrow (%1)".arg(tomorrowDOW));
        compare(DateUtils.formattedDate(date), "21 Dec 2012");
    }

    function test_formatDuration() {
        compare(DateUtils.formatDuration(24 * 60000, DateUtils.Short, DateUtils.Any), "24:00");
        compare(DateUtils.formatDuration(32000, DateUtils.Short, DateUtils.Seconds), "0:00:32");
        compare(DateUtils.formatDuration(121000, DateUtils.Short, DateUtils.Minutes), "0:02");
        compare(DateUtils.formatDuration(3610000, DateUtils.Short, DateUtils.Hours), "1");

        compare(DateUtils.formatDuration(24 * 60000, DateUtils.Long, DateUtils.Any), "24m 0s");
        compare(DateUtils.formatDuration(32000, DateUtils.Long, DateUtils.Seconds), "0h 0m 32s");
        compare(DateUtils.formatDuration(121000, DateUtils.Long, DateUtils.Minutes), "0h 2m");
        compare(DateUtils.formatDuration(3610000, DateUtils.Long, DateUtils.Hours), "1h");
    }

    function test_friendlyTime() {
        var now = new Date();

        compare(DateUtils.friendlyTime(now, true), "Now");
        compare(DateUtils.friendlyTime(now, false), "now");
        compare(DateUtils.friendlyTime(dateTime, true), "21 Dec 2012 13:37:00");
        compare(DateUtils.friendlyTime(dateTime, false), "on 21 Dec 2012 13:37:00");
    }

    function test_dayOfWeek() {
        compare(DateUtils.dayOfWeek(today), todayDOW);
        compare(DateUtils.dayOfWeek(tomorrow), tomorrowDOW)
    }
}
