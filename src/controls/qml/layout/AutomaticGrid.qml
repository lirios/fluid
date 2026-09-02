// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class AutomaticGrid
    \brief Lay out children in a grid that automatically fits the available space.

    AutomaticGrid is a Fluid layout utility rather than a Material 3 component.
    Its delegates can be styled with Material 3 tokens and styles as appropriate
    for the containing application.

    \code{.qml}
    import QtQuick
    import Fluid as Fluid

    Item {
        width: 600
        height: 600

        Fluid.AutomaticGrid {
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
    Accessible.ignored: true

    /*!
        The delegate provides a template defining each item instantiated by the grid.

        \sa Repeater::delegate
    */
    default property alias delegate: repeater.delegate

    /*!
        Cell width.
    */
    property real cellWidth

    /*!
        Cell height.
    */
    property real cellHeight

    /*!
        The model providing data to the grid.

        This property can be set to any of the supported <a href="https://doc.qt.io/qt-6/qtquick-modelviewsdata-modelview.html">Qt Quick data models</a>.

        \sa Repeater::model
    */
    property alias model: repeater.model

    /*!
        Maximum width.
    */
    property real widthOverride: parent.width

    /*!
        Maximum height.
    */
    property real heightOverride: parent.height

    /*!
        Minimum spacing between columns.
    */
    property real minColumnSpacing

    columns: {
        var flooredResult = Math.floor(widthOverride / cellWidth);
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
    width: widthOverride - 2 * columnSpacing

    Repeater {
        id: repeater
    }
}
