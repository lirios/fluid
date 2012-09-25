/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2005 Aaron Seigo
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Aaron Seigo <aseigo@kde.org>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
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
