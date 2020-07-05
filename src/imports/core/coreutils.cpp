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

#include "coreutils.h"

/*!
    \qmltype Fluid.Core::Utils
    \inqmlmodule Fluid.Core
    \ingroup fluidcore

    \brief A collection of helpful utility methods.
*/
CoreUtils::CoreUtils(QObject *parent)
    : QObject(parent)
{
}

/*!
    \qmlmethod real Fluid.Core::Utils::scale(real percent, real start, real end)

    Scale \a percent in the range between \a start and \a end.
*/
qreal CoreUtils::scale(qreal percent, qreal start, qreal end)
{
    return start + ((end - start) * (percent / 100));
}
