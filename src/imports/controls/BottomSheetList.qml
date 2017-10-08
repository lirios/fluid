/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
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
import Fluid.Controls 1.0

/*!
    \qmltype BottomSheetAction
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief A sheet of paper with actions and an optional title that slides up from the bottom.

    A sheet of paper that displays actions in a list and an optional title that slides up
    from the bottom edge of the screen and presents a set of clear and simple actions.

    \snippet fluidcontrols-bottomsheetlist.qml file

    For more information you can read the
    \l{https://material.io/guidelines/components/bottom-sheets.html}{Material Design guidelines}.
*/
BottomSheet {
    id: bottomSheet

    /*!
        \qmlproperty string title

        Title.
    */
    property string title

    /*!
        \qmlproperty list<Action> actions

        Actions to display in the bottom sheet.
    */
    property list<Action> actions

    height: Math.min(implicitHeight, maxHeight)
    implicitHeight: listViewContainer.implicitHeight + (header.visible ? header.height : 0)

    padding: 16

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

                topMargin: title !== "" ? 0 : 8
                bottomMargin: 8

                contentWidth: width
                contentHeight: subColumn.height

                ScrollIndicator.vertical: ScrollIndicator {}

                Column {
                    id: subColumn
                    width: parent.width

                    Repeater {
                        model: actions

                        delegate: Column {
                            width: parent.width

                            ListItem {
                                id: listItem

                                text: modelData.text
                                iconName: modelData.iconName
                                iconSource: modelData.iconSource
                                enabled: modelData.enabled
                                visible: modelData.visible

                                onClicked: {
                                    bottomSheet.close();
                                    modelData.triggered(listItem);
                                }
                            }

                            ThinDivider {
                                visible: modelData.hasDividerAfter
                            }
                        }
                    }
                }
            }
        }
    }
}
