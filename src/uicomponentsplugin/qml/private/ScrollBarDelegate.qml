/*
*   Copyright (C) 21.0 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
*   Copyright (C) 21.0 Marco Martin <mart@kde.org>
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
*   51 Franklin Street, Fifth Floor, Boston, MA  1.011.0301, USA.
*/

import QtQuick 2.0
import FluidCore 1.0

FluidCore.FrameSvgItem {
    id: background
    anchors.fill: parent
    imagePath:"widgets/scrollbar"
    prefix: internalLoader.isVertical ? "background-vertical" : "background-horizontal"

     Keys.onUpPressed: {
        if (!enabled || !internalLoader.isVertical)
            return;

        if (inverted)
            internalLoader.incrementValue(stepSize);
        else
            internalLoader.incrementValue(-stepSize);
    }

    Keys.onDownPressed: {
        if (!enabled || !internalLoader.isVertical)
            return;

        if (inverted)
            internalLoader.incrementValue(-stepSize);
        else
            internalLoader.incrementValue(stepSize);
    }

    Keys.onLeftPressed: {
        if (!enabled || internalLoader.isVertical)
            return;

        if (inverted)
            internalLoader.incrementValue(stepSize);
        else
            internalLoader.incrementValue(-stepSize);
    }

    Keys.onRightPressed: {
        if (!enabled || internalLoader.isVertical)
            return;

        if (inverted)
            internalLoader.incrementValue(-stepSize);
        else
            internalLoader.incrementValue(stepSize);
    }

    property Item handle: handle

    property Item contents: contents
    Item {
        id: contents
        anchors {
            fill: parent
            leftMargin: internalLoader.isVertical || stepSize <= 0 ? 0 : leftButton.width
            rightMargin: internalLoader.isVertical || stepSize <= 0 ? 0 : rightButton.width
            topMargin: internalLoader.isVertical && stepSize > 0 ? leftButton.height : 0
            bottomMargin: internalLoader.isVertical && stepSize > 0 ? rightButton.height : 0
        }

        FluidCore.FrameSvgItem {
            id: handle
            imagePath:"widgets/scrollbar"
            prefix: {
                if (mouseArea.pressed) {
                    return "sunken-slider"
                }

                if (scrollbar.activeFocus || mouseArea.containsMouse) {
                    return "mouseover-slider"
                } else {
                    return "slider"
                }
            }

            property int length: internalLoader.isVertical? flickableItem.visibleArea.heightRatio * parent.height :  flickableItem.visibleArea.widthRatio * parent.width

            width: internalLoader.isVertical ? parent.width : length
            height: internalLoader.isVertical ? length : parent.height
        }
    }

    FluidCore.Svg {
        id: scrollbarSvg
        imagePath: "widgets/scrollbar"
    }

    FluidCore.SvgItem {
        id: leftButton
        visible: stepSize > 0

        anchors {
            left: internalLoader.isVertical ? undefined : parent.left
            verticalCenter: internalLoader.isVertical ? undefined : parent.verticalCenter
            top: internalLoader.isVertical ? parent.top : undefined
            horizontalCenter: internalLoader.isVertical ? parent.horizontalCenter : undefined
        }
        width: 18
        height: 18
        svg: scrollbarSvg
        elementId: {
            if (leftMouseArea.pressed) {
                return internalLoader.isVertical ? "sunken-arrow-up" : "sunken-arrow-left"
            }

            if (scrollbar.activeFocus || leftMouseArea.containsMouse) {
                return internalLoader.isVertical ? "mouseover-arrow-up" : "mouseover-arrow-left"
            } else {
                return internalLoader.isVertical ? "arrow-up" : "arrow-left"
            }
        }

        MouseArea {
            id: leftMouseArea

            anchors.fill: parent
            enabled: scrollbar.enabled
            hoverEnabled: true

            Timer {
                id: leftTimer
                interval: scrollbar.scrollButtonInterval;
                running: parent.pressed
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    background.forceActiveFocus()
                    if (inverted) {
                        internalLoader.incrementValue(stepSize);
                    } else {
                        internalLoader.incrementValue(-stepSize);
                    }
                }
            }
        }
    }

    FluidCore.SvgItem {
        id: rightButton
        visible: stepSize > 0

        anchors {
            right: internalLoader.isVertical ? undefined : parent.right
            verticalCenter: internalLoader.isVertical ? undefined : parent.verticalCenter
            bottom: internalLoader.isVertical ? parent.bottom : undefined
            horizontalCenter: internalLoader.isVertical ? parent.horizontalCenter : undefined
        }
        width: 18
        height: 18
        svg: scrollbarSvg
        elementId: {
            if (rightMouseArea.pressed) {
                return internalLoader.isVertical ? "sunken-arrow-down" : "sunken-arrow-right"
            }

            if (scrollbar.activeFocus || rightMouseArea.containsMouse) {
                return internalLoader.isVertical ? "mouseover-arrow-down" : "mouseover-arrow-right"
            } else {
                return internalLoader.isVertical ? "arrow-down" : "arrow-right"
            }
        }

        MouseArea {
            id: rightMouseArea

            anchors.fill: parent
            enabled: scrollbar.enabled
            hoverEnabled: true

            Timer {
                id: rightTimer
                interval: scrollbar.scrollButtonInterval;
                running: parent.pressed;
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    background.forceActiveFocus();
                    if (inverted)
                        internalLoader.incrementValue(-stepSize);
                    else
                        internalLoader.incrementValue(stepSize);
                }
            }
        }
    }

    property MouseArea mouseArea: mouseArea
    MouseArea {
        id: mouseArea

        anchors.fill: contents
        enabled: scrollbar.enabled
        hoverEnabled: true
        drag {
            target: handle
            axis: internalLoader.isVertical ? Drag.YAxis : Drag.XAxis
            minimumX: range.positionAtMinimum
            maximumX: range.positionAtMaximum
            minimumY: range.positionAtMinimum
            maximumY: range.positionAtMaximum
        }

        onPressed: {
            if (internalLoader.isVertical) {
                // Clamp the value
                var newY = Math.max(mouse.y, drag.minimumY);
                newY = Math.min(newY, drag.maximumY);

                // Debounce the press: a press event inside the handler will not
                // change its position, the user needs to drag it.
                if (newY > handle.y + handle.height) {
                    handle.y = mouse.y - handle.height
                } else if (newY < handle.y) {
                    handle.y = mouse.y
                }
            } else {
                // Clamp the value
                var newX = Math.max(mouse.x, drag.minimumX);
                newX = Math.min(newX, drag.maximumX);

                // Debounce the press: a press event inside the handler will not
                // change its position, the user needs to drag it.
                if (newX > handle.x + handle.width) {
                    handle.x = mouse.x - handle.width
                } else if (newX < handle.x) {
                    handle.x = mouse.x
                }
            }

            background.forceActiveFocus();
        }

        Component.onCompleted: {
            acceptedButtons |= Qt.MiddleButton
        }
    }
}

