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

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import "private" as Private
import "." 1.0


/**Documented API
Inherits:
        Dialog

Imports:
        QtQuick 2.0
        FluidCore

Description:
        CommonDialog is a convenience component that provides a dialog with the platform-style title area. You only have to define titleText. CommonDialog handles its layout automatically.
        Note: This component is experimental, so it may be changed or removed in future releases.

Properties:
        string titleText:
        the title of the dialog.

        string titleIcon:
        the name or path of the dialog title icon

        Array variant buttonTexts:
        the texts of all the buttons

Signals:
        buttonClicked(int index):
        Emitted when the user clicks on a button
        @arg int index: the index of the clicked button: buttonTexts[index] will hold the text of the clicked button.

**/
Dialog {
    id: root

    property alias titleText: titleAreaText.text
    property string titleIcon
    property variant buttonTexts: []

    signal buttonClicked(int index)

    onButtonTextsChanged: {
        for (var i = buttonRow.children.length; i > 0; --i) {
            buttonRow.children[i - 1].destroy()
        }
        for (var j = 0; j < buttonTexts.length; ++j) {
            var button = buttonComponent.createObject(buttonRow)
            button.text = buttonTexts[j]
            button.index = j
        }
    }

    Component {
        id: buttonComponent
        Button {
            property int index

            onClicked: {
                if (root.status == DialogStatus.Open) {
                    root.buttonClicked(index)
                    root.close()
                }
            }
        }
    }

    QtObject {
        id: internal

        /*function buttonWidth() {
            switch (buttonTexts.length) {
                case 0: return 0
                case 1: return Math.round((800 - 3 * 4) / 2)
                default: return (buttonContainer.width - (buttonTexts.length + 1) *
                    4) / buttonTexts.length
            }
        }*/

        function iconSource() {
            return root.titleIcon
        }
    }

    title: FluidCore.FrameSvgItem {
        imagePath: "widgets/extender-dragger"
        prefix: "root"
        anchors.left: parent.left
        anchors.right: parent.right
        //FIXME: +5 because of Plasma::Dialog margins
        height: titleAreaText.paintedHeight + margins.top + margins.bottom

        LayoutMirroring.childrenInherit: true

        Column {
            id: titleLayoutHelper // needed to make the text mirror correctly

            anchors {
                right: parent.right
                left: titleAreaIcon.source == "" ? parent.left : titleAreaIcon.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: parent.margins.left
                rightMargin: parent.margins.right
                topMargin: parent.margins.top
                bottomMargin: parent.margins.bottom
            }

            Label {
                id: titleAreaText
                LayoutMirroring.enabled: root.LayoutMirroring.enabled
                elide: Text.ElideRight
                height: paintedHeight
                anchors {
                    left: parent.left
                    right: parent.right
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Private.IconLoader {
            id: titleAreaIcon
            width: theme.iconSizeSmall
            height: theme.iconSizeSmall
            source: titleIcon
            anchors.left: parent.left
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    buttons: Row {
        id: buttonRow

        LayoutMirroring.enabled: false
        LayoutMirroring.childrenInherit: true
        objectName: "buttonRow"
        anchors.centerIn: parent
        spacing: 4
    }
}
