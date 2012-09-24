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

ImplicitSizeItem {
    id: checkbox

    property Style platformStyle: CheckBoxStyle{}
    property alias platformMouseAnchors: mouseArea.anchors

    //Deprecated, TODO Remove this on w13
    property alias style: checkbox.platformStyle

    property string text
    property bool checked: false
    property bool pressed
    signal clicked

    implicitWidth: image.width + body.spacing + label.implicitWidth
    implicitHeight: body.height

    onWidthChanged: if (width > 0 && width != implicitWidth)
                        label.width = checkbox.width - body.spacing - image.width

    Binding {
        target: checkbox
        property: "pressed"
        value: mouseArea.pressed && mouseArea.containsMouse
    }

    property alias __imageSource: image.source

    function __handleChecked() {
        checkbox.checked = !checkbox.checked;
    }

    Row {
        id: body
        spacing: 15

        BorderImage {
            id: image
            smooth: true

            width: 42; height: 42

            source: !checkbox.enabled ? platformStyle.backgroundDisabled :
                    checkbox.pressed ? platformStyle.backgroundPressed :
                    checkbox.checked ? platformStyle.backgroundSelected :
                    platformStyle.background

            border {
                left: 4
                top: 4
                right: 4
                bottom: 4
            }
        }

        Label {
            id: label
            anchors.verticalCenter: image.verticalCenter
            text: checkbox.text
            elide: checkbox.platformStyle.elideMode
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: body
        anchors.topMargin: platformStyle.mouseMarginTop
        anchors.leftMargin: platformStyle.mouseMarginLeft
        anchors.rightMargin: platformStyle.mouseMarginRight
        anchors.bottomMargin: platformStyle.mouseMarginBottom

        onPressed: {
            // TODO: enable feedback without old themebridge
            // if (checkbox.checked)
            //     meegostyle.feedback("pressOnFeedback");
            // else
            //     meegostyle.feedback("pressOffFeedback");
        }

        onClicked: {
            __handleChecked();
            // TODO: enable feedback without old themebridge
            // if (checkbox.checked)
            //     meegostyle.feedback("releaseOnFeedback");
            // else
            //     meegostyle.feedback("releaseOffFeedback");
        }
    }
    Component.onCompleted: mouseArea.clicked.connect(clicked)
}
