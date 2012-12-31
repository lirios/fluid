/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2005 Aaron Seigo <aseigo@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Aaron Seigo
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

#include "fluid.h"

namespace Fluid
{
    Direction locationToDirection(Location location)
    {
        switch (location) {
            case Floating:
            case Desktop:
            case TopEdge:
            case FullScreen:
                //TODO: should we be smarter for floating and planer?
                //      perhaps we should take a QRect and/or QPos as well?
                return Down;
            case BottomEdge:
                return Up;
            case LeftEdge:
                return Right;
            case RightEdge:
                return Left;
        }

        return Down;
    }

    Direction locationToInverseDirection(Location location)
    {
        switch (location) {
            case Floating:
            case Desktop:
            case TopEdge:
            case FullScreen:
                //TODO: should we be smarter for floating and planer?
                //      perhaps we should take a QRect and/or QPos as well?
                return Up;
            case BottomEdge:
                return Down;
            case LeftEdge:
                return Left;
            case RightEdge:
                return Right;
        }

        return Up;
    }
}
