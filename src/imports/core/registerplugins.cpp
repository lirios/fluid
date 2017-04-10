/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QtCore/QCoreApplication>

#include "coreplugin.h"
#include "../controls/controlsplugin.h"
#include "registerplugins.h"

void registerPlugins()
{
    FluidCorePlugin fluidCore;
    fluidCore.registerTypes("Fluid.Core");

    FluidControlsPlugin fluidControls;
    fluidControls.registerTypes("Fluid.Controls");
}

Q_COREAPP_STARTUP_FUNCTION(registerPlugins)
