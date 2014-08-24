/****************************************************************************
 * This file is part of Hawaii Framework.
 *
 * Copyright (C) 2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Hawaii.Shell.Controls 1.0
import Hawaii.Shell.Controls.Styles 1.0 as Styles
import org.kde.plasma.core 2.0 as PlasmaCore

Styles.Style {
    readonly property var control: __control

    padding {
        left: 0
        top: 0
        right: 0
        bottom: 0
    }

    property Component background: Rectangle {
        color: PlasmaCore.ColorScope.backgroundColor
    }

    /*! \internal */
    property Component panel: Item {
        anchors.fill: parent
        implicitWidth: padding.left + padding.right + backgroundLoader.implicitWidth
        implicitHeight: padding.top + padding.bottom + backgroundLoader.implicitHeight

        Loader {
            id: backgroundLoader
            sourceComponent: background
            anchors.fill: parent
            anchors.leftMargin: padding.left
            anchors.topMargin: padding.top
            anchors.rightMargin: padding.right
            anchors.bottomMargin: padding.bottom
        }
    }
}
