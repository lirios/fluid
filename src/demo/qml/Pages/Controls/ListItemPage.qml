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

import QtQuick 2.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0
import "../.."

Page {
    ListView {
        anchors.fill: parent
        model: ListModel {
            ListElement { title: "List Item 1"; source: "qrc:/qml/Pages/Compound/SubPage.qml" }
            ListElement { title: "List Item 2"; source: "qrc:/qml/Pages/Compound/SubPage.qml" }
            ListElement { title: "List Item 3"; source: "qrc:/qml/Pages/Compound/SubPage.qml" }
            ListElement { title: "List Item 4"; source: "qrc:/qml/Pages/Compound/SubPage.qml" }
            ListElement { title: "List Item 5"; source: "qrc:/qml/Pages/Compound/SubPage.qml" }
        }
        header: Subheader {
            text: "Header"
        }
        delegate: ListItem {
            text: model.title
            onClicked: pageStack.push(model.source)
        }

        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
