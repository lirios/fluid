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

    // Common API
    default property alias content: contentField.children

    // Common API inherited from Popup:
    /*
        function open()
        function close()

        property Item visualParent
        property int status
    */

    // platformStyle API
    property Style platformStyle: MenuStyle{}
    property alias style: root.platformStyle // Deprecated
    property alias platformTitle: titleBar.children
    property alias title: titleBar.children // Deprecated
    property alias __footer: footerBar.children

    // private api
    property int __statusBarDelta: visualParent ? 0 :
                 __findItem( "appWindowContent") != null ? 0 :
                 __findItem( "pageStackWindow") != null && __findItem( "pageStackWindow").showStatusBar ? 36 : 0

    property string __animationChief: "abstractMenu"
    property int __pressDelay: platformStyle.pressDelay
    property alias __statesWrapper: statesWrapper
    property alias __menuPane: menuPane

    // This item will find the object with the given objectName ... or will return
    function __findItem( objectName ) {
        var next = parent;

        if (next != null) {
            while (next) {
                if(next.objectName == objectName){
                    return next;
                }

                next = next.parent;
            }
        }

        return null;
    }

    __dim: platformStyle.dim
    __fadeInDuration: platformStyle.fadeInDuration
    __fadeOutDuration: platformStyle.fadeOutDuration
    __fadeInDelay: platformStyle.fadeInDelay
    __fadeOutDelay: platformStyle.fadeOutDelay
    __faderBackground: platformStyle.faderBackground
    __fadeInEasingType: platformStyle.fadeInEasingType
    __fadeOutEasingType: platformStyle.fadeOutEasingType

    anchors.fill: parent

    // When application is minimized menu is closed.
    Connections {
        target: platformWindow
        onActiveChanged: {
            if(!platformWindow.active)
                close()
        }
    }

    // This is needed for menus which are not instantiated inside the
    // content window of the PageStackWindow:
    Item {
        id: roundedCorners
        visible: root.status != DialogStatus.Closed && !visualParent
                 && __findItem( "pageStackWindow") != null && __findItem( "pageStackWindow").platformStyle.cornersVisible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height - __statusBarDelta - 2
        z: 10001

        // compensate for the widening of the edges of the fader (which avoids artefacts during rotation)
        anchors.topMargin:    +1
        anchors.rightMargin:  +1
        anchors.bottomMargin: +1
        anchors.leftMargin:   +1

        Image {
            anchors.top : parent.top
            anchors.left: parent.left
            source: "image://theme/meegotouch-applicationwindow-corner-top-left"
        }
        Image {
            anchors.top: parent.top
            anchors.right: parent.right
            source: "image://theme/meegotouch-applicationwindow-corner-top-right"
        }
        Image {
            anchors.bottom : parent.bottom
            anchors.left: parent.left
            source: "image://theme/meegotouch-applicationwindow-corner-bottom-left"
        }
        Image {
            anchors.bottom : parent.bottom
            anchors.right: parent.right
            source: "image://theme/meegotouch-applicationwindow-corner-bottom-right"
        }
    }

    // Shadows:
    Image {
        anchors.top : menuPane.top
        anchors.right: menuPane.left
        anchors.bottom : menuPane.bottom
        source: "image://theme/meegotouch-menu-shadow-left"
        visible: root.status != DialogStatus.Closed
    }
    Image {
        anchors.bottom : menuPane.top
        anchors.left: menuPane.left
        anchors.right : menuPane.right
        source: "image://theme/meegotouch-menu-shadow-top"
        visible: root.status != DialogStatus.Closed
    }
    Image {
        anchors.top : menuPane.top
        anchors.left: menuPane.right
        anchors.bottom : menuPane.bottom
        source: "image://theme/meegotouch-menu-shadow-right"
        visible: root.status != DialogStatus.Closed
    }
    Image {
        anchors.top : menuPane.bottom
        anchors.left: menuPane.left
        anchors.right : menuPane.right
        source: "image://theme/meegotouch-menu-shadow-bottom"
        visible: root.status != DialogStatus.Closed
    }

    Item {
        id: menuPane
        //ToDo: add support for layoutDirection Qt::RightToLeft
        x: platformStyle.leftMargin
        width:  parent.width  - platformStyle.leftMargin - platformStyle.rightMargin  // ToDo: better width heuristic
        height: (screen.currentOrientation == 1) || (screen.currentOrientation == 4) ?
                /* Portrait  */ titleBar.height + flickableContent.height + footerBar.height :
                /* Landscape */ parent.height - platformStyle.topMargin - platformStyle.bottomMargin - __statusBarDelta
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        state: __statesWrapper.state

        // Acts as debounce during orientation change.
        Behavior on height {NumberAnimation {duration:1}}

        BorderImage {
           id: backgroundImage
           source: // !enabled ? root.platformStyle.disabledBackground :
                   root.platformStyle.background
           anchors.fill : parent
           verticalTileMode : BorderImage.Repeat
           border { left: 22; top: theme.inverted ? 124 : 22;
                    right: 22; bottom: theme.inverted ? 2 : 22 }
        }

        // this item contains the whole menu (content rectangle)
        Item {
            id: backgroundRect
            anchors.fill: parent

                Item {
                    id: titleBar
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: childrenRect.height
                }

                Item {
                    // Required to have the ScrollDecorator+Flickable handled
                    // by the column as a single item while keeping the
                    // ScrollDecorator working
                    id: flickableContent
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.top: backgroundRect.top
                    anchors.topMargin: titleBar.height
                    property int maxHeight : visualParent
                                             ? visualParent.height - platformStyle.topMargin - __statusBarDelta
                                               - footerBar.height - titleBar.height
                                             : root.parent
                                                     ? root.parent.height - platformStyle.topMargin - __statusBarDelta
                                                       - footerBar.height - titleBar.height
                                                     : 350

                    height: contentField.childrenRect.height + platformStyle.topPadding + platformStyle.bottomPadding < maxHeight
                            ? contentField.childrenRect.height + platformStyle.topPadding + platformStyle.bottomPadding
                            : maxHeight

                    Flickable {
                        id: flickable
                        anchors.fill: parent
                        contentWidth: parent.width
                        contentHeight: contentField.childrenRect.height + platformStyle.topPadding + platformStyle.bottomPadding
                        interactive: contentHeight > flickable.height
                        flickableDirection: Flickable.VerticalFlick
                        pressDelay: __pressDelay
                        clip: true

                        Item {
                            id: contentRect
                            height: contentField.childrenRect.height

                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.topMargin: platformStyle.topPadding
                            anchors.bottomMargin: platformStyle.bottomPadding
                            anchors.leftMargin: platformStyle.leftPadding
                            anchors.rightMargin: platformStyle.rightPadding

                            Item {
                                id: contentField
                                anchors.fill: contentRect

                                function closeMenu() { root.close(); }
                            }
                        }
                    }
                    ScrollDecorator {
                        id: scrollDecorator
                        flickableItem: flickable
                    }
                }

                Item {
                    id: footerBar
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.top: backgroundRect.top
                    anchors.topMargin: titleBar.height + flickableContent.height
                    height: childrenRect.height
                }

        }
    }

    onPrivateClicked: close() // "reject()"

    StateGroup {
        id: statesWrapper

        state: "hidden"

        states: [
            State {
                name: "visible"
                when: root.__animationChief == "abstractMenu" && (root.status == DialogStatus.Opening || root.status == DialogStatus.Open)
                PropertyChanges {
                    target: __menuPane
                    opacity: 1.0
                }
            },
            State {
                name: "hidden"
                when: root.__animationChief == "abstractMenu" && (root.status == DialogStatus.Closing || root.status == DialogStatus.Closed)
                PropertyChanges {
                    target: __menuPane
                    opacity: 0.0
                }
            }
        ]

    }
}
