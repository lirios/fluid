/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2011 Daker Fernandes Pinheiro <dakerfp@gmail.com>
 * Copyright (C) 2011 Marco Martin <mart@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Marco Martin
 *    Daker Fernandes Pinheiro
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

import QtQuick 2.0
import FluidCore 1.0 as FluidCore

FluidCore.FrameSvgItem {
    id: background
    anchors.fill: parent
    imagePath:"widgets/scrollbar"
    prefix: internalLoader.isVertical ? "background-vertical" : "background-horizontal"

    opacity: 0
    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutQuad
        }
    }

    property Item handle: handle

    property Item contents: contents
    Item {
        id: contents
        anchors.fill: parent

        FluidCore.FrameSvgItem {
            id: handle
            imagePath:"widgets/scrollbar"
            prefix: "slider"

            function length()
            {
                var nh, ny;

                if (internalLoader.isVertical) {
                    nh = flickableItem.visibleArea.heightRatio * internalLoader.height
                } else {
                    nh = flickableItem.visibleArea.widthRatio * internalLoader.width
                }

                if (internalLoader.isVertical) {
                    ny = flickableItem.visibleArea.yPosition * internalLoader.height
                } else {
                    ny = flickableItem.visibleArea.xPosition * internalLoader.width
                }

                if (ny > 3) {
                    var t

                    if (internalLoader.isVertical) {
                        t = Math.ceil(internalLoader.height - 3 - ny)
                    } else {
                        t = Math.ceil(internalLoader.width - 3 - ny)
                    }

                    if (nh > t) {
                        return t
                    } else {
                        return nh
                    }
                } else {
                    return nh + ny
                }
            }

            width: internalLoader.isVertical ? parent.width : length()
            height: internalLoader.isVertical ? length() : parent.height
        }
    }

    property MouseArea mouseArea: null

    Connections {
        target: flickableItem
        onMovingChanged: {
            if (flickableItem.moving) {
                opacityTimer.running = false
                background.opacity = 1
            } else {
                opacityTimer.restart()
            }
        }
    }
    Timer {
        id: opacityTimer
        interval: 500
        repeat: false
        running: false
        onTriggered: {
            background.opacity = 0
        }
    }
}

