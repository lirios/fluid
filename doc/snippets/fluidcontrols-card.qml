/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:FDL$
 *
 * Permission is granted to copy, distribute and/or modify this document
 * under the terms of the GNU Free Documentation License, Version 1.3
 * or any later version published by the Free Software Foundation;
 * with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
 * A copy of the license is included in the section entitled "GNU
 * Free Documentation License".
 *
 * $END_LICENSE$
 ***************************************************************************/

//! [file]
import QtQuick 2.10
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
//! [file]
