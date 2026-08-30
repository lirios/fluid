// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "shapetokens.h"
#include "statetokens.h"

// Component values map to the AndroidX Material 3 generated tokens where available:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// CheckboxTokens.kt; system references are provided by ShapeTokens.kt and StateTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 checkbox tokens. */
struct CheckBox
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerSize READ containerSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerSize READ stateLayerSize CONSTANT FINAL)
    Q_PROPERTY(qreal contentPadding READ contentPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentSpacing READ contentSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal containerPadding READ containerPadding CONSTANT FINAL)
    Q_PROPERTY(qreal selectedOutlineWidth READ selectedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedOutlineWidth READ unselectedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal selectedDisabledContainerOpacity READ selectedDisabledContainerOpacity CONSTANT
                       FINAL)
    Q_PROPERTY(qreal unselectedDisabledContainerOpacity READ unselectedDisabledContainerOpacity
                       CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal containerSize() const
    {
        return 18.0;
    }
    constexpr ShapeValue containerShape() const
    {
        return { 2.0, 2.0, 2.0, 2.0 };
    }
    constexpr qreal iconSize() const
    {
        return 18.0;
    }
    constexpr qreal stateLayerSize() const
    {
        return 40.0;
    }
    // Fluid label/layout metrics; AndroidX CheckboxTokens has no label composition tokens.
    constexpr qreal contentPadding() const
    {
        return 8.0;
    }
    constexpr qreal contentSpacing() const
    {
        return 8.0;
    }
    constexpr qreal containerPadding() const
    {
        return 4.0;
    }
    constexpr qreal selectedOutlineWidth() const
    {
        return 0.0;
    }
    constexpr qreal unselectedOutlineWidth() const
    {
        return 2.0;
    }
    constexpr qreal selectedDisabledContainerOpacity() const
    {
        return 0.38;
    }
    constexpr qreal unselectedDisabledContainerOpacity() const
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
