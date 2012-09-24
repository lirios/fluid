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
    width: screen.displayWidth
    height: screen.displayHeight

    property alias color: background.color

    default property alias content: windowContent.data

    // Read only property true if window is in portrait
    property alias inPortrait: window.portrait
    property string __previousOrientationString

    objectName: "windowRoot"

    signal orientationChangeAboutToStart
    signal orientationChangeStarted
    signal orientationChangeFinished

    // Quick & coarse rotation consistent with MTF
    function __beginTransformation() {
        snapshot.take();
        snapshot.opacity = 1.0;
        snapshotRotation.angle = -window.rotation;
        snapshot.smooth = false; 
        platformWindow.animating = true;
        root.orientationChangeAboutToStart();
    }

    function __continueTransformation() {
        windowContent.opacity = 0.0;
        root.orientationChangeStarted();
    }

    function __endTransformation() {
        windowRotation.angle = 0
        snapshot.free();
        root.orientationChangeFinished();
        platformWindow.animating = false;
    }


    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"
    }

    Item {
        id: window
        property bool portrait

    	function rotationAngle( prevOrient, orient ) {
            if ( prevOrient == orient ) return 0;
            return ( (prevOrient == "Landscape" && orient == "LandscapeInverted" )
                                              || (prevOrient == "LandscapeInverted" && orient == "Landscape" )
                                              || (prevOrient == "Portrait" && orient == "PortraitInverted" )
                                              || (prevOrient == "PortraitInverted" && orient == "Portrait" ) ) ? 180 : 90;
        }

        Component.onCompleted: {
            width = screen.platformWidth;
            height = screen.platformHeight;
            __previousOrientationString = window.state;
        }

        anchors.centerIn : parent
        transform: Rotation { id: windowRotation;
                                origin.x: 0;
                                origin.y: 0;
                                angle: 0
                            }

        Item {
            id: windowContent
            width: parent.width
            height: parent.height - heightDelta

            // Used for resizing windowContent when virtual keyboard appears
            property int heightDelta: 0

            objectName: "windowContent"
            clip: true

            Connections {
                id: inputContextConnection
                target: inputContext
                onSoftwareInputPanelVisibleChanged: inputContextConnection.updateWindowContentHeightDelta();

                onSoftwareInputPanelRectChanged: inputContextConnection.updateWindowContentHeightDelta();

                function updateWindowContentHeightDelta() {
                    if(inputContext.customSoftwareInputPanelVisible)
                        return

                    if (root.inPortrait) {
                        windowContent.heightDelta = inputContext.softwareInputPanelRect.width
                    } else {
                        if (inputContext.softwareInputPanelRect.height < window.height) 
                            windowContent.heightDelta = inputContext.softwareInputPanelRect.height                      
                        else 
                            windowContent.heightDelta = 0
                    }
                }
            }
        }

        SoftwareInputPanel {
            id: softwareInputPanel
            active: inputContext.customSoftwareInputPanelVisible
            anchors.bottom: parent.bottom

            onHeightChanged: {
                windowContent.heightDelta = height
            }

            Loader {
                id: softwareInputPanelLoader
                width: parent.width
                sourceComponent: inputContext.customSoftwareInputPanelComponent
            }
        }

        Snapshot {
            id: snapshot
            anchors.top: parent.top
            anchors.left: parent.left
            width: screen.displayWidth
            height: screen.displayHeight
            snapshotWidth: screen.displayWidth
            snapshotHeight: screen.displayHeight
            opacity: 0
            transform: Rotation { id: snapshotRotation;
                                  origin.x: screen.displayHeight / 2; origin.y: screen.displayHeight / 2;
                                  angle: 0 }
        }

        state: screen.orientationString

        onStateChanged: {
            if (inputContext.softwareInputPanelVisible) {
                root.orientationChangeAboutToStart();
                platformWindow.startSipOrientationChange(screen.rotation);
                root.orientationChangeStarted();
                relayoutingWaiter.animating = true
            }
        }


        states: [
            State {
                name: "Landscape"
                PropertyChanges { target: window; rotation: screen.rotation; portrait: screen.isPortrait; explicit: true; }
                PropertyChanges { target: window; height: screen.platformHeight; width: screen.platformWidth; explicit: true; }
                PropertyChanges { target: windowRotation;
                                  origin.x: root.height / 2;
                                  origin.y: root.height / 2; }
                PropertyChanges { target: snapshot; anchors.leftMargin: 0; anchors.topMargin: 0 }
            },
            State {
                name: "Portrait"
                PropertyChanges { target: window; rotation: screen.rotation; portrait: screen.isPortrait; explicit: true; }
                PropertyChanges { target: window; height: screen.platformHeight; width: screen.platformWidth; explicit: true; }
                PropertyChanges { target: windowRotation;
                                  origin.x: root.height - root.width / 2;
                                  origin.y: root.width / 2; }
                PropertyChanges { target: snapshot; anchors.leftMargin: 0; anchors.topMargin: 0 }
            },
            State {
                name: "LandscapeInverted"
                PropertyChanges { target: window; rotation: screen.rotation; portrait: screen.isPortrait; explicit: true; }
                PropertyChanges { target: window; height: screen.platformHeight; width: screen.platformWidth; explicit: true; }
                PropertyChanges { target: windowRotation;
                                  origin.x: root.height / 2;
                                  origin.y: root.height / 2; }
                PropertyChanges { target: snapshot; anchors.leftMargin: 374; anchors.topMargin: 0 }
            },
            State {
                name: "PortraitInverted"
                PropertyChanges { target: window; rotation: screen.rotation; portrait: screen.isPortrait; explicit: true; }
                PropertyChanges { target: window; height: screen.platformHeight; width: screen.platformWidth; explicit: true; }
                PropertyChanges { target: windowRotation;
                                  origin.x: root.height - root.width / 2;
                                  origin.y: root.width / 2; }
                PropertyChanges { target: snapshot; anchors.leftMargin: 0; anchors.topMargin: 374 }
            }
        ]

        transitions: [
        Transition {
            // use this transition when sip is visible
            from: (inputContext.softwareInputPanelVisible ?  "*" : "disabled")
            to:   (inputContext.softwareInputPanelVisible ?  "*" : "disabled")
            PropertyAction { target: window; properties: "rotation"; }
        },
        Transition {
            // use this transition when sip is not visible
            from: (screen.minimized || !screen.isDisplayLandscape ? "disabled" : (inputContext.softwareInputPanelVisible ? "disabled" : "*"))
            to:   (screen.minimized || !screen.isDisplayLandscape ? "disabled" : (inputContext.softwareInputPanelVisible ? "disabled" : "*"))
            SequentialAnimation {
                alwaysRunToEnd: true
                ScriptAction { script: __beginTransformation() }
                PropertyAction { target: window; properties: "portrait"; }
                PropertyAction { target: window; properties: "width"; }
                PropertyAction { target: window; properties: "height"; }
                ScriptAction { script: __continueTransformation() }
                ParallelAnimation {
                    NumberAnimation { target: windowContent; property: "opacity";
                                      to: 1.0; easing.type: Easing.InOutExpo; duration: 600; }
                    NumberAnimation { target: snapshot; property: "opacity";
                                      to: 0.0; easing.type: Easing.InOutExpo; duration: 600; }
                    PropertyAction { target: windowRotation; properties: "origin.x"; }
                    PropertyAction { target: windowRotation; properties: "origin.y"; }
                    RotationAnimation { target: windowRotation; property: "angle";
                                        from: -screen.rotationDirection * window.rotationAngle(__previousOrientationString, window.state);
                                        to: 0;
                                        direction: RotationAnimation.Shortest;
                                        easing.type: Easing.InOutExpo; duration: 600; }
                }
                ScriptAction { script: __endTransformation() }
            }
        }
        ]

        focus: true
        Keys.onReleased: {
            if (event.key == Qt.Key_I && event.modifiers == Qt.AltModifier) {
                theme.inverted = !theme.inverted;
            }
            if (event.key == Qt.Key_E && event.modifiers == Qt.AltModifier) {
                if(screen.currentOrientation == Screen.Landscape) {
                    screen.allowedOrientations = Screen.Portrait;
                } else if(screen.currentOrientation == Screen.Portrait) {
                    screen.allowedOrientations = Screen.LandscapeInverted;
                } else if(screen.currentOrientation == Screen.LandscapeInverted) {
                    screen.allowedOrientations = Screen.PortraitInverted;
                } else if(screen.currentOrientation == Screen.PortraitInverted) {
                    screen.allowedOrientations = Screen.Landscape;
                }
            }
            if (event.key == Qt.Key_E && event.modifiers == Qt.ControlModifier ) {
                if(screen.currentOrientation == Screen.Portrait) {
                    screen.allowedOrientations = Screen.Landscape;
                } else if(screen.currentOrientation == Screen.LandscapeInverted) {
                    screen.allowedOrientations = Screen.Portrait;
                } else if(screen.currentOrientation == Screen.PortraitInverted) {
                    screen.allowedOrientations = Screen.LandscapeInverted;
                } else if(screen.currentOrientation == Screen.Landscape) {
                    screen.allowedOrientations = Screen.PortraitInverted;
                }
            }
        }

        Item {
            // Item for requesting finish of orientation change animation, when
            // VKB is open.
            id: relayoutingWaiter

            property bool animating: false
            property variant softwareInputPanelRect : inputContext.softwareInputPanelRect

            onSoftwareInputPanelRectChanged: {
                if (animating) {
                    animating = false
                    relayoutingTimer.running = true
                }
            }

            Timer {
                // Timer is triggered after window's contents have been
                // relayouted.
                id: relayoutingTimer;
                interval: 10
                onTriggered: {
                    inputContext.update();
                    platformWindow.finishSipOrientationChange(window.rotation);
                    root.orientationChangeFinished();
                }
            }
        }
    }
    onOrientationChangeFinished: __previousOrientationString = screen.orientationString;
}
