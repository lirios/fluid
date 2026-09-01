// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD
import QtQuick

/*!
    \class MenuGap
    \brief A non-interactive gap between Expressive menu segments.

    MenuGap occupies the specified Material segmented-menu gap and never
    accepts keyboard or pointer focus. In a vertical Menu it ends the current
    elevated surface and starts another. Material recommends using no more
    than two gaps and avoiding gaps in scrollable menus; these usage guidelines
    are intentionally not enforced at runtime.
*/
Item {
    objectName: "menuGap"
    readonly property int _menuContentType: 2

    implicitHeight: MD.Tokens.menu.verticalSegmentedGap
    enabled: false
    focus: false
    Accessible.ignored: true
}
