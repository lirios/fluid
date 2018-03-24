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
import QtGraphicalEffects 1.0

/*!
  \qmltype CircleMask
  \inqmlmodule Fluid.Effects
  \ingroup fluideffects

  \brief Circular mask.
*/
Item {
    id: item

    /*!
        \qmlproperty variant source

        This property defines the source item that is going to be masked.
    */
    property alias source: mask.source

    Rectangle {
        id: circleMask

        width: parent.width
        height: parent.height

        smooth: true
        visible: false

        radius: Math.max(width/2, height/2)
    }

    OpacityMask {
        id: mask

        width: parent.width
        height: parent.height

        maskSource: circleMask
    }
}
