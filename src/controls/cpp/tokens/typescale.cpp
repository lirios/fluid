// Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "typescale.h"

namespace Fluid {

//
// TypeScale
//

TypeScale::TypeScale(QObject *parent)
    : QObject(parent)
    , m_displayLarge(Style::TypeFace::Brand, 57, 64, QFont::Weight::Normal, -0.25)
    , m_displayMedium(Style::TypeFace::Brand, 45, 52, QFont::Weight::Normal, 0.0)
    , m_displaySmall(Style::TypeFace::Brand, 36, 44, QFont::Weight::Normal, 0.0)
    , m_headlineLarge(Style::TypeFace::Brand, 32, 40, QFont::Weight::Medium, 0.0)
    , m_headlineMedium(Style::TypeFace::Brand, 28, 36, QFont::Weight::Medium, 0.0)
    , m_headlineSmall(Style::TypeFace::Brand, 24, 32, QFont::Weight::Medium, 0.0)
    , m_titleLarge(Style::TypeFace::Brand, 22, 28, QFont::Weight::Normal, 0.0)
    , m_titleMedium(Style::TypeFace::Plain, 16, 24, QFont::Weight::Medium, 0.15)
    , m_titleSmall(Style::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.1)
    , m_bodyLarge(Style::TypeFace::Plain, 16, 24, QFont::Weight::Normal, 0.5)
    , m_bodyMedium(Style::TypeFace::Plain, 14, 20, QFont::Weight::Normal, 0.25)
    , m_bodySmall(Style::TypeFace::Plain, 12, 16, QFont::Weight::Normal, 0.4)
    , m_labelLarge(Style::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.1)
    , m_labelMedium(Style::TypeFace::Plain, 12, 16, QFont::Weight::Medium, 0.5)
    , m_labelSmall(Style::TypeFace::Plain, 11, 16, QFont::Weight::Medium, 0.5)
{
}

TypeScaleValue TypeScale::displayLarge() const
{
    return m_displayLarge;
}

TypeScaleValue TypeScale::displayMedium() const
{
    return m_displayMedium;
}

TypeScaleValue TypeScale::displaySmall() const
{
    return m_displaySmall;
}

TypeScaleValue TypeScale::headlineLarge() const
{
    return m_headlineLarge;
}

TypeScaleValue TypeScale::headlineMedium() const
{
    return m_headlineMedium;
}

TypeScaleValue TypeScale::headlineSmall() const
{
    return m_headlineSmall;
}

TypeScaleValue TypeScale::titleLarge() const
{
    return m_titleLarge;
}

TypeScaleValue TypeScale::titleMedium() const
{
    return m_titleMedium;
}

TypeScaleValue TypeScale::titleSmall() const
{
    return m_titleSmall;
}

TypeScaleValue TypeScale::bodyLarge() const
{
    return m_bodyLarge;
}

TypeScaleValue TypeScale::bodyMedium() const
{
    return m_bodyMedium;
}

TypeScaleValue TypeScale::bodySmall() const
{
    return m_bodySmall;
}

TypeScaleValue TypeScale::labelLarge() const
{
    return m_labelLarge;
}

TypeScaleValue TypeScale::labelMedium() const
{
    return m_labelMedium;
}

TypeScaleValue TypeScale::labelSmall() const
{
    return m_labelSmall;
}

//
// EmphasizedTypeScale
//

EmphasizedTypeScale::EmphasizedTypeScale(QObject *parent)
    : TypeScale(parent)
{
    m_displayLarge = TypeScaleValue(Style::TypeFace::Brand, 57, 64, QFont::Weight::Medium, -0.25);
    m_displayMedium = TypeScaleValue(Style::TypeFace::Brand, 45, 52, QFont::Weight::Medium, 0.0);
    m_displaySmall = TypeScaleValue(Style::TypeFace::Brand, 36, 44, QFont::Weight::Medium, 0.0);
    m_headlineLarge = TypeScaleValue(Style::TypeFace::Brand, 32, 40, QFont::Weight::Medium, 0.0);
    m_headlineMedium = TypeScaleValue(Style::TypeFace::Brand, 28, 36, QFont::Weight::Medium, 0.0);
    m_headlineSmall = TypeScaleValue(Style::TypeFace::Brand, 24, 32, QFont::Weight::Medium, 0.0);
    m_titleLarge = TypeScaleValue(Style::TypeFace::Brand, 22, 28, QFont::Weight::Medium, 0.0);
    m_titleMedium = TypeScaleValue(Style::TypeFace::Plain, 16, 24, QFont::Weight::DemiBold, 0.15);
    m_titleSmall = TypeScaleValue(Style::TypeFace::Plain, 14, 20, QFont::Weight::DemiBold, 0.1);
    m_bodyLarge = TypeScaleValue(Style::TypeFace::Plain, 16, 24, QFont::Weight::Medium, 0.5);
    m_bodyMedium = TypeScaleValue(Style::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.25);
    m_bodySmall = TypeScaleValue(Style::TypeFace::Plain, 12, 16, QFont::Weight::Medium, 0.4);
    m_labelLarge = TypeScaleValue(Style::TypeFace::Plain, 14, 20, QFont::Weight::Bold, 0.1);
    m_labelMedium = TypeScaleValue(Style::TypeFace::Plain, 12, 16, QFont::Weight::Bold, 0.5);
    m_labelSmall = TypeScaleValue(Style::TypeFace::Plain, 11, 16, QFont::Weight::Bold, 0.5);
}

} // namespace Fluid