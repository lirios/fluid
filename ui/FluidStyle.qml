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
import Fluid.Core 1.0

pragma Singleton

QtObject {
    id: fluidStyle

    readonly property color iconColorLight: Qt.rgba(0,0,0,0.54)
    readonly property color iconColorDark: Qt.rgba(1,1,1)

    readonly property font subheadingFont: Qt.font({ family: "Roboto",
                                                     pointSize: Device.isMobile ? 16 : 15 })

    readonly property font body1Font: Qt.font({ family: "Roboto",
                                                pointSize: Device.isMobile ? 14 : 13 })

    readonly property font titleFont: Qt.font({ family: "Roboto", weight: Font.DemiBold,
                                                pointSize: 20 })

    /* Control fonts that don't fit into the standard font styles */

    readonly property font subheaderFont: Qt.font({ family: "Roboto", weight: Font.DemiBold,
                                                    pointSize: 14 })
}
