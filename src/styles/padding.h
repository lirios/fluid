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

#ifndef PADDING_H
#define PADDING_H

#include <QtCore/QObject>

class Padding : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int left READ left WRITE setLeft NOTIFY leftChanged)
    Q_PROPERTY(int top READ top WRITE setTop NOTIFY topChanged)
    Q_PROPERTY(int right READ right WRITE setRight NOTIFY rightChanged)
    Q_PROPERTY(int bottom READ bottom WRITE setBottom NOTIFY bottomChanged)
public:
    explicit Padding(QObject *parent = 0);

    int left() const;
    void setLeft(int arg);

    int top() const;
    void setTop(int arg);

    int right() const;
    void setRight(int arg);

    int bottom() const;
    void setBottom(int arg);

Q_SIGNALS:
    void leftChanged();
    void topChanged();
    void rightChanged();
    void bottomChanged();

private:
    int m_left;
    int m_top;
    int m_right;
    int m_bottom;
};

#endif // PADDING_H
