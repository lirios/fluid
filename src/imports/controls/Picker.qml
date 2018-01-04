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

import QtQml 2.2
import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates

/*!
    \qmltype Picker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Container for pickers. Used with time and datepicker

    This component is used as container for the time and datepicker.
    It shows the header on top in portrait orientation, on the left in landscape orientation

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.Picker {
            header: Item {
                anchors.fill: parent
                anchors.margins: 16
            }
            selector: Item {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.bottomMargin: 10
            }
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/components/pickers.html}{Material Design guidelines}.

*/
FluidTemplates.Picker {
    id: picker

    property bool __footerIsVisible: footer && footer.children.length > 0

    signal accepted(var date)
    signal rejected()

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    background: Pane {
        implicitWidth: picker.orientation === FluidTemplates.Picker.Landscape ? 500 : 340
        implicitHeight: picker.orientation === FluidTemplates.Picker.Landscape ? 350 : 470

        locale: picker.locale

        Material.elevation: __footerIsVisible ? 0 : 1
    }
}
