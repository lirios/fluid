/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include "qmldateutils.h"

DateUtils::DateUtils(QObject *parent)
    : QObject(parent)
{
}

QString DateUtils::formattedDate(const QDate &date) const
{
    return Fluid::DateUtils::formattedDate(date);
}

QString DateUtils::formatDuration(qlonglong duration, DurationFormat format,
                                  DurationType type) const
{
    return Fluid::DateUtils::formatDuration(duration,
                                            static_cast<Fluid::DateUtils::DurationFormat>(format),
                                            static_cast<Fluid::DateUtils::DurationType>(type));
}

QString DateUtils::friendlyTime(const QDateTime &time, bool standalone) const
{
    return Fluid::DateUtils::friendlyTime(time, standalone);
}

QString DateUtils::dayOfWeek(const QDate &date) const
{
    return Fluid::DateUtils::dayOfWeek(date);
}
