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

#include <QDateTime>

#include "picker.h"

/*!
    \brief Control to select a both date and time.

    Stand-alone control to select both date and time.

    \code{.qml}
    import QtQuick
    import Fluid

    Item {
        width: 600
        height: 600

        DateTimePicker {
            anchors.centerIn: parent
            onSelectedDateTimeChanged: {
                console.log("You have selected:", selectedDateTime);
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/pickers.html">Material Design guidelines</a>.
*/
class DateTimePicker : public Picker
{
    Q_OBJECT
    /*!
        This property holds the current selection mode.

        It is changed by the user, clicking on the year or calendar.

        Possible values:
        - DateTimePicker.Year The user is selecting the year.
        - DateTimePicker.Month The user is selecting the month.
        - DateTimePicker.Hour The user is selecting the hour.
        - DateTimePicker.Minute The user is selecting the minute.
        - DateTimePicker.Second The user is selecting the second.
    */
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged FINAL)
    /*!
        This property determines the visibility of the day of week row.
    */
    Q_PROPERTY(bool dayOfWeekRowVisible READ dayOfWeekRowVisible WRITE setDayOfWeekRowVisible NOTIFY dayOfWeekRowVisibleChanged FINAL)
    /*!
        This property determines the visibility of the week number column.
    */
    Q_PROPERTY(bool weekNumberVisible READ weekNumberVisible WRITE setWeekNumberVisible NOTIFY weekNumberVisibleChanged FINAL)
    /*!
        This property determines the visibility of the AM/PM switch.
    */
    Q_PROPERTY(bool prefer24Hour READ prefer24Hour WRITE setPrefer24Hour NOTIFY prefer24HourChanged FINAL)
    /*!
        This property holds the start date.
    */
    Q_PROPERTY(QDate from READ from WRITE setFrom RESET resetFrom NOTIFY fromChanged FINAL)
    /*!
        This property holds the end date.
    */
    Q_PROPERTY(QDate to READ to WRITE setTo RESET resetTo NOTIFY toChanged FINAL)
    /*!
        This property holds the date and time that has been selected by the user.
        The default value is the current date and time.
    */
    Q_PROPERTY(QDateTime selectedDateTime READ selectedDateTime WRITE setSelectedDateTime NOTIFY selectedDateTimeChanged FINAL)
    QML_ELEMENT
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

