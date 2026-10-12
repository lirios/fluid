// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "elevationtokens.h"
#include "shapetokens.h"

// Generated AndroidX values: VERSION 18_0_18, SplitButtonXSmallTokens.kt,
// SplitButtonSmallTokens.kt, SplitButtonMediumTokens.kt, SplitButtonLargeTokens.kt,
// SplitButtonXLargeTokens.kt; common-button elevation from FilledButtonTokens.kt,
// FilledTonalButtonTokens.kt and ElevatedButtonTokens.kt, VERSION v0_11_0.
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// Optical coefficient: HorizontalCenterOptically.kt at the same pinned revision.
// menuAnchorGap and trailingSelectedStateLayerOpacity follow the component specification:
// https://m3.material.io/components/split-button/specs

namespace Fluid {

/*! \brief Immutable Material Design 3 Expressive split-button metrics. */
struct SplitButton
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerHeightExtraSmall READ containerHeightExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightSmall READ containerHeightSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightMedium READ containerHeightMedium CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightLarge READ containerHeightLarge CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightExtraLarge READ containerHeightExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpaceExtraSmall READ betweenSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpaceSmall READ betweenSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpaceMedium READ betweenSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpaceLarge READ betweenSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpaceExtraLarge READ betweenSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerCornerCornerSizeExtraSmall READ innerCornerCornerSizeExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerCornerCornerSizeSmall READ innerCornerCornerSizeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerCornerCornerSizeMedium READ innerCornerCornerSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal innerCornerCornerSizeLarge READ innerCornerCornerSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerCornerCornerSizeExtraLarge READ innerCornerCornerSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerHoveredCornerCornerSizeExtraSmall READ innerHoveredCornerCornerSizeExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerHoveredCornerCornerSizeSmall READ innerHoveredCornerCornerSizeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerHoveredCornerCornerSizeMedium READ innerHoveredCornerCornerSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal innerHoveredCornerCornerSizeLarge READ innerHoveredCornerCornerSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerHoveredCornerCornerSizeExtraLarge READ innerHoveredCornerCornerSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerPressedCornerCornerSizeExtraSmall READ innerPressedCornerCornerSizeExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerPressedCornerCornerSizeSmall READ innerPressedCornerCornerSizeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal innerPressedCornerCornerSizeMedium READ innerPressedCornerCornerSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal innerPressedCornerCornerSizeLarge READ innerPressedCornerCornerSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal innerPressedCornerCornerSizeExtraLarge READ innerPressedCornerCornerSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonLeadingSpaceExtraSmall READ leadingButtonLeadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonLeadingSpaceSmall READ leadingButtonLeadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonLeadingSpaceMedium READ leadingButtonLeadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonLeadingSpaceLarge READ leadingButtonLeadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonLeadingSpaceExtraLarge READ leadingButtonLeadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonTrailingSpaceExtraSmall READ leadingButtonTrailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonTrailingSpaceSmall READ leadingButtonTrailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonTrailingSpaceMedium READ leadingButtonTrailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonTrailingSpaceLarge READ leadingButtonTrailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingButtonTrailingSpaceExtraLarge READ leadingButtonTrailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSizeExtraSmall READ trailingIconSizeExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSizeSmall READ trailingIconSizeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSizeMedium READ trailingIconSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSizeLarge READ trailingIconSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSizeExtraLarge READ trailingIconSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonLeadingSpaceExtraSmall READ trailingButtonLeadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonLeadingSpaceSmall READ trailingButtonLeadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonLeadingSpaceMedium READ trailingButtonLeadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonLeadingSpaceLarge READ trailingButtonLeadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonLeadingSpaceExtraLarge READ trailingButtonLeadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonTrailingSpaceExtraSmall READ trailingButtonTrailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonTrailingSpaceSmall READ trailingButtonTrailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonTrailingSpaceMedium READ trailingButtonTrailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonTrailingSpaceLarge READ trailingButtonTrailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingButtonTrailingSpaceExtraLarge READ trailingButtonTrailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal menuAnchorGap READ menuAnchorGap CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSelectedStateLayerOpacity READ trailingSelectedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal opticalCenteringCoefficient READ opticalCenteringCoefficient CONSTANT FINAL)
    Q_PROPERTY(qreal flatContainerElevation READ flatContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal flatHoverContainerElevation READ flatHoverContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal elevatedContainerElevation READ elevatedContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal elevatedHoverContainerElevation READ elevatedHoverContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContainerElevation READ disabledContainerElevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue outerCornerShape READ outerCornerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue trailingExpandedInnerCornerShape READ trailingExpandedInnerCornerShape CONSTANT FINAL)

