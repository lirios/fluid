import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import Fluid.Controls 1.0

TextField {
    id: root

    property alias title: placeholderLabel.text

    onPlaceholderTextChanged: placeholderText = ""
    Component.onCompleted: placeholderText = ""

    selectByMouse: true

    Label {
        id: placeholderLabel

        anchors {
            left: parent.left
            top: parent.top
        }

        font.bold: true

        readonly property int offset: Qt.application.font.pixelSize

        states: [
            State {
                name: "focused"
                when: root.focus
                PropertyChanges {
                    target: placeholderLabel

                    color: Material.accent
                    font.pointSize: Qt.application.font.pointSize
                    anchors.topMargin: -offset
                }
            },
            State {
                name: "notFocusedNotEmpty"
                when: !root.focus && root.text != ""
                PropertyChanges {
                    target: placeholderLabel

                    font.pointSize: Qt.application.font.pointSize
                    anchors.topMargin: -offset
                    color: Material.color(Material.Grey)
                }
            },
            State {
                name: "notFocusedEmpty"
                when: !root.focus && root.text == ""
                PropertyChanges {
                    target: placeholderLabel

                    color: Material.color(Material.Grey)
                    anchors.topMargin: offset
                    font.pointSize: Qt.application.font.pointSize + 2
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    properties: "anchors.topMargin,font.pointSize"
                    duration: Units.shortDuration
                    easing.type: Easing.InOutQuad
                }
                ColorAnimation {
                    duration: Units.shortDuration
                }
            }
        ]
    }
}
