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

#include <QDate>
#include <QQmlEngine>

#include "picker.h"

/*!
    \brief Control to select a single date.

    Stand-alone control to select a single date from a calendar.

    \code{.qml}
    import Fluid
    import QtQuick

    Item {
        width: 600
        height: 600

        DatePicker {
            anchors.centerIn: parent
            onSelectedDateChanged: {
                console.log("You have selected:", selectedDate);
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/pickers.html">Material Design guidelines</a>.
*/
class DatePicker : public Picker
{
    Q_OBJECT
    /*!
        This property holds the current selection mode.

        It is changed by the user, clicking on the year or calendar.

        Possible values:
         - DatePicker.Year The user is selecting the year.
         - DatePicker.Month The user is selecting the month.
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
        This property holds the start date.
    */
    Q_PROPERTY(QDate from READ from WRITE setFrom RESET resetFrom NOTIFY fromChanged FINAL)
    /*!
        This property holds the end date.
    */
    Q_PROPERTY(QDate to READ to WRITE setTo RESET resetTo NOTIFY toChanged FINAL)
    /*!
        This property holds the date that has been selected by the user.
        The default value is the current date.
    */
    Q_PROPERTY(QDate selectedDate READ selectedDate WRITE setSelectedDate NOTIFY selectedDateChanged FINAL)
    QML_ELEMENT
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

