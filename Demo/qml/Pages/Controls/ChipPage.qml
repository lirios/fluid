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
import QtQuick.Controls.Material 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.1 as FluidControls
import "../.." as Components

Components.StyledPage {
    Column {
        anchors.centerIn: parent
        spacing: 16

        Column {
            spacing: 16

            FluidControls.TitleLabel {
                text: qsTr("Input Chips")
            }

            FluidCore.SortFilterProxyModel {
                id: contactModel

                sourceModel: ListModel {
                    ListElement {
                        label: "Contact Name 1"
                        value: "primaryemail@email.com"
                        imageSource: "qrc:/images/balloon.jpg"
                    }
                    ListElement {
                        label: "Contact Name 2"
                        value: "email2@email.com"
                        imageSource: "qrc:/images/balloon.jpg"
                    }
                    ListElement {
                        label: "Contact Name 3"
                        value: "email3@email.com"
                        imageSource: "qrc:/images/balloon.jpg"
                    }
                }
                sortExpression: {
                    return (modelLeft.weight < modelRight.weight) && (modelRight.email < modelRight.email);
                }
            }

            Row {
                spacing: 8

                FluidControls.Chip {
                    id: inputChip1
                    iconItem: FluidControls.CircleImage {
                        source: inputChip1.selectedItem.imageSource
                        width: 24
                        height: 24
                    }
                    text: selectedItem.label
                    expandable: true
                    model: contactModel
                    onSelectedItemChanged: console.info(selectedItem.value)
                }

                FluidControls.Chip {
                    id: inputChip2
                    iconItem: FluidControls.CircleImage {
                        source: inputChip2.selectedItem.imageSource
                        width: 24
                        height: 24
                    }
                    text: selectedItem.label
                    expandable: true
                    deletable: true
                    model: contactModel
                    onDeleted: console.info(qsTr("Deleted"))
                    onSelectedItemChanged: console.info(selectedItem.value)
                }
            }
        }

        Column {
            spacing: 16

            FluidControls.TitleLabel {
                text: qsTr("Color Chips")
            }

            ButtonGroup {
                id: colorChipsGroup
            }

            Row {
                spacing: 8

                FluidControls.Chip {
                    id: colorChip1
                    iconItem: Rectangle {
                        width: 24
                        height: 24
                        radius: 12
                        color: Material.color(Material.Blue)

                        FluidControls.Icon {
                            anchors.centerIn: parent
                            source: colorChip1.checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                            size: 20
                        }
                    }
                    text: qsTr("Blue 500")
                    checkable: true
                    ButtonGroup.group: colorChipsGroup
                }

                FluidControls.Chip {
                    id: colorChip2
                    iconItem: Rectangle {
                        width: 24
                        height: 24
                        radius: 12
                        color: Material.color(Material.Green)

                        FluidControls.Icon {
                            anchors.centerIn: parent
                            source: colorChip2.checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                            size: 20
                        }
                    }
                    text: qsTr("Green 500")
                    checkable: true
                    ButtonGroup.group: colorChipsGroup
                }

                FluidControls.Chip {
                    id: colorChip3
                    iconItem: Rectangle {
                        width: 24
                        height: 24
                        radius: 12
                        color: Material.color(Material.Red)

                        FluidControls.Icon {
                            anchors.centerIn: parent
                            source: colorChip3.checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                            size: 20
                        }
                    }
                    text: qsTr("Red 500")
                    checkable: true
                    ButtonGroup.group: colorChipsGroup
                }
            }
        }

        Column {
            spacing: 16

            FluidControls.TitleLabel {
                text: qsTr("Choice Chips")
            }

            ButtonGroup {
                id: choiceChipsGroup
            }

            Row {
                id: choiceChips
                spacing: 8

                FluidControls.Chip {
                    checkable: true
                    checked: true
                    text: qsTr("Extra Soft")
                    ButtonGroup.group: choiceChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Soft")
                    ButtonGroup.group: choiceChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Medium")
                    ButtonGroup.group: choiceChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Hard")
                    ButtonGroup.group: choiceChipsGroup
                }
            }
        }

        Column {
            spacing: 16

            FluidControls.TitleLabel {
                text: qsTr("Filter Chips")
            }

            ButtonGroup {
                id: filterChipsGroup
                exclusive: false
            }

            Row {
                id: filterChips
                spacing: 8

                FluidControls.Chip {
                    checkable: true
                    checked: true
                    text: qsTr("Elevator")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Washer / Dryer")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Fireplace")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Wheelchair access")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Dogs ok")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }

                FluidControls.Chip {
                    checkable: true
                    text: qsTr("Cats ok")
                    icon.source: checked ? FluidControls.Utils.iconUrl("navigation/check") : ""
                    ButtonGroup.group: filterChipsGroup
                }
            }
        }

        Column {
            spacing: 16

            FluidControls.TitleLabel {
                text: qsTr("Chips")
            }

            Row {
                spacing: 8

                FluidControls.Chip {
                    text: qsTr("Chip")
                }
                FluidControls.Chip {
                    text: qsTr("Deletable chip")
                    deletable: true
                    onDeleted: console.info(qsTr("Deleted"))
                }
            }

            Row {
                spacing: 8

                FluidControls.Chip {
                    text: qsTr("Chip with icon")
                    icon.source: FluidControls.Utils.iconUrl("action/face")
                }
                FluidControls.Chip {
                    text: qsTr("Deletable chip with icon")
                    icon.source: FluidControls.Utils.iconUrl("social/person")
                    deletable: true
                    onDeleted: console.info(qsTr("Deleted"))
                }
            }

            Row {
                spacing: 8

                FluidControls.Chip {
                    iconItem: FluidControls.CircleImage {
                        source: "qrc:/images/balloon.jpg"
                        width: 24
                        height: 24
                    }
                    text: qsTr("Chip with image")
                }
                FluidControls.Chip {
                    iconItem: FluidControls.CircleImage {
                        source: "qrc:/images/balloon.jpg"
                        width: 24
                        height: 24
                    }
                    text: qsTr("Deletable chip with image")
                    deletable: true
                    onDeleted: console.info(qsTr("Deleted"))
                }
            }
        }
    }
}
