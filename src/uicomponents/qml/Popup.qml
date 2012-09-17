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

Item {
    id: root

    // api
    property alias visualParent: fader.visualParent

    // possible states: Opening, Open, Closing, Closed
    // Opening and Closing are used during animation (when the dialog fades/moves/pops/whatever in)
    property int status: DialogStatus.Closed

    // private api
    property double __dim: 0.9
    property int __fadeInDuration
    property int __fadeOutDuration
    property int __fadeInDelay
    property int __fadeOutDelay
    property int __fadeInEasingType
    property int __fadeOutEasingType
    property string __faderBackground

    property bool __platformModal: false

    function open() {
        if (status == DialogStatus.Closed)
            status = DialogStatus.Opening;
    }

    function close() {
        if (status == DialogStatus.Open)
            status = DialogStatus.Closing;
    }

    signal privateClicked

    //Deprecated, TODO Remove the following two lines on w13
   signal clicked
   onClicked: privateClicked()

    QtObject {
        id: parentCache
        property QtObject oldParent: null
    }

    Component.onCompleted: {
        parentCache.oldParent = parent;
        fader.parent = parent;
        parent = fader;
        fader.privateClicked.connect(privateClicked)
    }

    //if this is not given, application may crash in some cases
    Component.onDestruction: {
        if (parentCache.oldParent != null) {
            parent = parentCache.oldParent
            fader.parent = root
        }
    }

    Fader {
        id: fader
        dim: root.__dim
        fadeInDuration: root.__fadeInDuration
        fadeOutDuration: root.__fadeOutDuration
        fadeInDelay: root.__fadeInDelay
        fadeOutDelay: root.__fadeOutDelay
        fadeInEasingType: root.__fadeInEasingType
        fadeOutEasingType: root.__fadeOutEasingType


        background: root.__faderBackground

        MouseArea {
            anchors.fill: parent
            enabled: root.status == DialogStatus.Opening || root.status == DialogStatus.Closing
            z: Number.MAX_VALUE
        }
    }

    function __fader() {
        return fader;
    }

}
