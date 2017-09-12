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

import QtQml 2.2
import QtQuick 2.3
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

/*!
    \qmltype DateSelector
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief datePicker to select date between minDate and maxDate

    The DateSelector is used to select a date between minDate and maxDate.
    It's part of the DatePicker but can be used also standalone.

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.DateSelector {
            anchors.fill: parent
            minDate: new Date(1976, 0, 1)
            maxDate: new Date(2150, 11, 31)
            dayOfWeekRowVisible: false
            weekNumberVisible: false

            onSelectedDateChanged: {
                console.log(selectedDate)
            }
        }
    }

    \endcode
*/
Item {
    id: dateSelector

    property alias currentItem: listView.currentItem

    property int navigatorHeight: 50
    property int orientation: Qt.LandscapeOrientation
    property bool dayOfWeekRowVisible: true
    property bool weekNumberVisible: true
    property var selectedDate: new Date()
    onSelectedDateChanged: listView.currentIndex = listView.model.indexOf(selectedDate)
    property var minDate: new Date(1976, 0, 1)
    property var maxDate: new Date(2150, 11, 31)
    property var locale: Qt.locale()

    Column {
        width: parent.width
        height: parent.height

        Item {
            id: navigator

            height: navigatorHeight
            width: parent.width

            FluidControls.IconButton {
                id: prevMonthButton

                anchors.top: parent.top
                anchors.left: parent.left

                iconName: "navigation/chevron_left"
                iconColor: "black"

                onClicked: listView.currentIndex--;
            }

            FluidControls.SubheadingLabel {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: dateSelector.locale.standaloneMonthName(listView.currentItem.currentModel.month) + " " + listView.currentItem.currentModel.year
            }

            FluidControls.IconButton {
                id: nextMonthButton

                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 16

                iconName: "navigation/chevron_right"
                iconColor: "black"

                onClicked: listView.currentIndex++;
            }
        }

        Item {
            width: parent.width
            height: parent.height - navigator.height

            ListView {
                id: listView
                anchors.fill: parent
                clip: true
                snapMode: ListView.SnapOneItem
                orientation: ListView.Horizontal
                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightMoveDuration: 200
                Component.onCompleted: currentIndex = listView.model.indexOf(selectedDate)

                model: CalendarModel {
                    id: calendarModel
                    from: minDate
                    to: maxDate
                }

                move: Transition {
                    NumberAnimation { properties: "x,y"; duration: 1 }
                }
                moveDisplaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 10 }
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
                            color: Material.secondaryTextColor
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
                            color: Material.secondaryTextColor
                        }

                    }

                    MonthGrid {
                        id: grid
                        month: model.month
                        year: model.year
                        locale: dateSelector.locale

                        Layout.column: 2
                        Layout.row: 1
                        Layout.rowSpan: 2
                        Layout.bottomMargin: 10
                        Layout.topMargin: 10
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        delegate: Item {
                            function isEqual(date) {
                                return model.day === date.getDate() && model.month === date.getMonth() && model.year === date.getFullYear()
                            }

                            id: dayDelegate

                            Rectangle {
                                width: Math.max(dayLabel.implicitHeight, dayLabel.implicitWidth) * 2
                                height: width
                                radius: width / 2
                                y: -dayLabel.height / 8
                                color: isEqual(selectedDate) ? Material.accent : "transparent"
                                visible: model.month === grid.month ? 1 : 0
                                anchors.centerIn: parent
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
                                color: isEqual(selectedDate) ? "white" : (isEqual(new Date()) ? Material.accent : Material.primaryTextColor)
                                opacity: model.month === grid.month ? 1 : 0
                            }
                            MouseArea {
                                anchors.fill: parent
                                enabled: model.month === grid.month
                                onClicked: selectedDate = model.date
                            }
                        }
                    }
                }
            }
        }
    }
}
