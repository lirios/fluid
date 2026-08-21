// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 Expressive button tokens. */
struct Button
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightExtraSmall READ containerHeightExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightSmall READ containerHeightSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightMedium READ containerHeightMedium CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightLarge READ containerHeightLarge CONSTANT FINAL)
    Q_PROPERTY(qreal containerHeightExtraLarge READ containerHeightExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal iconSizeExtraSmall READ iconSizeExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal iconSizeSmall READ iconSizeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal iconSizeMedium READ iconSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal iconSizeLarge READ iconSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal iconSizeExtraLarge READ iconSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpaceExtraSmall READ leadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpaceSmall READ leadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpaceMedium READ leadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpaceLarge READ leadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpaceExtraLarge READ leadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpaceExtraSmall READ trailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpaceSmall READ trailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpaceMedium READ trailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpaceLarge READ trailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpaceExtraLarge READ trailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpaceExtraSmall READ iconLabelSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpaceSmall READ iconLabelSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpaceMedium READ iconLabelSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpaceLarge READ iconLabelSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal iconLabelSpaceExtraLarge READ iconLabelSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedOutlineWidthExtraSmall READ outlinedOutlineWidthExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthSmall READ outlinedOutlineWidthSmall CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthMedium READ outlinedOutlineWidthMedium CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthLarge READ outlinedOutlineWidthLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedOutlineWidthExtraLarge READ outlinedOutlineWidthExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal containerShapeRound READ containerShapeRound CONSTANT FINAL)
    Q_PROPERTY(
            qreal containerShapeSquareExtraSmall READ containerShapeSquareExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerShapeSquareSmall READ containerShapeSquareSmall CONSTANT FINAL)
    Q_PROPERTY(qreal containerShapeSquareMedium READ containerShapeSquareMedium CONSTANT FINAL)
    Q_PROPERTY(qreal containerShapeSquareLarge READ containerShapeSquareLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal containerShapeSquareExtraLarge READ containerShapeSquareExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal pressedContainerShapeExtraSmall READ pressedContainerShapeExtraSmall CONSTANT
                       FINAL)
    Q_PROPERTY(qreal pressedContainerShapeSmall READ pressedContainerShapeSmall CONSTANT FINAL)
    Q_PROPERTY(qreal pressedContainerShapeMedium READ pressedContainerShapeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal pressedContainerShapeLarge READ pressedContainerShapeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal pressedContainerShapeExtraLarge READ pressedContainerShapeExtraLarge CONSTANT
                       FINAL)
    Q_PROPERTY(qreal selectedContainerShapeRoundExtraSmall READ
                       selectedContainerShapeRoundExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal selectedContainerShapeRoundSmall READ selectedContainerShapeRoundSmall CONSTANT
                       FINAL)
    Q_PROPERTY(qreal selectedContainerShapeRoundMedium READ selectedContainerShapeRoundMedium
                       CONSTANT FINAL)
    Q_PROPERTY(qreal selectedContainerShapeRoundLarge READ selectedContainerShapeRoundLarge CONSTANT
                       FINAL)
    Q_PROPERTY(qreal selectedContainerShapeRoundExtraLarge READ
                       selectedContainerShapeRoundExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal selectedContainerShapeSquare READ selectedContainerShapeSquare CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContainerOpacity READ disabledContainerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledIconOpacity READ disabledIconOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledLabelTextOpacity READ disabledLabelTextOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal elevatedContainerElevation READ elevatedContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal flatContainerElevation READ flatContainerElevation CONSTANT FINAL)

