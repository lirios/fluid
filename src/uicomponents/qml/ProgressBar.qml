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
import FluidUi 1.0

import "Utils.js" as Utils

ImplicitSizeItem {
    id: container

    property alias minimumValue: progressModel.minimumValue
    property alias maximumValue: progressModel.maximumValue
    property alias value: progressModel.value
    property bool indeterminate: false

    // Styling for the ProgressBar
    property Style platformStyle: ProgressBarStyle{}

    //Deprecated, can be removed on W13
    property alias style: container.platformStyle

    implicitWidth: platformStyle.sizeButton
    implicitHeight: background.height

    QtObject {
        id: internal
        property Flickable flick
        property bool offScreen: false
    }

    BorderImage {
        id: background
        width: parent.width
        horizontalTileMode: BorderImage.Repeat
        source: platformStyle.barBackground

        border {
            left: 6
            top: 4
            right: 6
            bottom: 4
        }
    }

    MaskedItem {
        id: foreground
        width: parent.width
        height: parent.height

        mask: BorderImage {
            width: indeterminate ? container.width : progressModel.position
            height: foreground.height
            source: platformStyle.barMask

            border {
                left: 4
                top: 4
                right: 4
                bottom: 4
            }
        }        

        Image {
            id: texture
            width: foreground.width + sourceSize.width + 25
            height: foreground.height
            fillMode: Image.Tile

            property real xTemp;                 
           
            source: indeterminate ? platformStyle.unknownTexture : platformStyle.knownTexture
 
            onXTempChanged: {   
                // Control the animation speed with this multiplier and the NumberAnimation duration divider
                texture.x = Math.round(texture.xTemp) * 4;
            }

            NumberAnimation on xTemp {
                running: indeterminate && container.visible && Qt.application.active && !internal.offScreen
                loops: Animation.Infinite
                from: -texture.sourceSize.width
                to: 0
                // time = distance / speed, where speed = 10 from the platformStyle
                duration: (1000 * texture.sourceSize.width / 10)
            }
        }
    }

    RangeModel {
        id: progressModel
        positionAtMinimum: 0
        positionAtMaximum: background.width

        // Defaults from Common API specification
        minimumValue: 0
        maximumValue: 1.0
    }

    Connections {
        target: internal.flick

        onMovementStarted: internal.offScreen = false

        onMovementEnded: {
            var pos = mapToItem(internal.flick, 0, 0)
            internal.offScreen = (pos.y + container.height <= 0) || (pos.y >= internal.flick.height) || (pos.x + container.width <= 0) || (pos.x >= internal.flick.width)
        }
    }

    Component.onCompleted: {
        var flick = Utils.findFlickable()
        if (flick)
            internal.flick = flick
    }
}
