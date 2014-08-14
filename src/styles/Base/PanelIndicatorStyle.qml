/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2013-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

import QtQuick 2.0
import Fluid.Ui 1.0
import Hawaii.Shell.Styles 1.0

Style {
    property color textColor: "#cccccc"
    property color highlightedTextColor: "white"
    property color highlightColor: "#48acea"

    property Component panel: Item {
        property real spacing: 4 * __style.dpiScaleFactor
        property int spacingMult: __item.label ? 4 : 3

        implicitWidth: iconItem.width + labelItem.paintedWidth + (spacing * spacingMult)

        Rectangle {
            id: highlight
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0; color: highlightColor }
                GradientStop { position: 1; color: Qt.darker(highlightColor, 1.8) }
            }
            color: highlightColor
            opacity: __item.selected ? 1.0 : 0.0

            Behavior on opacity { NumberAnimation { duration: 80 } }
        }

        Icon {
            id: iconItem
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: spacing
            }
            iconName: __item.iconName ? __item.iconName : "unknown"
            color: __item.selected || __item.hovered ? highlightedTextColor : textColor
            width: __item.iconSize
            height: __item.iconSize
            visible: __item.iconName !== ""

            Behavior on color {
                ColorAnimation { easing.type: Easing.Linear; duration: 250 }
            }
        }

        Text {
            id: labelItem
            anchors {
                left: iconItem.right
                verticalCenter: iconItem.verticalCenter
                leftMargin: spacing
                rightMargin: spacing
            }
            text: __item.label
            font.weight: Font.Bold
            font.pointSize: 9 * __style.dpiScaleFactor
            color: __item.selected || __item.hovered ? highlightedTextColor : textColor
            visible: __item.label !== ""

            Behavior on color {
                ColorAnimation { easing.type: Easing.Linear; duration: 250 }
            }
        }
    }
}
