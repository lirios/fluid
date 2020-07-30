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
import QtQuick.Controls 2.3 as QQC2
import QtQuick.Controls.impl 2.3 as QQCImpl2

QQC2.ToolButton {
    id: control

    property bool hoverAnimation: false

    contentItem: QQCImpl2.IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: control.icon.color

        rotation: control.hoverAnimation && control.hovered ? 90 : 0

        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }
}
