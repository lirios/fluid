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

#ifndef TIMEPICKER_H
#define TIMEPICKER_H

#include <QTime>

#include "picker.h"

class TimePicker : public Picker
{
    Q_OBJECT
    Q_PROPERTY(bool prefer24Hour READ prefer24Hour WRITE setPrefer24Hour NOTIFY prefer24HourChanged FINAL)
    Q_PROPERTY(QTime selectedTime READ selectedTime WRITE setSelectedTime NOTIFY selectedTimeChanged FINAL)
public:
    explicit TimePicker(QQuickItem *parent = nullptr);

    bool prefer24Hour() const;
    void setPrefer24Hour(bool value);

    QTime selectedTime() const;
    void setSelectedTime(const QTime &time);

Q_SIGNALS:
    void prefer24HourChanged();
    void selectedTimeChanged();

private:
    bool m_prefer24Hour = true;
    QTime m_selectedTime;
};

QML_DECLARE_TYPE(TimePicker)

#endif // TIMEPICKER_H
