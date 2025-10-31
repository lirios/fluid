/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick
import Qt5Compat.GraphicalEffects

/*!
    \brief Provides a wave animation for transitioning between views of content.

    For more information you can read the
    <a href="https://material.io/guidelines/motion/material-motion.html#material-motion-how-does-material-move">Material Design guidelines</a>.
*/
Item {
    id: wave

    /*!
        This property holds whether the wave is open.
    */
    property bool open: false

    /*!
        This property holds the current size of the wave.
    */
    property real size: 0

    /*!
        This property holds the horizontal center of the wave.
    */
    property real initialX

    /*!
        This property holds the vertical center of the wave.
    */
    property real initialY

    /*!
        This property holds the abstract width of the wave.
    */
    property real abstractWidth: parent.width

    /*!
        This property holds the abstract height of the wave.
    */
    property real abstractHeight: parent.height

    /*!
        This property holds the diameter of the completely open wave.
    */
    property real diameter: 2 * Math.sqrt(Math.pow(Math.max(initialX, abstractWidth - initialX), 2)
            + Math.pow(Math.max(initialY, abstractHeight - initialY), 2))

    /*!
        This signal is emitted, when the wave has finished opening or closing.
        \a open defines, whether the wave was being opened or closed.
    */
    signal finished(bool open)

    /*!
        Opens the wave centering the wave at (\a x, \a y).
    */
    function openWave(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.open = true;
    }

    /*!
        Closes the wave centering the wave at (\a x, \a y).
    */
    function closeWave(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.open = false;
    }

    visible: open
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Item {
            width: wave.width
            height: wave.height
            Rectangle {
                x: initialX - size/2
                y: initialY - size/2
                width: size
                height: size
                radius: size/2
            }
        }
    }

    states: State {
        name: "open"
        when: wave.open

        PropertyChanges {
            target: wave
            size: wave.diameter
        }
    }

    transitions: Transition {
        from: ""
        to: "open"
        reversible: true

        SequentialAnimation {
            ScriptAction {
                script: wave.visible = wave.open;
            }
            NumberAnimation {
                property: "size"
                easing.type: Easing.OutCubic
            }
            ScriptAction {
                script: wave.finished(wave.open)
            }
        }
    }
}
