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

FocusScope {
    id: button

    // Common public API
    property bool checked: false
    property bool checkable: false
    property alias pressed: mouseArea.pressed
    property alias text: label.text
    property url iconSource
    property alias platformMouseAnchors: mouseArea.anchors

    signal clicked

    // Used in ButtonGroup.js to set the segmented look on the buttons.
    property string __buttonType

    // Styling for the Button
    property Style platformStyle: ButtonStyle {}

    implicitWidth: platformStyle.buttonWidth
    implicitHeight: platformStyle.buttonHeight
    width: implicitWidth

    property alias font: label.font

    // private property
    // deprecated, use positive/negative dialog instead
    property bool __dialogButton: false

    property bool __positiveDialogButton: false
    property bool __negativeDialogButton: false

    BorderImage {
        id: background
        anchors.fill: parent
        border { left: button.platformStyle.backgroundMarginLeft; top: button.platformStyle.backgroundMarginTop;
                 right: button.platformStyle.backgroundMarginRight; bottom: button.platformStyle.backgroundMarginBottom }

        source: __dialogButton ? (pressed ? button.platformStyle.pressedDialog : button.platformStyle.dialog) :
                __positiveDialogButton ? (pressed ? button.platformStyle.pressedPositiveDialog : button.platformStyle.positiveDialog) :
                __negativeDialogButton ? (pressed ? button.platformStyle.pressedNegativeDialog : button.platformStyle.negativeDialog) :
                !enabled ? (checked ? button.platformStyle.checkedDisabledBackground : button.platformStyle.disabledBackground) :
                pressed ? button.platformStyle.pressedBackground :
                checked ? button.platformStyle.checkedBackground :
                button.platformStyle.background;
    }

    Image {
        id: icon
        anchors.left: label.visible ? parent.left : undefined
        anchors.leftMargin: label.visible ? UI.MARGIN_XLARGE : 0
        anchors.centerIn: label.visible ? undefined : parent

        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -1

        source: button.iconSource

        visible: source != ""
    }

    Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: icon.visible ? icon.right : parent.left
        anchors.leftMargin: icon.visible ? UI.PADDING_XLARGE : UI.BUTTON_LABEL_MARGIN
        anchors.right: parent.right
        anchors.rightMargin: UI.BUTTON_LABEL_MARGIN

        horizontalAlignment: icon.visible ? Text.AlignLeft : button.platformStyle.horizontalAlignment
        elide: Text.ElideRight

        font.family: button.platformStyle.fontFamily
        font.weight: checked ? button.platformStyle.checkedFontWeight : button.platformStyle.fontWeight
        font.pixelSize: button.platformStyle.fontPixelSize
        font.capitalization: button.platformStyle.fontCapitalization
        color: !enabled ? button.platformStyle.disabledTextColor :
               pressed ? button.platformStyle.pressedTextColor :
               checked ? button.platformStyle.checkedTextColor :
                         button.platformStyle.textColor;
        text: ""
        visible: text != ""
    }

    MouseArea {
        id: mouseArea
        anchors {
            fill: parent
            rightMargin: (platformStyle.position != "horizontal-center"
                            && platformStyle.position != "horizontal-left") ? platformStyle.mouseMarginRight : 0
            leftMargin: (platformStyle.position != "horizontal-center"
                            && platformStyle.position != "horizontal-right") ? platformStyle.mouseMarginLeft : 0
            topMargin: (platformStyle.position != "vertical-center"
                            && platformStyle.position != "vertical-bottom") ? platformStyle.mouseMarginTop : 0
            bottomMargin: (platformStyle.position != "vertical-center"
                            && platformStyle.position != "vertical-top") ? platformStyle.mouseMarginBottom : 0
        }
	onClicked: if (button.checkable) button.checked = !button.checked
    }
    Component.onCompleted: mouseArea.clicked.connect(clicked)
}
