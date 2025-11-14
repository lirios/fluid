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

#include "token.h"

Token::Token(QObject *parent)
    : QObject(parent)
{
}

// Shape tokens - Corner radius
qreal Token::cornerRadiusNone() const
{
    return 0.0;
}

qreal Token::cornerRadiusExtraSmall() const
{
    return 4.0;
}

qreal Token::cornerRadiusSmall() const
{
    return 8.0;
}

qreal Token::cornerRadiusMedium() const
{
    return 12.0;
}

qreal Token::cornerRadiusLarge() const
{
    return 16.0;
}

qreal Token::cornerRadiusExtraLarge() const
{
    return 28.0;
}

qreal Token::cornerRadiusFull() const
{
    return 9999.0; // Represents full rounding
}

// Typography tokens - Font sizes
int Token::fontSizeDisplayLarge() const
{
    return 57;
}

int Token::fontSizeDisplayMedium() const
{
    return 45;
}

int Token::fontSizeDisplaySmall() const
{
    return 36;
}

int Token::fontSizeHeadlineLarge() const
{
    return 32;
}

int Token::fontSizeHeadlineMedium() const
{
    return 28;
}

int Token::fontSizeHeadlineSmall() const
{
    return 24;
}

int Token::fontSizeTitleLarge() const
{
    return 22;
}

int Token::fontSizeTitleMedium() const
{
    return 16;
}

int Token::fontSizeTitleSmall() const
{
    return 14;
}

int Token::fontSizeBodyLarge() const
{
    return 16;
}

int Token::fontSizeBodyMedium() const
{
    return 14;
}

int Token::fontSizeBodySmall() const
{
    return 12;
}

int Token::fontSizeLabelLarge() const
{
    return 14;
}

int Token::fontSizeLabelMedium() const
{
    return 12;
}

int Token::fontSizeLabelSmall() const
{
    return 11;
}

// Spacing tokens
int Token::spacingExtraSmall() const
{
    return 4;
}

int Token::spacingSmall() const
{
    return 8;
}

int Token::spacingMedium() const
{
    return 16;
}

int Token::spacingLarge() const
{
    return 24;
}

int Token::spacingExtraLarge() const
{
    return 32;
}

// Elevation tokens
int Token::elevationLevel0() const
{
    return 0;
}

int Token::elevationLevel1() const
{
    return 1;
}

int Token::elevationLevel2() const
{
    return 3;
}

int Token::elevationLevel3() const
{
    return 6;
}

int Token::elevationLevel4() const
{
    return 8;
}

int Token::elevationLevel5() const
{
    return 12;
}

// Motion tokens - Duration
int Token::durationShort1() const
{
    return 50;
}

int Token::durationShort2() const
{
    return 100;
}

int Token::durationShort3() const
{
    return 150;
}

int Token::durationShort4() const
{
    return 200;
}

int Token::durationMedium1() const
{
    return 250;
}

int Token::durationMedium2() const
{
    return 300;
}

int Token::durationMedium3() const
{
    return 350;
}

int Token::durationMedium4() const
{
    return 400;
}

int Token::durationLong1() const
{
    return 450;
}

int Token::durationLong2() const
{
    return 500;
}

int Token::durationLong3() const
{
    return 550;
}

int Token::durationLong4() const
{
    return 600;
}

Token *Token::create(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)

    return new Token();
}
