/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

/*!
    \qmltype IconButton
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief \l ToolButton with an \l Icon.
*/
ToolButton {
    id: iconButton

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

        Icon width and height.

        \sa Icon::size
    */
    property alias iconSize: icon.size

    /*!
        \qmlproperty color iconColor

        Icon color.

        \sa Icon::color
    */
    property alias iconColor: icon.color

    /*!
        \qmlproperty bool hoverAnimation

        Specify whether the icon should be rotated 90 degrees when the mouse hovers.
        Default is \c false.
    */
    property bool hoverAnimation: false

    indicator: Icon {
        id: icon

        anchors.centerIn: parent
        rotation: iconButton.hoverAnimation && iconButton.hovered ? 90 : 0

        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }
}
