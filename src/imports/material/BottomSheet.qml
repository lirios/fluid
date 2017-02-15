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
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype BottomSheet
    \inqmlmodule Fluid.Material
    \ingroup fluidmaterial

    \brief A sheet of paper that slides up from the bottom.

    A sheet of paper that slides up from the bottom edge of the screen and presents
    a set of clear and simple actions.
*/
Drawer {
    id: bottomSheet

    /*!
        \internal
    */
    default property alias content: containerPane.data

    /*!
        Maximum height of the bottom sheet.

        By default it's set to the height of the \c ApplicationWindow
        minus \c AppBar height.
    */
    property int maxHeight: ApplicationWindow.contentItem.height - ApplicationWindow.header.height

    modal: true
    edge: Qt.BottomEdge

    width: parent.width
    height: Math.min(containerPane.childrenRect.height, maxHeight)

    Pane {
        id: containerPane

        width: parent.width
        height: parent.height
    }
}
