/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Core 1.0
import Fluid.Controls 1.0
import QtGraphicalEffects 1.0

/*!
   \qmltype ActionButton
   \inqmlmodule Fluid.Material

   \brief A floating action button.

   An ActionButton is a floating action button that provides a primary action
   on the current page.
 */
Button {
    id: button

    /*!
       The name of the icon to display in the action button, selected from the Material
       Design icon collection by Google.
     */
    property alias iconName: icon.name

    /*!
       Floating action buttons come in two sizes:

       \list
       \li \b {Default size} - for most use cases
       \li \b {Mini size} - only used to create visual continuity with other screen elements
       \endlist
     */
    property bool isMiniSize: false

    padding: 0

    width: 76
    height: 76

    contentItem: Item {
        implicitHeight: isMiniSize ? 40 : 56
        implicitWidth: implicitHeight

        Icon {
            id: icon

            anchors.centerIn: parent
            color: Utils.lightDark(button.Material.background, "black", "white")
            size: 24
        }
    }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: 64

        x: 6
        y: 6

        width: parent.width - 12
        height: parent.height - 12

        radius: width/2

        color: button.Material.background

        RectangularGlow {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: button.Material.elevation === 1 ? 1.5 : 1

            width: parent.width
            height: parent.height

            z: -1

            glowRadius: button.Material.elevation === 1 ? 0.75 : 0.3
            opacity: button.Material.elevation === 1 ? 0.6 : 0.3
            spread: button.Material.elevation === 1 ? 0.7 : 0.85
            color: "black"
            cornerRadius: height/2
        }

        Ripple {
            anchors.fill: parent
            control: button

            circular: true
        }
    }
}
