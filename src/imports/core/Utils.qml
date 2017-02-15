/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
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

pragma Singleton

/*!
    \qmltype Utils
    \inqmlmodule Fluid.Core
    \ingroup fluidcore

    \brief A collection of helpful utility methods.

    Currently the only utility methods are for working with colors.
*/
QtObject {
    /*!
        Make sure we have a real \l color object to work with (versus a string like "#ccc")
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
        Blend \a color1 and \a color2 together and set alpha to \a a.
    */
    function blendColors(color1, color2, a) {
        return alpha(Qt.tint(color1, color2), a)
    }

    /*!
        Calculate luminance of \a color.
    */
    function luminance(color) {
        color = asColor(color)
        return (color.r * 0.2126) + (color.g * 0.7152) + (color.b * 0.0722)
    }

    /*!
        Select a color depending on whether \a background color is light or dark.
        Returns \a lightColor if \a background is a light color, otherwise
        returns \a darkColor.
    */
    function lightDark(background, lightColor, darkColor) {
        return isDarkColor(background) ? darkColor : lightColor
    }

    /*!
        Returns \c true if \a color is dark and should have light content on top.
    */
    function isDarkColor(color) {
        color = asColor(color)

        var a = 1 - (0.299 * color.r + 0.587 * color.g + 0.114 * color.b)

        return color.a > 0 && a >= 0.3
    }

    /*!
        Returns a source suitable for an \l Image from an icon name.
        If \a name is an URL it will be returned verbatim, instead if it
        contains a slash character an icon relative to Fluid icons/ directory
        will be returned, otherwise an image://fluidicontheme/\a name URL.
    */
    function getSourceForIconName(name) {
        return name ? name.indexOf("/") === 0 || name.indexOf("file://") === 0 || name.indexOf("qrc") === 0
                      ? name
                      : name.indexOf("/") !== -1 ? "image://fluidicons/" + name
                                                 : "image://fluidicontheme/" + name
                    : ""
    }

    /*!
        Scale \a percent in the range between \a start and \a end.
    */
    function scale(percent, start, end) {
        var diff = end - start

        return start + percent * diff
    }
}
