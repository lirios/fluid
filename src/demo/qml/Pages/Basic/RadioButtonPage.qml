/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.1
import "../.." as Components

Components.StyledPageTwoColumns {
    leftColumn: ColumnLayout {
        anchors.centerIn: parent

        TitleLabel {
            text: qsTr("Enabled")

            Layout.alignment: Qt.AlignHCenter
        }

        RadioButton {
            checked: true
            text: checked ? qsTr("On") : qsTr("Off")
        }

        RadioButton {
            checked: false
            checkable: false
            text: qsTr("Off")
        }
    }

    rightColumn: ColumnLayout {
        anchors.centerIn: parent

        TitleLabel {
            text: qsTr("Disabled")

            Layout.alignment: Qt.AlignHCenter
        }

        RadioButton {
            enabled: false
            checked: true
            text: checked ? qsTr("On") : qsTr("Off")
        }

        RadioButton {
            enabled: false
            checked: false
            checkable: false
            text: qsTr("Off")
        }
    }
}
