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

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid.Controls as FluidControls
import Fluid.Layouts as FluidLayouts
import Fluid.Demo as FluidDemo

Page {
    Material.theme: lightRadio.checked ? Material.Light : Material.Dark

    Row {
        id: themeRow
        anchors {
            top: parent.top
            left: parent.left
        }

        spacing: 16

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

    FluidControls.SearchBar {
        id: searchBar
        anchors.left: themeRow.right
    }

    ScrollView {
        id: scrollView
        anchors { left: parent.left; right: parent.right; top: searchBar.bottom; bottom: parent.bottom }

        clip: true

        ColumnLayout {
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
                                source: FluidControls.Utils.iconUrl(entry.currentCategory + "/" + model.name)
                                visible: model.name.indexOf(searchBar.searchText) !== -1
                                size: 48

                                ToolTip.visible: iconMouseArea.containsMouse
                                ToolTip.text: entry.currentCategory + "/" + model.name

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
