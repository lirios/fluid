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

    /*! The corner radius of the group box outline. */
    property real radius: MD.Tokens.shape.cornerValueMedium

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding, implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    spacing: MD.Tokens.measurement.space75
    padding: MD.Tokens.measurement.space150
    topPadding: padding + (implicitLabelWidth > 0 ? implicitLabelHeight : 0)

    label: MD.Label {
        objectName: "groupBoxLabel"

        x: Math.max(control.leftPadding, MD.Tokens.measurement.space50)

        width: control.availableWidth

        text: control.title
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        Accessible.ignored: true
    }

    background: Rectangle {
        objectName: "groupBoxBackground"

        y: control.topPadding - control.bottomPadding

        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding

        color: "transparent"
        radius: control.radius
        border.width: 1
        border.color: control.MD.Style.outlineVariantColor
    }
}
