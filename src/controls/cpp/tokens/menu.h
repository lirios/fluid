// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

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
    Q_PROPERTY(qreal containerRadius READ containerRadius CONSTANT FINAL)
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

public:
    //! Elevation of the temporary menu surface.
    constexpr qreal containerElevation() const
    {
        return 3.0;
    }

    //! Corner radius of the menu surface.
    constexpr qreal containerRadius() const
    {
        return 4.0;
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
        return 0.08;
    }

    //! Opacity of the keyboard-focus state layer.
    constexpr qreal focusStateLayerOpacity() const
    {
        return 0.10;
    }

    //! Opacity of the pressed state layer.
    constexpr qreal pressedStateLayerOpacity() const
    {
        return 0.10;
    }

    //! Opacity of disabled menu-item content.
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
};

} // namespace Fluid
