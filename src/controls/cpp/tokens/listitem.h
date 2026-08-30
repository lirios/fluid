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
// ListTokens.kt and ListItemTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 Expressive list item tokens. */
struct ListItem
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal oneLineContainerHeight READ oneLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal twoLineContainerHeight READ twoLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal threeLineContainerHeight READ threeLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpace READ leadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpace READ trailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal topSpace READ topSpace CONSTANT FINAL)
    Q_PROPERTY(qreal bottomSpace READ bottomSpace CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpace READ betweenSpace CONSTANT FINAL)
    Q_PROPERTY(qreal segmentedGap READ segmentedGap CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerExpressiveShape READ containerExpressiveShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue hoveredContainerExpressiveShape READ hoveredContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue focusedContainerExpressiveShape READ focusedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerExpressiveShape READ pressedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerExpressiveShape READ selectedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal leadingIconSize READ leadingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSize READ trailingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingAvatarSize READ leadingAvatarSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingImageSize READ leadingImageSize CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledStateLayerOpacity READ disabledStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal draggedStateLayerOpacity READ draggedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal draggedContainerElevation READ draggedContainerElevation CONSTANT FINAL)

public:
    constexpr qreal oneLineContainerHeight() const
    {
        return 56.0;
    }
    constexpr qreal twoLineContainerHeight() const
    {
        return 72.0;
    }
    constexpr qreal threeLineContainerHeight() const
    {
        return 88.0;
    }
    constexpr qreal leadingSpace() const
    {
        return 16.0;
    }
    constexpr qreal trailingSpace() const
    {
        return 16.0;
    }
    constexpr qreal topSpace() const
    {
        return 10.0;
    }
    constexpr qreal bottomSpace() const
    {
        return 10.0;
    }
    constexpr qreal betweenSpace() const
    {
        return 12.0;
    }
    constexpr qreal segmentedGap() const
    {
        return 2.0;
    }
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerNone();
    }
    constexpr ShapeValue containerExpressiveShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }
    constexpr ShapeValue hoveredContainerExpressiveShape() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue focusedContainerExpressiveShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue pressedContainerExpressiveShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue selectedContainerExpressiveShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr qreal leadingIconSize() const
    {
        return 24.0;
    }
    constexpr qreal trailingIconSize() const
    {
        return 24.0;
    }
    constexpr qreal leadingAvatarSize() const
    {
        return 40.0;
    }
    constexpr qreal leadingImageSize() const
    {
        return 56.0;
    }
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledStateLayerOpacity() const
    {
        return 0.1;
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
    constexpr qreal draggedStateLayerOpacity() const
    {
        return StateTokens{ }.draggedStateLayerOpacity();
    }
    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level0();
    }
    constexpr qreal draggedContainerElevation() const
    {
        return ElevationTokens{ }.level4();
    }
};

} // namespace Fluid
