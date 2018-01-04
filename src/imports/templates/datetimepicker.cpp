/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "datetimepicker.h"

DateTimePicker::DateTimePicker(QQuickItem *parent)
    : Picker(parent)
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
    , m_selectedDateTime(QDateTime::currentDateTime())
{
}

DateTimePicker::Mode DateTimePicker::mode() const
{
    return m_mode;
}

void DateTimePicker::setMode(DateTimePicker::Mode mode)
{
    if (m_mode == mode)
        return;

    m_mode = mode;
    Q_EMIT modeChanged();
}

bool DateTimePicker::dayOfWeekRowVisible() const
{
    return m_dayOfWeekRowVisible;
}

void DateTimePicker::setDayOfWeekRowVisible(bool value)
{
    if (m_dayOfWeekRowVisible == value)
        return;

    m_dayOfWeekRowVisible = value;
    Q_EMIT dayOfWeekRowVisibleChanged();
}

bool DateTimePicker::weekNumberVisible() const
{
    return m_weekNumberVisible;
}

void DateTimePicker::setWeekNumberVisible(bool value)
{
    if (m_weekNumberVisible == value)
        return;

    m_weekNumberVisible = value;
    Q_EMIT weekNumberVisibleChanged();
}

bool DateTimePicker::prefer24Hour() const
{
    return m_prefer24Hour;
}

void DateTimePicker::setPrefer24Hour(bool value)
{
    if (m_prefer24Hour == value)
        return;

    m_prefer24Hour = value;
    Q_EMIT prefer24HourChanged();
}

QDate DateTimePicker::from() const
{
    return m_from;
}

void DateTimePicker::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();
}

void DateTimePicker::resetFrom()
{
    setFrom(QDate(1, 1, 1));
}

QDate DateTimePicker::to() const
{
    return m_to;
}

void DateTimePicker::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();
}

void DateTimePicker::resetTo()
{
    setTo(QDate(275759, 9, 25));
}

QDateTime DateTimePicker::selectedDateTime() const
{
    return m_selectedDateTime;
}

void DateTimePicker::setSelectedDateTime(const QDateTime &dateTime)
{
    if (m_selectedDateTime == dateTime)
        return;

    m_selectedDateTime = dateTime;
    Q_EMIT selectedDateTimeChanged();
}
