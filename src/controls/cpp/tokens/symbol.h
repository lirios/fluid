// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

// Fluid symbol metrics were audited against the pinned AndroidX Material 3 token set;
// it has no generated SymbolTokens.kt counterpart and these values remain Fluid-specific:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/

namespace Fluid {

/*! \brief Material Symbols icon tokens. */
struct Symbol
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal size READ size CONSTANT FINAL)

public:
    constexpr qreal size() const
    {
        return 24.0;
    }
};

} // namespace Fluid
