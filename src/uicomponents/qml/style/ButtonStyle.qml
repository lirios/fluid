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
    property int fontWeight: Font.Bold
    property int checkedFontWeight: Font.Bold
    property int horizontalAlignment: Text.AlignHCenter

    // Text Color
    property color textColor: inverted ? UI.COLOR_BUTTON_INVERTED_FOREGROUND : UI.COLOR_BUTTON_FOREGROUND
    property color pressedTextColor: UI.COLOR_BUTTON_SECONDARY_FOREGROUND
    property color disabledTextColor: UI.COLOR_BUTTON_DISABLED_FOREGROUND
    property color checkedTextColor: UI.COLOR_BUTTON_INVERTED_FOREGROUND

    // Dimensions
    property int buttonWidth: UI.BUTTON_WIDTH
    property int buttonHeight: UI.BUTTON_HEIGHT

    // Mouse
    property real mouseMarginRight: 0.0
    property real mouseMarginLeft: 0.0
    property real mouseMarginTop: 0.0
    property real mouseMarginBottom: 0.0

    // Background
    property int backgroundMarginRight: 22
    property int backgroundMarginLeft: 22
    property int backgroundMarginTop: 22
    property int backgroundMarginBottom: 22

    /* The position property can take one of the following values:

        [horizontal-left] [horizontal-center] [horizontal-right]

        [vertical-top]
        [vertical-center]
        [vertical-bottom]
     */
    property string position: ""

    property url background: "image://theme/meegotouch-button" + __invertedString + "-background" + (position ? "-" + position : "")
    property url pressedBackground: "image://theme/" + __colorString + "meegotouch-button" + __invertedString + "-background-pressed" + (position ? "-" + position : "")
    property url disabledBackground: "image://theme/meegotouch-button" + __invertedString + "-background-disabled" + (position ? "-" + position : "")
    property url checkedBackground: "image://theme/" + __colorString + "meegotouch-button" + __invertedString + "-background-selected" + (position ? "-" + position : "")
    property url checkedDisabledBackground: "image://theme/" + __colorString + "meegotouch-button" + __invertedString + "-background-disabled-selected" + (position ? "-" + position : "")
    
    // Deprecated, user positive/negative dialog instead
    property url dialog: "image://theme/meegotouch-dialog-button-negative"
    property url pressedDialog:  "image://theme/meegotouch-dialog-button-negative-pressed"

    property url positiveDialog: "image://theme/meegotouch-dialog-button-positive"
    property url pressedPositiveDialog:  "image://theme/meegotouch-dialog-button-positive-pressed"
    property url negativeDialog: "image://theme/meegotouch-dialog-button-negative"
    property url pressedNegativeDialog:  "image://theme/meegotouch-dialog-button-negative-pressed"
}
