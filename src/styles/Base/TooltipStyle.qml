/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2012-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Hawaii.Shell.Styles 1.0

Style {
    property color panelColor1: Qt.rgba(0.13, 0.13, 0.13, 0.8)
    property color panelColor2: Qt.rgba(0, 0, 0, 0.8)
    property color textColor: "white"
    property color textShadowColor: Qt.rgba(0, 0, 0, 0.7)

    property Component panel: Rectangle {
        border.color: Qt.rgba(0, 0, 0, 0.5)
        color: "black"
        opacity: 0.7
        radius: 6
        antialiasing: true
    }
}
