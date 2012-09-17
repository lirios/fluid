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

Style {
    // Font
    property string fontFamily: __fontFamily
    property int fontPixelSize: UI.FONT_DEFAULT_SIZE
    property int fontCapitalization: Font.MixedCase
    property int fontWeight: Font.Normal

    // Text
    property color textColor: "black"
    property int textStyle: Text.Sunken
    property color textStyleColor: "#111111"

    // Dimensions
    property int buttonWidth: 40 // DEPRECATED
    property int buttonPaddingLeft: 8
    property int buttonPaddingRight: 8
    property int buttonHeight: 56

    // Mouse
    property real mouseMarginLeft: (position == "horizontal-left") ? 6 : 0
    property real mouseMarginTop: 8
    property real mouseMarginRight: (position == "horizontal-right") ? 6 : 0
    property real mouseMarginBottom: 10

    // Background
    property int backgroundMarginLeft: 19
    property int backgroundMarginTop: 15
    property int backgroundMarginRight: 19
    property int backgroundMarginBottom: 15

    // Position can take one of the following values:
    // [horizontal-left] [horizontal-center] [horizontal-right]
    property string position: ""

    property string __suffix: (position ? "-" + position : "")

    property url background: "image://theme/meegotouch-text-editor" + __suffix
    property url pressedBackground: "image://theme/meegotouch-text-editor-pressed" + __suffix
    property url checkedBackground: "image://theme/meegotouch-text-editor-selected" + __suffix
}
