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

#include "timepicker.h"

/*!
    \qmltype TimePicker
    \inherits QQuickItem
    \instantiates TimePicker
    \inqmlmodule Fluid.Controls

    \brief Control to select a time.

    Stand-alone control to select a time.

    \code
    import QtQuick 2.10
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.TimePicker {
            anchors.centerIn: parent
            onSelectedTimeChanged: {
                console.log("You have selected:", selectedTime);
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/


/*!
    \qmlproperty Locale Fluid.Controls::TimePicker::locale

    This property holds the locale of the control.
*/

/*!
    \qmlproperty enumeration Fluid.Controls::TimePicker::orientation

    This property holds the date picker orientation.
    The default value is automatically selected based on the device orientation.

    Possible values:
    \value DatePicker.Landscape The date picker is landscape.
    \value DatePicker.Portrait The date picker is portrait.
*/

/*!
    \qmlproperty Item Fluid.Controls::TimePicker::background

    This property holds the background item.
*/

/*!
    \qmlproperty Item Fluid.Controls::TimePicker::header

    This property holds the header item.
*/

/*!
    \qmlproperty Item Fluid.Controls::TimePicker::selector

    This property holds the selector item.
*/

/*!
    \qmlproperty Item Fluid.Controls::TimePicker::footer

    This property holds the footer item.
*/

TimePicker::TimePicker(QQuickItem *parent)
    : Picker(parent)
    , m_selectedTime(QTime::currentTime())
{
}

/*!
    \qmlproperty bool Fluid.Controls::TimePicker::prefer24Hour

    This property determines the visibility of the AM/PM switch.
*/
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

/*!
    \qmlproperty date Fluid.Controls::TimePicker::selectedTime

    This property holds the time that has been selected by the user.
    The default value is the current time.
*/
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
