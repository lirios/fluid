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
import QtQuick.Controls.Material 2.2
import Fluid.Controls 1.0
import Fluid.Effects 1.0

/*!
  \qmltype Chip
  \inqmlmodule Fluid.Controls
  \ingroup fluidcontrols

  \brief Chips represent complex entities in small blocks, such as a contact.
*/
Rectangle {
    /*!
      \qmlproperty string caption

      The caption to show in the chip
    */
    property string caption: ""

    /*!
      \qmlproperty alias icon

      The icon to display (if any)
    */
    property alias icon: contactIcon

    /*!
      \qmlproperty bool deletable

      Whether the chip can be deleted
    */
    property bool deletable: false

    /*!
      Emitted, when the user wants to delete the chip
    */
    signal deleted()

    width: contactIcon.width + captionLabel.implicitWidth + deleteButton.width + 12
    height: 32
    radius: 16
    color: Material.color(Material.Grey, Material.Shade300)
    Icon {
        id: contactIcon
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        width: 32
        height: width
        visible: false
    }
    CircleMask {
        id: circleMask
        anchors.fill: contactIcon
        source: contactIcon
        visible: source !== ""
    }
    CaptionLabel {
        id: captionLabel
        anchors {
            left: parent.left
            right: deleteButton.left
            verticalCenter: parent.verticalCenter
            leftMargin: circleMask.visible ? 40 : 12
            rightMargin: deletable ? 4 : 12
        }
        text: caption
    }
    ToolButton {
        id: deleteButton
        icon.source: Utils.iconUrl("navigation/close")
        icon.color: Material.iconColor
        visible: deletable
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 40
        height: width
        onClicked: deleted();
    }
}
