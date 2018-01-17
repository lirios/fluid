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

pragma Singleton

/*!
    \qmltype Utils
    \inqmlmodule Fluid.Core
    \ingroup fluidcore

    \brief A collection of helpful utility methods.
*/
QtObject {
    /*!
        \qmlmethod real Utils::scale(real percent, real start, real end)

        Scale \a percent in the range between \a start and \a end.
    */
    function scale(percent, start, end) {
        var diff = end - start;
        return start + percent * diff;
    }
}
