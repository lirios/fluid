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

import QtQuick 2.10
import QtGraphicalEffects 1.0

Item {
    id: wave

    property bool open: false
    property real size: 0
    property real initialX
    property real initialY
    property real abstractWidth: parent.width
    property real abstractHeight: parent.height
    property real diameter: 2 * Math.sqrt(Math.pow(Math.max(initialX, abstractWidth - initialX), 2)
            + Math.pow(Math.max(initialY, abstractHeight - initialY), 2))

    signal finished(bool open)

    function openWave(x, y) {
        wave.initialX = x || parent.width/2;
        wave.initialY = y || parent.height/2;
        wave.open = true;
    }

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
