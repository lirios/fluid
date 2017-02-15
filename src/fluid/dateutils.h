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

#pragma once

#include <QtCore/QObject>
#include <QtCore/QDateTime>

#include <Fluid/fluidglobal.h>

namespace Fluid {

class FLUID_EXPORT DateUtils : public QObject
{
    Q_OBJECT

public:
    enum DurationFormat { Long, Short };
    Q_ENUM(DurationFormat)

    enum DurationType { Seconds, Minutes, Hours, Any };
    Q_ENUM(DurationType)

    static QString formatDuration(qlonglong duration, DurationFormat format = Short,
                                  DurationType type = Any);
    static QString friendlyTime(const QDateTime &time, bool standalone);
};

} // namespace Fluid
