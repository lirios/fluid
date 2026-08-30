// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "shapetokens.h"
#include "statetokens.h"

// Component values map to the AndroidX Material 3 generated tokens where available:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// SwitchTokens.kt; system references are provided by ShapeTokens.kt and StateTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 switch tokens. */
struct Switch
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal trackWidth READ trackWidth CONSTANT FINAL)
    Q_PROPERTY(qreal trackHeight READ trackHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue trackShape READ trackShape CONSTANT FINAL)
    Q_PROPERTY(qreal trackOutlineWidth READ trackOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerSize READ stateLayerSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue stateLayerShape READ stateLayerShape CONSTANT FINAL)
    Q_PROPERTY(qreal contentPadding READ contentPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentSpacing READ contentSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal selectedHandleSize READ selectedHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedHandleSize READ unselectedHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal withIconHandleSize READ withIconHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal pressedHandleSize READ pressedHandleSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue handleShape READ handleShape CONSTANT FINAL)
    Q_PROPERTY(qreal selectedIconSize READ selectedIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedIconSize READ unselectedIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal disabledTrackOpacity READ disabledTrackOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal disabledSelectedHandleOpacity READ disabledSelectedHandleOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledUnselectedHandleOpacity READ disabledUnselectedHandleOpacity CONSTANT
                       FINAL)
    Q_PROPERTY(qreal disabledSelectedIconOpacity READ disabledSelectedIconOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal disabledUnselectedIconOpacity READ disabledUnselectedIconOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal trackWidth() const
    {
        return 52.0;
    }
    constexpr qreal trackHeight() const
    {
        return 32.0;
    }
    constexpr ShapeValue trackShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr qreal trackOutlineWidth() const
    {
        return 2.0;
    }
    constexpr qreal stateLayerSize() const
    {
        return 40.0;
    }
    constexpr ShapeValue stateLayerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    // Fluid label/layout metrics; AndroidX SwitchTokens has no label composition tokens.
    constexpr qreal contentPadding() const
    {
        return 8.0;
    }
    constexpr qreal contentSpacing() const
    {
        return 8.0;
    }
    constexpr qreal selectedHandleSize() const
    {
        return 24.0;
    }
    constexpr qreal unselectedHandleSize() const
    {
        return 16.0;
    }
    constexpr qreal withIconHandleSize() const
    {
        return 24.0;
    }
    constexpr qreal pressedHandleSize() const
    {
        return 28.0;
    }
    constexpr ShapeValue handleShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr qreal selectedIconSize() const
    {
        return 16.0;
    }
    constexpr qreal unselectedIconSize() const
    {
        return 16.0;
    }
    constexpr qreal disabledTrackOpacity() const
    {
        return 0.12;
    }
    constexpr qreal disabledSelectedHandleOpacity() const
    {
        return 1.0;
    }
    constexpr qreal disabledUnselectedHandleOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledSelectedIconOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledUnselectedIconOpacity() const
    {
        return 0.38;
    }
    constexpr qreal hoverStateLayerOpacity() const
    {
        return StateTokens{ }.hoverStateLayerOpacity();
    }
    constexpr qreal focusStateLayerOpacity() const
    {
        return StateTokens{ }.focusStateLayerOpacity();
    }
    constexpr qreal pressedStateLayerOpacity() const
    {
        return StateTokens{ }.pressedStateLayerOpacity();
    }
};

} // namespace Fluid
