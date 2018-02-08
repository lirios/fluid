/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls
import Fluid.Effects 1.0 as FluidEffects

/*!
    \qmltype FloatingActionButton
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief A floating action button.

    A floating action button represents the primary action of the current page
    and is used for a promoted action.

    It is a push button with rounded corners and an icon in the center.

    \snippet fluidcontrols-fab.qml file

    For more information you can read the
    \l{https://material.io/guidelines/components/buttons-floating-action-button.html}{Material Design guidelines}.
*/
RoundButton {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentItem.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentItem.implicitHeight) + topPadding + bottomPadding

    leftPadding: 6
    rightPadding: 6
    topPadding: 6
    bottomPadding: 6

    /*!
        \qmlproperty bool mini

        Floating action button comes in two sizes:

        \list
            \li \c Default (56x56 pixels): default size for most use cases
            \li \c Mini (40x40 pixels): only used to create visual continuity with other screen elements
        \endlist

        This property holds whether the floating action button size is \c Mini or not.

        By default it is \c true if screen width is less than 460 pixels.
    */
    property bool mini: Screen.width < 460

    Material.elevation: 1

    background: Rectangle {
        implicitWidth: control.mini ? 40 : 56
        implicitHeight: implicitWidth

        x: control.leftPadding
        y: control.topPadding

        color: !control.enabled ? control.Material.buttonDisabledColor
                                : control.checked || control.highlighted ? control.Material.highlightedButtonColor : control.Material.buttonColor
        radius: control.radius

        RectangularGlow {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: control.Material.elevation === 1 ? 1.5 : 1

            width: parent.width
            height: parent.height

            z: -1

            visible: control.enabled && control.Material.buttonColor.a > 0

            glowRadius: control.Material.elevation === 1 ? 0.75 : 0.3
            opacity: control.Material.elevation === 1 ? 0.6 : 0.3
            spread: control.Material.elevation === 1 ? 0.7 : 0.85
            color: "black"
            cornerRadius: height/2
        }

        FluidControls.Ripple {
            anchors.fill: parent
            control: control
            circular: true
        }
    }
}
