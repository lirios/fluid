/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 * Copyright (C) 2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
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
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3
import Fluid.Core 1.0
import Fluid.Controls 1.0

Item {
    id: icon

    property color color: Material.iconColor
    property real size: 24
    property string name
    property url source: {
        return name ? name.indexOf("/") === 0 || name.indexOf("file://") === 0 || name.indexOf("qrc") === 0
                      ? name : "image://fluidicontheme/" + name
                    : "";
    }
    property alias status: image.status
    property alias cache: image.cache
    readonly property bool valid: status == Image.Ready
    property bool colorize: (String(icon.source).indexOf(".color.") === -1 &&
                             String(icon.source).indexOf("image://fluidicontheme/") === -1) ||
                            String(icon.source).indexOf("symbolic") !== -1 ||
                            (String(icon.source).indexOf("image://fluidicontheme/") !== -1 &&
                             icon.name.indexOf("/") !== -1)
    readonly property real sourceSize: String(icon.source).indexOf("image://fluidicontheme/") === 0 ? Units.roundToIconSize(size) : size

    width: size
    height: size

    Image {
        id: image

        anchors.fill: parent
        visible: !colorize

        source: icon.source

        sourceSize {
            width: icon.sourceSize * Screen.devicePixelRatio
            height: icon.sourceSize * Screen.devicePixelRatio
        }
    }

    ColorOverlay {
        id: overlay

        anchors.fill: parent
        source: image
        color: Color.transparent(icon.color, 1)
        cached: true
        visible: icon.valid && colorize
        opacity: icon.color.a
    }
}
