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
import Fluid.Controls as FluidControls

Dialog {
    /*!
        \internal
    */
    default property alias content: dialogContent.data

    property alias text: dialogLabel.text

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    focus: true
    modal: true

    Column {
        id: dialogContent
        anchors {
            left: parent.left
            top: parent.top
        }
        spacing: FluidControls.Units.smallSpacing
        width: parent.width

        FluidControls.DialogLabel {
            id: dialogLabel
            wrapMode: Text.Wrap
            width: parent.width
            visible: text !== ""
        }
    }
}
