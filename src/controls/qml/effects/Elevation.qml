// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
   \brief Material Design elevation effect.

   An effect for standard Material Design elevation shadows.
 */
MD.ElevationImpl {
    color: MD.Style.shadowColor
    visible: !MD.Utils.epsilonEqual(elevation, MD.Tokens.elevationLevel0)

    Behavior on elevation {
        NumberAnimation {
            duration: MD.Tokens.durationMedium1
        }
    }
}
