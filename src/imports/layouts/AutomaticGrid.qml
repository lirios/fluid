/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
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

/*!
    \qmltype AutomaticGrid
    \inqmlmodule Fluid.Layouts
    \ingroup fluidlayouts

    \brief Lay out children in a grid that automatically fits the available space.

    \code
    import QtQuick 2.10
    import Fluid.Layouts 1.0 as FluidLayouts

    Item {
        width: 600
        height: 600

        FluidLayouts.AutomaticGrid {
            anchors.fill: parent
            cellWidth: 100
            cellHeight: cellWidth
            model: 20

            delegate: Rectangle {
                id: item
                height: 100.0 * Math.random()
                color: Qt.rgba(Math.random(), Math.random(), Math.random(), Math.random())
                Text {
                    text: index
                }
            }
        }
    }
    \endcode
*/
Grid {
    id: grid

    /*!
        \qmlproperty Component delegate
        \default

        The delegate provides a template defining each item istantiated by the grid.

        \sa Repeater::delegate
    */
    default property alias delegate: repeater.delegate

    /*!
        \qmlproperty real cellWidth

        Cell width.
    */
    property real cellWidth

    /*!
        \qmlproperty real cellHeight

        Cell height.
    */
    property real cellHeight

    /*!
        \qmlproperty any model

        The model providing data to the grid.

        This property can be set to any of the supported \l {qml-data-models}{data models}.

        \sa Repeater::model
    */
    property alias model: repeater.model

    /*!
        \qmlproperty real widthOverride

        Maximum width.
    */
    property real widthOverride: parent.width

    /*!
        \qmlproperty real heightOverride

        Maximum height.
    */
    property real heightOverride: parent.height

    /*!
        \qmlproperty real minColumnSpacing

        Minimum spacing between columns.
    */
    property real minColumnSpacing

    columns: {
        var flooredResult = Math.floor(widthOverride/cellWidth);
        if (flooredResult >= 1 && flooredResult <= repeater.count)
            if ((widthOverride - (flooredResult * cellWidth)) / (flooredResult + 1) < minColumnSpacing)
                return flooredResult - 1;
            else
                return flooredResult;
        else if (flooredResult > repeater.count)
            return repeater.count;
        else
            return 1;
    }

    columnSpacing: (widthOverride - (columns * cellWidth)) / (columns + 1) < (minColumnSpacing / 2) ? (minColumnSpacing / 2) : (widthOverride - (columns * cellWidth)) / (columns + 1)
    width: widthOverride - 2*columnSpacing

    Repeater {
        id: repeater
    }
}
