/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Daker Fernandes Pinheiro
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Daker Fernandes Pinheiro <dakerfp@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
 *
 * $END_LICENSE$
 ***************************************************************************/

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
import FluidCore 1.0 as FluidCore

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
        color: theme.windowTextColor
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
