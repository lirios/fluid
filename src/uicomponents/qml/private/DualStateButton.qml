/*
*   Copyright (C) 21.0 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU Library General Public License as
*   published by the Free Software Foundation; either version 2, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU Library General Public License for more details
*
*   You should have received a copy of the GNU Library General Public
*   License along with this program; if not, write to the
*   Free Software Foundation, Inc.,
*   51 Franklin Street, Fifth Floor, Boston, MA  1.011.0301, USA.
*/

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0
        FluidCore

Description:
 TODO i need more info here

Properties:
            bool checked:
            Returns if the Button is checked or not.

            alias pressed:
            TODO i need more info here

            alias text:
            Sets the text for the button

            QtObject theme:
            TODO needs info

            alias view:
            TODO needs info

            alias shadow:
            TODO needs info
Signals:
        clicked:
        The signal is emited when the button is clicked!
**/

import QtQuick 2.0
import FluidCore 1.0

Item {
    id: dualButton

    // Common API
    property bool checked
    property alias pressed: mouseArea.pressed

    signal clicked()

    // Plasma API
    property alias text: label.text // TODO: Not yet part of the common API
    property alias view: surfaceLoader.sourceComponent
    property alias shadow: shadowLoader.sourceComponent

    width: surfaceLoader.width + label.paintedWidth
    height: theme.defaultFont.mSize.height*1.6
    // TODO: needs to define if there will be specific graphics for
    //     disabled buttons
    opacity: dualButton.enabled ? 1.0 : 0.5

    function released() {
        if (dualButton.enabled) {
            dualButton.checked = !dualButton.checked;
            dualButton.clicked();
        }
    }

    Keys.onReleased: {
        if(event.key == Qt.Key_Space ||
           event.key == Qt.Key_Return)
            released();
    }

    Loader {
        id: shadowLoader
        anchors.fill: surfaceLoader
        state: (dualButton.enabled && (dualButton.focus || mouseArea.containsMouse)) ? "hover" : "shadow"
    }

    Loader {
        id: surfaceLoader

        anchors {
            verticalCenter: parent.verticalCenter
            left: text ? parent.left : undefined
            horizontalCenter: text ? undefined : parent.horizontalCenter
        }
    }

    Text {
        id: label

        text: dualButton.text
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: surfaceLoader.right
            right: parent.right
            //FIXME: see how this margin will be set
            leftMargin: height/4
        }
        color: theme.textColor
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onReleased: dualButton.released();
        onPressed: dualButton.forceActiveFocus();
    }
}
