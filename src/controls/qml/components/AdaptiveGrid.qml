// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \class AdaptiveGrid
    \brief An equal-column Material Design 3 grid that adapts to width breakpoints.

    AdaptiveGrid places its child items in an internal GridLayout. Set the
    standard Layout attached properties on each child to choose its row,
    logical column, and spans. The number of columns and default horizontal
    spacing adapt to referenceWidth.

    \code{.qml}
    import QtQuick
    import QtQuick.Layouts
    import Fluid as MD

    MD.AdaptiveGrid {
        width: 840

        Rectangle {
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.fillWidth: true
            implicitHeight: 80
        }
    }
    \endcode
*/
Item {
    id: control

    /*!
        The objects managed by the internal GridLayout.

        Visual children can use Layout.row, Layout.column, Layout.rowSpan, and
        Layout.columnSpan in the same way as direct children of GridLayout.
    */
    default property alias contentData: layout.data

    /*!
        The width used to select breakpoint.

        It defaults to this item's width. Assigning another value overrides
        width-based adaptation until the default binding is restored.
    */
    property real referenceWidth: width

    /*! The breakpoint selected from referenceWidth. */
    readonly property int breakpoint: MD.Breakpoints.fromWidth(referenceWidth)

    /*! The number of equal grid columns for breakpoint. */
    readonly property int columns: MD.Breakpoints.columnCount(breakpoint)

    /*!
        The horizontal space between each outer edge and the grid content.

        The adaptive default is 16 dp for Compact and 24 dp for other
        breakpoints. Assigning a value overrides that default.
    */
    property real margins: MD.Breakpoints.margin(breakpoint)

    /*!
        The horizontal space between adjacent columns.

        The adaptive default is 16 dp for Compact and 24 dp for other
        breakpoints. Assigning a value overrides that default.
    */
    property real columnSpacing: MD.Breakpoints.gutter(breakpoint)

    /*!
        The vertical space between adjacent rows.

        The default is zero. Assigning a value overrides that default.
    */
    property real rowSpacing: MD.Tokens.measurement.space0

    /*!
        The direction in which the internal GridLayout places items.

        The default is GridLayout.LeftToRight. This property forwards directly
        to the internal GridLayout.
    */
    property alias flow: layout.flow

    /*!
        The horizontal layout direction used by the grid and ruler helpers.

        Set this to Qt.RightToLeft to mirror physical column placement while
        preserving logical column numbering. This property forwards directly
        to the internal GridLayout.
    */
    property alias layoutDirection: layout.layoutDirection

    /*! The non-negative width between the two outer horizontal margins. */
    readonly property real contentWidth: Math.max(0, width - 2 * margins)

    /*!
        The calculated width of one equal grid column.

        It is zero when the available content width cannot accommodate the
        configured gutters.
    */
    readonly property real columnWidth: Math.max(0, (contentWidth - (columns - 1) * columnSpacing) / columns)

    implicitWidth: layout.implicitWidth + 2 * margins
    implicitHeight: layout.implicitHeight

    /*!
        Returns the physical left edge of logical column \a index in local
        coordinates, including the outer margin.

        Logical column zero is the leftmost column in left-to-right layouts and
        the rightmost column in right-to-left layouts. An invalid, non-integer
        index returns NaN.
    */
    function columnLeft(index) {
        if (!Number.isInteger(index) || index < 0 || index >= columns)
            return NaN;

        const physicalIndex = layoutDirection === Qt.RightToLeft ? columns - index - 1 : index;
        return margins + physicalIndex * (columnWidth + columnSpacing);
    }

    /*!
        Returns the physical right edge of logical column \a index in local
        coordinates, including the outer margin.

        An invalid, non-integer index returns NaN.
    */
    function columnRight(index) {
        const left = columnLeft(index);
        return Number.isNaN(left) ? NaN : left + columnWidth;
    }

    /*!
        Returns the width occupied by \a span adjacent columns and their
        intervening gutters.

        A span must be an integer from one through columns. An invalid span
        returns NaN.
    */
    function spanWidth(span) {
        if (!Number.isInteger(span) || span < 1 || span > columns)
            return NaN;
        return span * columnWidth + (span - 1) * columnSpacing;
    }

    GridLayout {
        id: layout

        x: control.margins
        width: control.contentWidth
        height: control.height
        columns: control.columns
        columnSpacing: control.columnSpacing
        rowSpacing: control.rowSpacing
        uniformCellWidths: true
    }
}
