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

/*!
   \qmltype Wave
   \inqmlmodule Fluid.Material 1.0
   \brief Provides a wave animation for transitioning between views of content.
 */
Rectangle {
    id: wave

    property bool opened
    property real size: 0
    property real initialX
    property real initialY
    property real abstractWidth: parent.width
    property real abstractHeight: parent.height
    property real diameter: 2 * Math.sqrt(Math.pow(Math.max(initialX, abstractWidth - initialX), 2)
            + Math.pow(Math.max(initialY, abstractHeight - initialY), 2))

    signal finished(bool opened)

    function open(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.opened = true;
    }

    function close(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.opened = false;
    }

    width: size
    height: size
    radius: size/2
    x: initialX - size/2
    y: initialY - size/2
    clip: true

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
