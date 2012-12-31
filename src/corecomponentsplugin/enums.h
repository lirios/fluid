/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2011 Marco Martin <mart@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Marco Martin
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

#ifndef ENUMS_H
#define ENUMS_H

#include <QObject>

class DialogStatus : public QObject
{
    Q_OBJECT
    Q_ENUMS(Status)
public:
    enum Status {
        Opening,
        Open,
        Closing,
        Closed
    };
};

class PageOrientation : public QObject
{
    Q_OBJECT
    Q_ENUMS(Orientation)
public:
    enum Orientation {
        Automatic,
        LockPortrait,
        LockLandscape,
        LockPrevious,
        Manual
    };
};

class PageStatus : public QObject
{
    Q_OBJECT
    Q_ENUMS(Status)
public:
    enum Status {
        Inactive,
        Activating,
        Active,
        Deactivating
    };
};

#endif // ENUMS_H
