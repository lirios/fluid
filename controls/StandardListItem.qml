/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2013-2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.1
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Fluid.UI 1.0
import Fluid.Controls 1.0

EmptyListItem {
    property alias iconName: icon.iconName

    property alias text: label.text

    property bool progression: false

    default property alias control: container.children

    height: Math.max(label.paintedHeight, icon.height) + 22

    RowLayout {
        Icon {
            id: icon
            width: Units.iconSizes.small
            height: width
            color: {
                if (iconName.indexOf("-symbolic", iconName.length - 9) != -1)
                    return selected ? Material.textSelectionColor : Material.textColor;
                return Qt.rgba(0, 0, 0, 0);
            }
            visible: iconName != ""
        }

        Label {
            id: label
            color: selected ? Material.textSelectionColor : Material.textColor

            Layout.fillWidth: true
        }

        Item {
            id: container
            visible: !progression

            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