public:
    constexpr qreal minimumInteractiveSize() const
    {
        return 48.0;
    }
    constexpr qreal containerHeightExtraSmall() const
    {
        return 32.0;
    }
    constexpr qreal containerHeightSmall() const
    {
        return 40.0;
    }
    constexpr qreal containerHeightMedium() const
    {
        return 56.0;
    }
    constexpr qreal containerHeightLarge() const
    {
        return 96.0;
    }
    constexpr qreal containerHeightExtraLarge() const
    {
        return 136.0;
    }
    constexpr qreal iconSizeExtraSmall() const
    {
        return 20.0;
    }
    constexpr qreal iconSizeSmall() const
    {
        return 20.0;
    }
    constexpr qreal iconSizeMedium() const
    {
        return 24.0;
    }
    constexpr qreal iconSizeLarge() const
    {
        return 32.0;
    }
    constexpr qreal iconSizeExtraLarge() const
    {
        return 40.0;
    }
    constexpr qreal leadingSpaceExtraSmall() const
    {
        return 12.0;
    }
    constexpr qreal leadingSpaceSmall() const
    {
        return 16.0;
    }
    constexpr qreal leadingSpaceMedium() const
    {
        return 24.0;
    }
    constexpr qreal leadingSpaceLarge() const
    {
        return 48.0;
    }
    constexpr qreal leadingSpaceExtraLarge() const
    {
        return 64.0;
    }
    constexpr qreal trailingSpaceExtraSmall() const
    {
        return 12.0;
    }
    constexpr qreal trailingSpaceSmall() const
    {
        return 16.0;
    }
    constexpr qreal trailingSpaceMedium() const
    {
        return 24.0;
    }
    constexpr qreal trailingSpaceLarge() const
    {
        return 48.0;
    }
    constexpr qreal trailingSpaceExtraLarge() const
    {
        return 64.0;
    }
    constexpr qreal iconLabelSpaceExtraSmall() const
    {
        return 8.0;
    }
    constexpr qreal iconLabelSpaceSmall() const
    {
        return 8.0;
    }
    constexpr qreal iconLabelSpaceMedium() const
    {
        return 8.0;
    }
    constexpr qreal iconLabelSpaceLarge() const
    {
        return 12.0;
    }
    constexpr qreal iconLabelSpaceExtraLarge() const
    {
        return 16.0;
    }
    constexpr qreal outlinedOutlineWidthExtraSmall() const
    {
        return 1.0;
    }
    constexpr qreal outlinedOutlineWidthSmall() const
    {
        return 1.0;
    }
    constexpr qreal outlinedOutlineWidthMedium() const
    {
        return 1.0;
    }
    constexpr qreal outlinedOutlineWidthLarge() const
    {
        return 2.0;
    }
    constexpr qreal outlinedOutlineWidthExtraLarge() const
    {
        return 3.0;
    }
    constexpr qreal containerShapeRound() const
    {
        return 9999.0;
    }
    constexpr qreal containerShapeSquareExtraSmall() const
    {
        return 12.0;
    }
    constexpr qreal containerShapeSquareSmall() const
    {
        return 12.0;
    }
    constexpr qreal containerShapeSquareMedium() const
    {
        return 16.0;
    }
    constexpr qreal containerShapeSquareLarge() const
    {
        return 28.0;
    }
    constexpr qreal containerShapeSquareExtraLarge() const
    {
        return 28.0;
    }
    constexpr qreal pressedContainerShapeExtraSmall() const
    {
        return 8.0;
    }
    constexpr qreal pressedContainerShapeSmall() const
    {
        return 8.0;
    }
    constexpr qreal pressedContainerShapeMedium() const
    {
        return 12.0;
    }
    constexpr qreal pressedContainerShapeLarge() const
    {
        return 16.0;
    }
    constexpr qreal pressedContainerShapeExtraLarge() const
    {
        return 16.0;
    }
    constexpr qreal selectedContainerShapeRoundExtraSmall() const
    {
        return 12.0;
    }
    constexpr qreal selectedContainerShapeRoundSmall() const
    {
        return 12.0;
    }
    constexpr qreal selectedContainerShapeRoundMedium() const
    {
        return 16.0;
    }
    constexpr qreal selectedContainerShapeRoundLarge() const
    {
        return 28.0;
    }
    constexpr qreal selectedContainerShapeRoundExtraLarge() const
    {
        return 28.0;
    }
    constexpr qreal selectedContainerShapeSquare() const
    {
        return 9999.0;
    }
    constexpr qreal disabledContainerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal disabledIconOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledLabelTextOpacity() const
    {
        return 0.38;
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
    constexpr qreal elevatedContainerElevation() const
    {
        return 1.0;
    }
    constexpr qreal flatContainerElevation() const
    {
        return 0.0;
    }
};

} // namespace Fluid
