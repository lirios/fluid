// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
     \class Elevation
     \brief Applies a Material 3 elevation shadow effect.

     For more information see the
     <a href="https://m3.material.io/styles/elevation/overview">Material Design 3 elevation guidelines</a>.
 */
MD.ElevationImpl {
    Accessible.ignored: true
    color: MD.Style.shadowColor
    visible: !MD.Utils.epsilonEqual(elevation, MD.Tokens.elevation.level0)

    Behavior on elevation {
        NumberAnimation {
            duration: MD.Tokens.motion.duration.medium1
        }
    }
}
