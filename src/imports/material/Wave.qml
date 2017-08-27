/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
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

import QtQuick 2.4
import QtGraphicalEffects 1.0

/*!
   \qmltype Wave
   \inqmlmodule Fluid.Material
   \ingroup fluidmaterial

   \brief Provides a wave animation for transitioning between views of content.
 */

Item {
    id: wave

    /*!
      \c True, iif the wave is opened
    */
    property bool opened
    /*!
      The current size of the wave
    */
    property real size: 0
    /*!
      The horizontal center of the wave
    */
    property real initialX
    /*!
      The vertical center of the wave
    */
    property real initialY
    /*!
      The abstract width of the wave
    */
    property real abstractWidth: parent.width
    /*!
      The abstract height of the wave
    */
    property real abstractHeight: parent.height
    /*!
      The diameter of the completely opened wave
    */
    property real diameter: 2 * Math.sqrt(Math.pow(Math.max(initialX, abstractWidth - initialX), 2)
            + Math.pow(Math.max(initialY, abstractHeight - initialY), 2))

    /*!
      This signal is emitted, when the wave has finished opening or closing.
      \a opened defines, whether the wave was opened or closed
    */
    signal finished(bool opened)

    /*!
      Opens the wave centering the wave at (\a x, \a y)
    */
    function open(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.opened = true;
    }

    /*!
      Closes the wave centering the wave at (\a x, \a y)
    */
    function close(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.opened = false;
    }

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
        name: "opened"
        when: wave.opened

        PropertyChanges {
            target: wave
            size: wave.diameter
        }
    }

    transitions: Transition {
        from: ""
        to: "opened"
        reversible: true

        SequentialAnimation {
            NumberAnimation {
                property: "size"
                easing.type: Easing.OutCubic
            }
            ScriptAction {
                script: wave.finished(wave.opened)
            }
        }
    }
}
