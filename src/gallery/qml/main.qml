/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Fluid as MD

MD.ApplicationWindow {
    id: window

    visible: true

    width: 1024
    height: 800

    title: qsTr("Fluid Gallery")

    Components {
        anchors.fill: parent
    }
}
