/****************************************************************************
 * This file is part of Fluid.
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

import QtQuick 2.1

Item {
    id: root

    /*! This property holds whether the list item is selected.

        It's an alias for \c ListView.isCurrentItem
    */
    readonly property bool selected: root.ListView.isCurrentItem

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

    width: root.ListView.view.width

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: Qt.lighter(__syspal.highlight, 1.3) }
            GradientStop { position: 1; color: Qt.lighter(__syspal.highlight, 1.0) }
        }
        visible: selected
    }

    Rectangle {
        anchors.fill: parent
        color: "#cdcdcd"
        visible: !selected
    }

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
            top: parent.top
            margins: 11
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
