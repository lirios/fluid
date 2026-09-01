// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class GroupBox
    \brief Groups related controls under a shared title and outline.

    GroupBox uses the inherited \c title and \c contentItem API. Its label and
    outline automatically follow the current Material color and typography theme.

    GroupBox is a Qt Quick Controls container styled by Fluid; Material 3 does
    not define a standalone group box component.
*/
T.GroupBox {
    id: control

    Accessible.role: Accessible.Grouping
    Accessible.name: title

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding, implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    label: MD.Label {
        x: Math.max(control.leftPadding, MD.Tokens.measurement.space50)

        width: control.availableWidth

        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        Accessible.ignored: true
    }

    background: Item {
        y: control.topPadding - control.bottomPadding

        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
    }
}
