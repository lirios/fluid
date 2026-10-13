// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "shapetokens.h"

// AndroidX Material 3 generated tokens (BadgeTokens.kt, VERSION: v0_103):
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// ../Badge.kt supplies padding and icon offsets at the same revision.
// Label limits: https://m3.material.io/components/badges/specs

namespace Fluid {

/*! \brief Immutable Material Design 3 badge metrics. */
struct Badge
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal size READ size CONSTANT FINAL)
    Q_PROPERTY(qreal largeSize READ largeSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue shape READ shape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue largeShape READ largeShape CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalPadding READ horizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalOffset READ horizontalOffset CONSTANT FINAL)
    Q_PROPERTY(qreal verticalOffset READ verticalOffset CONSTANT FINAL)
    Q_PROPERTY(qreal largeHorizontalOffset READ largeHorizontalOffset CONSTANT FINAL)
    Q_PROPERTY(qreal largeVerticalOffset READ largeVerticalOffset CONSTANT FINAL)
    Q_PROPERTY(qreal maximumCharacters READ maximumCharacters CONSTANT FINAL)
    Q_PROPERTY(qreal maximumCount READ maximumCount CONSTANT FINAL)

public:
    constexpr qreal size() const
    {
        return 6.0;
    }

    constexpr qreal largeSize() const
    {
        return 16.0;
    }

    constexpr ShapeValue shape() const
    {
        return ShapeTokens{ }.cornerFull();
    }

    constexpr ShapeValue largeShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }

    constexpr qreal horizontalPadding() const
    {
        return 4.0;
    }

    constexpr qreal horizontalOffset() const
    {
        return 6.0;
    }

    constexpr qreal verticalOffset() const
    {
        return 6.0;
    }

    constexpr qreal largeHorizontalOffset() const
    {
        return 12.0;
    }

    constexpr qreal largeVerticalOffset() const
    {
        return 14.0;
    }

    constexpr qreal maximumCharacters() const
    {
        return 4.0;
    }

    constexpr qreal maximumCount() const
    {
        return 999.0;
    }
};

} // namespace Fluid
