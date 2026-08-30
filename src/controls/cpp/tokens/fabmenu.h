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
// FabMenuTokens.kt, FabMenuCloseButtonTokens.kt, and FabMenuItemTokens.kt.

namespace Fluid {

/*!
    \brief Material Design 3 Expressive FAB menu tokens.

    The values follow the Material 3 Expressive FAB menu specification. They are
    exposed through \c Tokens.fabMenu for use by the public QML FabMenu,
    FabMenuButton, and FabMenuItem controls.
*/
struct FabMenu
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal closeButtonContainerWidth READ closeButtonContainerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal closeButtonContainerHeight READ closeButtonContainerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue closeButtonContainerShape READ closeButtonContainerShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal closeButtonIconSize READ closeButtonIconSize CONSTANT FINAL)
    Q_PROPERTY(
            qreal closeButtonContainerElevation READ closeButtonContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal closeButtonFocusContainerElevation READ closeButtonFocusContainerElevation
                       CONSTANT FINAL)
    Q_PROPERTY(qreal closeButtonHoverContainerElevation READ closeButtonHoverContainerElevation
                       CONSTANT FINAL)
    Q_PROPERTY(qreal closeButtonPressedContainerElevation READ closeButtonPressedContainerElevation
                       CONSTANT FINAL)
    Q_PROPERTY(qreal closeButtonBetweenSpace READ closeButtonBetweenSpace CONSTANT FINAL)
    Q_PROPERTY(qreal listItemContainerHeight READ listItemContainerHeight CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue listItemContainerShape READ listItemContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal listItemContainerElevation READ listItemContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal listItemIconSize READ listItemIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal listItemIconLabelSpace READ listItemIconLabelSpace CONSTANT FINAL)
    Q_PROPERTY(qreal listItemLeadingSpace READ listItemLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal listItemTrailingSpace READ listItemTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal listItemBetweenSpace READ listItemBetweenSpace CONSTANT FINAL)
    Q_PROPERTY(qreal listItemStaggerDelay READ listItemStaggerDelay CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal scrimOpacity READ scrimOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal containerMargin READ containerMargin CONSTANT FINAL)

public:
    //! Width of the expanded close button.
    constexpr qreal closeButtonContainerWidth() const
    {
        return 56.0;
    }

    //! Height of the expanded close button.
    constexpr qreal closeButtonContainerHeight() const
    {
        return 56.0;
    }

    //! Fully rounded corner radius of the expanded close button.
    constexpr ShapeValue closeButtonContainerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }

    //! Size of the close button icon.
    constexpr qreal closeButtonIconSize() const
    {
        return 20.0;
    }

    //! Resting elevation of the close button.
    constexpr qreal closeButtonContainerElevation() const
    {
        return ElevationTokens{ }.level3();
    }

    //! Elevation of the focused close button.
    constexpr qreal closeButtonFocusContainerElevation() const
    {
        return ElevationTokens{ }.level3();
    }

    //! Elevation of the hovered close button.
    constexpr qreal closeButtonHoverContainerElevation() const
    {
        return ElevationTokens{ }.level4();
    }

    //! Elevation of the pressed close button.
    constexpr qreal closeButtonPressedContainerElevation() const
    {
        return ElevationTokens{ }.level3();
    }

    //! Space between the close button and the nearest list item.
    constexpr qreal closeButtonBetweenSpace() const
    {
        return 8.0;
    }

    //! Height of a FAB menu list item.
    constexpr qreal listItemContainerHeight() const
    {
        return 56.0;
    }

    //! Fully rounded corner radius of a list item.
    constexpr ShapeValue listItemContainerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }

    //! Resting elevation of a list item.
    constexpr qreal listItemContainerElevation() const
    {
        return ElevationTokens{ }.level0();
    }

    //! Size of the leading list item icon.
    constexpr qreal listItemIconSize() const
    {
        return 24.0;
    }

    //! Space between the list item icon and its label.
    constexpr qreal listItemIconLabelSpace() const
    {
        return 8.0;
    }

    //! Logical leading padding of a list item.
    constexpr qreal listItemLeadingSpace() const
    {
        return 24.0;
    }

    //! Logical trailing padding of a list item.
    constexpr qreal listItemTrailingSpace() const
    {
        return 24.0;
    }

    //! Space between adjacent list items.
    constexpr qreal listItemBetweenSpace() const
    {
        return 4.0;
    }

    //! Per-item delay of the staggered list entrance, in milliseconds.
    constexpr qreal listItemStaggerDelay() const
    {
        return 30.0;
    }

    //! Opacity of the hover state layer.
    constexpr qreal hoverStateLayerOpacity() const
    {
        return StateTokens{ }.hoverStateLayerOpacity();
    }

    //! Opacity of the keyboard-focus state layer.
    constexpr qreal focusStateLayerOpacity() const
    {
        return StateTokens{ }.focusStateLayerOpacity();
    }

    //! Opacity of the pressed state layer.
    constexpr qreal pressedStateLayerOpacity() const
    {
        return StateTokens{ }.pressedStateLayerOpacity();
    }

    //! Opacity of disabled list item content.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }

    //! Opacity of the scrim shown behind an expanded FAB menu.
    constexpr qreal scrimOpacity() const
    {
        return 0.32;
    }

    //! Inset of the FAB menu from the edges of its container.
    constexpr qreal containerMargin() const
    {
        return 16.0;
    }
};

} // namespace Fluid
