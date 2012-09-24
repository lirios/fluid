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

/*
Class: Switch
   The Switch component is similar to the CheckBox component but instead of
   selecting items it should be used when setting options to On/Off.
*/
Item {
    id: root

    width: slider.width
    height: slider.height

    /*
    * Property: checked
     * [bool=false] The checked state of switch
     */
    property bool checked: false

    // Styling for the Switch
    property Style platformStyle: SwitchStyle {}

    //Deprecated, TODO Remove this on w13
    property alias style: root.platformStyle

    property alias platformMouseAnchors: mouseArea.anchors

    /*
    * Property: enabled
     * [bool=true] Enables/Disables the component. Notice that the disable state is not Toolkit compliant
     * and not present inside the qt-components
     */

    Item {
        id: slider

        width: 66
        height: 42

        state: root.checked ? "checked" : "unchecked"

        property real knobPos: (knob.x - platformStyle.minKnobX) / (platformStyle.maxKnobX - platformStyle.minKnobX)

        Image {
            source: platformStyle.switchOn
            opacity: slider.knobPos
        }
        Image {
            source: platformStyle.switchOff
            opacity: 1.0 - slider.knobPos
        }

        states: [
            State {
                name: "unchecked"
                PropertyChanges { target: knob; x: platformStyle.minKnobX }
            },
            State {
                name: "checked"
                PropertyChanges { target: knob; x: platformStyle.maxKnobX }
            }
        ]

        transitions: [
            Transition {
                SmoothedAnimation { properties: "x"; velocity: 500; maximumEasingTime: 0 }
            }
        ]

        // thumb (shadow)
        Image {
            id: knob

            // thumb (inline)
            Image {
                width: 30
                height: 30
                x: 0
                y: -2
                source: (slider.enabled ? (mouseArea.pressed ? platformStyle.thumbPressed : platformStyle.thumb) : platformStyle.thumbDisabled)
            }

            source: platformStyle.shadow

            y: 8

            width: 30
            height: 30
        }

        MouseArea {
            id: mouseArea
            property int downMouseX
            property int downKnobX
            anchors {
                fill: parent
                rightMargin: platformStyle.mouseMarginRight
                leftMargin: platformStyle.mouseMarginLeft
                topMargin: platformStyle.mouseMarginTop
                bottomMargin: platformStyle.mouseMarginBottom
            }

            function snap() {
                if (knob.x < (platformStyle.maxKnobX + platformStyle.minKnobX) / 2) {
                    if (root.checked) {
                        root.checked = false;
                    } else {
                        knob.x = platformStyle.minKnobX;
                    }
                } else {
                    if (!root.checked) {
                        root.checked = true;
                    } else {
                        knob.x = platformStyle.maxKnobX;
                    }
                }
            }

            onPressed: {
                downMouseX = mouseX;
                downKnobX = knob.x;
            }

            onPositionChanged: {
                var newKnobX = downKnobX - (downMouseX - mouseX);
                knob.x = newKnobX < platformStyle.minKnobX ? platformStyle.minKnobX : newKnobX > platformStyle.maxKnobX ? platformStyle.maxKnobX : newKnobX;
            }

            onReleased: {
                if (Math.abs(downMouseX - mouseX) < 5)
                    root.checked = !root.checked;
                else
                    snap();
            }

            onCanceled: {
                snap();
            }

        }
    }
}
