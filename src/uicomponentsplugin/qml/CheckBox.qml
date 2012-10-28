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
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

/**Documented API
Inherits:
        The private DualStateButton

Imports:
        QtQuick 2.0
        FluidCore

Description:
        A check box is a component that can be switched on (checked) or off (unchecked). Check boxes are typically used to represent features in an application that can be enabled or disabled without affecting others, but different types of behavior can be implemented. When a check box is checked or unchecked it sends a clicked signal for the application to handle.
        When a check box has the focus, its state can be toggled using the Qt.Key_Select, Qt.Key_Return, and Qt.Key_Enter hardware keys that send the clicked signal.

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
import FluidCore 1.0 as FluidCore
import "private" as Private

Private.DualStateButton {
    id: checkBox
    view: FluidCore.FrameSvgItem {
        imagePath: "widgets/button"
        prefix: "normal"
        width: theme.defaultFont.mSize.height + margins.left
        height: theme.defaultFont.mSize.height + margins.top

        FluidCore.SvgItem {
            svg: FluidCore.Svg {
                id: checkmarkSvg
                imagePath: "widgets/checkmarks"
            }
            elementId: "checkbox"
            opacity: checked ? 1 : 0
            anchors {
                fill: parent
                margins: parent.margins.left/2
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    shadow: Private.ButtonShadow {}
}
