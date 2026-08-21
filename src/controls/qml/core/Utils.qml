// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma Singleton

import QtQml
import QtQuick

/*!
    \class Utils
    \brief Provides shared color and numeric utility functions.

    Utils is a Fluid infrastructure singleton rather than a Material 3
    component. Controls use it to apply values supplied by the Material 3 token
    and style systems.
*/
QtObject {
    function scale(percent: real, start: real, end: real): real {
        return start + ((end - start) * (percent / 100));
    }

    function transparent(c: color, alpha: real): color {
        return Qt.rgba(c.r, c.g, c.b, alpha);
    }

    function epsilonEqual(x: real, y: real): real {
        return Math.abs(x - y) < Number.EPSILON;
    }
}
