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

#include <QColor>
#include <QObject>
#include <QQmlEngine>

class Color : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit Color(QObject *parent = nullptr);

    Q_INVOKABLE QColor transparent(const QColor &color, qreal alpha);
    Q_INVOKABLE QColor blend(const QColor &color1, const QColor &color2, qreal alpha);
    Q_INVOKABLE qreal luminance(const QColor &color);
    Q_INVOKABLE bool isDarkColor(const QColor &color);
    Q_INVOKABLE QColor lightDark(const QColor &background, const QColor &lightColor,
                                 const QColor &darkColor);

    static Color *create(QQmlEngine *engine, QJSEngine *jsEngine);
};

