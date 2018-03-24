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

#include "datetimepicker.h"

/*!
    \qmltype DateTimePicker
    \inherits QQuickItem
    \instantiates DateTimePicker
    \inqmlmodule Fluid.Controls

    \brief Control to select a both date and time

    Stand-alone control to select both date and time.

    \code
    import QtQuick 2.10
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DateTimePicker {
            anchors.centerIn: parent
            onSelectedDateTimeChanged: {
                console.log("You have selected:", selectedDateTime);
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/

/*!
    \qmlproperty Locale Fluid.Controls::DateTimePicker::locale

    This property holds the locale of the control.
*/

/*!
    \qmlproperty enumeration Fluid.Controls::DateTimePicker::orientation

    This property holds the date picker orientation.
    The default value is automatically selected based on the device orientation.

    Possible values:
    \value DatePicker.Landscape The date picker is landscape.
    \value DatePicker.Portrait The date picker is portrait.
*/

/*!
    \qmlproperty Item Fluid.Controls::DateTimePicker::background

    This property holds the background item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DateTimePicker::header

    This property holds the header item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DateTimePicker::selector

    This property holds the selector item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DateTimePicker::footer

    This property holds the footer item.
*/

DateTimePicker::DateTimePicker(QQuickItem *parent)
    : Picker(parent)
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
    , m_selectedDateTime(QDateTime::currentDateTime())
{
}

/*!
    \qmlproperty enumeration Fluid.Controls::DateTimePicker::mode

    This property holds the current selection mode.

    It is changed by the user, clicking on the year or calendar.

    Possible values:
    \value DateTimePicker.Year The user is selecting the year.
    \value DateTimePicker.Month The user is selecting the month.
    \value DateTimePicker.Hour The user is selecting the hour.
    \value DateTimePicker.Minute The user is selecting the minute.
    \value DateTimePicker.Second The user is selecting the second.
*/
DateTimePicker::Mode DateTimePicker::mode() const
{
    return m_mode;
}

void DateTimePicker::setMode(DateTimePicker::Mode mode)
{
    if (m_mode == mode)
        return;

    m_mode = mode;
    Q_EMIT modeChanged();
}

/*!
    \qmlproperty bool Fluid.Controls::DateTimePicker::dayOfWeekRowVisible

    This property determines the visibility of the day of week row.
*/
bool DateTimePicker::dayOfWeekRowVisible() const
{
    return m_dayOfWeekRowVisible;
}

void DateTimePicker::setDayOfWeekRowVisible(bool value)
{
    if (m_dayOfWeekRowVisible == value)
        return;

    m_dayOfWeekRowVisible = value;
    Q_EMIT dayOfWeekRowVisibleChanged();
}

/*!
    \qmlproperty bool Fluid.Controls::DateTimePicker::weekNumberVisible

    This property determines the visibility of the week number column.
*/
bool DateTimePicker::weekNumberVisible() const
{
    return m_weekNumberVisible;
}

void DateTimePicker::setWeekNumberVisible(bool value)
{
    if (m_weekNumberVisible == value)
        return;

    m_weekNumberVisible = value;
    Q_EMIT weekNumberVisibleChanged();
}

/*!
    \qmlproperty bool Fluid.Controls::DateTimePicker::prefer24Hour

    This property determines the visibility of the AM/PM switch.
*/
bool DateTimePicker::prefer24Hour() const
{
    return m_prefer24Hour;
}

void DateTimePicker::setPrefer24Hour(bool value)
{
    if (m_prefer24Hour == value)
        return;

    m_prefer24Hour = value;
    Q_EMIT prefer24HourChanged();
}

/*!
    \qmlproperty date Fluid.Controls::DateTimePicker::from

    This property holds the start date.
*/
QDate DateTimePicker::from() const
{
    return m_from;
}

void DateTimePicker::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();
}

void DateTimePicker::resetFrom()
{
    setFrom(QDate(1, 1, 1));
}

/*!
    \qmlproperty date Fluid.Controls::DateTimePicker::to

    This property holds the end date.
*/
QDate DateTimePicker::to() const
{
    return m_to;
}

void DateTimePicker::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();
}

void DateTimePicker::resetTo()
{
    setTo(QDate(275759, 9, 25));
}

/*!
    \qmlproperty date Fluid.Controls::DateTimePicker::selectedDateTime

    This property holds the date and time that has been selected by the user.
    The default value is the current date and time.
*/
QDateTime DateTimePicker::selectedDateTime() const
{
    return m_selectedDateTime;
}

void DateTimePicker::setSelectedDateTime(const QDateTime &dateTime)
{
    if (m_selectedDateTime == dateTime)
        return;

    m_selectedDateTime = dateTime;
    Q_EMIT selectedDateTimeChanged();
}
