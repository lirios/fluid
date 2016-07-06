/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.0

pragma Singleton

QtObject {
    id: fluidStyle

    readonly property color iconColorLight: Qt.rgba(0,0,0,0.54)
    readonly property color iconColorDark: Qt.rgba(1,1,1)
}
