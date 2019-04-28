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

import QtQuick 2.10
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import Fluid.Controls 1.0 as FluidControls
import "../.."

Page {
    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width

            FluidControls.ListItem {
                text: "ListItem with only text"
            }

            FluidControls.ListItem {
                text: "ListItem with sub text"
                subText: "Sub text"
            }

            FluidControls.ListItem {
                text: "ListItem with sub text and 2/2 lines"
                subText: "Sub text line 1\nSub text line 2"
            }

            FluidControls.ListItem {
                text: "ListItem with sub text and 3/3 lines"
                subText: "Sub text line 1\nSub text line 2\nSub text line 3"
                maximumLineCount: 3
            }

            FluidControls.ListItem {
                text: "ListItem with sub text and 4/4 lines"
                subText: "Sub text line 1\nSub text line 2\nSub text line 3\nSub text line 4"
                maximumLineCount: 4
            }

            FluidControls.ListItem {
                text: "ListItem with sub text and 5/3 lines"
                subText: "Sub text line 1\nSub text line 2\nSub text line 3\nSub text line 4\nSub text line 5"
                maximumLineCount: 3
            }

            FluidControls.ListItem {
                text: "ListItem with value text"
                valueText: "Value"
            }

            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/event")
                text: "ListItem with icon"
            }

            FluidControls.ListItem {
                text: "ListItem with custom rightItem"
                rightItem: Switch {
                    anchors.centerIn: parent
                    checked: true
                }
            }

            FluidControls.ListItem {
                text: "ListItem with custom secondaryItem"
                secondaryItem: Slider {
                    width: parent.width
                    from: 0
                    to: 100
                    value: 50
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
