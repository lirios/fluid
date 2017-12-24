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
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates

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

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.

*/
FluidTemplates.Picker {
    id: picker

    readonly property int footerHeight: 50
    property alias header: header.data
    property alias selector: selectorContainer.data
    property alias footer: footer.data
    property alias standardButtons: buttonBox.standardButtons
    property alias standardButtonsContainer: buttonBox.data

    signal accepted(var date)
    signal rejected()

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    background: FluidControls.Card {
        implicitWidth: picker.orientation === FluidTemplates.Picker.Landscape ? 500 : 340
        implicitHeight: picker.orientation === FluidTemplates.Picker.Landscape ? 350 : 470

        locale: picker.locale

        Control {
            id: control

            implicitWidth: parent.width
            implicitHeight: parent.height

            GridLayout {
                id: content
                anchors.fill: parent
                columns: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 1
                rows: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 3
                anchors.margins: 0
                columnSpacing: 0
                rowSpacing: 0

                Rectangle {
                    id: header
                    Layout.column: 1
                    Layout.row: 1
                    Layout.rowSpan: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 1
                    width: picker.orientation === FluidTemplates.Picker.Landscape ? parent.width / 3 : parent.width
                    height: picker.orientation === FluidTemplates.Picker.Landscape ? parent.height : 96
                    color: picker.Material.accentColor
                }

                Item {
                    id: selectorContainer
                    Layout.row: picker.orientation === FluidTemplates.Picker.Landscape ? 1 : 2
                    Layout.column: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 1
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                    width: (picker.orientation === FluidTemplates.Picker.Landscape ? control.implicitWidth - header.width : control.implicitWidth) - 10
                    height: control.implicitHeight - (picker.orientation === FluidTemplates.Picker.Landscape ? 0 : header.height) - footer.height
                }

                Item {
                    id: footer
                    Layout.row: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 3
                    Layout.column: picker.orientation === FluidTemplates.Picker.Landscape ? 2 : 1
                    height: footerHeight
                    width: picker.orientation === FluidTemplates.Picker.Landscape ? (parent.width / 3) * 2 : parent.width

                    DialogButtonBox {
                        id: buttonBox
                        padding: 0
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                            anchors.fill: parent
                            color: picker.Material.background
                        }
                        onAccepted: picker.accepted(selectedDate)
                        onRejected: picker.rejected()
                    }
                }
            }
        }
    }
}
