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

#pragma once

#include <QtCore/qglobal.h>

#ifndef FLUID_STATIC
#  if defined(QT_BUILD_FLUID_LIB)
#    define FLUID_EXPORT Q_DECL_EXPORT
#  else
#    define FLUID_EXPORT Q_DECL_IMPORT
#  endif
#  define FLUID_NO_EXPORT Q_DECL_HIDDEN
#else
#  define FLUID_EXPORT
#  define FLUID_NO_EXPORT
#endif
