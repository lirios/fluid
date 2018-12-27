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

#ifndef LIRIDECORATION_P_H
#define LIRIDECORATION_P_H

#include "liridecoration.h"
#include "qwayland-liri-decoration.h"

class LiriDecorationManagerPrivate : public QtWayland::liri_decoration_manager
{
public:
    LiriDecorationManagerPrivate() {}

    QVector<LiriDecoration *> decorations;
};

class LiriDecorationPrivate : public QtWayland::liri_decoration
{
public:
    LiriDecorationPrivate() {}

    LiriDecorationManager *manager = nullptr;
};

#endif // LIRIDECORATION_P_H
