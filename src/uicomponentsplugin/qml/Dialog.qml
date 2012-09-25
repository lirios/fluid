/****************************************************************************
**
** Copyright (C) 21.0 Marco Martin  <mart@kde.org>
**
** Copyright (C) 21.0 Nokia Corporation and/or its subsidiary(-ies).
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

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0
        FluidCore

Description:
        Provides a top-level window for short-term tasks and brief interaction with the user.
        A dialog floats on the top layer of the application view, usually overlapping the area reserved for the application content. Normally, a dialog provides information and gives warnings to the user, or asks the user to answer a question or select an option.

Properties:
        list<Item> buttons:
        A list of items in the dialog's button area. For example, you can use Row or Button components but you can also use any number of components that are based on Item component.

        list<Item> content:
        A list of items in the dialog's content area. You can use any component that is based on Item. For example, you can use ListView, so that the user can select from a list of names.

        int status:
        Indicates the dialog's phase in its life cycle. The values are as follows:
            - DialogStatus.Opening - the dialog is opening
            - DialogStatus.Open - the dialog is open and visible to the user
            - DialogStatus.Closing - the dialog is closing
            - DialogStatus.Closed - the dialog is closed and not visible to the user
        The dialog's initial status is DialogStatus.Closed.

        list<Item> title:
        A list of items in the dialog's title area. You can use a Text component but also any number of components that are based on Item. For example, you can use Text and Image components.

        Item visualParent:
        The item that is dimmed when the dialog opens. By default the root parent object is visualParent.

Signals:
        accepted():
        This signal is emitted when the user accepts the dialog's request or the accept() method is called.
        See also rejected().

        clickedOutside(): This signal is emitted when the user taps in the area that is inside the dialog's visual parent area but outside the dialog's area. Normally the visual parent is the root object. In that case this signal is emitted if the user taps anywhere outside the dialog's area.
        See also visualParent.

        rejected():
        This signal is emitted when the user rejects the dialog's request or the reject() method is called.
        See also accepted().

Methods:
        void accept():
        Accepts the dialog's request without any user interaction. The method emits the accepted() signal and closes the dialog.
        See also reject().

        void close():
        Closes the dialog without any user interaction.

        void open():
        Shows the dialog to the user.

        void reject():
        Rejects the dialog's request without any user interaction. The method emits the rejected() signal and closes the dialog.
        See also accept().
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import "private/AppManager.js" as Utils
import "." 1.0

Item {
    id: root

    property alias title: titleBar.children
    property alias content: contentItem.children
    property alias buttons: buttonItem.children
//    property alias visualParent: dialog.visualParent
    property int status: DialogStatus.Closed


    property alias privateTitleHeight: titleBar.height
    property alias privateButtonsHeight: buttonItem.height

    signal accepted
    signal rejected
    signal clickedOutside

    function open()
    {
        var pos = dialog.popupPosition(null, Qt.AlignCenter)
        dialog.x = pos.x
        dialog.y = pos.y

        dialog.visible = true
        dialog.activateWindow()
    }

    function accept()
    {
        if (status == DialogStatus.Open) {
            dialog.visible = false
            accepted()
        }
    }

    function reject() {
        if (status == DialogStatus.Open) {
            dialog.visible = false
            rejected()
        }
    }

    function close() {
        dialog.visible = false
    }

    visible: false

    FluidCore.Dialog {
        id: dialog
        windowFlags: Qt.Dialog


        //onFaderClicked: root.clickedOutside()
        property Item rootItem

        //state: "Hidden"
        visible: false
        onVisibleChanged: {
            if (visible) {
                status = DialogStatus.Open
            } else {
                status = DialogStatus.Closed
            }
        }

        mainItem: Item {
            id: mainItem
            width: theme.defaultFont.mSize.width * 40
            height: titleBar.childrenRect.height + contentItem.childrenRect.height + buttonItem.childrenRect.height + 8

            // Consume all key events that are not processed by children
            Keys.onPressed: event.accepted = true
            Keys.onReleased: event.accepted = true

            Item {
                id: titleBar

                height: childrenRect.height
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
            }

            Item {
                id: contentItem

                onChildrenRectChanged: mainItem.width = Math.max(childrenRect.width, buttonItem.childrenRect.width)

                clip: true
                anchors {
                    top: titleBar.bottom
                    left: parent.left
                    right: parent.right
                    bottom: buttonItem.top
                    bottomMargin: 8
                }
            }

            Item {
                id: buttonItem

                height: childrenRect.height
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 4
                }
            }
        }

        Component.onCompleted: {
            rootItem = Utils.rootObject()
        }
    }
}
