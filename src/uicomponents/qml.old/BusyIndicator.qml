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
import "." 1.0

import "UIConstants.js" as UI
import "Utils.js" as Utils

// ### Display Entered / Exited! Pause animation when not "on display".
// ### LayoutDirection

ImplicitSizeItem {
    id: root

    property bool running: false

    property Style platformStyle: BusyIndicatorStyle{}

    //Deprecated, TODO Remove this on w13
    property alias style: root.platformStyle

    implicitWidth: platformStyle.size == "small" ? 24 : platformStyle.size == "medium" ? 32 : 96;
    implicitHeight: implicitWidth

    QtObject {
        id: internal
        property Flickable flick
        property bool offScreen: false
    }

    Image {
        id: spinner
        property int index: 1
        // This is re-evaluated for each frame. Could be optimized by calculating the sources separately is js
        source: root.platformStyle.spinnerFrames + "_" + root.implicitWidth + "_" + index
        smooth: true

        NumberAnimation on index {
            from: 1; to: root.platformStyle.numberOfFrames
            duration: root.platformStyle.period
            running: root.running && root.visible && Qt.application.active && !internal.offScreen
            loops: Animation.Infinite
        }
    }

    Connections {
        target: internal.flick

        onMovementStarted: internal.offScreen = false

        onMovementEnded: {
            var pos = mapToItem(internal.flick, 0, 0)
            internal.offScreen = (pos.y + root.height <= 0) || (pos.y >= internal.flick.height) || (pos.x + root.width <= 0) || (pos.x >= internal.flick.width)
        }
    }

    Component.onCompleted: {
        var flick = Utils.findFlickable()
        if (flick)
            internal.flick = flick
    }
}
