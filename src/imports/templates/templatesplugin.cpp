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

#include "templatesplugin.h"

#include "datepicker.h"
#include "dateselector.h"
#include "datetimepicker.h"
#include "timepicker.h"
#include "timeselector.h"
#include "yearmodel.h"
#include "yearselector.h"

void FluidTemplatesPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Fluid.Templates"));

    qmlRegisterType<DatePicker>(uri, 1, 0, "DatePicker");
    qmlRegisterType<DateSelector>(uri, 1, 0, "DateSelector");
    qmlRegisterType<DateTimePicker>(uri, 1, 0, "DateTimePicker");
    qmlRegisterType<TimePicker>(uri, 1, 0, "TimePicker");
    qmlRegisterType<TimeSelector>(uri, 1, 0, "TimeSelector");
    qmlRegisterType<YearSelector>(uri, 1, 0, "YearSelector");

    qmlRegisterUncreatableType<YearModel>(uri, 1, 0, "YearModel",
                                          QStringLiteral("Cannot instantiate YearModel"));
}
