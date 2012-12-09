/****************************************************************************
**
** Copyright (C) 2011 Marco Martin  <mart@kde.org>
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
        The item that the dialog refers to. The dialog will usually be positioned relative to VisualParent

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
        Accepts the dialog's request without any user interaction. The method emits the accepted() signal and closes the internalLoader.dialog.
        See also reject().

        void close():
        Closes the dialog without any user interaction.

        void open():
        Shows the dialog to the user.

        void reject():
        Rejects the dialog's request without any user interaction. The method emits the rejected() signal and closes the internalLoader.dialog.
        See also accept().
**/

import QtQuick 2.0
import QtQuick.Window 2.0
import FluidCore 1.0
import "private/AppManager.js" as Utils
import "private" as Private

Item {
    id: root

    property alias title: titleBar.children
    property alias content: contentItem.children
    property alias buttons: buttonItem.children
    property Item visualParent
    property int status: DialogStatus.Closed


    property alias privateTitleHeight: titleBar.height
    property alias privateButtonsHeight: buttonItem.height

    signal accepted
    signal rejected
    signal clickedOutside

    function open() {
        dialogLayout.parent = internalLoader.item.mainItem

        if (internalLoader.dialog) {
            var pos = internalLoader.dialog.popupPosition(root.visualParent, Qt.AlignCenter)
            internalLoader.dialog.x = pos.x
            internalLoader.dialog.y = pos.y

            internalLoader.dialog.visible = true
            internalLoader.dialog.activateWindow()
        } else {
            internalLoader.inlineDialog.open()
        }
    }

    function accept() {
        if (status == DialogStatus.Open) {
            if (internalLoader.dialog) {
                internalLoader.dialog.visible = false
            } else {
                internalLoader.inlineDialog.close()
            }
            accepted()
        }
    }

    function reject() {
        if (status == DialogStatus.Open) {
            if (internalLoader.dialog) {
                internalLoader.dialog.visible = false
            } else {
                internalLoader.inlineDialog.close()
            }
            rejected()
        }
    }

    function close() {
        if (internalLoader.dialog) {
            internalLoader.dialog.visible = false
        } else {
            internalLoader.inlineDialog.close()
        }
    }

    visible: false

    Loader {
        id: internalLoader
        //the root item of the scene. Determines if there is enough room for an inline dialog
        property Item rootItem

        //this is when the dialog is a separate window
        property Item dialog: sourceComponent == dialogComponent ? item : null
        //this is when the dialog is inline
        property Item inlineDialog: sourceComponent == inlineDialogComponent ? item : null

        property bool loadCompleted: false

        Component.onCompleted: {
            rootItem = Utils.rootObject()
            loadCompleted = true
        }

        sourceComponent: {
            if (loadCompleted) {
                if (rootItem == null || dialogLayout.width > rootItem.width || dialogLayout.height > rootItem.height) {
                    dialogComponent
                } else {
                    inlineDialogComponent
                }
            }
        }
    }

    Component {
        id: dialogComponent
        Window {
            flags: Qt.Popup

            //state: "Hidden"
            visible: false
            onVisibleChanged: {
                if (visible) {
                    root.status = DialogStatus.Open
                } else {
                    root.status = DialogStatus.Closed
                }
            }

            Item {
                id: dialogMainItem
                width: dialogLayout.width
                height: dialogLayout.height
            }

            Component.onCompleted: dialogLayout.parent = dialogMainItem
            Component.onDestruction: dialogLayout.parent = root
        }
    }

    Component {
        id: inlineDialogComponent
        Private.InlineDialog {
            id: inlineDialog
            visualParent: root.visualParent
            property Item mainItem: inlineDialogMainItem
            onStatusChanged: root.status = status

            Item {
                id: inlineDialogMainItem
                width: dialogLayout.width
                height: dialogLayout.height
            }

            Component.onCompleted: {
                dialogLayout.parent = inlineDialogMainItem
            }
            Component.onDestruction: dialogLayout.parent = root
        }
    }

    Item {
        id: dialogLayout
        width: Math.max(buttonItem.childrenRect.width,  Math.min(contentItem.childrenRect.width, theme.defaultFont.mSize.width * 30))
        height: titleBar.height + contentItem.childrenRect.height + buttonItem.childrenRect.height + 10

        parent: internalLoader.dialog ? internalLoader.dialog : internalLoader.inlineDialog
        // Consume all key events that are not processed by children
        Keys.onPressed: event.accepted = true
        Keys.onReleased: event.accepted = true

        Item {
            id: titleBar

            height: children.length > 0 && children[0].visible ? childrenRect.height : 0
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }

        Item {
            id: contentItem

            clip: true
            anchors {
                top: titleBar.bottom
                left: parent.left
                right: parent.right
                bottom: buttonItem.top
                bottomMargin: 6
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
}
