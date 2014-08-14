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

AbstractStyle::AbstractStyle(QObject *parent)
    : QObject(parent)
{
}

Padding *AbstractStyle::padding()
{
    return &m_padding;
}

QQmlListProperty<QObject> AbstractStyle::data()
{
    return QQmlListProperty<QObject>(this, 0, &AbstractStyle::data_append, &AbstractStyle::data_count,
                                     &AbstractStyle::data_at, &AbstractStyle::data_clear);
}

void AbstractStyle::data_append(QQmlListProperty<QObject> *list, QObject *object)
{
    if (AbstractStyle *style = qobject_cast<AbstractStyle *>(list->object))
        style->m_data.append(object);
}

int AbstractStyle::data_count(QQmlListProperty<QObject> *list)
{
    if (AbstractStyle *style = qobject_cast<AbstractStyle *>(list->object))
        return style->m_data.count();
    return 0;
}

QObject *AbstractStyle::data_at(QQmlListProperty<QObject> *list, int index)
{
    if (AbstractStyle *style = qobject_cast<AbstractStyle *>(list->object))
        return style->m_data.at(index);
    return 0;
}

void AbstractStyle::data_clear(QQmlListProperty<QObject> *list)
{
    if (AbstractStyle *style = qobject_cast<AbstractStyle *>(list->object))
        style->m_data.clear();
}

#include "moc_abstractstyle.cpp"
