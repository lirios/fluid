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

#ifndef DATEPICKER_H
#define DATEPICKER_H

#include <QDate>

#include "picker.h"

class DatePicker : public Picker
{
    Q_OBJECT
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged FINAL)
    Q_PROPERTY(bool dayOfWeekRowVisible READ dayOfWeekRowVisible WRITE setDayOfWeekRowVisible NOTIFY dayOfWeekRowVisibleChanged FINAL)
    Q_PROPERTY(bool weekNumberVisible READ weekNumberVisible WRITE setWeekNumberVisible NOTIFY weekNumberVisibleChanged FINAL)
    Q_PROPERTY(QDate from READ from WRITE setFrom RESET resetFrom NOTIFY fromChanged FINAL)
    Q_PROPERTY(QDate to READ to WRITE setTo RESET resetTo NOTIFY toChanged FINAL)
    Q_PROPERTY(QDate selectedDate READ selectedDate WRITE setSelectedDate NOTIFY selectedDateChanged FINAL)
public:
    enum Mode {
        Year,
        Month
    };
    Q_ENUM(Mode)

    explicit DatePicker(QQuickItem *parent = nullptr);

    Mode mode() const;
    void setMode(Mode mode);

    bool dayOfWeekRowVisible() const;
    void setDayOfWeekRowVisible(bool value);

    bool weekNumberVisible() const;
    void setWeekNumberVisible(bool value);

    QDate from() const;
    void setFrom(const QDate &date);
    void resetFrom();

    QDate to() const;
    void setTo(const QDate &date);
    void resetTo();

    QDate selectedDate() const;
    void setSelectedDate(const QDate &date);

Q_SIGNALS:
    void modeChanged();
    void dayOfWeekRowVisibleChanged();
    void weekNumberVisibleChanged();
    void fromChanged();
    void toChanged();
    void selectedDateChanged();

private:
    Mode m_mode = Month;
    bool m_dayOfWeekRowVisible = true;
    bool m_weekNumberVisible = true;
    QDate m_from;
    QDate m_to;
    QDate m_selectedDate;
};

#endif // DATEPICKER_H
