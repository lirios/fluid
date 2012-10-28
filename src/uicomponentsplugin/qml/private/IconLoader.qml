/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
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
        Item

Imports:
        QtQuick 2.0
        FluidCore
        FluidExtra

Description:
 TODO i need more info here

Properties:
        bool valid:
        Returns if the icon is valid or not.

        string source:
        Returns the dir,in which the icon exists.
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import FluidExtra 1.0 as FluidExtra

Item {
    id: root

    property bool valid: false

    property variant source

    onSourceChanged: {
        //is it a qicon?
        if (typeof source != "string") {
            imageLoader.sourceComponent = iconComponent
            valid = true
            return
        } else if (source == "") {
            imageLoader.sourceComponent = null
            valid = false
            return
        }

        svgIcon.imagePath = "toolbar-icons/"+root.source.split("-")[0]
        if (!svgIcon.isValid() || !svgIcon.hasElement(root.source)) {
            svgIcon.imagePath = "icons/"+root.source.split("-")[0]
        }

        if (svgIcon.isValid() && svgIcon.hasElement(root.source)) {
            imageLoader.sourceComponent = svgComponent
        } else if ((root.source.indexOf(".") == -1 && root.source.indexOf(":") == -1)) {
            imageLoader.sourceComponent = iconComponent
        } else {
            imageLoader.sourceComponent = imageComponent
        }
        valid = true
    }

    implicitWidth: theme.smallIconSize
    implicitHeight: theme.smallIconSize

    FluidCore.Svg {
        id: svgIcon
    }

    function roundToStandardSize(size)
    {
        if (size >= theme.enormousIconSize) {
            return theme.enormousIconSize
        } else if (size >= theme.hugeIconSize) {
            return theme.hugeIconSize
        } else if (size >= theme.largeIconSize) {
            return theme.largeIconSize
        } else if (size >= theme.mediumIconSize) {
            return theme.mediumIconSize
        } else if (size >= theme.smallMediumIconSize) {
            return theme.smallMediumIconSize
        } else {
            return theme.smallIconSize
        }
    }

    Loader {
        id: imageLoader
        anchors.fill: parent

        Component {
            id: svgComponent

            FluidCore.SvgItem {
                svg: svgIcon
                elementId: root.source
                anchors.fill: parent
                smooth: true
            }
        }

        Component {
            id: iconComponent

            FluidExtra.IconItem {
                icon: (typeof source == "string") ? QIcon(root.source) : root.source
                smooth: true
                anchors.fill: parent
            }
        }

        Component {
            id: imageComponent

            Image {
                source: root.source
                sourceSize.width: width
                sourceSize.height: height
                fillMode: Image.PreserveAspectFit
                smooth: true
                anchors.fill: parent
            }
        }
    }
}
