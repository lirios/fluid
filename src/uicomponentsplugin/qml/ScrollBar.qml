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

/**Documented API
Inherits:
        Item

Imports:
        FluidCore
        QtQuick 2.0

Description:
        Just a simple Scroll Bar which is using the plasma theme.
        This component does not belong to the QtComponents API specification
        but it was base on ScrollDecorator component.
        You should not use it for touch interfaces, use a flickable and a
        ScrollDecorator instead.
        By default, this component will look and behave like a scroll decorator
        on touchscreens

Properties:

        enumeration orientation:
        This property holds the orientation where the ScrollBar will scroll.
        The orientation can be either Qt.Horizontal or Qt.Vertical
        The default value is Qt.Vertical.

        bool inverted:
        This property holds if the ScrollBar will increase the Flickable
        content in the normal direction (Left to Right or Top to Bottom) or
        if this will be inverted.
        The default value is false.

        bool updateValueWhileDragging:
        This property holds if the Scrollbar will update the Flickeble
        position while dragging or only when released.
        The default value is true.

        real stepSize:
        This property holds how many steps exists while moving the handler.
        If you want the ScrollBar buttons to appear you must set this property
        with a value bigger than 0.
        The default value is 0.

        bool pressed:
        This property holds if the ScrollBar is pressed.

        real scrollButtonInterval:
        This property holds the interval time used by the ScrollBar button
        to increase or decrease steps.

        Flickable flickableItem:
        This property holds the Flickable component which the ScrollBar will
        interact with.

        bool interactive:
        This property holds  if the ScrollBar is interactive.
        The default value is true.

        bool enabeld:
        This property holds if the button will be enabled for user
        interaction.
        The default value is true.
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import "private" as Private

/**
 * A generic ScrollBar/ScrollDecorator component:
 * Always prefer this to ScrollDecorator that is not available on desktop.
 * By default, this component will look and behave like a scroll decorator on touchscreens
 */
// TODO: add support mouse wheel events
Item {
    id: scrollbar

    // Common API
    property Flickable flickableItem: null
    property int orientation: Qt.Vertical
    property bool interactive: true

    // Plasma API
    property bool inverted: false
    property alias stepSize: range.stepSize
    property bool pressed: internalLoader.item.mouseArea?internalLoader.item.mouseArea.pressed:false
    property real scrollButtonInterval: 50

    implicitWidth: internalLoader.isVertical ? (interactive ? 16 : 12) : 200
    implicitHeight: internalLoader.isVertical ? 200 : (interactive ? 16 : 12)
    // TODO: needs to define if there will be specific graphics for
    //     disabled scroll bars
    opacity: enabled ? 1.0 : 0.5

    visible: flickableItem && internalLoader.handleEnabled

    anchors {
        right: flickableItem.right
        left: (orientation == Qt.Vertical) ? undefined : flickableItem.left
        top: (orientation == Qt.Vertical) ? flickableItem.top : undefined
        bottom: flickableItem.bottom
    }

    Loader {
        id: internalLoader
        anchors.fill: parent
        //property bool handleEnabled: internalLoader.isVertical ? item.handle.height < item.contents.height : item.handle.width < item.contents.width
        property bool handleEnabled: internalLoader.isVertical ? flickableItem.contentHeight > flickableItem.height : flickableItem.contentWidth > flickableItem.width
        property bool isVertical: orientation == Qt.Vertical

        function incrementValue(increment)
        {
            if (!flickableItem)
                return;

            if (internalLoader.isVertical) {
                flickableItem.contentY = Math.max(0, Math.min(flickableItem.contentHeight - flickableItem.height,
                    flickableItem.contentY + increment))
            } else {
                flickableItem.contentX = Math.max(0, Math.min(flickableItem.contentWidth - flickableItem.width,
                    flickableItem.contentX + increment))
            }
        }


        Connections {
            target: flickableItem
            onContentHeightChanged: {
                range.value = flickableItem.contentY
            }
            onContentYChanged: {
                if (internalLoader.isVertical) {
                    range.value = flickableItem.contentY
                }
            }
            onContentXChanged: {
                if (!internalLoader.isVertical) {
                    range.value = flickableItem.contentX
                }
            }
        }
        Connections {
            target: internalLoader.item.handle
            onYChanged: updateFromHandleTimer.running = true
            onXChanged: updateFromHandleTimer.running = true
        }
        FluidCore.RangeModel {
            id: range

            minimumValue: 0
            maximumValue: {
                var diff;
                if (internalLoader.isVertical) {
                    diff = flickableItem.contentHeight - flickableItem.height
                } else {
                    diff = flickableItem.contentWidth - flickableItem.width
                }

                return Math.max(0, diff)
            }

            stepSize: 10
            inverted: scrollbar.inverted
            positionAtMinimum: 0
            positionAtMaximum: {
                if (internalLoader.isVertical) {
                    internalLoader.item.contents.height - internalLoader.item.handle.height
                } else {
                    internalLoader.item.contents.width - internalLoader.item.handle.width
                }
            }

            onValueChanged: {
                if (flickableItem.moving) {
                    return
                }

                if (internalLoader.isVertical) {
                    flickableItem.contentY = value
                } else {
                    flickableItem.contentX = value
                }
            }


            onPositionChanged: {
                if (internalLoader.item.mouseArea && internalLoader.item.mouseArea.pressed) {
                    return
                }

                if (internalLoader.isVertical) {
                    internalLoader.item.handle.y = position
                } else {
                    internalLoader.item.handle.x = position
                }
            }
        }

        Timer {
            id: updateFromHandleTimer
            interval: 10
            onTriggered: {
                if (internalLoader.isVertical && enabled && interactive) {
                    range.position = internalLoader.item.handle.y
                } else {
                    range.position = internalLoader.item.handle.x
                }
            }
        }

        source: interactive ? "private/ScrollBarDelegate.qml" : "private/ScrollDecoratorDelegate.qml"
    }
}
