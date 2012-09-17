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

StatusBarInternal {
    id: statusBar
    anchors.top: parent.top
    width: parent.width

    property bool showStatusBar: true
    property bool __completed: false

    states: State {
        name: "hide"; when: showStatusBar==false
        PropertyChanges { target: statusBar; anchors.topMargin: -statusBar.height; visible: false}
    }

    Component.onCompleted: {
        statusBar.orientation = screen.currentOrientation
        screen.updatePlatformStatusBarRect(statusBar)
        __completed = true;
    }

    onWidthChanged: {
        updatePlatformStatusBarTimer.running = true
    }

    Timer {
        // Timer is used to update statusbarrect to avoid duplicated calls during animation,
        // also onActiveChanged coming too early
        id: updatePlatformStatusBarTimer
        repeat: false
        interval: 50
        onTriggered: {
            screen.updatePlatformStatusBarRect(statusBar);
        }
    }

    Connections {
        target: platformWindow
        onActiveChanged: {
            updatePlatformStatusBarTimer.running = true
        }
    }

    transitions: Transition {
        from: __completed ? "" : "invalid"
        to: __completed ? "hide" : "invalid"
        reversible: true
        SequentialAnimation {
            ScriptAction {
                script: updatePlatformStatusBarTimer.running = true
            }
            PropertyAnimation { target: statusBar; properties: "anchors.topMargin"; easing.type: Easing.InOutExpo; duration: 500 }
            PropertyAnimation { target: statusBar; properties: "visible"; }
            ScriptAction {
                script: updatePlatformStatusBarTimer.running = true
            }
        }
    }
}
