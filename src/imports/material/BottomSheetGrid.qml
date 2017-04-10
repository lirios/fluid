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

import QtQuick 2.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Templates 2.0 as T
import Fluid.Controls 1.0
import Fluid.Layouts 1.0 as FluidLayouts

/*!
    \qmltype BottomSheetGrid
    \inqmlmodule Fluid.Material
    \ingroup fluidmaterial

    \brief A sheet of paper with actions and an optional title that slides up from the bottom.

    A sheet of paper that displays actions in a grid and an optional title that slides up
    from the bottom edge of the screen and presents a set of clear and simple actions.
*/
BottomSheet {
    id: bottomSheet

    /*!
        Title.
    */
    property string title

    /*!
        Actions to display in the bottom sheet.
    */
    property list<Action> actions

    /*
        Number of columns.
        By default it's set to fit the screen width.
    */
    property alias columns: grid.columns

    /*!
        Number of rows.
        By default it's set to fit the screen size based on the \l columns.
    */
    property alias rows: grid.rows

    height: Math.min(implicitHeight, maxHeight)
    implicitHeight: listViewContainer.implicitHeight + (header.visible ? header.height : 0)

    Column {
        id: column

        anchors.fill: parent

        Subheader {
            id: header
            text: title
            visible: title !== ""
            height: 56
        }

        Item {
            id: listViewContainer

            width: parent.width
            height: title !== "" ? parent.height - header.height : parent.height

            implicitHeight: listView.contentHeight + listView.topMargin + listView.bottomMargin

            Flickable {
                id: listView

                clip: true

                width: parent.width
                height: parent.height

                interactive: bottomSheet.height < bottomSheet.implicitHeight

                topMargin: title !== "" ? 0 : 16
                bottomMargin: 24
                leftMargin: 16
                rightMargin: 16

                contentWidth: width
                contentHeight: grid.height

                ScrollIndicator.vertical: ScrollIndicator {}

                Grid {
                    id: grid

                    property int cellWidth: 96
                    property int cellHeight: 96

                    width: parent.width

                    spacing: 16

                    columns: Math.floor((width - leftMargin - rightMargin) / (cellWidth + spacing))
                    rows: Math.ceil(actions.length / columns)

                    Repeater {
                        model: actions

                        delegate: T.AbstractButton {
                            id: item

                            width: grid.cellWidth
                            height: grid.cellHeight

                            enabled: modelData.enabled
                            visible: modelData.visible

                            onClicked: {
                                bottomSheet.close();
                                modelData.triggered(item);
                            }

                            background: Ripple {
                                width: parent.width
                                height: parent.height
                                control: item
                            }

                            contentItem: Item {
                                implicitWidth: grid.cellWidth
                                implicitHeight: grid.cellHeight

                                Icon {
                                    id: icon

                                    anchors.top: parent.top
                                    anchors.topMargin: 8
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    name: modelData.iconName
                                    source: modelData.iconSource
                                    size: 48
                                }

                                Label {
                                    anchors.top: icon.bottom
                                    anchors.topMargin: 8
                                    width: parent.width

                                    text: modelData.text
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
