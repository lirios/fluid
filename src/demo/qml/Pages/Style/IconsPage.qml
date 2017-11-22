/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Fluid.Controls 1.0 as FluidControls
import Fluid.Layouts 1.0 as FluidLayouts
import Fluid.Demo 1.0 as FluidDemo

Page {
    header: Row {
        RadioButton {
            id: lightRadio
            text: qsTr("Light")
            checked: true
        }

        RadioButton {
            id: darkRadio
            text: qsTr("Dark")
        }
    }

    Material.theme: lightRadio.checked ? Material.Light : Material.Dark

    ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true

        ColumnLayout {
            anchors.fill: parent

            Repeater {
                model: FluidDemo.IconCategoryModel {}
                delegate: ColumnLayout {
                    id: entry

                    property string currentCategory: model.category

                    FluidControls.Subheader {
                        text: model.category
                    }

                    GridLayout {
                        columns: (scrollView.width * 0.8) / 48
                        columnSpacing: 16
                        rowSpacing: 16

                        Repeater {
                            model: FluidDemo.IconNameModel {
                                category: entry.currentCategory
                            }
                            delegate: FluidControls.Icon {
                                name: entry.currentCategory + "/" + model.name
                                size: 48

                                ToolTip.visible: iconMouseArea.containsMouse
                                ToolTip.text: name

                                MouseArea {
                                    id: iconMouseArea
                                    anchors.fill: parent
                                    acceptedButtons: Qt.NoButton
                                    hoverEnabled: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
