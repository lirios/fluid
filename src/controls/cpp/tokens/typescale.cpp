// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "typescale.h"

namespace Fluid {

// Values are from AndroidX TypeScaleTokens.kt, VERSION: v0_103, at the pinned directory:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/

//
// TypeScale
//

TypeScale::TypeScale(QObject *parent)
    : QObject(parent)
    , m_displayLarge(FluidStyle::TypeFace::Brand, 57, 64, QFont::Weight::Normal, -0.2)
    , m_displayMedium(FluidStyle::TypeFace::Brand, 45, 52, QFont::Weight::Normal, 0.0)
    , m_displaySmall(FluidStyle::TypeFace::Brand, 36, 44, QFont::Weight::Normal, 0.0)
    , m_headlineLarge(FluidStyle::TypeFace::Brand, 32, 40, QFont::Weight::Normal, 0.0)
    , m_headlineMedium(FluidStyle::TypeFace::Brand, 28, 36, QFont::Weight::Normal, 0.0)
    , m_headlineSmall(FluidStyle::TypeFace::Brand, 24, 32, QFont::Weight::Normal, 0.0)
    , m_titleLarge(FluidStyle::TypeFace::Brand, 22, 28, QFont::Weight::Normal, 0.0)
    , m_titleMedium(FluidStyle::TypeFace::Plain, 16, 24, QFont::Weight::Medium, 0.2)
    , m_titleSmall(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.1)
    , m_bodyLarge(FluidStyle::TypeFace::Plain, 16, 24, QFont::Weight::Normal, 0.5)
    , m_bodyMedium(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Normal, 0.2)
    , m_bodySmall(FluidStyle::TypeFace::Plain, 12, 16, QFont::Weight::Normal, 0.4)
    , m_labelLarge(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.1)
    , m_labelMedium(FluidStyle::TypeFace::Plain, 12, 16, QFont::Weight::Medium, 0.5)
    , m_labelSmall(FluidStyle::TypeFace::Plain, 11, 16, QFont::Weight::Medium, 0.5)
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
    m_displayLarge =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 57, 64, QFont::Weight::Medium, 0.0);
    m_displayMedium =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 45, 52, QFont::Weight::Medium, 0.0);
    m_displaySmall =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 36, 44, QFont::Weight::Medium, 0.0);
    m_headlineLarge =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 32, 40, QFont::Weight::Medium, 0.0);
    m_headlineMedium =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 28, 36, QFont::Weight::Medium, 0.0);
    m_headlineSmall =
            TypeScaleValue(FluidStyle::TypeFace::Brand, 24, 32, QFont::Weight::Medium, 0.0);
    m_titleLarge = TypeScaleValue(FluidStyle::TypeFace::Brand, 22, 28, QFont::Weight::Medium, 0.0);
    m_titleMedium = TypeScaleValue(FluidStyle::TypeFace::Plain, 16, 24, QFont::Weight::Bold, 0.15);
    m_titleSmall = TypeScaleValue(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Bold, 0.1);
    m_bodyLarge = TypeScaleValue(FluidStyle::TypeFace::Plain, 16, 24, QFont::Weight::Medium, 0.15);
    m_bodyMedium = TypeScaleValue(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Medium, 0.25);
    m_bodySmall = TypeScaleValue(FluidStyle::TypeFace::Plain, 12, 16, QFont::Weight::Medium, 0.4);
    m_labelLarge = TypeScaleValue(FluidStyle::TypeFace::Plain, 14, 20, QFont::Weight::Bold, 0.1);
    m_labelMedium = TypeScaleValue(FluidStyle::TypeFace::Plain, 12, 16, QFont::Weight::Bold, 0.5);
    m_labelSmall = TypeScaleValue(FluidStyle::TypeFace::Plain, 11, 16, QFont::Weight::Bold, 0.5);
}

} // namespace Fluid
