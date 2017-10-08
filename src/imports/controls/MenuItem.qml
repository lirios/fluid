/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype MenuItem
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Menu item with an \l Icon.

    This component will be deprecated as soon as Qt 5.10 is released.

    For more information you can read the
    \l{https://material.io/guidelines/components/menus.html#menus-menu-items}{Material Design guidelines}.
*/
MenuItem {
    id: control

    /*!
        \qmlproperty string iconName

        Icon name.

        \sa Icon::name
    */
    property alias iconName: icon.name

    /*!
        \qmlproperty url iconSource

        Icon source URL.

        \sa Icon::source
    */
    property alias iconSource: icon.source

    /*!
        \qmlproperty size iconSize

        Icon size.

        \sa Icon::size
    */
    property alias iconSize: icon.size

    /*!
        \qmlproperty color iconColor

        Icon color.

        \sa Icon::color
    */
    property alias iconColor: icon.color

    contentItem: Item {
        FluidControls.Icon {
            id: icon

            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            anchors {
                left: icon.right
                verticalCenter: parent.verticalCenter
                leftMargin: 16
            }

            leftPadding: control.checkable && !control.mirrored ? control.indicator.width + control.spacing : 0
            rightPadding: control.checkable && control.mirrored ? control.indicator.width + control.spacing : 0

            text: control.text
            font: control.font
            color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
            elide: Text.ElideRight
            visible: control.text
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }
}
