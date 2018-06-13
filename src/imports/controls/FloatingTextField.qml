import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Templates 2.4 as T

import Fluid.Controls 1.0

T.TextField {
    id: control

    implicitWidth: Math.max((background ? background.implicitWidth : 0),
                            placeholderText ?
                                placeholder.implicitWidth +
                                leftPadding + rightPadding : 0) ||
                   (contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             (background ? background.implicitHeight : 0),
                             placeholder.implicitHeight + topPadding + bottomPadding)

    topPadding: contentHeight
    bottomPadding: Units.smallSpacing * 2

    selectByMouse: true

    Label {
        id: placeholder

        anchors.top: parent.top
        x: control.leftPadding

        font: control.font
        text: control.placeholderText
        elide: Label.AlignRight
        width: control.width - (control.leftPadding + control.rightPadding)

        readonly property int offset: Qt.application.font.pixelSize


        states: [
            State {
                name: "focused"
                when: control.focus
                PropertyChanges {
                    target: placeholder

                    color: enabled ? Material.accent : Material.hintTextColor
                    font.pointSize: Qt.application.font.pointSize
                    anchors.topMargin: 0
                }
            },
            State {
                name: "notFocusedNotEmpty"
                when: !control.focus && control.text != ""
                PropertyChanges {
                    target: placeholder

                    font.pointSize: Qt.application.font.pointSize
                    anchors.topMargin: 0
                    color: Material.hintTextColor
                }
            },
            State {
                name: "notFocusedEmpty"
                when: !control.focus && control.text == ""
                PropertyChanges {
                    target: placeholder

                    color: Material.hintTextColor
                    anchors.topMargin: offset * 2
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

    background: Rectangle {
        y: control.height - height - control.bottomPadding + 8
        implicitWidth: 120
        height: control.activeFocus || control.hovered ? 2 : 1
        color: control.activeFocus ?
                   control.Material.accentColor :
                   (control.hovered ?
                        control.Material.primaryTextColor :
                        control.Material.hintTextColor)
    }
}
