/****************************************************************************
 * This file is part of Hawaii Framework.
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

/*!
    \qmltype StyledItem
    \qmlabstract
    \inqmlmodule Hawaii.Shell.Controls.Styles 1.0
*/

Item {
    id: root

    /*! \qmlproperty Component StyledItem::style
        The style Component for this item.
        \sa {Hawaii Shell Controls Styles QML Types}
    */
    property Component style

    /*! \internal */
    property QtObject __style: styleLoader.item

    /*! \internal */
    property Item __panel: panelLoader.item

    implicitWidth: __panel ? __panel.implicitWidth : 0
    implicitHeight: __panel ? __panel.implicitHeight : 0

    Loader {
        id: panelLoader
        anchors.fill: parent
        sourceComponent: __style ? __style.panel : null
        onStatusChanged: {
            if (status === Loader.Error)
                console.error("Failed to load Style for", root);
        }

        Loader {
            property Item __item: root

            id: styleLoader
            sourceComponent: style
            onStatusChanged: {
                if (status === Loader.Error)
                    console.error("Failed to load Style for", root);
            }
        }
    }
}
