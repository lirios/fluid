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
// NavigationRailBaselineItemTokens.kt, NavigationRailCollapsedTokens.kt,
// NavigationRailExpandedTokens.kt, NavigationRailHorizontalItemTokens.kt, and
// NavigationRailVerticalItemTokens.kt, VERSION: v0_11_0; ScrimTokens.kt, VERSION: v0_117.
// ItemHorizontalPadding follows the AndroidX WideNavigationRail implementation at:
// https://android.googlesource.com/platform/frameworks/support/+/8ac4ef277273e07d515f12ad4d71d517d7c57fef/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/WideNavigationRail.kt

namespace Fluid {

/*! \brief Material Design 3 Expressive navigation rail tokens. */
struct NavigationRail
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal collapsedContainerWidth READ collapsedContainerWidth CONSTANT FINAL)
    Q_PROPERTY(
            qreal expandedContainerWidthMinimum READ expandedContainerWidthMinimum CONSTANT FINAL)
    Q_PROPERTY(
            qreal expandedContainerWidthMaximum READ expandedContainerWidthMaximum CONSTANT FINAL)
    Q_PROPERTY(qreal modalContainerElevation READ modalContainerElevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue modalContainerShape READ modalContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal topSpace READ topSpace CONSTANT FINAL)
    Q_PROPERTY(qreal collapsedItemVerticalSpace READ collapsedItemVerticalSpace CONSTANT FINAL)
    Q_PROPERTY(qreal itemContainerHeight READ itemContainerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue itemContainerShape READ itemContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal itemContainerVerticalSpace READ itemContainerVerticalSpace CONSTANT FINAL)
    Q_PROPERTY(qreal headerSpaceMinimum READ headerSpaceMinimum CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue activeIndicatorShape READ activeIndicatorShape CONSTANT FINAL)
    Q_PROPERTY(
            qreal activeIndicatorIconLabelSpace READ activeIndicatorIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal activeIndicatorLeadingSpace READ activeIndicatorLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal activeIndicatorTrailingSpace READ activeIndicatorTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(
            qreal verticalActiveIndicatorHeight READ verticalActiveIndicatorHeight CONSTANT FINAL)
    Q_PROPERTY(qreal verticalActiveIndicatorWidth READ verticalActiveIndicatorWidth CONSTANT FINAL)
    Q_PROPERTY(qreal verticalIconLabelSpace READ verticalIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal verticalLeadingSpace READ verticalLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal verticalTrailingSpace READ verticalTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalActiveIndicatorHeight READ horizontalActiveIndicatorHeight CONSTANT
                       FINAL)
    Q_PROPERTY(qreal horizontalFullWidthLeadingSpace READ horizontalFullWidthLeadingSpace CONSTANT
                       FINAL)
    Q_PROPERTY(qreal horizontalFullWidthTrailingSpace READ horizontalFullWidthTrailingSpace CONSTANT
                       FINAL)
    Q_PROPERTY(qreal horizontalIconLabelSpace READ horizontalIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalLeadingSpace READ horizontalLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal itemHorizontalPadding READ itemHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal modalScrimOpacity READ modalScrimOpacity CONSTANT FINAL)

public:
    //! Resting elevation of the persistent rail container.
    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level0();
    }

    //! Shape of the persistent rail container.
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerNone();
    }

    //! Width of a collapsed Expressive navigation rail.
    constexpr qreal collapsedContainerWidth() const
    {
        return 96.0;
    }

    //! Minimum width of an expanded Expressive navigation rail.
    constexpr qreal expandedContainerWidthMinimum() const
    {
        return 220.0;
    }

    //! Maximum width of an expanded Expressive navigation rail.
    constexpr qreal expandedContainerWidthMaximum() const
    {
        return 360.0;
    }

    //! Elevation of an expanded modal navigation rail.
    constexpr qreal modalContainerElevation() const
    {
        return ElevationTokens{ }.level2();
    }

    //! Shape of an expanded modal navigation rail.
    constexpr ShapeValue modalContainerShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }

    //! Vertical space between the rail edge and its content.
    constexpr qreal topSpace() const
    {
        return 44.0;
    }

    //! Space between consecutive collapsed destinations.
    constexpr qreal collapsedItemVerticalSpace() const
    {
        return 4.0;
    }

    //! Baseline height of a navigation-rail destination.
    constexpr qreal itemContainerHeight() const
    {
        return 64.0;
    }

    //! Baseline shape of a destination container.
    constexpr ShapeValue itemContainerShape() const
    {
        return ShapeTokens{ }.cornerNone();
    }

    //! Baseline vertical space between destination containers.
    constexpr qreal itemContainerVerticalSpace() const
    {
        return 6.0;
    }

    //! Minimum space between a header and top-arranged destinations.
    constexpr qreal headerSpaceMinimum() const
    {
        return 40.0;
    }

    //! Size of a destination icon.
    constexpr qreal iconSize() const
    {
        return 24.0;
    }

    //! Shape of the active destination indicator.
    constexpr ShapeValue activeIndicatorShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }

    //! Baseline space between icon and label inside an active indicator.
    constexpr qreal activeIndicatorIconLabelSpace() const
    {
        return 8.0;
    }

    //! Baseline leading space inside an active indicator.
    constexpr qreal activeIndicatorLeadingSpace() const
    {
        return 16.0;
    }

    //! Baseline trailing space inside an active indicator.
    constexpr qreal activeIndicatorTrailingSpace() const
    {
        return 16.0;
    }

    //! Height of the collapsed, vertically arranged active indicator.
    constexpr qreal verticalActiveIndicatorHeight() const
    {
        return 32.0;
    }

    //! Width of the collapsed, vertically arranged active indicator.
    constexpr qreal verticalActiveIndicatorWidth() const
    {
        return 56.0;
    }

    //! Space between icon and label in a collapsed destination.
    constexpr qreal verticalIconLabelSpace() const
    {
        return 4.0;
    }

    //! Leading space of a collapsed destination.
    constexpr qreal verticalLeadingSpace() const
    {
        return 16.0;
    }

    //! Trailing space of a collapsed destination.
    constexpr qreal verticalTrailingSpace() const
    {
        return 16.0;
    }

    //! Height of the expanded, horizontally arranged active indicator.
    constexpr qreal horizontalActiveIndicatorHeight() const
    {
        return 56.0;
    }

    //! Leading space inside a full-width expanded indicator.
    constexpr qreal horizontalFullWidthLeadingSpace() const
    {
        return 16.0;
    }

    //! Trailing space inside a full-width expanded indicator.
    constexpr qreal horizontalFullWidthTrailingSpace() const
    {
        return 16.0;
    }

    //! Space between icon and label in an expanded destination.
    constexpr qreal horizontalIconLabelSpace() const
    {
        return 8.0;
    }

    //! Leading space of an expanded destination.
    constexpr qreal horizontalLeadingSpace() const
    {
        return 16.0;
    }

    //! Horizontal inset applied around expanded destinations by AndroidX.
    constexpr qreal itemHorizontalPadding() const
    {
        return 20.0;
    }

    //! Opacity of a hovered destination's state layer.
    constexpr qreal hoverStateLayerOpacity() const
    {
        return StateTokens{ }.hoverStateLayerOpacity();
    }

    //! Opacity of a keyboard-focused destination's state layer.
    constexpr qreal focusStateLayerOpacity() const
    {
        return StateTokens{ }.focusStateLayerOpacity();
    }

    //! Opacity of a pressed destination's state layer.
    constexpr qreal pressedStateLayerOpacity() const
    {
        return StateTokens{ }.pressedStateLayerOpacity();
    }

    //! Opacity of disabled destination content.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }

    //! Opacity of the scrim behind an expanded modal rail.
    constexpr qreal modalScrimOpacity() const
    {
        return 0.32;
    }
};

} // namespace Fluid
