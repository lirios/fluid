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

AbstractMenu {
    id: root

    // API
    property string platformTitleText
    property string titleText
    property url platformIcon
    property url icon

    // platformStyle API
    property Style platformStyle: ContextMenuStyle{}
    property Style style:         ContextMenuStyle{}

    onPlatformTitleTextChanged: logDeprecatedMsg("platformTitleText")
    onTitleTextChanged:         logDeprecatedMsg("titleText")
    onPlatformIconChanged:      logDeprecatedMsg("platformIcon")
    onIconChanged:              logDeprecatedMsg("iconChanged")
    onPlatformStyleChanged:     logDeprecatedMsg("platformStyle")
    onStyleChanged:             logDeprecatedMsg("style")

    function logDeprecatedMsg(name) {
        console.log("Warning: " + name + " is deprecated");
    }

    function __beginTransformationToHidden() {
        __fader().state = "hidden";
        root.status = DialogStatus.Closing;
    }

    function __beginTransformationToVisible() {
        __fader().state = "visible";
        root.status = DialogStatus.Opening;
        __menuPane.anchors.rightMargin = 0;
        __menuPane.anchors.bottomMargin = 0;
    }

    __statesWrapper.transitions: [
        Transition {
            from: "visible"; to: "hidden"
            SequentialAnimation {
                ScriptAction {script: __beginTransformationToHidden()}

                NumberAnimation {target: __menuPane;
                              property: screen.currentOrientation == Screen.Portrait ? "anchors.bottomMargin" : "anchors.rightMargin";
                              easing.type: Easing.InOutQuint;
                              to: screen.currentOrientation == Screen.Portrait ? -__menuPane.height : -__menuPane.width;
                              from: 0; duration: 350}

                NumberAnimation {target: __menuPane; property: "opacity";
                              from: 1.0; to: 0.0; duration: 0}

                ScriptAction {script: status = DialogStatus.Closed}
            }
        },
        Transition {
            from: "hidden"; to: "visible"
            SequentialAnimation {
                ScriptAction {script: __beginTransformationToVisible()}

                NumberAnimation {target: __menuPane;
                                 property: screen.currentOrientation == Screen.Portrait ? "anchors.bottomMargin" : "anchors.rightMargin";
                                 easing.type: Easing.InOutQuint;
                                 from: screen.currentOrientation == Screen.Portrait ? -__menuPane.height : -__menuPane.width;
                                 to: 0; duration: 350}

                ScriptAction {script: status = DialogStatus.Open}
            }
        }
    ]
}
