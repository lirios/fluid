// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Rectangle {
    property alias value: label.text

    width: 24
    height: 24
    radius: width / 2

    border.color: "white"
    color: "#322F35"

    MD.Label {
        id: label

        anchors.centerIn: parent
        font.pixelSize: parent.height * 0.625
        font.weight: Font.Bold
        color: "white"
    }
}
