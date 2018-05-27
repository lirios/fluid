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
import Fluid.Controls 1.1 as FluidControls
import "../.."

Flickable {
    id: root

    contentHeight: content.height + padding * 2

    clip: true

    property int padding: 16

    ScrollBar.vertical: ScrollBar {}

    Column {
        id: content

        anchors.top: parent.top
        anchors.topMargin: root.padding
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: root.padding
        anchors.rightMargin: root.padding

        spacing: 1

        ButtonGroup { id: panelsExlusiveGroup }

        FluidControls.ExpansionPanel {
            id: tripNamePanel

            width: parent.width

            summaryTitle: qsTr("Trip name")

            ButtonGroup.group: panelsExlusiveGroup

            expandedPanelDelegate: Item {
                height: childrenRect.height

                TextField {
                    id: tripNameField

                    width: parent.width

                    placeholderText: qsTr("Insert the trip name")

                    text: qsTr("Carribean cruise")

                    Binding {
                        target: tripNamePanel
                        property: "summarySubtitle"
                        value: tripNameField.text ? tripNameField.text : tripNameField.placeholderText
                    }
                }
            }
        }

        FluidControls.ExpansionPanel {
            id: locationPanel

            width: parent.width

            summaryTitle: qsTr("Location")

            ButtonGroup.group: panelsExlusiveGroup

            expandedPanelDelegate: Column {

                RadioButton {
                    id: barbadosRadioButton

                    anchors.horizontalCenter: parent.horizontalCenter

                    checked: false

                    text: qsTr("Barbados")
                }

                RadioButton {
                    id: dominicaRadioButton

                    anchors.horizontalCenter: parent.horizontalCenter

                    checked: false

                    text: qsTr("Dominica")
                }

                Binding {
                    target: locationPanel
                    property: "summarySubtitle"
                    value: barbadosRadioButton.checked ? barbadosRadioButton.text : (dominicaRadioButton.checked ? dominicaRadioButton.text : qsTr("No location selected"))
                }
            }
        }

        FluidControls.ExpansionPanel {
            id: carrierPanel

            width: parent.width

            summaryTitle: qsTr("Carrier")

            ButtonGroup.group: panelsExlusiveGroup

            expandedPanelDelegate: Column {

                RadioButton {
                    id: bestLineRadioButton

                    anchors.horizontalCenter: parent.horizontalCenter

                    checked: false

                    text: qsTr("The best cruise line")
                }

                RadioButton {
                    id: worstLineRadioButton

                    anchors.horizontalCenter: parent.horizontalCenter

                    checked: false

                    text: qsTr("The worst cruise line")
                }

                Binding {
                    target: carrierPanel
                    property: "summarySubtitle"
                    value: bestLineRadioButton.checked ? bestLineRadioButton.text : (worstLineRadioButton.checked ? worstLineRadioButton.text : qsTr("No carrier selected"))
                }
            }
        }

        FluidControls.ExpansionPanel {
            id: customPanel

            width: parent.width

            ButtonGroup.group: panelsExlusiveGroup

            summaryDelegate: Row {
                height: 100

                spacing: 10

                Label {
                    width: (parent.width - parent.spacing*2) /3

                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Column 1")
                }

                Label {
                    width: (parent.width - parent.spacing*2) /3

                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Column 2")
                }

                Label {
                    width: (parent.width - parent.spacing*2) /3

                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Column 3")
                }
            }

            expandedPanelDelegate: Label {
                text: qsTr("This is a customized panel")
            }
        }
    }
}
