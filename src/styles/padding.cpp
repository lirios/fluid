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

#include "padding.h"

Padding::Padding(QObject *parent)
    : QObject(parent)
    , m_left(0)
    , m_top(0)
    , m_right(0)
    , m_bottom(0)
{
}

int Padding::left() const
{
    return m_left;
}

int Padding::top() const
{
    return m_top;
}

int Padding::right() const
{
    return m_right;
}

int Padding::bottom() const
{
    return m_bottom;
}

void Padding::setLeft(int arg)
{
    if (m_left != arg) {
        m_left = arg;
        emit leftChanged();
    }
}

void Padding::setTop(int arg)
{
    if (m_top != arg) {
        m_top = arg;
        emit topChanged();
    }
}

void Padding::setRight(int arg)
{
    if (m_right != arg) {
        m_right = arg;
        emit rightChanged();
    }
}

void Padding::setBottom(int arg)
{
    if (m_bottom != arg) {
        m_bottom = arg;
        emit bottomChanged();
    }
}

#include "moc_padding.cpp"
