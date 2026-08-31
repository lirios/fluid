// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "elevationtokens.h"
#include "shapetokens.h"

// Component values map to the AndroidX Material 3 generated tokens, VERSION: v0_210:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// FilledAutocompleteTokens.kt and OutlinedAutocompleteTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 tokens for exposed dropdown menus. */
struct ExposedDropdownMenu
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal fieldHeight READ fieldHeight CONSTANT FINAL)
    Q_PROPERTY(qreal minimumWidth READ minimumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal preferredWidth READ preferredWidth CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalPadding READ horizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal contentVerticalPadding READ contentVerticalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal labelInputTextSpace READ labelInputTextSpace CONSTANT FINAL)
    Q_PROPERTY(qreal supportingTextTopSpace READ supportingTextTopSpace CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue filledContainerShape READ filledContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal filledLeadingIconSize READ filledLeadingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal filledActiveIndicatorHeight READ filledActiveIndicatorHeight CONSTANT FINAL)
    Q_PROPERTY(qreal filledHoverActiveIndicatorHeight READ filledHoverActiveIndicatorHeight CONSTANT
                       FINAL)
    Q_PROPERTY(qreal filledFocusActiveIndicatorHeight READ filledFocusActiveIndicatorHeight CONSTANT
                       FINAL)
    Q_PROPERTY(
            qreal filledDisabledContainerOpacity READ filledDisabledContainerOpacity CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue outlinedContainerShape READ outlinedContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedLeadingIconSize READ outlinedLeadingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidth READ outlinedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedHoverOutlineWidth READ outlinedHoverOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedFocusOutlineWidth READ outlinedFocusOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedDisabledOutlineOpacity READ outlinedDisabledOutlineOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedLabelHorizontalPadding READ outlinedLabelHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSize READ trailingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingIconContentSpace READ leadingIconContentSpace CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconContentSpace READ trailingIconContentSpace CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal popupAnchorGap READ popupAnchorGap CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue popupContainerShape READ popupContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal popupContainerElevation READ popupContainerElevation CONSTANT FINAL)

public:
    //! Minimum height of the text-field container.
    constexpr qreal fieldHeight() const
    {
        return 56.0;
    }
    //! Minimum supported field width.
    constexpr qreal minimumWidth() const
    {
        return 280.0;
    }
    //! Preferred field width.
    constexpr qreal preferredWidth() const
    {
        return 280.0;
    }
    //! Logical outer padding of field content.
    constexpr qreal horizontalPadding() const
    {
        return 16.0;
    }
    //! Vertical padding used by text inside the field.
    constexpr qreal contentVerticalPadding() const
    {
        return 8.0;
    }
    //! Space between a floated label and input text.
    constexpr qreal labelInputTextSpace() const
    {
        return 4.0;
    }
    //! Space above supporting or error text.
    constexpr qreal supportingTextTopSpace() const
    {
        return 4.0;
    }
    //! Shape of the filled field container.
    constexpr ShapeValue filledContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmallTop();
    }
    //! Size of the optional leading icon in a filled field.
    constexpr qreal filledLeadingIconSize() const
    {
        return 20.0;
    }
    //! Resting thickness of the filled active indicator.
    constexpr qreal filledActiveIndicatorHeight() const
    {
        return 1.0;
    }
    //! Hovered thickness of the filled active indicator.
    constexpr qreal filledHoverActiveIndicatorHeight() const
    {
        return 1.0;
    }
    //! Focused thickness of the filled active indicator.
    constexpr qreal filledFocusActiveIndicatorHeight() const
    {
        return 2.0;
    }
    //! Opacity of the filled container when disabled.
    constexpr qreal filledDisabledContainerOpacity() const
    {
        return 0.04;
    }
    //! Shape of the outlined field container.
    constexpr ShapeValue outlinedContainerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }
    //! Size of the optional leading icon in an outlined field.
    constexpr qreal outlinedLeadingIconSize() const
    {
        return 24.0;
    }
    //! Resting thickness of the field outline.
    constexpr qreal outlinedOutlineWidth() const
    {
        return 1.0;
    }
    //! Hovered thickness of the field outline.
    constexpr qreal outlinedHoverOutlineWidth() const
    {
        return 1.0;
    }
    //! Focused thickness of the field outline.
    constexpr qreal outlinedFocusOutlineWidth() const
    {
        return 2.0;
    }
    //! Opacity of the outline when disabled.
    constexpr qreal outlinedDisabledOutlineOpacity() const
    {
        return 0.12;
    }
    //! Surface-backed horizontal padding around a floated outlined-field label.
    constexpr qreal outlinedLabelHorizontalPadding() const
    {
        return 4.0;
    }
    //! Size of the dropdown indicator icon.
    constexpr qreal trailingIconSize() const
    {
        return 24.0;
    }
    //! Space between a leading icon and text content.
    constexpr qreal leadingIconContentSpace() const
    {
        return 16.0;
    }
    //! Space between text content and the dropdown indicator.
    constexpr qreal trailingIconContentSpace() const
    {
        return 12.0;
    }
    //! Opacity of disabled field content.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
    //! Vertical distance between the field and popup.
    constexpr qreal popupAnchorGap() const
    {
        return 4.0;
    }
    //! Shape of the popup surface.
    constexpr ShapeValue popupContainerShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    //! Elevation of the popup surface.
    constexpr qreal popupContainerElevation() const
    {
        return ElevationTokens{ }.level2();
    }
};

} // namespace Fluid
