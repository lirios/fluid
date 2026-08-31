// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import Fluid as MD
import QtQuick

/*!
    \class MenuSectionLabel
    \brief A non-interactive label identifying a menu section.

    Section labels use the menu's logical outer spacing and do not participate
    in menu keyboard navigation.
*/
Item {
    id: control
    objectName: "menuSectionLabel"

    //! Localized text displayed by the section label.
    property string text: ""

    implicitWidth: label.implicitWidth + MD.Tokens.menu.verticalItemLeadingSpace
                   + MD.Tokens.menu.verticalItemTrailingSpace
    implicitHeight: MD.Tokens.menu.verticalItemHeight
    focus: false

    MD.Label {
        id: label
        objectName: "menuSectionLabelText"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: MD.Tokens.menu.verticalItemLeadingSpace
        anchors.rightMargin: MD.Tokens.menu.verticalItemTrailingSpace
        text: control.text
        typescale: MD.Tokens.typescale.labelLarge
        color: control.MD.Style.onSurfaceVariantColor
        horizontalAlignment: control.LayoutMirroring.enabled ? Text.AlignRight : Text.AlignLeft
        elide: Text.ElideRight
    }
}
