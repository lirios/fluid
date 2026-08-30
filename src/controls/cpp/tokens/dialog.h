// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "elevationtokens.h"
#include "shapetokens.h"
#include "statetokens.h"

// Component values map to the AndroidX Material 3 generated tokens:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// DialogTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 dialog tokens. */
struct Dialog
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal withIconIconSize READ withIconIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal actionHoverStateLayerOpacity READ actionHoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal actionFocusStateLayerOpacity READ actionFocusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal actionPressedStateLayerOpacity READ actionPressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level3();
    }
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr qreal withIconIconSize() const
    {
        return 24.0;
    }
    constexpr qreal actionHoverStateLayerOpacity() const
    {
        return StateTokens{ }.hoverStateLayerOpacity();
    }
    constexpr qreal actionFocusStateLayerOpacity() const
    {
        return StateTokens{ }.focusStateLayerOpacity();
    }
    constexpr qreal actionPressedStateLayerOpacity() const
    {
        return StateTokens{ }.pressedStateLayerOpacity();
    }
};

} // namespace Fluid
