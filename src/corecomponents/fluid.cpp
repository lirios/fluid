/*
 *   Copyright 2005 by Aaron Seigo <aseigo@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "fluid.h"

namespace FluidCore
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
