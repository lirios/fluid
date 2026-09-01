// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD
import QtQuick

/*!
    \class MenuDivider
    \brief A non-interactive semantic divider for menu content.

    The line is inset by the menu's logical outer content spacing and mirrors
    automatically with its surrounding menu. In a vertical Menu it separates
    adjacent item-shape groups while retaining a single elevated surface.
*/
MD.Divider {
    objectName: "menuDivider"
    readonly property int _menuContentType: 1

    leadingInset: MD.Tokens.menu.verticalDividerInset
    trailingInset: MD.Tokens.menu.verticalDividerInset
    enabled: false
    focus: false
    Accessible.role: Accessible.Separator
}
