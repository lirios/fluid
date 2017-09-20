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
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype Picker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Container for pickers. Used with time and datepicker

    This component is used as container for the time and datepicker.
    It shows the header on top in portrait orientation, on the left in landscape orientation

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.Picker {
            header: Item {
                anchors.fill: parent
                anchors.margins: 16
            }
            selector: Item {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.bottomMargin: 10
            }
        }
    }
    \endcode

*/
FluidControls.Card {
    id: pickerDialog

    property int orientation: Qt.LandscapeOrientation
    readonly property int footerHeight: 50
    property alias header: header.data
    property alias selector: selectorContainer.data
    property alias footer: footer.data
    property alias standardButtons: buttonBox.standardButtons
    property alias standardButtonsContainer: buttonBox.data

    signal accepted(var date)
    signal rejected()

    width: orientation === Qt.LandscapeOrientation ? 500 : 340
    height: orientation === Qt.LandscapeOrientation ? 350 : 470

    Control {
        id: picker
        implicitWidth: parent.width
        implicitHeight: parent.height

        GridLayout {
            id: content
            anchors.fill: parent
            columns: orientation === Qt.LandscapeOrientation ? 2 : 1
            rows: orientation === Qt.LandscapeOrientation ? 2 : 3
            anchors.margins: 0
            columnSpacing: 0
            rowSpacing: 0

            Rectangle {
                id: header
                Layout.column: 1
                Layout.row: 1
                Layout.rowSpan: orientation === Qt.LandscapeOrientation ? 2 : 1
                width: orientation === Qt.LandscapeOrientation ? parent.width / 3 : parent.width
                height: orientation === Qt.LandscapeOrientation ? parent.height : 96
                color: Material.accentColor
            }

            Item {
                id: selectorContainer
                Layout.row: pickerDialog.orientation === Qt.LandscapeOrientation ? 1 : 2
                Layout.column: pickerDialog.orientation === Qt.LandscapeOrientation ? 2 : 1
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                width: (pickerDialog.orientation === Qt.LandscapeOrientation ? picker.implicitWidth - header.width : picker.implicitWidth) - 10
                height: picker.implicitHeight - (pickerDialog.orientation === Qt.LandscapeOrientation ? 0 : header.height) - footer.height
            }

            Item {
                id: footer
                Layout.row: orientation === Qt.LandscapeOrientation ? 2 : 3
                Layout.column: orientation === Qt.LandscapeOrientation ? 2 : 1
                height: footerHeight
                width: orientation === Qt.LandscapeOrientation ? (parent.width / 3) * 2 : parent.width

                DialogButtonBox {
                    id: buttonBox
                    padding: 0
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle {
                        anchors.fill: parent
                        color: Material.background
                    }
                    onAccepted: pickerDialog.accepted(selectedDate)
                    onRejected: pickerDialog.rejected()
                }
            }
        }
    }
}
