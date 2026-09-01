// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "elevationtokens.h"
#include "shapetokens.h"

// Component values map to the AndroidX Material 3 generated tokens and tooltip implementation:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// PlainTooltipTokens.kt, RichTooltipTokens.kt, and ../Tooltip.kt (VERSION: v0_210).

namespace Fluid {

/*!
    \brief Material Design 3 tokens for plain and rich tooltips.

    Generated component values and AndroidX tooltip layout metrics are exposed
    through \c Tokens.toolTip for the public PlainToolTip and RichToolTip controls.

    For the component behavior represented by these values, see the
    <a href="https://m3.material.io/components/tooltips/overview">Material Design 3
    tooltip guidelines</a>.
*/
struct ToolTip
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal minimumWidth READ minimumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal minimumHeight READ minimumHeight CONSTANT FINAL)
    Q_PROPERTY(qreal plainMaximumWidth READ plainMaximumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal richMaximumWidth READ richMaximumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal anchorSpacing READ anchorSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal viewportMargin READ viewportMargin CONSTANT FINAL)
    Q_PROPERTY(qreal plainHorizontalPadding READ plainHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal plainVerticalPadding READ plainVerticalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal richHorizontalPadding READ richHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal richHeadlineFirstBaseline READ richHeadlineFirstBaseline CONSTANT FINAL)
    Q_PROPERTY(qreal richBodyFirstBaseline READ richBodyFirstBaseline CONSTANT FINAL)
    Q_PROPERTY(qreal richBodyBottomPadding READ richBodyBottomPadding CONSTANT FINAL)
    Q_PROPERTY(qreal richActionMinimumHeight READ richActionMinimumHeight CONSTANT FINAL)
    Q_PROPERTY(qreal richActionBottomPadding READ richActionBottomPadding CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue plainContainerShape READ plainContainerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue richContainerShape READ richContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal richContainerElevation READ richContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal closedScale READ closedScale CONSTANT FINAL)

public:
    //! Minimum tooltip width.
    constexpr qreal minimumWidth() const
    {
        return 40.0;
    }

    //! Minimum tooltip height.
    constexpr qreal minimumHeight() const
    {
        return 24.0;
    }

    //! Maximum plain-tooltip width.
    constexpr qreal plainMaximumWidth() const
    {
        return 200.0;
    }

    //! Maximum rich-tooltip width.
    constexpr qreal richMaximumWidth() const
    {
        return 320.0;
    }

    //! Space between the tooltip and its anchor.
    constexpr qreal anchorSpacing() const
    {
        return 4.0;
    }

    //! Minimum distance maintained between a tooltip and a viewport edge.
    constexpr qreal viewportMargin() const
    {
        return 4.0;
    }

    //! Horizontal padding of a plain tooltip.
    constexpr qreal plainHorizontalPadding() const
    {
        return 8.0;
    }

    //! Vertical padding of a plain tooltip.
    constexpr qreal plainVerticalPadding() const
    {
        return 4.0;
    }

    //! Horizontal padding of a rich tooltip.
    constexpr qreal richHorizontalPadding() const
    {
        return 16.0;
    }

    //! Distance from the rich container top to the headline's first baseline.
    constexpr qreal richHeadlineFirstBaseline() const
    {
        return 28.0;
    }

    //! Distance from the body slot top to its first baseline when rich content is present.
    constexpr qreal richBodyFirstBaseline() const
    {
        return 24.0;
    }

    //! Bottom padding below the rich body when a headline or actions are present.
    constexpr qreal richBodyBottomPadding() const
    {
        return 16.0;
    }

    //! Minimum height reserved for the rich-tooltip action area.
    constexpr qreal richActionMinimumHeight() const
    {
        return 36.0;
    }

    //! Bottom padding below rich-tooltip actions.
    constexpr qreal richActionBottomPadding() const
    {
        return 8.0;
    }

    //! Shape of a plain tooltip container.
    constexpr ShapeValue plainContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }

    //! Shape of a rich tooltip container.
    constexpr ShapeValue richContainerShape() const
    {
        return ShapeTokens{ }.cornerMedium();
    }

    //! Shadow elevation of a rich tooltip container.
    constexpr qreal richContainerElevation() const
    {
        return ElevationTokens{ }.level2();
    }

    //! Scale used at the closed endpoint of tooltip transitions.
    constexpr qreal closedScale() const
    {
        return 0.8;
    }
};

} // namespace Fluid
