// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T
import Fluid as MD

T.ScrollView {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    ScrollBar.vertical: MD.ScrollBar {
        parent: control

        x: control.mirrored ? 0 : control.width - width
        y: control.topPadding

        height: control.availableHeight

        active: control.ScrollBar.horizontal.active
    }

    ScrollBar.horizontal: MD.ScrollBar {
        parent: control

        x: control.leftPadding
        y: control.height - height

        width: control.availableWidth

        active: control.ScrollBar.vertical.active
    }
}
