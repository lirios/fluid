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

#include "datepicker.h"

/*!
    \qmltype DatePicker
    \inherits QQuickItem
    \instantiates DatePicker
    \inqmlmodule Fluid.Controls

    \brief Control to select a single date.

    Stand-alone control to select a single date from a calendar.

    \code
    import QtQuick 2.10
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DatePicker {
            anchors.centerIn: parent
            onSelectedDateChanged: {
                console.log("You have selected:", selectedDate);
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/

/*!
    \qmlproperty Locale Fluid.Controls::DatePicker::locale

    This property holds the locale of the control.
*/

/*!
    \qmlproperty enumeration Fluid.Controls::DatePicker::orientation

    This property holds the date picker orientation.
    The default value is automatically selected based on the device orientation.

    Possible values:
    \value DatePicker.Landscape The date picker is landscape.
    \value DatePicker.Portrait The date picker is portrait.
*/

/*!
    \qmlproperty Item Fluid.Controls::DatePicker::background

    This property holds the background item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DatePicker::header

    This property holds the header item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DatePicker::selector

    This property holds the selector item.
*/

/*!
    \qmlproperty Item Fluid.Controls::DatePicker::footer

    This property holds the footer item.
*/

DatePicker::DatePicker(QQuickItem *parent)
    : Picker(parent)
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
    , m_selectedDate(QDate::currentDate())
{
}

/*!
    \qmlproperty enumeration Fluid.Controls::DatePicker::mode

    This property holds the current selection mode.

    It is changed by the user, clicking on the year or calendar.

    Possible values:
    \value DatePicker.Year The user is selecting the year.
    \value DatePicker.Month The user is selecting the month.
*/
DatePicker::Mode DatePicker::mode() const
{
    return m_mode;
}

void DatePicker::setMode(DatePicker::Mode mode)
{
    if (m_mode == mode)
        return;

    m_mode = mode;
    Q_EMIT modeChanged();
}

/*!
    \qmlproperty bool Fluid.Controls::DatePicker::dayOfWeekRowVisible

    This property determines the visibility of the day of week row.
*/
bool DatePicker::dayOfWeekRowVisible() const
{
    return m_dayOfWeekRowVisible;
}

void DatePicker::setDayOfWeekRowVisible(bool value)
{
    if (m_dayOfWeekRowVisible == value)
        return;

    m_dayOfWeekRowVisible = value;
    Q_EMIT dayOfWeekRowVisibleChanged();
}

/*!
    \qmlproperty bool Fluid.Controls::DatePicker::weekNumberVisible

    This property determines the visibility of the week number column.
*/
bool DatePicker::weekNumberVisible() const
{
    return m_weekNumberVisible;
}

void DatePicker::setWeekNumberVisible(bool value)
{
    if (m_weekNumberVisible == value)
        return;

    m_weekNumberVisible = value;
    Q_EMIT weekNumberVisibleChanged();
}

/*!
    \qmlproperty date Fluid.Controls::DatePicker::from

    This property holds the start date.
*/
QDate DatePicker::from() const
{
    return m_from;
}

void DatePicker::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();
}

void DatePicker::resetFrom()
{
    setFrom(QDate(1, 1, 1));
}

/*!
    \qmlproperty date Fluid.Controls::DatePicker::to

    This property holds the end date.
*/
QDate DatePicker::to() const
{
    return m_to;
}

void DatePicker::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();
}

void DatePicker::resetTo()
{
    setTo(QDate(275759, 9, 25));
}

/*!
    \qmlproperty date Fluid.Controls::DatePicker::selectedDate

    This property holds the date that has been selected by the user.
    The default value is the current date.
*/
QDate DatePicker::selectedDate() const
{
    return m_selectedDate;
}

void DatePicker::setSelectedDate(const QDate &date)
{
    if (m_selectedDate == date)
        return;

    m_selectedDate = date;
    Q_EMIT selectedDateChanged();
}
