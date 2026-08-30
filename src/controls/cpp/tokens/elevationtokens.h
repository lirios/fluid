// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*!
    \brief Material Design 3 system elevation tokens.

    Values are from AndroidX ElevationTokens.kt, VERSION: v0_103, at the pinned directory:
    https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
*/
struct ElevationTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal level0 READ level0 CONSTANT FINAL)
    Q_PROPERTY(qreal level1 READ level1 CONSTANT FINAL)
    Q_PROPERTY(qreal level2 READ level2 CONSTANT FINAL)
    Q_PROPERTY(qreal level3 READ level3 CONSTANT FINAL)
    Q_PROPERTY(qreal level4 READ level4 CONSTANT FINAL)
    Q_PROPERTY(qreal level5 READ level5 CONSTANT FINAL)

public:
    constexpr qreal level0() const
    {
        return 0.0;
    }
    constexpr qreal level1() const
    {
        return 1.0;
    }
    constexpr qreal level2() const
    {
        return 3.0;
    }
    constexpr qreal level3() const
    {
        return 6.0;
    }
    constexpr qreal level4() const
    {
        return 8.0;
    }
    constexpr qreal level5() const
    {
        return 12.0;
    }
};

} // namespace Fluid
