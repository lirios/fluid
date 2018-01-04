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

#include "datepicker.h"

DatePicker::DatePicker(QQuickItem *parent)
    : Picker(parent)
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
    , m_selectedDate(QDate::currentDate())
{
}

DatePicker::Mode DatePicker::mode() const
{
    return m_mode;
}

void DatePicker::setMode(DatePicker::Mode mode)
{
    if (m_mode == mode)
        return;

    m_mode = mode;
    Q_EMIT modeChanged();
}

bool DatePicker::dayOfWeekRowVisible() const
{
    return m_dayOfWeekRowVisible;
}

void DatePicker::setDayOfWeekRowVisible(bool value)
{
    if (m_dayOfWeekRowVisible == value)
        return;

    m_dayOfWeekRowVisible = value;
    Q_EMIT dayOfWeekRowVisibleChanged();
}

bool DatePicker::weekNumberVisible() const
{
    return m_weekNumberVisible;
}

void DatePicker::setWeekNumberVisible(bool value)
{
    if (m_weekNumberVisible == value)
        return;

    m_weekNumberVisible = value;
    Q_EMIT weekNumberVisibleChanged();
}

QDate DatePicker::from() const
{
    return m_from;
}

void DatePicker::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();
}

void DatePicker::resetFrom()
{
    setFrom(QDate(1, 1, 1));
}

QDate DatePicker::to() const
{
    return m_to;
}

void DatePicker::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();
}

void DatePicker::resetTo()
{
    setTo(QDate(275759, 9, 25));
}

QDate DatePicker::selectedDate() const
{
    return m_selectedDate;
}

void DatePicker::setSelectedDate(const QDate &date)
{
    if (m_selectedDate == date)
        return;

    m_selectedDate = date;
    Q_EMIT selectedDateChanged();
}
