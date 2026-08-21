// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
    \class Divider
    \brief A Material Design 3 divider.

    Dividers are thin lines that group content in lists or other containers.  A
    divider can be full-width, inset on one side, or inset on both sides by
    setting \c leadingInset and \c trailingInset, and can be laid out
    horizontally or vertically via \c orientation.

    \code
    MD.Divider {
        Layout.fillWidth: true
    }

    MD.Divider {
        Layout.fillWidth: true
        leadingInset: MD.Tokens.divider.inset
    }

    MD.Divider {
        Layout.fillWidth: true
        leadingInset: MD.Tokens.divider.inset
        trailingInset: MD.Tokens.divider.inset
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/divider/overview">Material Design 3 guidelines</a>.
*/
Item {
    id: control

    /*!
        \brief The orientation of the divider.

        Either \c Qt.Horizontal (the default) or \c Qt.Vertical.
    */
    property int orientation: Qt.Horizontal

    /*!
        \brief Inset applied before the divider line.

        For a horizontal divider this is a left margin, for a vertical divider
        a top margin.  Defaults to \c 0, meaning a full-width divider.  Set to
        \c MD.Tokens.divider.inset to align it with leading list item content.
    */
    property real leadingInset: 0

    /*!
        \brief Inset applied after the divider line.

        For a horizontal divider this is a right margin, for a vertical
        divider a bottom margin.  Defaults to \c 0.  Set alongside \c leadingInset to \c MD.Tokens.divider.inset for a middle-inset divider.
    */
    property real trailingInset: 0

    /*!
        \brief The color of the divider line.

        Defaults to \c control.MD.Style.outlineVariantColor.
    */
    property color color: control.MD.Style.outlineVariantColor

    implicitWidth: control.orientation === Qt.Vertical ? MD.Tokens.divider.thickness : 0
    implicitHeight: control.orientation === Qt.Horizontal ? MD.Tokens.divider.thickness : 0

    Rectangle {
        objectName: "dividerLine"

        anchors.fill: parent
        anchors.leftMargin: control.orientation === Qt.Horizontal ? control.leadingInset : 0
        anchors.rightMargin: control.orientation === Qt.Horizontal ? control.trailingInset : 0
        anchors.topMargin: control.orientation === Qt.Vertical ? control.leadingInset : 0
        anchors.bottomMargin: control.orientation === Qt.Vertical ? control.trailingInset : 0

        color: control.color
    }
}
