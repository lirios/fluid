// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*!
    \brief Material Design 3 system state tokens.

    Values are from AndroidX StateTokens.kt, VERSION: v0_210, at the pinned directory:
    https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
*/
struct StateTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal draggedStateLayerOpacity READ draggedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal draggedStateLayerOpacity() const
    {
        return 0.16;
    }
    constexpr qreal focusStateLayerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal hoverStateLayerOpacity() const
    {
        return 0.08;
    }
    constexpr qreal pressedStateLayerOpacity() const
    {
        return 0.1;
    }
};

} // namespace Fluid
