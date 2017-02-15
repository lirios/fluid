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

import QtQuick 2.4
import QtGraphicalEffects 1.0
import Fluid.Effects 1.0

/*!
    \qmltype CircleImage
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Circular image.
*/
Item {
    id: item

    property alias source: image.source
    property alias status: image.status
    property alias sourceSize: image.sourceSize
    property alias asynchronous: image.asynchronous
    property alias cache: image.cache
    property alias fillMode: image.fillMode

    width: image.implicitWidth
    height: image.implicitHeight

    Image {
        id: image
        anchors.fill: parent
        visible: false
    }

    CircleMask {
        anchors.fill: image
        source: image
    }
}
