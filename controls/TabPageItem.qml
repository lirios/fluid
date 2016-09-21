 /*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import QtQuick.Controls 2.0

/*!
    \qmltype TabPageItem
    \inqmlmodule Fluid.Controls 1.0
    \brief An item for TabPage.

    \code
    TabPage {
        TabPageItem {
            title: qsTr("First")

            Label {
                anchors.centerIn: parent
                text: qsTr("First")
            }
        }

        TabPageItem {
            title: qsTr("Second")

            Label {
                anchors.centerIn: parent
                text: qsTr("Second")
            }
        }
    }
    \endcode
*/
Item {
    property alias buttons: bar.contentChildren
    readonly property alias position: bar.position

    default property alias contents: swipeView.contentChildren
    property alias count: swipeView.count
    property alias currentIndex: swipeView.currentIndex

    header: ToolBar {
        TabBar {
            id: bar
            width: parent.width
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: bar.currentIndex
    }
}
