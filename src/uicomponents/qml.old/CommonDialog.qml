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

Dialog {
    id: genericDialog

    property string titleText: ""

    property Style platformStyle: SelectionDialogStyle {}

    //Deprecated, TODO Remove this on w13
    property alias style: genericDialog.platformStyle

    //private
    property bool __drawFooterLine: false

    title: Item {
        id: header
        height: genericDialog.platformStyle.titleBarHeight

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Item {
            id: labelField

            anchors.fill:  parent

            Item {
                id: labelWrapper
                anchors.left: labelField.left
                anchors.right: closeButton.left

                anchors.bottom:  parent.bottom
                anchors.bottomMargin: genericDialog.platformStyle.titleBarLineMargin

                //anchors.verticalCenter: labelField.verticalCenter

                height: titleLabel.height

                Label {
                    id: titleLabel
                    x: genericDialog.platformStyle.titleBarIndent
                    width: parent.width - closeButton.width
                    //anchors.baseline:  parent.bottom
                    font: genericDialog.platformStyle.titleBarFont
                    color: genericDialog.platformStyle.commonLabelColor
                    elide: genericDialog.platformStyle.titleElideMode
                    text: genericDialog.titleText
                }

            }

            Image {
                id: closeButton
                anchors.bottom:  parent.bottom
                anchors.bottomMargin: genericDialog.platformStyle.titleBarLineMargin-6
                //anchors.verticalCenter: labelField.verticalCenter
                anchors.right: labelField.right

                opacity: closeButtonArea.pressed ? 0.5 : 1.0

                source: "image://theme/icon-m-common-dialog-close"

                MouseArea {
                    id: closeButtonArea
                    anchors.fill: parent
                    onClicked:  {genericDialog.reject();}
                }

            }

        }

        Rectangle {
            id: headerLine

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.bottom:  header.bottom

            height: 1

            color: "#4D4D4D"
        }

    }

    content: Item {id: contentField}

    buttons: Item {
         id: footer

         width: parent.width
         height: childrenRect.height

         //hack to make sure, we're evaluating the correct height
         Item {
             id: lineWrapper
             width: parent.width
             height: childrenRect.height
             y: 10

             Rectangle {
                 id: footerLine

                 anchors.left: parent.left
                 anchors.right: parent.right
                 anchors.top: parent.top
                 height: genericDialog.__drawFooterLine ? 1 : 0

                 color: "#4D4D4D"
             }
         }

         //ugly hack to assure, that we're always evaluating the correct height
         Item {id: dummy; anchors.fill:  parent}

     }

}
