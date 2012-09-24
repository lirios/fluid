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
*   GNU General Public License for more details
*
*   You should have received a copy of the GNU Library General Public
*   License along with this program; if not, write to the
*   Free Software Foundation, Inc.,
*   51 Franklin Street, Fifth Floor, Boston, MA  1.011.0301, USA.
*/

/**Documented API
Inherits:
        DualStateButton

Imports:
        QtQuick 2.0
        FluidCore

Description:
        You can bind the Switch component to a feature that the application
        has to enable or disable depending on the user's input, for example.
        Switch has similar usage and API as CheckBox, except that Switch does
        not provide a built-in label.

Properties:
            bool checked:
            Returns true if the Button is checked, otherwise
            it returns false.

            bool pressed:
            Returns true if the Button is pressed, otherwise
            it returns false.

            string text:
            Sets the text for the switch.
            The default value is empty.No text
            will be displayed.

Signals:
        onClicked:
        The signal is emited when the button is clicked!
**/
import QtQuick 2.0
import FluidCore 1.0
import "private" as Private

Private.DualStateButton {
    id: switchItem

    view: FluidCore.FrameSvgItem {
        imagePath: "widgets/slider"
        prefix: "groove"
        width: height * 2
        height: Math.max(theme.defaultFont.mSize.height + margins.top + margins.bottom,
                         button.margins.top + button.margins.bottom)

        FluidCore.FrameSvgItem {
            id: highlight
            imagePath: "widgets/slider"
            prefix: "groove-highlight"
            anchors.fill: parent

            opacity: checked ? 1 : 0
            Behavior on opacity {
                PropertyAnimation { duration: 100 }
            }
        }

        FluidCore.FrameSvgItem {
            imagePath: "widgets/button"
            prefix: "shadow"
            anchors {
                fill: button
                leftMargin: -margins.left
                topMargin: -margins.top
                rightMargin: -margins.right
                bottomMargin: -margins.bottom
            }
        }

        FluidCore.FrameSvgItem {
            id: button
            imagePath: "widgets/button"
            prefix: "normal"
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: height
            x: checked ? width : 0
            Behavior on x {
                PropertyAnimation { duration: 100 }
            }
        }
    }
}

