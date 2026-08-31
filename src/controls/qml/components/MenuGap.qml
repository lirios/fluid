// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD
import QtQuick

/*!
    \class MenuGap
    \brief A non-interactive gap between Expressive menu segments.

    MenuGap occupies the specified Material segmented-menu gap and never
    accepts keyboard or pointer focus.
*/
Item {
    objectName: "menuGap"
    implicitHeight: MD.Tokens.menu.verticalSegmentedGap
    focus: false
}
