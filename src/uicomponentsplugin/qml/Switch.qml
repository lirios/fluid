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
import FluidCore 1.0 as FluidCore
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

