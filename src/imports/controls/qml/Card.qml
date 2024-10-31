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

import Fluid.Templates as FluidTemplates

/*!
    \brief Cards display content composed of different elements.

    \code{.qml}
    import QtQuick
    import Fluid as Fluid

    Fluid.Card {
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
                margins: Fluid.Units.smallSpacing * 2
            }
            spacing: Fluid.Units.smallSpacing * 2

            Fluid.TitleLabel {
                text: qsTr("Yosemite National Park")
            }

            Fluid.BodyLabel {
                text: qsTr("First protected in 1864, Yosemite National Park " +
                        "is best known for its waterfalls, but within its " +
                        "nearly 1,200 square miles, you can find deep " +
                        "valleys, grand meadows, ancient giant sequoias, " +
                        "a vast wilderness area, and much more.")
                wrapMode: Text.WordWrap
                width: parent.width
            }

            Row {
                spacing: Fluid.Units.smallSpacing

                Fluid.Button {
                    text: qsTr("Share")
                    flat: true
                }

                Fluid.Button {
                    text: qsTr("Explore")
                    flat: true
                }
            }
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/components/cards.html">Material Design guidelines</a>.
*/
FluidTemplates.Card {
}
