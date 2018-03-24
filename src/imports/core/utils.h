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

#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QUrl>

class Utils : public QObject
{
    Q_OBJECT
public:
    explicit Utils(QObject *parent = nullptr);

    Q_INVOKABLE qreal scale(qreal percent, qreal start, qreal end);
};

#endif // UTILS_H
