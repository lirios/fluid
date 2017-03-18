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

import QtQuick.Controls 2.0 as C
import QtQuick.Controls.Material 2.0

/*!
    \qmltype Card
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Cards display content composed of different elements.

    \code
    import QtQuick 2.4
    import Fluid.Controls 1.0 as FluidControls

    FluidControls.Card {
        anchors.centerIn: parent
        width: 400
        height: 400

        Image {
            id: picture
            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
            }
            height: 200
            source: "Yosemite.jpg"
        }

        Column {
            id: column
            anchors {
                left: parent.left
                top: picture.bottom
                right: parent.right
                margins: Units.smallSpacing * 2
            }
            spacing: Units.smallSpacing * 2

            FluidControls.TitleLabel {
                text: qsTr("Yosemite National Park")
            }

            FluidControls.BodyLabel {
                text: qsTr("First protected in 1864, Yosemite National Park " +
                           "is best known for its waterfalls, but within its " +
                           "nearly 1,200 square miles, you can find deep " +
                           "valleys, grand meadows, ancient giant sequoias, " +
                           "a vast wilderness area, and much more.")
                wrapMode: Text.WordWrap
                width: parent.width
            }

            Row {
                spacing: Units.smallSpacing

                Button {
                    text: qsTr("Share")
                    flat: true
                }

                Button {
                    text: qsTr("Explore")
                    flat: true
                }
            }
        }
    }
    \endcode
*/
C.Pane {
    padding: 0

    Material.background: "white"
    Material.elevation: 1
}
