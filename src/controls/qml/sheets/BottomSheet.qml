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
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
    \brief A sheet of paper that slides up from the bottom.

    A sheet of paper that slides up from the bottom edge of the screen and presents
    a set of clear and simple actions.

    \code{.qml}
    import QtQuick
    import QtQuick.Controls.Material
    import Fluid as Fluid

    Item {
        Fluid.Button {
            anchors.centerIn: parent
            text: qsTr("Press Me")
            onClicked: customBottomSheet.open()
        }

        Fluid.BottomSheet {
            id: customBottomSheet

            Column {
                width: parent.width

                Fluid.Pane {
                    width: parent.width
                    padding: 16

                    Column {
                        spacing: 8

                        Fluid.TitleLabel {
                            text: "freedom"
                        }

                        Fluid.BodyLabel {
                            text: "/ˈfriːdəm/"
                            color: Material.secondaryTextColor
                        }
                    }

                    Material.background: Material.color(Material.Yellow, Material.Shade800)
                }

                Fluid.Pane {
                    width: parent.width
                    implicitHeight: 100
                    padding: 16

                    Column {
                        Fluid.SubheadingLabel {
                            text: "noun"
                            color: Material.secondaryTextColor
                        }

                        Fluid.BodyLabel {
                            text: "the right to live in the way you want without being controlled by anyone else"
                        }
                    }
                }
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/bottom-sheets.html">Material Design guidelines</a>.
*/
Drawer {
    id: bottomSheet

    /*!
        Maximum height of the bottom sheet.

        By default it's set to the height of the \ref ApplicationWindow
        minus \ref AppBar height.
    */
    property int maxHeight: ApplicationWindow.contentItem.height - ApplicationWindow.header.height

    modal: true
    edge: Qt.BottomEdge

    width: parent.width
    height: Math.min(containerPane.childrenRect.height, maxHeight)
}
