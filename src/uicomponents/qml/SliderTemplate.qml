/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import FluidUi 1.0

Item {
    id: slider

    //
    // Common API
    //
    property int orientation: Qt.Horizontal
    property alias minimumValue: range.minimumValue
    property alias maximumValue: range.maximumValue
    property alias pressed: mouseArea.pressed
    property alias stepSize: range.stepSize
    property alias platformMouseAnchors: mouseArea.anchors

    // NOTE: this property is in/out, the user can set it, create bindings to it, and
    // at the same time the slider wants to update. There's no way in QML to do this kind
    // of updates AND allow the user bind it (without a Binding object). That's the
    // reason this is an alias to a C++ property in range model.
    property alias value: range.value

    //
    // Public extensions
    //
    property alias inverted: range.inverted

    // Value indicator displays the current value near the slider
    // if valueIndicatorText == "", a default formating will be applied
    property string valueIndicatorText: formatValue(range.value)
    property bool valueIndicatorVisible: false

    property int valueIndicatorMargin: 1
    property string valueIndicatorPosition: __isVertical ? "Left" : "Top"

    // The default implementation for label hides decimals until it hits a
    // floating point value at which point it keeps decimals
    property bool __useDecimals: false
    function formatValue(v) {
        return __useDecimals ? (v.toFixed(2)) : v;
    }

    //
    // "Protected" properties
    //

    // Hooks for customizing the pieces of the slider
    property Item __grooveItem
    property Item __valueTrackItem
    property Item __handleItem
    property Item __valueIndicatorItem

    property bool __isVertical: orientation == Qt.Vertical

    implicitWidth: 400
    implicitHeight: handle.height

    width: __isVertical ? implicitHeight : implicitWidth
    height: __isVertical ? implicitWidth : implicitHeight

    // This is a template slider, so every piece can be modified by passing a
    // different Component. The main elements in the implementation are
    //
    // - the 'range' does the calculations to map position to/from value,
    //   it also serves as a data storage for both properties;
    //
    // - the 'fakeHandle' is what the mouse area drags on the screen, it feeds
    //   the 'range' position and also reads it when convenient;
    //
    // - the real 'handle' it is the visual representation of the handle, that
    //   just follows the 'fakeHandle' position.
    //
    // Everything is encapsulated in a contents Item, so for the
    // vertical slider, we just swap the height/width, make it
    // horizontal, and then use rotation to make it vertical again.

    Component.onCompleted: {
        __grooveItem.parent = groove;
        __valueTrackItem.parent = valueTrack;
        __handleItem.parent = handle;
        __valueIndicatorItem.parent = valueIndicator;
    }

    Item {
        id: contents

        width: __isVertical ? slider.height : slider.width
        height: __isVertical ? slider.width : slider.height
        rotation: __isVertical ? -90 : 0

        anchors.centerIn: slider

        RangeModel {
            id: range
            minimumValue: 0.0
            maximumValue: 1.0
            value: 0
            stepSize: 0.0
            onValueChanged: {
                // XXX: Moved that outside formatValue to get rid of binding loop warnings
                var v = range.value
                if (parseInt(v) != v)
                    __useDecimals = true;
            }
            positionAtMinimum: handle.width / 2
            positionAtMaximum: contents.width - handle.width / 2
            onMaximumChanged: __useDecimals = false;
            onMinimumChanged: __useDecimals = false;
            onStepSizeChanged: __useDecimals = false;
        }

        Item {
            id: groove
            anchors.fill: parent
            anchors.leftMargin: handle.width / 2
            anchors.rightMargin: handle.width / 2
        }

        Item {
            id: valueTrack

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: groove.left
            anchors.right: handle.horizontalCenter
            anchors.rightMargin: handle.width / 2

            states: State {
                when: slider.inverted
                PropertyChanges {
                    target: valueTrack
                    anchors.rightMargin: 0
                    anchors.leftMargin: - handle.width / 2
                }
                AnchorChanges {
                    target: valueTrack
                    anchors.left: handle.horizontalCenter
                    anchors.right: groove.right
                }
            }
        }

        Item {
            id: handle
            transform: Translate { x: - handle.width / 2 }
            rotation: __isVertical ? 90 : 0

            anchors.verticalCenter: parent.verticalCenter

            width: __handleItem.width
            height: __handleItem.height

            x: fakeHandle.x
            Behavior on x {
                id: behavior
                enabled: !mouseArea.drag.active

                PropertyAnimation {
                    duration: behavior.enabled ? 150 : 0
                    easing.type: Easing.OutSine
                }
            }
        }

        Item {
            id: fakeHandle
            width: handle.width
            height: handle.height
            transform: Translate { x: - handle.width / 2 }
        }

        MouseArea {
            id: mouseArea
            property real oldPosition: 0
            anchors {
                fill: parent
                rightMargin: platformStyle.mouseMarginRight
                leftMargin: platformStyle.mouseMarginLeft
                topMargin: platformStyle.mouseMarginTop
                bottomMargin: platformStyle.mouseMarginBottom
            }

            drag.target: fakeHandle
            drag.axis: Drag.XAxis
            drag.minimumX: range.positionAtMinimum
            drag.maximumX: range.positionAtMaximum

            onPressed: {
                oldPosition = range.position;
                // Clamp the value
                var newX = Math.max(mouse.x + anchors.leftMargin, drag.minimumX);
                newX = Math.min(newX, drag.maximumX);

                // Debounce the press: a press event inside the handler will not
                // change its position, the user needs to drag it.
                if (Math.abs(newX - fakeHandle.x) > handle.width / 2)
                    range.position = newX;
            }

            onCanceled: {
                range.position = oldPosition;
            }
        }

        Item {
            id: valueIndicator

            transform: Translate {
                x: - handle.width / 2;
                y: __isVertical? -(__valueIndicatorItem.width/2)+20 : y ;
            }

            rotation: __isVertical ? 90 : 0
            visible: valueIndicatorVisible

            width: __valueIndicatorItem.width //+ (__isVertical? (handle.width/2) : 0 )
            height: __valueIndicatorItem.height

            state: {
                if (!__isVertical)
                    return slider.valueIndicatorPosition;

                if (valueIndicatorPosition == "Right")
                    return "Bottom";
                if (valueIndicatorPosition == "Top")
                    return "Right";
                if (valueIndicatorPosition == "Bottom")
                    return "Left";

                return "Top";
            }

            anchors.margins: valueIndicatorMargin

            states: [
                State {
                    name: "Top"
                    AnchorChanges {
                        target: valueIndicator
                        anchors.bottom: handle.top
                        anchors.horizontalCenter: handle.horizontalCenter
                    }
                },
                State {
                    name: "Bottom"
                    AnchorChanges {
                        target: valueIndicator
                        anchors.top: handle.bottom
                        anchors.horizontalCenter: handle.horizontalCenter
                    }
                },
                State {
                    name: "Right"
                    AnchorChanges {
                        target: valueIndicator
                        anchors.left: handle.right
                        anchors.verticalCenter: handle.verticalCenter
                    }
                },
                State {
                    name: "Left"
                    AnchorChanges {
                        target: valueIndicator
                        anchors.right: handle.left
                        anchors.verticalCenter: handle.verticalCenter
                    }
                }
            ]
        }
    }

    // when there is no mouse interaction, the handle's position binds to the value
    Binding {
        when: !mouseArea.drag.active
        target: fakeHandle
        property: "x"
        value: range.position
    }

    // when the slider is dragged, the value binds to the handle's position
    Binding {
        when: mouseArea.drag.active
        target: range
        property: "position"
        value: fakeHandle.x
    }
}
