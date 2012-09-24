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
import "UIConstants.js" as UI

DialogStyle {
    property alias titleBarFont: titleText.font
    property int titleBarHeight: 44
    property color titleBarColor: "white"
    property int titleBarIndent: 17
    property int titleBarLineMargin: 10

    property bool __portrait: (screen.currentOrientation == 1) || (screen.currentOrientation == 4)

    property int leftMargin:  __portrait ? 11 : 160
    property int rightMargin: __portrait ? 11 : 160

    property alias itemFont: itemText.font
    property int fontXLarge: 32
    property int fontLarge: 28
    property int fontDefault: 24
    property int fontSmall: 20
    property int fontXSmall: 18
    property int fontXXSmall: 16

    property color colorForeground: "#191919"
    property color colorSecondaryForeground: "#8c8c8c"
    property color colorBackground: "#ffffff"
    property color colorSelect: "#7fb133"

    property color commonLabelColor: "white"

    property int itemHeight: 64
    property color itemTextColor: "white"
    property color itemSelectedTextColor: "white"
    property int itemLeftMargin: 16
    property int itemRightMargin: 16

    property int contentSpacing: 10

    property int pressDelay: 350 // ms

    // Background
    property url itemBackground: ""
    property color itemBackgroundColor: "transparent"
    property color itemSelectedBackgroundColor: "#3D3D3D"
    property url itemSelectedBackground: "" // "image://theme/" + __colorString + "meegotouch-list-fullwidth-background-selected"
    property url itemPressedBackground: "image://theme/" + __colorString + "meegotouch-panel-inverted-background-pressed"

    property int buttonsTopMargin: 30 // ToDo: evaluate correct value

    Text {
        id: titleText
        font.family: __fontFamily
        font.pixelSize: UI.FONT_XLARGE
        font.capitalization: Font.MixedCase
        font.bold: false
    }

    Text {
        id: itemText
        font.family: __fontFamily
        font.pixelSize: UI.FONT_DEFAULT_SIZE
        font.capitalization: Font.MixedCase
        font.bold: true
    }
  }
