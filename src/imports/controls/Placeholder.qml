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

import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.impl 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0

/*!
    \qmltype Placeholder
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Shows a placeholder icon and text.

    For more information you can read the
    \l{https://material.io/guidelines/patterns/empty-states.html#empty-states-avoiding-completely-empty-states}{Material Design guidelines}.
*/
Control {
    id: control

    property alias icon: iconLabel.icon

    /*!
        \qmlproperty string text

        Text.
    */
    property alias text: textLabel.text

    /*!
        \qmlproperty string subText

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
