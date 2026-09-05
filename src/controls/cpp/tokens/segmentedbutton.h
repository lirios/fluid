// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "measurementtokens.h"
#include "shapetokens.h"
#include "statetokens.h"
#include "typescale.h"

// Generated component values: OutlinedSegmentedButtonTokens.kt, VERSION: v0_162.
// https://raw.githubusercontent.com/androidx/androidx/androidx-main/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/OutlinedSegmentedButtonTokens.kt
// Layout values: SegmentedButtonDefaults.ContentPadding and IconSpacing in:
// https://raw.githubusercontent.com/androidx/androidx/androidx-main/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/SegmentedButton.kt
// There is no generated disabled-container opacity; the platform retains the
// selected secondary-container color when disabled. Disabled outline and content
// map to on-surface in the generated tokens; active colors are resolved by Style.

namespace Fluid {

/*! \brief Material Design 3 outlined segmented-button tokens. */
struct SegmentedButton
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerHeight READ containerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal outlineWidth READ outlineWidth CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::TypeScaleValue labelTextFont READ labelTextFont CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledOutlineOpacity READ disabledOutlineOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal contentPadding READ contentPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentSpacing READ contentSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)

public:
    //! Height of the visible outlined container.
    constexpr qreal containerHeight() const
    {
        return 40.0;
    }
    //! Size of option icons and the selection indicator.
    constexpr qreal iconSize() const
    {
        return 18.0;
    }
    //! Thickness of the outline and shared dividers.
    constexpr qreal outlineWidth() const
    {
        return 1.0;
    }
    //! Full system shape applied to the group's outer corners.
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    //! Reference to the system label-large typography.
    TypeScaleValue labelTextFont() const;
    //! Generated opacity shared by disabled icons and labels.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
    //! Generated opacity of the disabled on-surface outline.
    constexpr qreal disabledOutlineOpacity() const
    {
        return 0.12;
    }
    //! System hover state-layer opacity.
    constexpr qreal hoverStateLayerOpacity() const
    {
        return StateTokens{ }.hoverStateLayerOpacity();
    }
    //! System focus state-layer opacity.
    constexpr qreal focusStateLayerOpacity() const
    {
        return StateTokens{ }.focusStateLayerOpacity();
    }
    //! System pressed state-layer opacity.
    constexpr qreal pressedStateLayerOpacity() const
    {
        return StateTokens{ }.pressedStateLayerOpacity();
    }
    //! Horizontal content padding from the AndroidX platform layout.
    constexpr qreal contentPadding() const
    {
        return 12.0;
    }
    //! Icon-to-content spacing from the AndroidX platform layout.
    constexpr qreal contentSpacing() const
    {
        return 8.0;
    }
    //! Minimum interaction target supplied by the system measurement tokens.
    constexpr qreal minimumInteractiveSize() const
    {
        return MeasurementTokens{ }.minimumInteractiveSize();
    }
};

} // namespace Fluid
