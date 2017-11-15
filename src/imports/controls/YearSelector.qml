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
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype YearSelector
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Tumbler to select a year between minDate and maxDate

    The YearSelector is used to select a year between minDate and maxDate.
    It's part of the DatePicker but can be used also standalone.

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.YearSelector {
            anchors.fill: parent
            minDate: new Date(1976, 0, 1)
            maxDate: new Date(2150, 11, 31)

            onSelectedDateChanged: {
                console.log(selectedDate)
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.
*/
Item {
    id: yearSelector

    property var minDate: new Date(1976, 0, 1)
    property var maxDate: new Date(2150, 11, 31)
    property var selectedDate: new Date()
    property var __model: []
    property int visibleItemCount: 7

    function calcModel(startDate, endDate) {
        var model = []
        if(startDate < endDate) {
            for(var i=startDate.getFullYear(); i < endDate.getFullYear(); i++) {
                model.push(i);
            }
        }
        __model = model;
    }

    onMinDateChanged: calcModel(minDate, maxDate)
    onMaxDateChanged: calcModel(minDate, maxDate)

    ListView {
        id: listView
        width: parent.width
        height: parent.height
        clip: true
        model: __model
        currentIndex: selectedDate.getFullYear() - minDate.getFullYear()
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 0
        preferredHighlightBegin: height / 2 - height / yearSelector.visibleItemCount / 2
        preferredHighlightEnd: height / 2 + height / yearSelector.visibleItemCount / 2
        delegate: FluidControls.SubheadingLabel {
            text: modelData
            color: ListView.view.currentIndex === index ? Material.accent : Material.primaryTextColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: ListView.view.currentIndex === index
            font.pixelSize: ListView.view.currentIndex === index ? 24 : 16
            height: listView.height / yearSelector.visibleItemCount
            width: parent.width
        }
        onCurrentIndexChanged: {
            if(selectedDate.getFullYear() !== model[currentIndex]) {
                selectedDate.setFullYear(model[currentIndex])
                selectedDate = new Date(selectedDate.getTime())
            }
        }
    }
    Component.onCompleted: {
        calcModel(minDate, maxDate)
        yearSelector.onSelectedDateChanged.connect(function() {
            listView.currentIndex = selectedDate.getFullYear() - minDate.getFullYear()
        });
        listView.currentIndex = selectedDate.getFullYear() - minDate.getFullYear()
    }
}
