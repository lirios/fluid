/****************************************************************************
 * This file is part of Hawaii Framework.
 *
 * Copyright (C) 2013-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include "abstractstyle.h"

/*!
    \qmltype AbstractStyle
    \instantiates AbstractStyle
    \qmlabstract
    \internal
*/

/*!
    \qmlproperty int AbstractStyle::padding.left
    \qmlproperty int AbstractStyle::padding.top
    \qmlproperty int AbstractStyle::padding.right
    \qmlproperty int AbstractStyle::padding.bottom

    This grouped property holds the \c left, \c top, \c right, \c bottom padding.
*/

/*!
    \qmlproperty real AbstractStyle::dpiScaleFactor

    DPI scale factor.
*/

AbstractStyle::AbstractStyle(QObject *parent)
    : QObject(parent)
{
}

Padding *AbstractStyle::padding()
{
    return &m_padding;
}

extern Q_GUI_EXPORT int qt_defaultDpiX();

qreal AbstractStyle::dpiScaleFactor() const
{
    return (qreal(qt_defaultDpiX()) / 96.0);
}

#include "moc_abstractstyle.cpp"
