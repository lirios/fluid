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
// MenuTokens.kt and MenuItemTokens.kt.

namespace Fluid {

/*!
    \brief Material Design 3 tokens for menus and menu items.

    The values follow the Material 3 Expressive menu specification. They are
    exposed through \c Tokens.menu for use by the public QML Menu control.
*/
struct Menu
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal topPadding READ topPadding CONSTANT FINAL)
    Q_PROPERTY(qreal bottomPadding READ bottomPadding CONSTANT FINAL)
    Q_PROPERTY(qreal viewportMargin READ viewportMargin CONSTANT FINAL)
    Q_PROPERTY(qreal minimumWidth READ minimumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal maximumWidth READ maximumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal itemHeight READ itemHeight CONSTANT FINAL)
    Q_PROPERTY(qreal itemHorizontalPadding READ itemHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelGap READ iconLabelGap CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalContainerShape READ verticalContainerShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalGroupShape READ verticalGroupShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalItemShape READ verticalItemShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalOnlyItemShape READ verticalOnlyItemShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalFirstItemShape READ verticalFirstItemShape CONSTANT FINAL)
    Q_PROPERTY(
            Fluid::ShapeValue verticalMiddleItemShape READ verticalMiddleItemShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalLastItemShape READ verticalLastItemShape CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalSelectedItemShape READ verticalSelectedItemShape CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue verticalInactiveItemShape READ verticalInactiveItemShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal verticalItemHeight READ verticalItemHeight CONSTANT FINAL)
    Q_PROPERTY(qreal verticalGroupPadding READ verticalGroupPadding CONSTANT FINAL)
    Q_PROPERTY(qreal verticalSegmentedGap READ verticalSegmentedGap CONSTANT FINAL)
    Q_PROPERTY(qreal verticalItemTopPadding READ verticalItemTopPadding CONSTANT FINAL)
    Q_PROPERTY(qreal verticalItemBottomPadding READ verticalItemBottomPadding CONSTANT FINAL)
    Q_PROPERTY(qreal verticalItemLeadingSpace READ verticalItemLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal verticalItemTrailingSpace READ verticalItemTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal verticalItemBetweenSpace READ verticalItemBetweenSpace CONSTANT FINAL)
    Q_PROPERTY(qreal verticalIconSize READ verticalIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal closedScale READ closedScale CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalViewportMargin READ horizontalViewportMargin CONSTANT FINAL)
    Q_PROPERTY(qreal verticalViewportMargin READ verticalViewportMargin CONSTANT FINAL)

public:
    //! Elevation of the temporary menu surface.
    constexpr qreal containerElevation() const
    {
        return ElevationTokens{ }.level2();
    }

    //! Corner radius of the menu surface.
    constexpr ShapeValue containerShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }

    //! Space above the first menu item.
    constexpr qreal topPadding() const
    {
        return 8.0;
    }

    //! Space below the last menu item.
    constexpr qreal bottomPadding() const
    {
        return 8.0;
    }

    //! Minimum distance maintained between a menu and a viewport edge.
    constexpr qreal viewportMargin() const
    {
        return 8.0;
    }

    //! Preferred minimum menu width.
    constexpr qreal minimumWidth() const
    {
        return 112.0;
    }

    //! Preferred maximum menu width.
    constexpr qreal maximumWidth() const
    {
        return 280.0;
    }

    //! Height of a one-line menu item.
    constexpr qreal itemHeight() const
    {
        return 48.0;
    }

    //! Logical leading and trailing padding of a menu item.
    constexpr qreal itemHorizontalPadding() const
    {
        return 16.0;
    }

    //! Size of leading, selection, and cascading-menu icons.
    constexpr qreal iconSize() const
    {
        return 24.0;
    }

    //! Space between adjacent menu-item content elements.
    constexpr qreal iconLabelGap() const
    {
        return 12.0;
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

    //! Opacity of disabled menu-item content.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }

    //! Shape of an Expressive vertical menu surface.
    constexpr ShapeValue verticalContainerShape() const
    {
        return ShapeTokens{ }.cornerLarge();
    }

    //! Shape of a group within an Expressive vertical menu.
    constexpr ShapeValue verticalGroupShape() const
    {
        return ShapeTokens{ }.cornerSmall();
    }

    //! Base shape of an Expressive vertical menu item.
    constexpr ShapeValue verticalItemShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }

    //! Shape of an item that is the only member of a group.
    constexpr ShapeValue verticalOnlyItemShape() const
    {
        return ShapeTokens{ }.cornerMedium();
    }

    //! Shape of the first item in a group.
    constexpr ShapeValue verticalFirstItemShape() const
    {
        return { ShapeTokens{ }.cornerValueMedium(), ShapeTokens{ }.cornerValueMedium(),
                 ShapeTokens{ }.cornerValueExtraSmall(), ShapeTokens{ }.cornerValueExtraSmall() };
    }

    //! Shape of a middle item in a group.
    constexpr ShapeValue verticalMiddleItemShape() const
    {
        return ShapeTokens{ }.cornerExtraSmall();
    }

    //! Shape of the last item in a group.
    constexpr ShapeValue verticalLastItemShape() const
    {
        return { ShapeTokens{ }.cornerValueExtraSmall(), ShapeTokens{ }.cornerValueExtraSmall(),
                 ShapeTokens{ }.cornerValueMedium(), ShapeTokens{ }.cornerValueMedium() };
    }

    //! Shape of a selected Expressive menu item.
    constexpr ShapeValue verticalSelectedItemShape() const
    {
        return ShapeTokens{ }.cornerMedium();
    }

    //! Shape used for an inactive Expressive menu item group.
    constexpr ShapeValue verticalInactiveItemShape() const
    {
        return ShapeTokens{ }.cornerSmall();
    }

    //! Height of an Expressive vertical menu item.
    constexpr qreal verticalItemHeight() const
    {
        return 44.0;
    }

    //! Padding between an Expressive menu surface and its item groups.
    constexpr qreal verticalGroupPadding() const
    {
        return 4.0;
    }

    //! Gap between adjacent segments in an Expressive item group.
    constexpr qreal verticalSegmentedGap() const
    {
        return 2.0;
    }

    //! Top content padding of an Expressive menu item.
    constexpr qreal verticalItemTopPadding() const
    {
        return 8.0;
    }

    //! Bottom content padding of an Expressive menu item.
    constexpr qreal verticalItemBottomPadding() const
    {
        return 8.0;
    }

    //! Logical leading content space of an Expressive menu item.
    constexpr qreal verticalItemLeadingSpace() const
    {
        return 16.0;
    }

    //! Logical trailing content space of an Expressive menu item.
    constexpr qreal verticalItemTrailingSpace() const
    {
        return 16.0;
    }

    //! Space between content elements in an Expressive menu item.
    constexpr qreal verticalItemBetweenSpace() const
    {
        return 12.0;
    }

    //! Size of icons in an Expressive menu item.
    constexpr qreal verticalIconSize() const
    {
        return 20.0;
    }

    //! Scale at which an Expressive menu starts and ends its motion.
    constexpr qreal closedScale() const
    {
        return 0.8;
    }

    //! Minimum horizontal distance from a menu to the viewport edge.
    constexpr qreal horizontalViewportMargin() const
    {
        return 8.0;
    }

    //! Minimum vertical distance from a menu to the viewport edge.
    constexpr qreal verticalViewportMargin() const
    {
        return 48.0;
    }
};

} // namespace Fluid
