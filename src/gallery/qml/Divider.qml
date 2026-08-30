// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property int sectionSpacing: 24

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: parent.width
            spacing: page.sectionSpacing

            MD.Label {
                Layout.fillWidth: true
                Layout.margins: page.sectionSpacing

                text: qsTr("Full-width")
            }

            MD.Divider {
                Layout.fillWidth: true
            }

            MD.Label {
                Layout.fillWidth: true
                Layout.margins: page.sectionSpacing

                text: qsTr("Inset")
            }

            MD.Divider {
                Layout.fillWidth: true

                leadingInset: MD.Tokens.divider.inset
            }

            MD.Label {
                Layout.fillWidth: true
                Layout.margins: page.sectionSpacing

                text: qsTr("Middle-inset")
            }

            MD.Divider {
                Layout.fillWidth: true

                leadingInset: MD.Tokens.divider.inset
                trailingInset: MD.Tokens.divider.inset
            }

            MD.Label {
                Layout.fillWidth: true
                Layout.margins: page.sectionSpacing

                text: qsTr("Vertical")
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.margins: page.sectionSpacing
                Layout.preferredHeight: 64

                spacing: page.sectionSpacing

                MD.Label {
                    text: qsTr("Left")
                }

                MD.Divider {
                    Layout.fillHeight: true

                    orientation: Qt.Vertical
                }

                MD.Label {
                    text: qsTr("Right")
                }
            }
        }
    }
}
