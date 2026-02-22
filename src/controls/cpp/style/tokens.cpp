/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "tokens.h"

namespace Fluid {

Tokens::Tokens(QObject *parent)
    : QObject(parent)
    , m_typescale(new TypeScale(this))
    , m_emphasizedTypeScale(new EmphasizedTypeScale(this))
{
}

// Shape tokens - Corner radius
qreal Tokens::cornerRadiusNone() const
{
    return 0.0;
}

qreal Tokens::cornerRadiusExtraSmall() const
{
    return 4.0;
}

qreal Tokens::cornerRadiusSmall() const
{
    return 8.0;
}

qreal Tokens::cornerRadiusMedium() const
{
    return 12.0;
}

qreal Tokens::cornerRadiusLarge() const
{
    return 16.0;
}

qreal Tokens::cornerRadiusExtraLarge() const
{
    return 28.0;
}

qreal Tokens::cornerRadiusFull() const
{
    return 9999.0; // Represents full rounding
}

// Typography tokens
TypeScale *Tokens::typescale() const
{
    return m_typescale;
}

EmphasizedTypeScale *Tokens::emphasizedTypeScale() const
{
    return m_emphasizedTypeScale;
}

// Spacing tokens
int Tokens::spacingExtraSmall() const
{
    return 4;
}

int Tokens::spacingSmall() const
{
    return 8;
}

int Tokens::spacingMedium() const
{
    return 16;
}

int Tokens::spacingLarge() const
{
    return 24;
}

int Tokens::spacingExtraLarge() const
{
    return 32;
}

// Elevation tokens
int Tokens::elevationLevel0() const
{
    return 0;
}

int Tokens::elevationLevel1() const
{
    return 1;
}

int Tokens::elevationLevel2() const
{
    return 3;
}

int Tokens::elevationLevel3() const
{
    return 6;
}

int Tokens::elevationLevel4() const
{
    return 8;
}

int Tokens::elevationLevel5() const
{
    return 12;
}

// Motion tokens - Duration
int Tokens::durationShort1() const
{
    return 50;
}

int Tokens::durationShort2() const
{
    return 100;
}

int Tokens::durationShort3() const
{
    return 150;
}

int Tokens::durationShort4() const
{
    return 200;
}

int Tokens::durationMedium1() const
{
    return 250;
}

int Tokens::durationMedium2() const
{
    return 300;
}

int Tokens::durationMedium3() const
{
    return 350;
}

int Tokens::durationMedium4() const
{
    return 400;
}

int Tokens::durationLong1() const
{
    return 450;
}

int Tokens::durationLong2() const
{
    return 500;
}

int Tokens::durationLong3() const
{
    return 550;
}

int Tokens::durationLong4() const
{
    return 600;
}

int Tokens::durationExtraLong1() const
{
    return 700;
}

int Tokens::durationExtraLong2() const
{
    return 800;
}

int Tokens::durationExtraLong3() const
{
    return 900;
}

int Tokens::durationExtraLong4() const
{
    return 1000;
}

// Motion tokens - Easing
Easing Tokens::easing() const
{
    return m_easing;
}

Spring Tokens::spring() const
{
    return m_spring;
}

Tokens *Tokens::create(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)

    return new Tokens();
}

} // namespace Fluid