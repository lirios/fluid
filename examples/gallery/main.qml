/****************************************************************************
 * This file is part of Fluid Examples.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:BSD2$
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import FluidUi 1.0

Rectangle {
    id: root
    color: "gainsboro"

    width: 400
    height: 400

    Row {
        id: row1
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }
        width: parent.width

        Column {
            RadioButton {
                text: "Radio button 1"
            }
            RadioButton {
                text: "Radio button 2"
            }
            RadioButton {
                text: "Radio button 3"
            }
            CheckBox {
                text: "Tri-state check box"
            }
        }

        Column {
            Button {
                text: "Default push button"
            }
            Button {
                checkable: true
                checked: true
                text: "Toggle Push Button"
            }
            Button {
                text: "Flat Push Button"
                visible: false
            }
        }
    }

    Row {
        id: row2
        anchors {
            top: row1.bottom
            left: parent.left
            margins: 10
        }
        width: parent.width

        Column {
            TextField {
            }

            Slider {
            }
        }
    }

    ProgressBar {
        id: progressBar
        anchors {
            top: row2.bottom
            left: parent.left
            margins: 10
        }
        width: parent.width - 20

        minimumValue: 0
        maximumValue: 100
        value: 0
    }

    Timer {
        running: true
        repeat: true
        interval: 1000
        onTriggered: progressBar.value += 1
    }
}
