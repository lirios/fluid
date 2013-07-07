/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.1

Item {
    id: root

    /*! This property holds whether the list item is selected.

        The default value is \c false.
    */
    property bool selected: false

    /*! This property holds whether the list item is highlighted
        when it is pressed.

        This is used to disable highlighting of the list item
        when a custom highlighting is needed.

        The default value is \c true.
    */
    property bool highlightWhenPressed: true

    signal clicked()

    Accessible.role: Accessible.Button

    default property alias children: body.children

    Rectangle {
        anchors.fill: parent
        color: "#e6e6e6"
        opacity: 0.7
        visible: root.highlightWhenPressed && mouse.pressed
    }

    Item {
        id: body
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
        }
        color: "#c1c1c1"
        height: 1
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
