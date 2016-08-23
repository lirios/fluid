/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Fluid.Core 1.0
import Fluid.Controls 1.0

Popup {
    property alias title: titleLabel.text
    property alias text: textLabel.text

    property alias positiveButton: positiveButton
    property alias negativeButton: negativeButton

    property string positiveButtonText: qsTr("Ok")
    property string negativeButtonText: qsTr("Cancel")

    default property alias dialogContent: dialogContentItem.data

    property bool __triggered

    padding: 0
    modal: true

    x: (Window.width - width)/2
    y: (Window.height - height)/2

    signal accepted
    signal rejected
    signal canceled

    onOpened: __triggered = false

    onAccepted: {
        __triggered = true
        close()
    }

    onRejected: {
        __triggered = true
        close()
    }

    onClosed: {
        if (!__triggered)
            canceled()
    }

    ColumnLayout {
        width: parent.width
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredWidth: column.implicitWidth + 48
            Layout.preferredHeight: column.implicitHeight + 48
            Layout.minimumWidth: Device.isMobile ? 280 : 300

            ColumnLayout {
                id: column

                anchors.centerIn: parent
                spacing: 0

                width: parent.width - 48

                TitleLabel {
                    id: titleLabel

                    Layout.fillWidth: true

                    wrapMode: Text.Wrap
                    visible: title != ""
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                    visible: titleLabel.visible && textLabel.visible
                }

                Label {
                    id: textLabel

                    Layout.fillWidth: true

                    font: FluidStyle.dialogFont
                    wrapMode: Text.Wrap
                    color: Material.secondaryTextColor
                    visible: text != ""
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                    visible: textLabel.visible
                }

                Item {
                    id: dialogContentItem
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 52

            spacing: 0

            Button {
                id: negativeButton

                Layout.alignment: Qt.AlignVCenter
                Material.foreground: Material.primaryColor

                text: negativeButtonText
                flat: true

                onClicked: rejected()
            }

            Item {
                Layout.preferredWidth: 8
            }

            Button {
                id: positiveButton

                Layout.alignment: Qt.AlignVCenter
                Material.foreground: Material.primaryColor

                text: positiveButtonText
                flat: true

                onClicked: accepted()
            }

            Item {
                Layout.preferredWidth: 8
            }
        }
    }
}