public:
    constexpr qreal containerHeightExtraSmall() const
    {
        return 32.0;
    }
    constexpr qreal containerHeightSmall() const
    {
        return 40.0;
    }
    constexpr qreal containerHeightMedium() const
    {
        return 56.0;
    }
    constexpr qreal containerHeightLarge() const
    {
        return 96.0;
    }
    constexpr qreal containerHeightExtraLarge() const
    {
        return 136.0;
    }
    constexpr qreal betweenSpaceExtraSmall() const
    {
        return 2.0;
    }
    constexpr qreal betweenSpaceSmall() const
    {
        return 2.0;
    }
    constexpr qreal betweenSpaceMedium() const
    {
        return 2.0;
    }
    constexpr qreal betweenSpaceLarge() const
    {
        return 2.0;
    }
    constexpr qreal betweenSpaceExtraLarge() const
    {
        return 2.0;
    }
    constexpr qreal innerCornerCornerSizeExtraSmall() const
    {
        return ShapeTokens{ }.cornerValueExtraSmall();
    }
    constexpr qreal innerCornerCornerSizeSmall() const
    {
        return ShapeTokens{ }.cornerValueExtraSmall();
    }
    constexpr qreal innerCornerCornerSizeMedium() const
    {
        return ShapeTokens{ }.cornerValueExtraSmall();
    }
    constexpr qreal innerCornerCornerSizeLarge() const
    {
        return ShapeTokens{ }.cornerValueSmall();
    }
    constexpr qreal innerCornerCornerSizeExtraLarge() const
    {
        return ShapeTokens{ }.cornerValueMedium();
    }
    constexpr qreal innerHoveredCornerCornerSizeExtraSmall() const
    {
        return ShapeTokens{ }.cornerValueSmall();
    }
    constexpr qreal innerHoveredCornerCornerSizeSmall() const
    {
        return ShapeTokens{ }.cornerValueMedium();
    }
    constexpr qreal innerHoveredCornerCornerSizeMedium() const
    {
        return ShapeTokens{ }.cornerValueMedium();
    }
    constexpr qreal innerHoveredCornerCornerSizeLarge() const
    {
        return ShapeTokens{ }.cornerValueLargeIncreased();
    }
    constexpr qreal innerHoveredCornerCornerSizeExtraLarge() const
    {
        return ShapeTokens{ }.cornerValueLargeIncreased();
    }
    constexpr qreal innerPressedCornerCornerSizeExtraSmall() const
    {
        return ShapeTokens{ }.cornerValueSmall();
    }
    constexpr qreal innerPressedCornerCornerSizeSmall() const
    {
        return ShapeTokens{ }.cornerValueMedium();
    }
    constexpr qreal innerPressedCornerCornerSizeMedium() const
    {
        return ShapeTokens{ }.cornerValueMedium();
    }
    constexpr qreal innerPressedCornerCornerSizeLarge() const
    {
        return ShapeTokens{ }.cornerValueLargeIncreased();
    }
    constexpr qreal innerPressedCornerCornerSizeExtraLarge() const
    {
        return ShapeTokens{ }.cornerValueLargeIncreased();
    }
    constexpr qreal leadingButtonLeadingSpaceExtraSmall() const
    {
        return 12.0;
    }
    constexpr qreal leadingButtonLeadingSpaceSmall() const
    {
        return 16.0;
    }
    constexpr qreal leadingButtonLeadingSpaceMedium() const
    {
        return 24.0;
    }
    constexpr qreal leadingButtonLeadingSpaceLarge() const
    {
        return 48.0;
    }
    constexpr qreal leadingButtonLeadingSpaceExtraLarge() const
    {
        return 64.0;
    }
    constexpr qreal leadingButtonTrailingSpaceExtraSmall() const
    {
        return 10.0;
    }
    constexpr qreal leadingButtonTrailingSpaceSmall() const
    {
        return 12.0;
    }
    constexpr qreal leadingButtonTrailingSpaceMedium() const
    {
        return 24.0;
    }
    constexpr qreal leadingButtonTrailingSpaceLarge() const
    {
        return 48.0;
    }
    constexpr qreal leadingButtonTrailingSpaceExtraLarge() const
    {
        return 64.0;
    }
    constexpr qreal trailingIconSizeExtraSmall() const
    {
        return 22.0;
    }
    constexpr qreal trailingIconSizeSmall() const
    {
        return 22.0;
    }
    constexpr qreal trailingIconSizeMedium() const
    {
        return 26.0;
    }
    constexpr qreal trailingIconSizeLarge() const
    {
        return 38.0;
    }
    constexpr qreal trailingIconSizeExtraLarge() const
    {
        return 50.0;
    }
    constexpr qreal trailingButtonLeadingSpaceExtraSmall() const
    {
        return 13.0;
    }
    constexpr qreal trailingButtonLeadingSpaceSmall() const
    {
        return 13.0;
    }
    constexpr qreal trailingButtonLeadingSpaceMedium() const
    {
        return 15.0;
    }
    constexpr qreal trailingButtonLeadingSpaceLarge() const
    {
        return 29.0;
    }
    constexpr qreal trailingButtonLeadingSpaceExtraLarge() const
    {
        return 43.0;
    }
    constexpr qreal trailingButtonTrailingSpaceExtraSmall() const
    {
        return 13.0;
    }
    constexpr qreal trailingButtonTrailingSpaceSmall() const
    {
        return 13.0;
    }
    constexpr qreal trailingButtonTrailingSpaceMedium() const
    {
        return 15.0;
    }
    constexpr qreal trailingButtonTrailingSpaceLarge() const
    {
        return 29.0;
    }
    constexpr qreal trailingButtonTrailingSpaceExtraLarge() const
    {
        return 43.0;
    }
    constexpr qreal menuAnchorGap() const
    {
        return 4.0;
    }
    constexpr qreal trailingSelectedStateLayerOpacity() const
    {
        return 0.10;
    }
    constexpr qreal opticalCenteringCoefficient() const
    {
        return 0.11;
    }
    constexpr qreal flatContainerElevation() const
    {
        return ElevationTokens{ }.level0();
    }
    constexpr qreal flatHoverContainerElevation() const
    {
        return ElevationTokens{ }.level1();
    }
    constexpr qreal elevatedContainerElevation() const
    {
        return ElevationTokens{ }.level1();
    }
    constexpr qreal elevatedHoverContainerElevation() const
    {
        return ElevationTokens{ }.level2();
    }
    constexpr qreal disabledContainerElevation() const
    {
        return ElevationTokens{ }.level0();
    }
    constexpr ShapeValue outerCornerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr ShapeValue trailingExpandedInnerCornerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
};

} // namespace Fluid
