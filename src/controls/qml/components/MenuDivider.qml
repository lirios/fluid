// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD

/*!
    \class MenuDivider
    \brief A non-interactive semantic divider for menu content.

    The line is inset by the menu's logical outer content spacing and mirrors
    automatically with its surrounding menu.
*/
MD.Divider {
    objectName: "menuDivider"
    leadingInset: MD.Tokens.menu.verticalItemLeadingSpace
    trailingInset: MD.Tokens.menu.verticalItemTrailingSpace
    focus: false
}
