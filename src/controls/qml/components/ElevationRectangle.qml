// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import Fluid as MD

/*!
    \class ElevationRectangle
    \brief A rectangle that casts a Material 3 elevation shadow.

    ElevationRectangle combines Rectangle with an Elevation effect that follows
    its size and individual corner radii. Transparent rectangles do not cast a shadow.

    For more information see the
    <a href="https://m3.material.io/styles/elevation/overview">Material Design 3 elevation guidelines</a>.
*/
Rectangle {
    id: root

    //! The elevation level used to render the shadow.
    property alias elevation: shadow.elevation

    //! The underlying Elevation effect, for advanced customization.
    property alias elevationItem: shadow

    //! Whether the elevation shadow is visible.
    property alias elevationVisible: shadow.visible

    MD.Elevation {
        id: shadow

        z: -1

        radius: root.radius
        topLeftRadius: root.topLeftRadius
        topRightRadius: root.topRightRadius
        bottomLeftRadius: root.bottomLeftRadius
        bottomRightRadius: root.bottomRightRadius

        width: root.width
        height: root.height

        visible: !MD.Utils.epsilonEqual(elevation, MD.Tokens.elevation.level0) && root.color.a > 0
    }
}
