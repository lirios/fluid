// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

MD.GroupBox {
    required property int gridColumns
    property bool fullWidth: false

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignTop
    Layout.columnSpan: fullWidth ? gridColumns : gridColumns >= 12 ? 6 : Math.min(gridColumns, 4)
}
