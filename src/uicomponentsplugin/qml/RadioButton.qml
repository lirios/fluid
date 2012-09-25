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
        The private DualStateButton

Imports:
        QtQuick 2.0
        FluidCore

Description:
        A radio button component consists of a radio button and a line of text. Only one item in a list may be selected at a time. Once an item is selected, it can be deselected only by selecting another item. Initial item selection may be set at the list creation. If not set, the list is shown without a selection.

Properties:
        bool checked:
        If the button is checked, its checked property is true; otherwise false. The property is false by default.

        bool pressed:
        If the button is pressed, its pressed property is true.
            See also clicked.

        string text:
        The text is shown beside the check box. By default text is an empty string.

Signals:
        clicked():
            Emitted when the user clicked a mouse button over the checkbox (or tapped on the touch screen)
**/

import QtQuick 2.0
import FluidCore 1.0
import "private" as Private

//FIXME: this should be round, DualStateButton shouldn't draw the shadow
Private.DualStateButton {
    id: radioButton
    view: FluidCore.SvgItem {
        svg: FluidCore.Svg {
            id: buttonSvg
            imagePath: "widgets/actionbutton"
        }
        elementId: "normal"
        width: theme.defaultFont.mSize.height + 6
        height: width

        FluidCore.SvgItem {
            svg: FluidCore.Svg {
                id: checkmarkSvg
                imagePath: "widgets/checkmarks"
            }
            elementId: "radiobutton"
            opacity: checked ? 1 : 0
            anchors {
                fill: parent
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    shadow: Private.RoundShadow {}
}