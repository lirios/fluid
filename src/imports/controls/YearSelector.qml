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
*/
Item {
    id: yearSelector

    property var minDate: new Date(1976, 0, 1)
    property var maxDate: new Date(2150, 11, 31)
    property var selectedDate: new Date()

    onSelectedDateChanged: yearTumbler.currentIndex = selectedDate.getFullYear() - minDate.getFullYear()

    Tumbler {
        id: yearTumbler

        function calcModel(startDate, endDate) {
            var model = [];
            if(startDate < endDate) {
                for(var i=startDate.getFullYear(); i < endDate.getFullYear(); i++) {
                    model.push(i);
                }
            }
            return model;
        }

        width: parent.width
        height: parent.height
        wrap: false
        visibleItemCount: 5
        model: calcModel(minDate, maxDate)
        delegate: FluidControls.SubheadingLabel {            
            text: modelData
            color: Material.primaryTextColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            font.bold: Tumbler.tumbler.currentIndex === index
            font.pixelSize: Tumbler.tumbler.currentIndex === index ? 24 : (20 - 2 * Math.abs(Tumbler.displacement))
        }
        onCurrentIndexChanged: {
            if(selectedDate.getFullYear() !== model[currentIndex]) {                
                selectedDate.setFullYear(model[currentIndex])
                selectedDate = new Date(selectedDate.getTime())
            }
        }
    }
}
