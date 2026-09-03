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
// FabBaselineTokens.kt, FabMediumTokens.kt, FabLargeTokens.kt, and
// FabPrimaryContainerTokens.kt (VERSION: v0_14_0); ExtendedFabPrimaryTokens.kt
// (VERSION: v0_103); ExtendedFabSmallTokens.kt, ExtendedFabMediumTokens.kt, and
// ExtendedFabLargeTokens.kt (VERSION: v0_14_0); and ../FloatingActionButton.kt for
// the corrected Medium and Large Extended FAB icon-label spacing.

namespace Fluid {

/*! \brief Material Design 3 Expressive floating action button tokens. */
struct Fab
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerHeight READ containerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal containerWidth READ containerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerHeight READ mediumContainerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue mediumContainerShape READ mediumContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerWidth READ mediumContainerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal mediumIconSize READ mediumIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerHeight READ largeContainerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue largeContainerShape READ largeContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerWidth READ largeContainerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal largeIconSize READ largeIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpace READ leadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal mediumLeadingSpace READ mediumLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal largeLeadingSpace READ largeLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpace READ trailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal mediumTrailingSpace READ mediumTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal largeTrailingSpace READ largeTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpace READ iconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal mediumIconLabelSpace READ mediumIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal largeIconLabelSpace READ largeIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal focusContainerElevation READ focusContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal hoverContainerElevation READ hoverContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal pressedContainerElevation READ pressedContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal loweredContainerElevation READ loweredContainerElevation CONSTANT FINAL)
    Q_PROPERTY(
            qreal loweredFocusContainerElevation READ loweredFocusContainerElevation CONSTANT FINAL)
    Q_PROPERTY(
            qreal loweredHoverContainerElevation READ loweredHoverContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal loweredPressedContainerElevation READ loweredPressedContainerElevation CONSTANT
                       FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal containerHeight() const
    {
        return 56.0;
    }
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr qreal containerWidth() const
    {
        return 56.0;
    }
    constexpr qreal iconSize() const
    {
        return 24.0;
    }
    constexpr qreal mediumContainerHeight() const
    {
        return 80.0;
    }
    constexpr ShapeValue mediumContainerShape() const
    {
        return ShapeTokens{ }.cornerLargeIncreased();
    }
    constexpr qreal mediumContainerWidth() const
    {
        return 80.0;
    }
    constexpr qreal mediumIconSize() const
    {
        return 28.0;
    }
    constexpr qreal largeContainerHeight() const
    {
        return 96.0;
    }
    constexpr ShapeValue largeContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr qreal largeContainerWidth() const
    {
        return 96.0;
    }
    constexpr qreal largeIconSize() const
    {
        return 32.0;
    }
    //! Leading space of a default-size Extended FAB.
    constexpr qreal leadingSpace() const
    {
        return 16.0;
    }
    //! Leading space of a medium Extended FAB.
    constexpr qreal mediumLeadingSpace() const
    {
        return 26.0;
    }
    //! Leading space of a large Extended FAB.
    constexpr qreal largeLeadingSpace() const
    {
        return 28.0;
    }
    //! Trailing space of a default-size Extended FAB.
    constexpr qreal trailingSpace() const
    {
        return 16.0;
    }
    //! Trailing space of a medium Extended FAB.
    constexpr qreal mediumTrailingSpace() const
    {
        return 26.0;
    }
    //! Trailing space of a large Extended FAB.
    constexpr qreal largeTrailingSpace() const
    {
        return 28.0;
    }
    //! Space between the icon and label of a default-size Extended FAB.
    constexpr qreal iconLabelSpace() const
    {
        return 8.0;
    }
    //! Space between the icon and label of a medium Extended FAB.
    constexpr qreal mediumIconLabelSpace() const
    {
        return 12.0;
    }
    //! Space between the icon and label of a large Extended FAB.
    constexpr qreal largeIconLabelSpace() const
    {
        return 16.0;
    }
    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level3();
    }
    constexpr qreal focusContainerElevation() const
    {
        return ElevationTokens{ }.level3();
    }
    constexpr qreal hoverContainerElevation() const
    {
        return ElevationTokens{ }.level4();
    }
    constexpr qreal pressedContainerElevation() const
    {
        return ElevationTokens{ }.level3();
    }
    constexpr qreal loweredContainerElevation() const
    {
        return ElevationTokens{ }.level1();
    }
    constexpr qreal loweredFocusContainerElevation() const
    {
        return ElevationTokens{ }.level1();
    }
    constexpr qreal loweredHoverContainerElevation() const
    {
        return ElevationTokens{ }.level2();
    }
    constexpr qreal loweredPressedContainerElevation() const
    {
        return ElevationTokens{ }.level1();
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
