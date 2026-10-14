// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid.Private as P

/*!
    \class IconImage
    \internal
    \brief Renders source icons with an optional alpha-preserving tint.
*/
P.IconImage {
    fillMode: Image.PreserveAspectFit
    Accessible.ignored: true
}
