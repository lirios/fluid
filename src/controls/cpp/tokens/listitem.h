// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 Expressive list item tokens. */
struct ListItem
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal oneLineContainerHeight READ oneLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal twoLineContainerHeight READ twoLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal threeLineContainerHeight READ threeLineContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpace READ leadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpace READ trailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal topSpace READ topSpace CONSTANT FINAL)
    Q_PROPERTY(qreal bottomSpace READ bottomSpace CONSTANT FINAL)
    Q_PROPERTY(qreal betweenSpace READ betweenSpace CONSTANT FINAL)
    Q_PROPERTY(qreal segmentedGap READ segmentedGap CONSTANT FINAL)
    Q_PROPERTY(qreal containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal containerExpressiveShape READ containerExpressiveShape CONSTANT FINAL)
    Q_PROPERTY(qreal hoveredContainerExpressiveShape READ hoveredContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal focusedContainerExpressiveShape READ focusedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal pressedContainerExpressiveShape READ pressedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal selectedContainerExpressiveShape READ selectedContainerExpressiveShape CONSTANT
                       FINAL)
    Q_PROPERTY(qreal leadingIconSize READ leadingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal trailingIconSize READ trailingIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingAvatarSize READ leadingAvatarSize CONSTANT FINAL)
    Q_PROPERTY(qreal leadingImageSize READ leadingImageSize CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledStateLayerOpacity READ disabledStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal draggedStateLayerOpacity READ draggedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal draggedContainerElevation READ draggedContainerElevation CONSTANT FINAL)

public:
    constexpr qreal oneLineContainerHeight() const
    {
        return 56.0;
    }
    constexpr qreal twoLineContainerHeight() const
    {
        return 72.0;
    }
    constexpr qreal threeLineContainerHeight() const
    {
        return 88.0;
    }
    constexpr qreal leadingSpace() const
    {
        return 16.0;
    }
    constexpr qreal trailingSpace() const
    {
        return 16.0;
    }
    constexpr qreal topSpace() const
    {
        return 10.0;
    }
    constexpr qreal bottomSpace() const
    {
        return 10.0;
    }
    constexpr qreal betweenSpace() const
    {
        return 12.0;
    }
    constexpr qreal segmentedGap() const
    {
        return 2.0;
    }
    constexpr qreal containerShape() const
    {
        return 0.0;
    }
    constexpr qreal containerExpressiveShape() const
    {
        return 4.0;
    }
    constexpr qreal hoveredContainerExpressiveShape() const
    {
        return 12.0;
    }
    constexpr qreal focusedContainerExpressiveShape() const
    {
        return 16.0;
    }
    constexpr qreal pressedContainerExpressiveShape() const
    {
        return 16.0;
    }
    constexpr qreal selectedContainerExpressiveShape() const
    {
        return 16.0;
    }
    constexpr qreal leadingIconSize() const
    {
        return 24.0;
    }
    constexpr qreal trailingIconSize() const
    {
        return 24.0;
    }
    constexpr qreal leadingAvatarSize() const
    {
        return 40.0;
    }
    constexpr qreal leadingImageSize() const
    {
        return 56.0;
    }
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledStateLayerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal hoverStateLayerOpacity() const
    {
        return 0.08;
    }
    constexpr qreal focusStateLayerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal pressedStateLayerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal draggedStateLayerOpacity() const
    {
        return 0.16;
    }
    constexpr qreal containerElevation() const
    {
        return 0.0;
    }
    constexpr qreal draggedContainerElevation() const
    {
        return 8.0;
    }
};

} // namespace Fluid
