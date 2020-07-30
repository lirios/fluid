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

    function test_formattedDate_data() {
        var defaultLocale = Qt.locale("C");

        var today = new Date();
        var todayDOW = today.toLocaleDateString(defaultLocale, "dddd");

        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);
        var tomorrowDOW = tomorrow.toLocaleDateString(defaultLocale, "dddd");

        var date = new Date(2012, 11, 21);

        return [
                    {
                        tag: "today",
                        value: today,
                        representation: "Today (%1)".arg(todayDOW)
                    },
                    {
                        tag: "tomorrow",
                        value: tomorrow,
                        representation: "Tomorrow (%1)".arg(tomorrowDOW)
                    },
                    {
                        tag: "date",
                        value: date,
                        representation: "21 Dec 2012"
                    }
                ];
    }

    function test_formattedDate(data) {
        skip("Skip all");
        compare(DateUtils.formattedDate(data.value), data.representation);
    }

    function test_formatDuration_data() {
        return [
                    {
                        tag: "short-24:00",
                        value: 24 * 60000,
                        format: DateUtils.Short,
                        type: DateUtils.Any,
                        representation: "24:00"
                    },
                    {
                        tag: "short-32s",
                        value: 32000,
                        format: DateUtils.Short,
                        type: DateUtils.Seconds,
                        representation: "0:00:32"
                    },
                    {
                        tag: "short-2m",
                        value: 121000,
                        format: DateUtils.Short,
                        type: DateUtils.Minutes,
                        representation: "0:02"
                    },
                    {
                        tag: "short-1h",
                        value: 3610000,
                        format: DateUtils.Short,
                        type: DateUtils.Hours,
                        representation: "1"
                    },
                    {
                        tag: "long-24:00",
                        value: 24 * 60000,
                        format: DateUtils.Long,
                        type: DateUtils.Any,
                        representation: "24m 0s"
                    },
                    {
                        tag: "long-32s",
                        value: 32000,
                        format: DateUtils.Long,
                        type: DateUtils.Seconds,
                        representation: "0h 0m 32s"
                    },
                    {
                        tag: "long-2m",
                        value: 121000,
                        format: DateUtils.Long,
                        type: DateUtils.Minutes,
                        representation: "0h 2m"
                    },
                    {
                        tag: "long-1h",
                        value: 3610000,
                        format: DateUtils.Long,
                        type: DateUtils.Hours,
                        representation: "1h"
                    },
                ];
    }

    function test_formatDuration(data) {
        compare(DateUtils.formatDuration(data.value, data.format, data.type), data.representation);
    }

    function test_friendlyTime_data() {
        return [
                    {
                        tag: "now-standalone",
                        value: new Date(),
                        standalone: true,
                        representation: "Now"
                    },
                    {
                        tag: "now",
                        value: new Date(),
                        standalone: false,
                        representation: "now"
                    },
                    {
                        tag: "datetime-standalone",
                        value: new Date(2012, 11, 21, 13, 37),
                        standalone: true,
                        representation: "21 Dec 2012 13:37:00"
                    },
                    {
                        tag: "datetime",
                        value: new Date(2012, 11, 21, 13, 37),
                        standalone: false,
                        representation: "on 21 Dec 2012 13:37:00"
                    },
                ];
    }

    function test_friendlyTime(data) {
        skip("Skip all");
        compare(DateUtils.friendlyTime(data.value, data.standalone), data.representation);
    }

    function test_dayOfWeek_data() {
        var defaultLocale = Qt.locale("C");

        var today = new Date();
        var todayDOW = today.toLocaleDateString(defaultLocale, "dddd");

        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);
        var tomorrowDOW = tomorrow.toLocaleDateString(defaultLocale, "dddd");

        return [
                    {
                        tag: "today",
                        value: today,
                        representation: todayDOW
                    },
                    {
                        tag: "tomorrow",
                        value: tomorrow,
                        representation: tomorrowDOW
                    }
                ];
    }

    function test_dayOfWeek(data) {
        compare(DateUtils.dayOfWeek(data.value), data.representation);
    }
}
