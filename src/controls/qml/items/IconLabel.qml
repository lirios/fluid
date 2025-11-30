// Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts

Item {
    id: root

    enum Display {
        IconOnly,
        TextOnly,
        TextBesideIcon,
        TextUnderIcon
    }

    property alias icon: iconItem
    property alias text: label.text
    property alias font: label.font
    property alias color: label.color

    property real spacing: 6
    property bool mirrored: false
    property int display: IconLabel.TextBesideIcon

    readonly property bool horizontalPair: display === IconLabel.TextBesideIcon
    readonly property bool verticalPair: display === IconLabel.TextUnderIcon

    implicitWidth: grid.implicitWidth
    implicitHeight: grid.implicitHeight

    LayoutMirroring.enabled: mirrored
    LayoutMirroring.childrenInherit: true

    GridLayout {
        id: grid

        anchors.centerIn: parent
        columns: horizontalPair ? 2 : 1
        rows: verticalPair ? 2 : 1
        columnSpacing: horizontalPair ? root.spacing : 0
        rowSpacing: verticalPair ? root.spacing : 0

        MD.Symbol {
            id: iconItem

            visible: root.display !== IconLabel.TextOnly

            Layout.row: 0
            Layout.column: verticalPair ? 0 : (horizontalPair && root.mirrored ? 1 : 0)
            Layout.minimumWidth: 0
            Layout.minimumHeight: 0
            Layout.preferredWidth: visible ? implicitWidth : 0
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.alignment: verticalPair ? Qt.AlignHCenter : Qt.AlignVCenter
        }

        MD.Label {
            id: label

            visible: root.display !== IconLabel.IconOnly
            wrapMode: MD.Label.NoWrap

            Layout.row: verticalPair && iconItem.visible ? 1 : 0
            Layout.column: verticalPair ? 0 : (horizontalPair && root.mirrored ? 0 : (horizontalPair ? 1 : 0))
            Layout.minimumWidth: 0
            Layout.minimumHeight: 0
            Layout.preferredWidth: visible ? implicitWidth : 0
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.alignment: verticalPair ? Qt.AlignHCenter : Qt.AlignVCenter
        }
    }
}
