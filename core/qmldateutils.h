/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
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

#ifdef FLUID_LOCAL
    #include "../src/dateutils.h"
#else
    #include <Fluid/DateUtils>
#endif
#include <QtCore/QObject>

class DateUtils : public QObject
{
    Q_OBJECT

public:
    enum DurationFormat { Long, Short };
    Q_ENUM(DurationFormat)

    enum DurationType { Seconds, Minutes, Hours, Any };
    Q_ENUM(DurationType)

    DateUtils(QObject *parent = nullptr);

    Q_INVOKABLE QString formatDuration(qlonglong duration,
                                       DurationFormat format = DurationFormat::Short,
                                       DurationType type = DurationType::Any) const;
};
