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

#ifndef TIMESELECTOR_H
#define TIMESELECTOR_H

#include <QQuickItem>
#include <QTime>

class TimeSelector : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged FINAL)
    Q_PROPERTY(TimeMode timeMode READ timeMode WRITE setTimeMode NOTIFY timeModeChanged FINAL)
    Q_PROPERTY(bool prefer24Hour READ prefer24Hour WRITE setPrefer24Hour NOTIFY prefer24HourChanged FINAL)
    Q_PROPERTY(QQuickItem *circle READ circle WRITE setCircle NOTIFY circleChanged FINAL)
    Q_PROPERTY(QTime selectedTime READ selectedTime WRITE setSelectedTime NOTIFY selectedTimeChanged FINAL)
public:
    enum Mode {
        None,
        Hour,
        Minute,
        Second
    };
    Q_ENUM(Mode)

    enum TimeMode {
        AM,
        PM
    };
    Q_ENUM(TimeMode)

    explicit TimeSelector(QQuickItem *parent = nullptr);

    Mode mode() const;
    void setMode(Mode mode);

    TimeMode timeMode() const;
    void setTimeMode(TimeMode timeMode);

    bool prefer24Hour() const;
    void setPrefer24Hour(bool value);

    QQuickItem *circle() const;
    void setCircle(QQuickItem *circle);

    QTime selectedTime() const;
    void setSelectedTime(const QTime &time);

Q_SIGNALS:
    void modeChanged();
    void timeModeChanged();
    void prefer24HourChanged();
    void selectedTimeChanged();
    void circleChanged();

private:
    Mode m_mode = None;
    TimeMode m_timeMode = AM;
    bool m_prefer24Hour = true;
    QQuickItem *m_circle = nullptr;
    QTime m_selectedTime;
};

QML_DECLARE_TYPE(TimeSelector)

#endif // TIMESELECTOR_H
