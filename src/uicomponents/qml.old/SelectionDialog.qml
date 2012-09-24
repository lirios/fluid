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

CommonDialog {
    id: root

    // Common API
    property alias model: selectionListView.model
    property int deselectedIndex: -1   // read & write
    property int selectedIndex: -1   // read & write
    //property string titleText: "Selection Dialog"


    property Component delegate:          // Note that this is the default delegate for the list
        Component {
            id: defaultDelegate

            Item {
                id: delegateItem
                property bool selected: index == selectedIndex;

                height: root.platformStyle.itemHeight
                anchors.left: parent.left
                anchors.right: parent.right

    // Legacy. "name" used to be the role which was used by delegate
    // "modelData" available for JS array and for models with one role
    // C++ models have "display" role available always
   function __setItemText() {
       try {
           itemText.text = name
       } catch(err) {
           try {
               itemText.text = modelData
           } catch (err) {
               itemText.text = display
           }
       }
   }


                MouseArea {
                    id: delegateMouseArea
                    anchors.fill: parent;
                    onPressed: {
                        deselectedIndex = selectedIndex;
                        selectedIndex = index;
                    }
                    onClicked:  accept();
                }

                Rectangle {
                    id: backgroundRect
                    anchors.fill: parent
                    color: delegateItem.selected ? root.platformStyle.itemSelectedBackgroundColor : root.platformStyle.itemBackgroundColor
                }

                BorderImage {
                    id: background
                    anchors.fill: parent
                    border { left: UI.CORNER_MARGINS; top: UI.CORNER_MARGINS; right: UI.CORNER_MARGINS; bottom: UI.CORNER_MARGINS }
                    source: delegateMouseArea.pressed ? root.platformStyle.itemPressedBackground :
                            delegateItem.selected ? root.platformStyle.itemSelectedBackground :
                            root.platformStyle.itemBackground
                }

                Text {
                    id: itemText
                    elide: Text.ElideRight
                    color: delegateItem.selected ? root.platformStyle.itemSelectedTextColor : root.platformStyle.itemTextColor
                    anchors.verticalCenter: delegateItem.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: root.platformStyle.itemLeftMargin
                    anchors.rightMargin: root.platformStyle.itemRightMargin
                    text: modelData
                    font: root.platformStyle.itemFont
                }

                Component.onCompleted: __setItemText() 
            }
        }

    onStatusChanged: {
      if (status == DialogStatus.Opening && selectedIndex >= 0) {
          selectionListView.positionViewAtIndex(selectedIndex, ListView.Center)
      }
    }

    // Style API
    property Style platformStyle: SelectionDialogStyle {}

    //Deprecated, TODO Remove this on w13
    property alias style: root.platformStyle

    // private api
    property int __pressDelay: platformStyle.pressDelay

    // the title field consists of the following parts: title string and
    // a close button (which is in fact an image)
    // it can additionally have an icon
    titleText:"Selection Dialog"

    // the content field which contains the selection content
    content: Item {

        id: selectionContent
        property int listViewHeight
        property int maxListViewHeight : visualParent
        ? visualParent.height * 0.87
                - root.platformStyle.titleBarHeight - root.platformStyle.contentSpacing - 50
        : root.parent
                ? root.parent.height * 0.87
                        - root.platformStyle.titleBarHeight - root.platformStyle.contentSpacing - 50
                : 350
        height: listViewHeight > maxListViewHeight ? maxListViewHeight : listViewHeight
        width: root.width
        y : root.platformStyle.contentSpacing

        ListView {
            id: selectionListView
            model: ListModel {}

            currentIndex : -1
            anchors.fill: parent
            delegate: root.delegate
            focus: true
            clip: true
            pressDelay: __pressDelay

            ScrollDecorator {
                id: scrollDecorator
                flickableItem: selectionListView
                platformStyle.inverted: true
            }
            onCountChanged: selectionContent.listViewHeight = (typeof model.count === 'undefined' ? model.length : model.count) * platformStyle.itemHeight
            onModelChanged: selectionContent.listViewHeight = (typeof model.count === 'undefined' ? model.length : model.count) * platformStyle.itemHeight
        }

    }
}


