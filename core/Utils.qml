/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.0

pragma Singleton

/*!
   \qmltype Utils
   \inqmlmodule Fluid.Core 1.0
   \brief A collection of helpful utility methods.

   Currently the only utility methods are for working with colors.
 */
QtObject {
    /*!
       Make sure we have a real color object to work with (versus a string like "#ccc")
     */
    function asColor(color) {
        return Qt.darker(color, 1)
    }

    /*!
       A utility method for changing the alpha on colors. Returns a new object, and does not
       modify the original color at all.
     */
    function alpha(color, alpha) {
        color = asColor(color)

        color.a = alpha

        return color
    }

    /*!
       Select a color depending on whether the background is light or dark.
     */
    function lightDark(background, lightColor, darkColor) {
        return isDarkColor(background) ? darkColor : lightColor
    }

    /*!
       Returns \c true if the color is dark and should have light content on top.
     */
    function isDarkColor(color) {
        color = asColor(color)

        var a = 1 - (0.299 * color.r + 0.587 * color.g + 0.114 * color.b)

        return color.a > 0 && a >= 0.3
    }
}
