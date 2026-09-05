// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

// The minimum interaction target follows AndroidX LocalMinimumInteractiveComponentSize:
// https://raw.githubusercontent.com/androidx/androidx/androidx-main/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/InteractiveComponentSize.kt

/*!
    \brief Material Design 3 system measurement tokens.

    Spacing values are multipliers of the 8 dp baseline unit exposed as \c space100.
    The separate \c minimumInteractiveSize metric provides the 48 dp minimum
    interaction target shared by controls.

    For more information see the
    <a href="https://m3.material.io/styles/spacing/overview">Material Design 3
    spacing guidelines</a>.
*/
struct MeasurementTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal space0 READ space0 CONSTANT FINAL)
    Q_PROPERTY(qreal space25 READ space25 CONSTANT FINAL)
    Q_PROPERTY(qreal space50 READ space50 CONSTANT FINAL)
    Q_PROPERTY(qreal space75 READ space75 CONSTANT FINAL)
    Q_PROPERTY(qreal space100 READ space100 CONSTANT FINAL)
    Q_PROPERTY(qreal space125 READ space125 CONSTANT FINAL)
    Q_PROPERTY(qreal space150 READ space150 CONSTANT FINAL)
    Q_PROPERTY(qreal space175 READ space175 CONSTANT FINAL)
    Q_PROPERTY(qreal space200 READ space200 CONSTANT FINAL)
    Q_PROPERTY(qreal space250 READ space250 CONSTANT FINAL)
    Q_PROPERTY(qreal space300 READ space300 CONSTANT FINAL)
    Q_PROPERTY(qreal space400 READ space400 CONSTANT FINAL)
    Q_PROPERTY(qreal space450 READ space450 CONSTANT FINAL)
    Q_PROPERTY(qreal space500 READ space500 CONSTANT FINAL)
    Q_PROPERTY(qreal space600 READ space600 CONSTANT FINAL)
    Q_PROPERTY(qreal space700 READ space700 CONSTANT FINAL)
    Q_PROPERTY(qreal space800 READ space800 CONSTANT FINAL)
    Q_PROPERTY(qreal space900 READ space900 CONSTANT FINAL)

public:
    //! Minimum interaction target, matching AndroidX InteractiveComponentSize.kt.
    constexpr qreal minimumInteractiveSize() const
    {
        return 48.0;
    }
    constexpr qreal space0() const
    {
        return space100() * 0.0;
    }
    constexpr qreal space25() const
    {
        return space100() * 0.25;
    }
    constexpr qreal space50() const
    {
        return space100() * 0.5;
    }
    constexpr qreal space75() const
    {
        return space100() * 0.75;
    }
    constexpr qreal space100() const
    {
        return 8.0;
    }
    constexpr qreal space125() const
    {
        return space100() * 1.25;
    }
    constexpr qreal space150() const
    {
        return space100() * 1.5;
    }
    constexpr qreal space175() const
    {
        return space100() * 1.75;
    }
    constexpr qreal space200() const
    {
        return space100() * 2.0;
    }
    constexpr qreal space250() const
    {
        return space100() * 2.5;
    }
    constexpr qreal space300() const
    {
        return space100() * 3.0;
    }
    constexpr qreal space400() const
    {
        return space100() * 4.0;
    }
    constexpr qreal space450() const
    {
        return space100() * 4.5;
    }
    constexpr qreal space500() const
    {
        return space100() * 5.0;
    }
    constexpr qreal space600() const
    {
        return space100() * 6.0;
    }
    constexpr qreal space700() const
    {
        return space100() * 7.0;
    }
    constexpr qreal space800() const
    {
        return space100() * 8.0;
    }
    constexpr qreal space900() const
    {
        return space100() * 9.0;
    }
};

} // namespace Fluid
