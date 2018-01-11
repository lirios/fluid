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

#ifndef DATETIMEPICKER_H
#define DATETIMEPICKER_H

#include <QDateTime>

#include "picker.h"

class DateTimePicker : public Picker
{
    Q_OBJECT
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged FINAL)
    Q_PROPERTY(bool dayOfWeekRowVisible READ dayOfWeekRowVisible WRITE setDayOfWeekRowVisible NOTIFY dayOfWeekRowVisibleChanged FINAL)
    Q_PROPERTY(bool weekNumberVisible READ weekNumberVisible WRITE setWeekNumberVisible NOTIFY weekNumberVisibleChanged FINAL)
    Q_PROPERTY(bool prefer24Hour READ prefer24Hour WRITE setPrefer24Hour NOTIFY prefer24HourChanged FINAL)
    Q_PROPERTY(QDate from READ from WRITE setFrom RESET resetFrom NOTIFY fromChanged FINAL)
    Q_PROPERTY(QDate to READ to WRITE setTo RESET resetTo NOTIFY toChanged FINAL)
    Q_PROPERTY(QDateTime selectedDateTime READ selectedDateTime WRITE setSelectedDateTime NOTIFY selectedDateTimeChanged FINAL)
public:
    enum Mode {
        Year,
        Month,
        Hour,
        Minute,
        Second
    };
    Q_ENUM(Mode)

    explicit DateTimePicker(QQuickItem *parent = nullptr);

    Mode mode() const;
    void setMode(Mode mode);

    bool dayOfWeekRowVisible() const;
    void setDayOfWeekRowVisible(bool value);

    bool weekNumberVisible() const;
    void setWeekNumberVisible(bool value);

    bool prefer24Hour() const;
    void setPrefer24Hour(bool value);

    QDate from() const;
    void setFrom(const QDate &date);
    void resetFrom();

    QDate to() const;
    void setTo(const QDate &date);
    void resetTo();

    QDateTime selectedDateTime() const;
    void setSelectedDateTime(const QDateTime &dateTime);

Q_SIGNALS:
    void modeChanged();
    void dayOfWeekRowVisibleChanged();
    void weekNumberVisibleChanged();
    void prefer24HourChanged();
    void fromChanged();
    void toChanged();
    void selectedDateTimeChanged();

private:
    Mode m_mode = Month;
    bool m_dayOfWeekRowVisible = true;
    bool m_weekNumberVisible = true;
    bool m_prefer24Hour = true;
    QDate m_from;
    QDate m_to;
    QDateTime m_selectedDateTime;
};

#endif // DATETIMEPICKER_H
