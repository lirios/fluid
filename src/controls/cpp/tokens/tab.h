// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "elevationtokens.h"
#include "shapetokens.h"
#include "statetokens.h"

// AndroidX PrimaryNavigationTabTokens.kt and SecondaryNavigationTabTokens.kt,
// VERSION: v0_162, at the pinned token directory:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// ../Tab.kt supplies horizontal padding; ../TabRow.kt uses DefaultSpatial motion.
// Material tabs specification (revision 2026-09-23_06-10-05) supplies the 2dp
// secondary indicator, 1dp divider, primary minimum/inset, badges, and scroll offset:
// https://m3.material.io/components/tabs/specs
// Material Web tabs/internal/_primary-tab.scss supplies the stacked 2dp gap.

namespace Fluid {

/*! \brief Immutable Material Design 3 primary and secondary tab metrics. */
struct Tab
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal primaryContainerHeight READ primaryContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal primaryWithIconAndLabelContainerHeight READ
                       primaryWithIconAndLabelContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal secondaryContainerHeight READ secondaryContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalPadding READ horizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal inlineIconLabelGap READ inlineIconLabelGap CONSTANT FINAL)
    Q_PROPERTY(qreal stackedIconLabelGap READ stackedIconLabelGap CONSTANT FINAL)
    Q_PROPERTY(qreal labelBadgeGap READ labelBadgeGap CONSTANT FINAL)
    Q_PROPERTY(qreal badgeOverlap READ badgeOverlap CONSTANT FINAL)
    Q_PROPERTY(qreal scrollableLeadingOffset READ scrollableLeadingOffset CONSTANT FINAL)
    Q_PROPERTY(qreal primaryActiveIndicatorHeight READ primaryActiveIndicatorHeight CONSTANT FINAL)
    Q_PROPERTY(qreal primaryActiveIndicatorMinimumWidth READ primaryActiveIndicatorMinimumWidth
                       CONSTANT FINAL)
    Q_PROPERTY(qreal primaryActiveIndicatorHorizontalInset READ
                       primaryActiveIndicatorHorizontalInset CONSTANT FINAL)
    Q_PROPERTY(
            qreal secondaryActiveIndicatorHeight READ secondaryActiveIndicatorHeight CONSTANT FINAL)
    Q_PROPERTY(qreal dividerHeight READ dividerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue primaryActiveIndicatorShape READ primaryActiveIndicatorShape
                       CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue secondaryActiveIndicatorShape READ secondaryActiveIndicatorShape
                       CONSTANT FINAL)

public:
    constexpr qreal primaryContainerHeight() const
    {
        return 48.0;
    }

    constexpr qreal primaryWithIconAndLabelContainerHeight() const
    {
        return 64.0;
    }

    constexpr qreal secondaryContainerHeight() const
    {
        return 48.0;
    }

    constexpr qreal minimumInteractiveSize() const
    {
        return 48.0;
    }

    constexpr qreal iconSize() const
    {
        return 24.0;
    }

    constexpr qreal horizontalPadding() const
    {
        return 16.0;
    }

    constexpr qreal inlineIconLabelGap() const
    {
        return 8.0;
    }

    constexpr qreal stackedIconLabelGap() const
    {
        return 2.0;
    }

    constexpr qreal labelBadgeGap() const
    {
        return 4.0;
    }

    constexpr qreal badgeOverlap() const
    {
        return 6.0;
    }

    constexpr qreal scrollableLeadingOffset() const
    {
        return 52.0;
    }

    constexpr qreal primaryActiveIndicatorHeight() const
    {
        return 3.0;
    }

    constexpr qreal primaryActiveIndicatorMinimumWidth() const
    {
        return 24.0;
    }

    constexpr qreal primaryActiveIndicatorHorizontalInset() const
    {
        return 2.0;
    }

    constexpr qreal secondaryActiveIndicatorHeight() const
    {
        return 2.0;
    }

    constexpr qreal dividerHeight() const
    {
        return 1.0;
    }

    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level0();
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

    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerNone();
    }

    constexpr ShapeValue primaryActiveIndicatorShape() const
    {
        return { 3.0, 3.0, 3.0, 3.0 };
    }

    constexpr ShapeValue secondaryActiveIndicatorShape() const
    {
        return ShapeTokens{ }.cornerNone();
    }
};

} // namespace Fluid
