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

Popup {
    id: root
    objectName: "baseDialog"

    // API
    property alias title: titleBar.children
    property alias content: contentField.children
    property alias buttons: buttonRow.children

    signal accepted
    signal rejected

    property Style platformStyle: DialogStyle {}

    //Deprecated, TODO Remove this on w13
    property alias style: root.platformStyle

    // private api
    property string __animationChief: "baseDialog"
    __dim: platformStyle.dim
    __fadeInDuration:  platformStyle.fadeInDuration
    __fadeOutDuration: platformStyle.fadeOutDuration
    __fadeInDelay:     platformStyle.fadeInDelay
    __fadeOutDelay:    platformStyle.fadeOutDelay

    // true: center of the content field is center of the background rect
    // false: the whole dialog is centered
    property bool __centerContentField: false

    width:  parent.width - platformStyle.leftMargin - platformStyle.rightMargin  // ToDo: better width heuristic
    height: titleBar.height + contentField.height + buttonRow.height

    anchors.centerIn: parent

    function reject() {
        close();
        rejected();
    }

    function accept() {
        close();
        accepted();
    }

    function __beginTransformationToHidden() {
        __fader().state = "hidden";

        backgroundRect.opacity = 1.0;
        contentField.opacity = 1.0
        root.opacity = 1.0

        statesWrapper.__buttonSaver = buttonRow.y
        statesWrapper.__titleSaver = titleBar.y
        root.status = DialogStatus.Closing;
    }

    // reset button and title bar
    // make sure, root isn't visible
    function __endTransformationToHidden() {
        buttonRow.y = statesWrapper.__buttonSaver
        titleBar.y = statesWrapper.__titleSaver
        backgroundRect = 0.0;
        root.opacity = 0.0;
        status = DialogStatus.Closed;
    }

    function __beginTransformationToVisible() {
        __fader().state = "visible";
        statesWrapper.__buttonSaver = buttonRow.y
        statesWrapper.__titleSaver = titleBar.y

        root.status = DialogStatus.Opening;
        // UPPERCASE-UGLY, but necessary to avoid flicker
        root.opacity = 1.0;
        backgroundRect.opacity = 1.0;
        titleBar.opacity = 0.0;
        contentField.opacity = 0.0;
        buttonRow.opacity = 0.0;
    }

    // reset button and title bar   
    function __endTransformationToVisible() {
        buttonRow.y = statesWrapper.__buttonSaver
        titleBar.y   = statesWrapper.__titleSaver
        root.status = DialogStatus.Open;
    }

    transform: Scale {
        id: contentScale
        xScale: 1.0; yScale: 1.0
        origin.x:  mapFromItem(root, root.width / 2, root.height / 2).x
        origin.y: mapFromItem(root, root.width / 2, root.height / 2).y

    }

    // this item contains the whole dialog (title bar + content rectangle, button row)
    Item {
        id: backgroundRect

        height:  root.height
        width: root.width

        anchors.centerIn:  root

        // center the whole dialog, not just the content field
        transform: Translate {
            id: contentTranslation
            y: root.__centerContentField ? 0 : (titleBar.height - buttonRow.height) / 2
        }


        // title bar
        Item {
            id: titleBar

            width: root.width
            height: childrenRect.height

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: contentField.top

            // animate over bottomMargin (i.e. the distance between the content field)
            anchors.bottomMargin: 0

        }

        //content area
        Item {
            id: contentField

            anchors.left: parent.left
            //anchors.right: parent.right

           anchors.horizontalCenter: backgroundRect.horizontalCenter
           anchors.verticalCenter: backgroundRect.verticalCenter

           height: childrenRect.height
        }

        //button row
        Item {
            id: buttonRow

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.top: contentField.bottom

            // animate over topMargin (i.e. the distance between the content field)
            anchors.topMargin: 0

            height: childrenRect.height
        }

    }

    onPrivateClicked:  if (!__platformModal) reject();

    StateGroup {
        id: statesWrapper

        state: "hidden"

        // needed for button and title bar animation
        // without resetting the button row's/title bar's coordinate system would be translated
        property int __buttonSaver: buttonRow.y
        property int __titleSaver: titleBar.y


        states: [
            State {
                name: "visible"
                when: root.__animationChief == "baseDialog" && (status == DialogStatus.Opening || status == DialogStatus.Open)
                PropertyChanges {
                    target: backgroundRect
                    opacity: 1.0
                }
            },
            State {
                name: "hidden"
                when: root.__animationChief == "baseDialog" && (status == DialogStatus.Closing || status == DialogStatus.Closed)
                PropertyChanges {
                    target: backgroundRect
                    opacity: 0.0
                }
            }
        ]

        transitions: [
            Transition {
                from: "visible"; to: "hidden"
                SequentialAnimation {
                    ScriptAction {script: __beginTransformationToHidden()}

                    NumberAnimation { target: backgroundRect; properties: "opacity"; from: 0.0; to: 1.0; duration: 0 }
                    NumberAnimation { target: contentField; properties: "opacity"; from: 0.0; to: 1.0; duration: 0 }
                    NumberAnimation { target: root; properties: "opacity"; from: 0.0; to: 1.0; duration: 0 }

                    // The closing transition fades out the dialog's content from 100% to 0%,
                    // scales down the content to 80% anchored in the center over 175msec, quintic ease in,
                    // then, after a 175ms delay the background fades to alpha 0% (350ms, quintic ease out).
                    // (background fading is done in Fader.qml)

                    SequentialAnimation {
                        ParallelAnimation {
                            PropertyAnimation {target: buttonRow; properties: "opacity"; from: 1.0; to: 0.0; duration: 175; easing.type: Easing.InQuint; }
                            PropertyAnimation {target: titleBar; properties: "opacity"; from: 1.0; to: 0.0; duration: 175; easing.type: Easing.InQuint; }
                            PropertyAnimation {target: contentField; properties: "opacity"; from: 1.0; to: 0.0; duration: 175; easing.type: Easing.InQuint; }
                            PropertyAnimation {target: contentScale; properties: "xScale,yScale"; from: 1.0 ; to: 0.8; duration: 175; easing.type: Easing.InQuint; }
                        }
                    }

                    ScriptAction {script: __endTransformationToHidden()}
                }
            },
            Transition {
                from: "hidden"; to: "visible"
                SequentialAnimation {
                    ScriptAction {script: __beginTransformationToVisible()}           

                    // The opening transition fades in from 0% to 100% and at the same time
                    // scales in the content from 80% to 100%, anchored in the center
                    // cubic ease out). --> Done inside the fader

                    ParallelAnimation {
                        PropertyAnimation {target: root; properties: "opacity"; from: 0.0; to: 1.0; duration: 350; easing.type: Easing.OutCubic; }
                        PropertyAnimation {target: buttonRow; properties: "opacity"; from: 0.0; to: 1.0; duration: 350; easing.type: Easing.OutCubic; }
                        PropertyAnimation {target: titleBar; properties: "opacity"; from: 0.0; to: 1.0; duration: 350; easing.type: Easing.OutCubic; }
                        PropertyAnimation {target: contentField; properties: "opacity"; from: 0.0; to: 1.0; duration: 350; easing.type: Easing.OutCubic; }
                        PropertyAnimation {target: contentScale; properties: "xScale,yScale"; from: 0.8 ; to: 1.0; duration: 350; easing.type: Easing.OutCubic; }
                    }

                    ScriptAction {script: __endTransformationToVisible()}
                }
            }
        ]
    }
}
