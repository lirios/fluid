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

#include "timepicker.h"

TimePicker::TimePicker(QQuickItem *parent)
    : Picker(parent)
    , m_selectedTime(QTime::currentTime())
{
}

bool TimePicker::prefer24Hour() const
{
    return m_prefer24Hour;
}

void TimePicker::setPrefer24Hour(bool value)
{
    if (m_prefer24Hour == value)
        return;

    m_prefer24Hour = value;
    Q_EMIT prefer24HourChanged();
}

QTime TimePicker::selectedTime() const
{
    return m_selectedTime;
}

void TimePicker::setSelectedTime(const QTime &time)
{
    if (m_selectedTime == time)
        return;

    m_selectedTime = time;
    Q_EMIT selectedTimeChanged();
}
