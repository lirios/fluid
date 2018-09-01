/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

Item {
    property url source
    property int fadeDuration: 250
    readonly property bool running: animation.running

    id: root
    onSourceChanged: {
        animation.running = false;

        if (__priv.currentLoader == loader1) {
            __priv.currentLoader = loader2;
            __priv.nextLoader = loader1;
        } else {
            __priv.currentLoader = loader1;
            __priv.nextLoader = loader2;
        }

        __priv.currentLoader.source = sourceUrl;
        __priv.currentLoader.opacity = 0;
        __priv.currentLoader.z = 1;
        __priv.nextLoader.z = 0;

        if (__priv.firstTime) {
            __priv.currentLoader.opacity = 1.0;
            __priv.nextLoader.opacity = 0.0;
            __priv.firstTime = false;
        } else {
            animation.running = true;
        }
    }

    QtObject {
        id: __priv

        property bool firstTime: true
        property Loader currentLoader: loader1
        property Loader nextLoader: loader2
    }

    SequentialAnimation {
        id: animation
        running: false

        NumberAnimation {
            target: __priv.currentLoader
            properties: "opacity"
            from: 0.0
            to: 1.0
            duration: root.fadeDuration
            easing.type: Easing.OutQuad
        }

        ScriptAction {
            script: {
                __priv.nextLoader.opacity = 0;
                //__priv.nextLoader.source = "";
            }
        }
    }

    Loader {
        id: loader1
        anchors.fill: parent
        z: 1
    }

    Loader {
        id: loader2
        anchors.fill: parent
        z: 0
    }
}
