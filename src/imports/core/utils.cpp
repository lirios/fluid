/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "utils.h"

/*!
    \qmltype Utils
    \inqmlmodule Fluid.Core
    \ingroup fluidcore

    \brief A collection of helpful utility methods.
*/
Utils::Utils(QObject *parent)
    : QObject(parent)
{
}

/*!
    \qmlmethod real Fluid.Controls::Utils::scale(real percent, real start, real end)

    Scale \a percent in the range between \a start and \a end.
*/
qreal Utils::scale(qreal percent, qreal start, qreal end)
{
    return start + ((end - start) * (percent / 100));
}

/*!
    \qmlmethod url Fluid.Controls::Utils::iconUrl(string name)

    Returns an URL for the Material Design icon \a name.
    Use this URL with Image or icon grouped property with controls.

    \code
    import QtQuick 2.10
    import Fluid.Core 1.0 as FluidCore

    Image {
        source: FluidCore.Utils.iconUrl("action/alarm")
        width: 64
        height: 64
    }
    \endcode

    \code
    import QtQuick 2.10
    import QtQuick.Controls 2.3
    import Fluid.Core 1.0 as FluidCore

    Button {
        icon.source: FluidCore.Utils.iconUrl("action/alarm")
        text: qsTr("Alarm")
    }
    \endcode
*/
QUrl Utils::iconUrl(const QString &name)
{
    return QUrl(QStringLiteral("qrc:/liri.io/imports/Fluid/Controls/icons/%1.svg").arg(name));
}
