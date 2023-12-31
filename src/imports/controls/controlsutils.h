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

#pragma once

#include <QObject>
#include <QUrl>
#include <QQmlEngine>

class ControlsUtils : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(Utils)
    QML_SINGLETON
public:
    explicit ControlsUtils(const QUrl &baseUrl, QObject *parent = nullptr);

    Q_INVOKABLE QUrl iconUrl(const QString &name);

    static ControlsUtils *create(QQmlEngine *engine, QJSEngine *jsEngine);

private:
    QUrl m_baseUrl;
};

