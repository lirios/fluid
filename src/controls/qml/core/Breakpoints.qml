// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma Singleton

import QtQuick
import Fluid as MD

/*!
    \class Breakpoints
    \brief Material Design 3 width breakpoints and adaptive grid metrics.

    Breakpoints classifies an available width into one of the five Material 3
    breakpoint ranges. The returned values can be used to adapt a layout's
    structure and its number of grid columns. Widths and metrics are expressed
    in device-independent pixels.

    \code{.qml}
    import Fluid as MD

    Item {
        readonly property int breakpoint: MD.Breakpoints.fromWidth(width)
        readonly property int columns: MD.Breakpoints.columnCount(breakpoint)
    }
    \endcode
*/
QtObject {
    /*!
        Material 3 width breakpoint ranges.

        \value Compact Widths from 0 up to, but excluding, 600 dp.
        \value Medium Widths from 600 up to, but excluding, 840 dp.
        \value Expanded Widths from 840 up to, but excluding, 1200 dp.
        \value Large Widths from 1200 up to, but excluding, 1600 dp.
        \value ExtraLarge Widths of 1600 dp and greater.
    */
    enum Breakpoint {
        Compact,
        Medium,
        Expanded,
        Large,
        ExtraLarge
    }

    /*! The inclusive lower bound of the Compact range. */
    readonly property real compactLowerBound: 0

    /*! The inclusive lower bound of the Medium range. */
    readonly property real mediumLowerBound: 600

    /*! The inclusive lower bound of the Expanded range. */
    readonly property real expandedLowerBound: 840

    /*! The inclusive lower bound of the Large range. */
    readonly property real largeLowerBound: 1200

    /*! The inclusive lower bound of the ExtraLarge range. */
    readonly property real extraLargeLowerBound: 1600

    /*!
        Returns the breakpoint containing \a width.

        A negative, non-finite, or non-numeric width returns Compact.
    */
    function fromWidth(width) {
        if (typeof width !== "number" || !Number.isFinite(width) || width < compactLowerBound)
            return Breakpoints.Compact;
        if (width >= extraLargeLowerBound)
            return Breakpoints.ExtraLarge;
        if (width >= largeLowerBound)
            return Breakpoints.Large;
        if (width >= expandedLowerBound)
            return Breakpoints.Expanded;
        if (width >= mediumLowerBound)
            return Breakpoints.Medium;
        return Breakpoints.Compact;
    }

    /*!
        Returns the adaptive grid column count for \a breakpoint.

        Compact grids have 4 columns, Medium and Expanded grids have 8, and
        Large and ExtraLarge grids have 12. An invalid value uses the Compact
        default of 4 columns.
    */
    function columnCount(breakpoint) {
        switch (breakpoint) {
        case Breakpoints.Medium:
        case Breakpoints.Expanded:
            return 8;
        case Breakpoints.Large:
        case Breakpoints.ExtraLarge:
            return 12;
        case Breakpoints.Compact:
        default:
            return 4;
        }
    }

    /*!
        Returns the recommended outer grid margin for \a breakpoint.

        Compact uses \c MD.Tokens.measurement.space200. Every other valid
        breakpoint uses \c MD.Tokens.measurement.space300. An invalid value
        uses the Compact default.
    */
    function margin(breakpoint) {
        switch (breakpoint) {
        case Breakpoints.Medium:
        case Breakpoints.Expanded:
        case Breakpoints.Large:
        case Breakpoints.ExtraLarge:
            return MD.Tokens.measurement.space300;
        case Breakpoints.Compact:
        default:
            return MD.Tokens.measurement.space200;
        }
    }

    /*!
        Returns the recommended inter-column gutter for \a breakpoint.

        Compact uses \c MD.Tokens.measurement.space200. Every other valid
        breakpoint uses \c MD.Tokens.measurement.space300. An invalid value
        uses the Compact default.
    */
    function gutter(breakpoint) {
        switch (breakpoint) {
        case Breakpoints.Medium:
        case Breakpoints.Expanded:
        case Breakpoints.Large:
        case Breakpoints.ExtraLarge:
            return MD.Tokens.measurement.space300;
        case Breakpoints.Compact:
        default:
            return MD.Tokens.measurement.space200;
        }
    }
}
