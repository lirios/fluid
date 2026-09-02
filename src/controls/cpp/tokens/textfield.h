// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "shapetokens.h"

// Component values map to the AndroidX Material 3 generated tokens:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// FilledTextFieldTokens.kt (VERSION: v0_210) and OutlinedTextFieldTokens.kt (VERSION: v0_103).
// Layout values follow the
// AndroidX Material 3 TextField implementation at the same pinned revision.

namespace Fluid {

/*! \brief Material Design 3 tokens for text fields. */
struct TextField
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal minimumWidth READ minimumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeight READ containerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalPadding READ horizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentVerticalPadding READ contentVerticalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal supportingTextTopSpace READ supportingTextTopSpace CONSTANT FINAL)
    Q_PROPERTY(qreal supportingTextMinimumHeight READ supportingTextMinimumHeight CONSTANT FINAL)
    Q_PROPERTY(qreal prefixSuffixTextSpace READ prefixSuffixTextSpace CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconTargetSize READ iconTargetSize CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue filledContainerShape READ filledContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal filledActiveIndicatorHeight READ filledActiveIndicatorHeight CONSTANT FINAL)
    Q_PROPERTY(qreal filledHoverActiveIndicatorHeight READ filledHoverActiveIndicatorHeight CONSTANT
                       FINAL)
    Q_PROPERTY(qreal filledDisabledActiveIndicatorHeight READ filledDisabledActiveIndicatorHeight
                       CONSTANT FINAL)
    Q_PROPERTY(qreal filledFocusActiveIndicatorHeight READ filledFocusActiveIndicatorHeight CONSTANT
                       FINAL)
    Q_PROPERTY(qreal filledDisabledActiveIndicatorOpacity READ
                       filledDisabledActiveIndicatorOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal filledDisabledContainerOpacity READ filledDisabledContainerOpacity CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue outlinedContainerShape READ outlinedContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidth READ outlinedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedHoverOutlineWidth READ outlinedHoverOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedDisabledOutlineWidth READ outlinedDisabledOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedFocusOutlineWidth READ outlinedFocusOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedDisabledOutlineOpacity READ outlinedDisabledOutlineOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedLabelHorizontalPadding READ outlinedLabelHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)

public:
    //! Preferred minimum width of a text field.
    constexpr qreal minimumWidth() const
    {
        return 280.0;
    }

    //! Minimum height of the text-field container.
    constexpr qreal containerHeight() const
    {
        return 56.0;
    }

    //! Logical horizontal padding around text-field content.
    constexpr qreal horizontalPadding() const
    {
        return 16.0;
    }

    //! Vertical padding around text-field content.
    constexpr qreal contentVerticalPadding() const
    {
        return 8.0;
    }

    //! Space between the container and supporting or error text.
    constexpr qreal supportingTextTopSpace() const
    {
        return 4.0;
    }

    //! Minimum height reserved for supporting or error text.
    constexpr qreal supportingTextMinimumHeight() const
    {
        return 16.0;
    }

    //! Space between input text and prefix or suffix text.
    constexpr qreal prefixSuffixTextSpace() const
    {
        return 2.0;
    }

    //! Visual size of leading and trailing icons.
    constexpr qreal iconSize() const
    {
        return 24.0;
    }

    //! Minimum target size reserved for leading and trailing icon slots.
    constexpr qreal iconTargetSize() const
    {
        return 48.0;
    }

    //! Shape of a filled text-field container.
    constexpr ShapeValue filledContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmallTop();
    }

    //! Resting thickness of a filled text field's active indicator.
    constexpr qreal filledActiveIndicatorHeight() const
    {
        return 1.0;
    }

    //! Hovered thickness of a filled text field's active indicator.
    constexpr qreal filledHoverActiveIndicatorHeight() const
    {
        return 1.0;
    }

    //! Disabled thickness of a filled text field's active indicator.
    constexpr qreal filledDisabledActiveIndicatorHeight() const
    {
        return 1.0;
    }

    //! Focused thickness of a filled text field's active indicator.
    constexpr qreal filledFocusActiveIndicatorHeight() const
    {
        return 2.0;
    }

    //! Opacity of a filled text field's active indicator when disabled.
    constexpr qreal filledDisabledActiveIndicatorOpacity() const
    {
        return 0.38;
    }

    //! Opacity of a filled text-field container when disabled.
    constexpr qreal filledDisabledContainerOpacity() const
    {
        return 0.04;
    }

    //! Shape of an outlined text-field container.
    constexpr ShapeValue outlinedContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }

    //! Resting thickness of an outlined text field's outline.
    constexpr qreal outlinedOutlineWidth() const
    {
        return 1.0;
    }

    //! Hovered thickness of an outlined text field's outline.
    constexpr qreal outlinedHoverOutlineWidth() const
    {
        return 1.0;
    }

    //! Disabled thickness of an outlined text field's outline.
    constexpr qreal outlinedDisabledOutlineWidth() const
    {
        return 1.0;
    }

    //! Focused thickness of an outlined text field's outline.
    constexpr qreal outlinedFocusOutlineWidth() const
    {
        return 2.0;
    }

    //! Opacity of an outlined text field's outline when disabled.
    constexpr qreal outlinedDisabledOutlineOpacity() const
    {
        return 0.12;
    }

    //! Horizontal padding around a floated outlined-field label.
    constexpr qreal outlinedLabelHorizontalPadding() const
    {
        return 4.0;
    }

    //! Opacity of text-field content when disabled.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
};

} // namespace Fluid
