// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "measurementtokens.h"
#include "statetokens.h"

// Component values map to the AndroidX Material 3 generated tokens where available:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// RadioButtonTokens.kt; state-layer opacities are provided by StateTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 radio-button tokens. */
struct RadioButton
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerSize READ stateLayerSize CONSTANT FINAL)
    Q_PROPERTY(qreal indicatorPadding READ indicatorPadding CONSTANT FINAL)
    Q_PROPERTY(qreal outlineWidth READ outlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal contentPadding READ contentPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentSpacing READ contentSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal selectedDisabledIconOpacity READ selectedDisabledIconOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal unselectedDisabledIconOpacity READ unselectedDisabledIconOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal minimumInteractiveSize() const
    {
        return MeasurementTokens{ }.minimumInteractiveSize();
    }
    constexpr qreal iconSize() const
    {
        return 20.0;
    }
    constexpr qreal stateLayerSize() const
    {
        return 40.0;
    }
    // Fluid layout metric matching the AndroidX RadioButtonPadding constant.
    constexpr qreal indicatorPadding() const
    {
        return 2.0;
    }
    constexpr qreal outlineWidth() const
    {
        return 2.0;
    }
    // Fluid label/layout metrics; AndroidX RadioButtonTokens has no label composition tokens.
    constexpr qreal contentPadding() const
    {
        return 8.0;
    }
    constexpr qreal contentSpacing() const
    {
        return 8.0;
    }
    constexpr qreal selectedDisabledIconOpacity() const
    {
        return 0.38;
    }
    constexpr qreal unselectedDisabledIconOpacity() const
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
