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

/*!
    \qmltype Color
    \instantiates Color
    \inqmlmodule Fluid.Controls

    \brief Utility functions for colors

    Utility functions to manipulate colors.
*/

Color::Color(QObject *parent)
    : QObject(parent)
{
}

/*!
    \qmlmethod color Fluid.Controls::Color::transparent(color color, real alpha)

    A utility method for changing the alpha on colors.
    Returns a new object, and does not modify the original color at all.
*/
QColor Color::transparent(const QColor &color, qreal alpha)
{
    return QColor(color.red(), color.green(), color.blue(), int(qBound<qreal>(0.0, alpha, 1.0) * 255));
}

/*!
    \qmlmethod color Fluid.Controls::Color::blend(color color1, color color2, real alpha)

    Blend \a color1 and \a color2 together and set alpha to \a a.
*/
QColor Color::blend(const QColor &color1, const QColor &color2, qreal alpha)
{
    QColor color;
    color.setRedF(color1.redF() * 0.5 + color2.redF() * 0.5);
    color.setGreenF(color1.greenF() * 0.5 + color2.greenF() * 0.5);
    color.setBlueF(color1.blueF() * 0.5 + color2.blueF() * 0.5);
    return transparent(color, alpha);
}

/*!
    \qmlmethod real Fluid.Controls::Color::luminance(color color)

    Calculate luminance of \a color.
*/
qreal Color::luminance(const QColor &color)
{
    return (color.redF() * 0.2126) + (color.greenF() * 0.7152) + (color.blueF() * 0.0722);
}

/*!
    \qmlmethod bool Fluid.Controls::Color::isDarkColor(color color)

    Returns \c true if \a color is dark and should have light content on top.
*/
bool Color::isDarkColor(const QColor &color)
{
    auto a = 1.0 - (0.299 * color.redF() + 0.587 * color.greenF() + 0.114 * color.blueF());
    return color.alphaF() > 0.0 && a >= 0.3;
}

/*!
    \qmlmethod color Fluid.Controls::Color::lightDark(color background, color lightColor, color darkColor)

    Select a color depending on whether \a background color is light or dark.
    Returns \a lightColor if \a background is a light color, otherwise
    returns \a darkColor.
*/
QColor Color::lightDark(const QColor &background, const QColor &lightColor, const QColor &darkColor)
{
    return isDarkColor(background) ? darkColor : lightColor;
}
