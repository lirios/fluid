/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "dateutils.h"

using namespace Fluid;

QString DateUtils::formatDuration(qlonglong duration, DurationFormat format, DurationType type)
{
    int hours = duration / (1000 * 60 * 60);
    int minutes = duration / (1000 * 60) - 60 * hours;
    int seconds = duration / 1000 - 60 * minutes - 60 * 60 * hours;

    QString string;

    if (type == Any || type == Seconds) {
        if (format == Short)
            string = QStringLiteral("%1").arg(seconds, 2, 10, QChar('0'));
        else
            string = QStringLiteral("%1s").arg(seconds);
    }

    if (type == Seconds || type == Minutes || (type == Any && (minutes >= 1 || hours >= 1))) {
        if (format == Short) {
            if (string.length() > 0)
                string = QStringLiteral("%1:%2").arg(minutes, 2, 10, QChar('0')).arg(string);
            else
                string = QStringLiteral("%1").arg(minutes, 2, 10, QChar('0'));
        } else {
            string = QStringLiteral("%1m %2").arg(minutes).arg(string);
        }
    }

    if (type == Seconds || type == Minutes || type == Hours || (type == Any && (hours >= 1))) {
        if (format == Short) {
            if (string.length() > 0)
                string = QStringLiteral("%1:%2").arg(hours).arg(string);
            else
                string = QStringLiteral("%1").arg(hours);
        } else {
            string = QStringLiteral("%1h %2").arg(hours).arg(string);
        }
    }

    return string.trimmed();
}

QString DateUtils::friendlyTime(const QDateTime &time, bool standalone)
{
    QDateTime now = QDateTime::currentDateTime();
    qint64 minutes = qRound64(time.secsTo(now) / 60.0f);
    if (minutes < 1)
        return standalone ? tr("Now") : "now";
    else if (minutes == 1)
        return tr("1 minute ago");
    else if (minutes < 60)
        return tr("%1 minutes ago").arg(minutes);
    qint64 hours = qRound64(minutes / 60.0f);
    if (hours == 1)
        return tr("1 hour ago");
    else if (hours < 24)
        return tr("%1 hours ago").arg(hours);
    qint64 days = qRound64(hours / 24.0f);
    if (days == 1)
        return tr("1 day ago");
    else if (days <= 10)
        return tr("%1 days ago").arg(days);
    QString string = time.toString();
    return standalone ? string : tr("on %1").arg(string);
}
