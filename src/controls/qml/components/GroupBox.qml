// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

T.GroupBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding, implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    label: MD.Label {
        x: Math.max(control.leftPadding, MD.Tokens.cornerRadiusExtraSmall)

        width: control.availableWidth

        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    background: Item {
        y: control.topPadding - control.bottomPadding

        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
    }
}
