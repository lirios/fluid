// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 Expressive floating action button tokens. */
struct Fab
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerHeight READ containerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal containerWidth READ containerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerHeight READ mediumContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerShape READ mediumContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerWidth READ mediumContainerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal mediumIconSize READ mediumIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerHeight READ largeContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerShape READ largeContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerWidth READ largeContainerWidth CONSTANT FINAL)
    Q_PROPERTY(qreal largeIconSize READ largeIconSize CONSTANT FINAL)
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
    constexpr qreal containerShape() const
    {
        return 16.0;
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
    constexpr qreal mediumContainerShape() const
    {
        return 20.0;
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
    constexpr qreal largeContainerShape() const
    {
        return 28.0;
    }
    constexpr qreal largeContainerWidth() const
    {
        return 96.0;
    }
    constexpr qreal largeIconSize() const
    {
        return 36.0;
    }
    constexpr qreal containerElevation() const
    {
        return 6.0;
    }
    constexpr qreal focusContainerElevation() const
    {
        return 6.0;
    }
    constexpr qreal hoverContainerElevation() const
    {
        return 8.0;
    }
    constexpr qreal pressedContainerElevation() const
    {
        return 6.0;
    }
    constexpr qreal loweredContainerElevation() const
    {
        return 1.0;
    }
    constexpr qreal loweredFocusContainerElevation() const
    {
        return 1.0;
    }
    constexpr qreal loweredHoverContainerElevation() const
    {
        return 3.0;
    }
    constexpr qreal loweredPressedContainerElevation() const
    {
        return 1.0;
    }
    constexpr qreal hoverStateLayerOpacity() const
    {
        return 0.08;
    }
    constexpr qreal focusStateLayerOpacity() const
    {
        return 0.10;
    }
    constexpr qreal pressedStateLayerOpacity() const
    {
        return 0.10;
    }
};

} // namespace Fluid
