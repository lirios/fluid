// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T
import Fluid as MD

/*!
    \class ScrollView
    \brief A scrolling viewport with Material-themed horizontal and vertical scrollbars.

    ScrollView supplies Fluid ScrollBar instances in both orientations and mirrors
    the vertical bar automatically for right-to-left layouts.

    Its scrolling behavior is provided by Qt Quick Controls, while its scrollbars
    follow the <a href="https://m3.material.io/components/scrollbar/overview">Material Design 3 scrollbar guidelines</a>.
*/
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
