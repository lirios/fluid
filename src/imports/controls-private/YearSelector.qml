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
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates

FluidTemplates.YearSelector {
    id: control

    delegate: FluidControls.SubheadingLabel {
        text: model.year
        color: ListView.view.currentIndex === index ? control.Material.accent : control.Material.primaryTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: ListView.view.currentIndex === index
        font.pixelSize: ListView.view.currentIndex === index ? 24 : 16
        width: parent.width
        height: control.contentItem.height / control.visibleItemCount
    }

    contentItem: ListView {
        width: parent.width
        height: parent.height
        clip: true
        model: control.model
        delegate: control.delegate
        currentIndex: control.selectedYear - control.from.getFullYear()
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 0
        preferredHighlightBegin: height / 2 - height / control.visibleItemCount / 2
        preferredHighlightEnd: height / 2 + height / control.visibleItemCount / 2
        onCurrentIndexChanged: {
            var year = model.get(currentIndex);
            if (control.selectedYear !== year)
                control.selectedYear = year;
        }
    }
}
