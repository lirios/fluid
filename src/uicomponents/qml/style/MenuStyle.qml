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

Style {
    id: root

    property real leftMargin: ( (screen.currentOrientation == 1) ||
                                 (screen.currentOrientation == 4) ) ? 0 : 427
    property real rightMargin: ( (screen.currentOrientation == 1) ||
                                 (screen.currentOrientation == 4) ) ? 0 : 0
    property real topMargin: ( (screen.currentOrientation == 1) ||
                               (screen.currentOrientation == 4) ) ? 246 : 0

    property real bottomMargin: 0

    property real leftPadding: 16
    property real rightPadding: 16
    property real topPadding: 16
    property real bottomPadding: 16

    // fader properties
    property double dim: 0.9
    property int fadeInDuration: 350 // ms
    property int fadeOutDuration: 350 // ms
    property int fadeInDelay: 0 // ms
    property int fadeOutDelay: 0 // ms
    property int fadeInEasingType: Easing.InOutQuint
    property int fadeOutEasingType: Easing.InOutQuint
    property url faderBackground: "image://theme/meegotouch-menu-dimmer"

    property int pressDelay: 0 // ms

    property url background: "image://theme/meegotouch-menu-background" + __invertedString
//    property url pressedBackground: "image://theme/meegotouch-menu" + __invertedString + "-background-pressed"
//    property url disabledBackground: "image://theme/meegotouch-menu" + __invertedString + "-background-disabled"
}
