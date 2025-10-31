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
import QtQuick.Controls.Material

/*!
    \brief Subheaders are special list tiles that delineate distinct sections of a list or grid list.

     For more information you can read the
     <a href="https://material.io/guidelines/components/subheaders.html">Material Design guidelines</a>.
*/
ItemDelegate {
    id: listItem

    /*!
        Text color.
    */
    property alias textColor: label.color

    width: parent ? parent.width : undefined
    hoverEnabled: false
    opacity: enabled ? 1.0 : 0.6

    Layout.fillWidth: true

    background: Item {
        implicitHeight: 48
    }

    contentItem: Label {
        id: label

        font.weight: Font.DemiBold
        font.pixelSize: 14
        text: listItem.text

        verticalAlignment: Text.AlignVCenter

        color: Material.secondaryTextColor
    }
}
