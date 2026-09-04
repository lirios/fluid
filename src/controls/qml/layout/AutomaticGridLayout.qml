// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

/*!
    \class AutomaticGridLayout
    \brief Lay out children in equal adaptive cells that fit the available space.

    AutomaticGridLayout is a Fluid layout utility influenced by AndroidX
    adaptive grid cells. It is not a standalone Material 3 component. Add items
    directly to it and use the standard Layout attached properties to control
    how each item participates in the grid.

    Since it derives from GridLayout, flow, layoutDirection, spans, alignment,
    margins, and fill behavior follow the Qt Quick Layouts contract.

    The minimum cell size is inferred from the largest effective preferred or
    implicit size of the visible children. Remaining space is distributed over
    equal tracks while columnSpacing and rowSpacing remain exact. Assign
    cellWidth or cellHeight to override the inferred value.

    It can be declared directly inside a GroupBox. In the default left-to-right
    flow, the available width determines the column limit and additional items
    increase the implicit height. Top-to-bottom flow uses the available height
    as the row limit and increases the implicit width.

    For more information about the adaptive-cell behavior, see
    <a href="https://developer.android.com/reference/kotlin/androidx/compose/foundation/lazy/grid/GridCells.Adaptive">GridCells.Adaptive</a>.

    \code{.qml}
    import QtQuick
    import QtQuick.Layouts
    import Fluid as Fluid

    Fluid.AutomaticGridLayout {
        width: 600

        Rectangle {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
        }

        Rectangle {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
        }
    }
    \endcode

    \sa GridLayout, GroupBox
*/
GridLayout {
    id: grid
    Accessible.ignored: true

    /*!
        The minimum width of an adaptive cell.

        The default is the largest effective preferred or implicit width among
        visible children. Assigning a value overrides that inference.
    */
    property real cellWidth: __inferredCellWidth

    /*!
        The minimum height of an adaptive cell.

        The default is the largest effective preferred or implicit height among
        visible children. Assigning a value overrides that inference.
    */
    property real cellHeight: __inferredCellHeight

    function __isLayoutChild(child) {
        return child && child.visible
                && String(child).indexOf("QQuickRepeater") !== 0;
    }

    readonly property int __visibleChildCount: {
        let count = 0;
        for (const child of children) {
            if (__isLayoutChild(child))
                ++count;
        }
        return count;
    }

    readonly property real __inferredCellWidth: {
        let maximum = 0;
        for (const child of children) {
            if (!__isLayoutChild(child))
                continue;
            const preferred = child.Layout.preferredWidth;
            const effective = Number.isFinite(preferred) && preferred >= 0
                    ? preferred : child.implicitWidth;
            if (Number.isFinite(effective) && effective > maximum)
                maximum = effective;
        }
        return maximum;
    }

    readonly property real __inferredCellHeight: {
        let maximum = 0;
        for (const child of children) {
            if (!__isLayoutChild(child))
                continue;
            const preferred = child.Layout.preferredHeight;
            const effective = Number.isFinite(preferred) && preferred >= 0
                    ? preferred : child.implicitHeight;
            if (Number.isFinite(effective) && effective > maximum)
                maximum = effective;
        }
        return maximum;
    }

    function __fittedTrackCount(availableSize, spacing, minimumSize) {
        if (__visibleChildCount < 1
                || !Number.isFinite(availableSize) || availableSize <= 0
                || !Number.isFinite(spacing) || spacing < 0
                || !Number.isFinite(minimumSize) || minimumSize <= 0)
            return 1;

        const fitted = Math.floor((availableSize + spacing)
                                  / (minimumSize + spacing));
        return Math.max(1, Math.min(fitted, __visibleChildCount));
    }

    columns: flow === GridLayout.LeftToRight
            ? __fittedTrackCount(width, columnSpacing, cellWidth) : 1
    rows: flow === GridLayout.TopToBottom
          ? __fittedTrackCount(height, rowSpacing, cellHeight) : 1

    columnSpacing: MD.Tokens.measurement.space200
    rowSpacing: MD.Tokens.measurement.space200
    uniformCellWidths: true
    uniformCellHeights: true
}
