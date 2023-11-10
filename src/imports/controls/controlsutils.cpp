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

#include "controlsutils.h"

/*!
    \qmltype Fluid.Controls::Utils
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief A collection of helpful utility methods.
*/
ControlsUtils::ControlsUtils(const QUrl &baseUrl, QObject *parent)
    : QObject(parent)
    , m_baseUrl(baseUrl)
{
}

/*!
    \qmlmethod url Fluid.Controls::Utils::iconUrl(string name)

    Returns an URL for the Material Design icon \a name.
    Use this URL with Image or icon grouped property with controls.

    \code
    import QtQuick 2.10
    import Fluid.Controls 1.0 as FluidControls

    Image {
        source: FluidControls.Utils.iconUrl("action/alarm")
        width: 64
        height: 64
    }
    \endcode

    \code
    import QtQuick 2.10
    import QtQuick.Controls 2.3
    import Fluid.Controls 1.0 as FluidControls

    Button {
        icon.source: FluidControls.Utils.iconUrl("action/alarm")
        text: qsTr("Alarm")
    }
    \endcode
*/
QUrl ControlsUtils::iconUrl(const QString &name)
{
#if FLUID_INSTALL_ICONS == 1
    return QUrl::fromLocalFile(QStringLiteral("%1/icons/%2.svg").arg(m_baseUrl.toLocalFile(), name));
#else
    return QUrl(QStringLiteral("qrc:/liri.io/imports/Fluid/Controls/icons/%1.svg").arg(name));
#endif
}
