/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "timeselector.h"

TimeSelector::TimeSelector(QQuickItem *parent)
    : QQuickItem(parent)
    , m_selectedTime(QTime::currentTime())
{
}

TimeSelector::Mode TimeSelector::mode() const
{
    return m_mode;
}

void TimeSelector::setMode(TimeSelector::Mode mode)
{
    if (m_mode == mode)
        return;

    m_mode = mode;
    Q_EMIT modeChanged();
}

TimeSelector::TimeMode TimeSelector::timeMode() const
{
    return m_timeMode;
}

void TimeSelector::setTimeMode(TimeSelector::TimeMode timeMode)
{
    if (m_timeMode == timeMode)
        return;

    m_timeMode = timeMode;
    Q_EMIT timeModeChanged();
}

bool TimeSelector::prefer24Hour() const
{
    return m_prefer24Hour;
}

void TimeSelector::setPrefer24Hour(bool value)
{
    if (m_prefer24Hour == value)
        return;

    m_prefer24Hour = value;
    Q_EMIT prefer24HourChanged();
}

QQuickItem *TimeSelector::circle() const
{
    return m_circle;
}

void TimeSelector::setCircle(QQuickItem *circle)
{
    if (m_circle == circle)
        return;

    if (m_circle)
        m_circle->setParentItem(nullptr);

    m_circle = circle;
    m_circle->setParentItem(this);
    Q_EMIT circleChanged();
}

QTime TimeSelector::selectedTime() const
{
    return m_selectedTime;
}

void TimeSelector::setSelectedTime(const QTime &time)
{
    if (m_selectedTime == time)
        return;

    m_selectedTime = time;
    Q_EMIT selectedTimeChanged();
}
