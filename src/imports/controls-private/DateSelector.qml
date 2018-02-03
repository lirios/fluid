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

import QtQml 2.2
import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Qt.labs.calendar 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates

FluidTemplates.DateSelector {
    id: control

    property alias currentItem: listView.currentItem

    onSelectedDateChanged: listView.currentIndex = listView.model.indexOf(selectedDate)

    navigator: Item {
        FluidControls.ToolButton {
            id: prevMonthButton

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16

            icon.source: FluidControls.Utils.iconUrl("navigation/chevron_left")

            onClicked: listView.currentIndex--;
        }

        FluidControls.SubheadingLabel {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: control.locale.standaloneMonthName(listView.currentItem.currentModel.month) + " " + listView.currentItem.currentModel.year
        }

        FluidControls.ToolButton {
            id: nextMonthButton

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 16

            icon.source: FluidControls.Utils.iconUrl("navigation/chevron_right")

            onClicked: listView.currentIndex++;
        }
    }

    calendar: Item {
        ListView {
            id: listView
            anchors.fill: parent
            clip: true
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 0
            Component.onCompleted: currentIndex = listView.model.indexOf(selectedDate)

            model: CalendarModel {
                id: calendarModel
                from: control.from
                to: control.to
            }

            delegate: GridLayout {
                id: monthGridDelegate

                property var currentModel: model

                columns: 2
                rows: 2
                width: listView.width
                height: listView.height

                DayOfWeekRow {
                    visible: dayOfWeekRowVisible
                    locale: grid.locale

                    Layout.column: 2
                    Layout.fillWidth: true
                    Layout.topMargin: 10

                    delegate: Label {
                        text: model.shortName
                        font.weight: Font.DemiBold
                        font.pixelSize: 13
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: control.Material.secondaryTextColor
                    }
                }

                WeekNumberColumn {
                    visible: weekNumberVisible
                    month: grid.month
                    year: grid.year
                    locale: grid.locale

                    Layout.fillHeight: true
                    Layout.column: 1
                    Layout.row: 1
                    Layout.rowSpan: 2
                    Layout.bottomMargin: 10
                    Layout.topMargin: 10

                    delegate: Label {
                        text: model.weekNumber
                        font.weight: Font.DemiBold
                        font.pixelSize: 13
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: control.Material.secondaryTextColor
                    }

                }

                MonthGrid {
                    id: grid
                    month: model.month
                    year: model.year
                    locale: control.locale

                    Layout.column: 2
                    Layout.row: 1
                    Layout.rowSpan: 2
                    Layout.bottomMargin: 10
                    Layout.topMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    delegate: Item {
                        id: dayDelegate

                        Rectangle {
                            anchors.centerIn: parent
                            width: Math.max(dayLabel.implicitHeight, dayLabel.implicitWidth) * 2
                            height: width
                            radius: width / 2
                            y: -dayLabel.height / 8
                            color: isEqual(selectedDate) ? control.Material.accent : "transparent"
                            visible: model.month === grid.month ? 1 : 0
                        }

                        Label {
                            id: dayLabel
                            text: model.day
                            font.weight: Font.DemiBold
                            font.pixelSize: 13
                            font.underline: isEqual(new Date())
                            width: parent.width
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: isEqual(selectedDate) ? "white" : (isEqual(new Date()) ? control.Material.accent : control.Material.primaryTextColor)
                            opacity: model.month === grid.month ? 1 : 0
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: model.month === grid.month
                            onClicked: control.selectedDate = model.date
                        }

                        function isEqual(date) {
                            return model.day === date.getDate() &&
                                    model.month === date.getMonth() &&
                                    model.year === date.getFullYear();
                        }
                    }
                }
            }
        }
    }
}
