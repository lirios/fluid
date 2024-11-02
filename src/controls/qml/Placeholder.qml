/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import Fluid

/*!
    \brief Shows a placeholder icon and text.

    For more information you can read the
    <a href="https://material.io/guidelines/patterns/empty-states.html#empty-states-avoiding-completely-empty-states">Material Design guidelines</a>.
*/
Control {
    id: control

    /*!
        Icon.
    */
    property alias icon: iconLabel.icon

    /*!
        Text.
    */
    property alias text: textLabel.text

    /*!
        Sub text.
    */
    property alias subText: subTextLabel.text

    implicitWidth: columnLayout.implicitWidth
    implicitHeight: columnLayout.implicitHeight

    leftPadding: Units.mediumSpacing
    rightPadding: Units.mediumSpacing

    ColumnLayout {
        id: columnLayout

        anchors.centerIn: parent
        
        IconLabel {
            id: iconLabel

            spacing: control.spacing
            mirrored: control.mirrored
            display: IconLabel.IconOnly

            icon.width: 96
            icon.height: 96
            icon.color: Material.iconColor

            Layout.alignment: Qt.AlignHCenter
        }

        TitleLabel {
            id: textLabel
            color: Material.secondaryTextColor
            horizontalAlignment: Qt.AlignHCenter

            Layout.fillWidth: true
        }

        SubheadingLabel {
            id: subTextLabel
            color: Material.secondaryTextColor
            horizontalAlignment: Qt.AlignHCenter
            wrapMode: Text.Wrap
            visible: text !== ""

            Layout.fillWidth: true
        }
    }
}
