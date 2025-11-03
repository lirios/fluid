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

#pragma once

#include <QTime>
#include <QQmlEngine>

#include "picker.h"

/*!
    \brief Control to select a time.

    Stand-alone control to select a time.

    \code{.qml}
    import QtQuick
    import Fluid

    Item {
        width: 600
        height: 600

        TimePicker {
            anchors.centerIn: parent
            onSelectedTimeChanged: {
                console.log("You have selected:", selectedTime);
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/pickers.html">Material Design guidelines</a>.
*/
class TimePicker : public Picker
{
    Q_OBJECT
    /*!
        This property determines the visibility of the AM/PM switch.
    */
    Q_PROPERTY(bool prefer24Hour READ prefer24Hour WRITE setPrefer24Hour NOTIFY prefer24HourChanged FINAL)
    /*!
        This property holds the time that has been selected by the user.
        The default value is the current time.
    */
    Q_PROPERTY(QTime selectedTime READ selectedTime WRITE setSelectedTime NOTIFY selectedTimeChanged FINAL)
    QML_ELEMENT
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

