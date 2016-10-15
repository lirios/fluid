/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import Fluid.Core 1.0

Object {
    id: platform

    property var platformExtensions

    property color decorationColor
    property var window: null

    onDecorationColorChanged: {
        if (platformExtensions && color != "#000000") {
            platformExtensions.decorationColor = decorationColor
        }
    }

    onWindowChanged: {
        if (platformExtensions) {
            platformExtensions.window = window
        }
    }

    Component.onCompleted: {
        try {
            var code = 'import Liri.Platform 1.0; PlatformExtensions {}'
            platformExtensions = Qt.createQmlObject(code, platform, "LiriExtensions");

            platformExtensions.window = window
            if (decorationColor != "#000000")
                platformExtensions.decorationColor = decorationColor
        } catch (error) {
            // Ignore the error; it only means that the Papyros
            // platform extensions are not available
        }
    }
}
