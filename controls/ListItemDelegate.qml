/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import Fluid.Material 1.0

ItemDelegate {
    property int dividerInset: 0
    property bool showDivider: false
    property bool interactive: true

    width: parent ? parent.width : undefined

    leftPadding: 16
    rightPadding: 16

    opacity: enabled ? 1 : 0.6
}
