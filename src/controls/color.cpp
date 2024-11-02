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

#include "color.h"

Color::Color(QObject *parent)
    : QObject(parent)
{
}

QColor Color::transparent(const QColor &color, qreal alpha)
{
    return QColor(color.red(), color.green(), color.blue(), int(qBound<qreal>(0.0, alpha, 1.0) * 255));
}

QColor Color::blend(const QColor &color1, const QColor &color2, qreal alpha)
{
    QColor color;
    color.setRedF(color1.redF() * 0.5 + color2.redF() * 0.5);
    color.setGreenF(color1.greenF() * 0.5 + color2.greenF() * 0.5);
    color.setBlueF(color1.blueF() * 0.5 + color2.blueF() * 0.5);
    return transparent(color, alpha);
}

qreal Color::luminance(const QColor &color)
{
    return (color.redF() * 0.2126) + (color.greenF() * 0.7152) + (color.blueF() * 0.0722);
}

bool Color::isDarkColor(const QColor &color)
{
    auto a = 1.0 - (0.299 * color.redF() + 0.587 * color.greenF() + 0.114 * color.blueF());
    return color.alphaF() > 0.0 && a >= 0.3;
}

QColor Color::lightDark(const QColor &background, const QColor &lightColor, const QColor &darkColor)
{
    return isDarkColor(background) ? darkColor : lightColor;
}

Color *Color::create(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)

    return new Color();
}
