// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "measurementtokens.h"
#include "shapetokens.h"
#include "statetokens.h"

// Component values map to the AndroidX Material 3 generated tokens:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
// IconButton*Tokens.kt and IconButtonXsmallTokens.kt through IconButtonXlargeTokens.kt.

namespace Fluid {

/*! \brief Material Design 3 Expressive icon button tokens. */
struct IconButton
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
    Q_PROPERTY(
            qreal defaultLeadingSpaceExtraSmall READ defaultLeadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal defaultLeadingSpaceSmall READ defaultLeadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal defaultLeadingSpaceMedium READ defaultLeadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal defaultLeadingSpaceLarge READ defaultLeadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal defaultLeadingSpaceExtraLarge READ defaultLeadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal narrowLeadingSpaceExtraSmall READ narrowLeadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal narrowLeadingSpaceSmall READ narrowLeadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal narrowLeadingSpaceMedium READ narrowLeadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal narrowLeadingSpaceLarge READ narrowLeadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal narrowLeadingSpaceExtraLarge READ narrowLeadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal wideLeadingSpaceExtraSmall READ wideLeadingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal wideLeadingSpaceSmall READ wideLeadingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal wideLeadingSpaceMedium READ wideLeadingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal wideLeadingSpaceLarge READ wideLeadingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal wideLeadingSpaceExtraLarge READ wideLeadingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal defaultTrailingSpaceExtraSmall READ defaultTrailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal defaultTrailingSpaceSmall READ defaultTrailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal defaultTrailingSpaceMedium READ defaultTrailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal defaultTrailingSpaceLarge READ defaultTrailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal defaultTrailingSpaceExtraLarge READ defaultTrailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal narrowTrailingSpaceExtraSmall READ narrowTrailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal narrowTrailingSpaceSmall READ narrowTrailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal narrowTrailingSpaceMedium READ narrowTrailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal narrowTrailingSpaceLarge READ narrowTrailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal narrowTrailingSpaceExtraLarge READ narrowTrailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal wideTrailingSpaceExtraSmall READ wideTrailingSpaceExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal wideTrailingSpaceSmall READ wideTrailingSpaceSmall CONSTANT FINAL)
    Q_PROPERTY(qreal wideTrailingSpaceMedium READ wideTrailingSpaceMedium CONSTANT FINAL)
    Q_PROPERTY(qreal wideTrailingSpaceLarge READ wideTrailingSpaceLarge CONSTANT FINAL)
    Q_PROPERTY(qreal wideTrailingSpaceExtraLarge READ wideTrailingSpaceExtraLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedOutlineWidthExtraSmall READ outlinedOutlineWidthExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthSmall READ outlinedOutlineWidthSmall CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthMedium READ outlinedOutlineWidthMedium CONSTANT FINAL)
    Q_PROPERTY(qreal outlinedOutlineWidthLarge READ outlinedOutlineWidthLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal outlinedOutlineWidthExtraLarge READ outlinedOutlineWidthExtraLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShapeRound READ containerShapeRound CONSTANT FINAL)
    Q_PROPERTY(
            Fluid::ShapeValue containerShapeSquareExtraSmall READ containerShapeSquareExtraSmall CONSTANT
                    FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShapeSquareSmall READ containerShapeSquareSmall CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShapeSquareMedium READ containerShapeSquareMedium CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue containerShapeSquareLarge READ containerShapeSquareLarge CONSTANT FINAL)
    Q_PROPERTY(
            Fluid::ShapeValue containerShapeSquareExtraLarge READ containerShapeSquareExtraLarge CONSTANT
                    FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerShapeExtraSmall READ pressedContainerShapeExtraSmall CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerShapeSmall READ pressedContainerShapeSmall CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerShapeMedium READ pressedContainerShapeMedium CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerShapeLarge READ pressedContainerShapeLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue pressedContainerShapeExtraLarge READ pressedContainerShapeExtraLarge CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeRoundExtraSmall READ
                       selectedContainerShapeRoundExtraSmall CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeRoundSmall READ selectedContainerShapeRoundSmall CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeRoundMedium READ selectedContainerShapeRoundMedium
                       CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeRoundLarge READ selectedContainerShapeRoundLarge CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeRoundExtraLarge READ
                       selectedContainerShapeRoundExtraLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue selectedContainerShapeSquare READ selectedContainerShapeSquare CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContainerOpacity READ disabledContainerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledIconOpacity READ disabledIconOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal minimumInteractiveSize() const
    {
        return MeasurementTokens{ }.minimumInteractiveSize();
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
        return 24.0;
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
    constexpr qreal defaultLeadingSpaceExtraSmall() const
    {
        return 6.0;
    }
    constexpr qreal defaultLeadingSpaceSmall() const
    {
        return 8.0;
    }
    constexpr qreal defaultLeadingSpaceMedium() const
    {
        return 16.0;
    }
    constexpr qreal defaultLeadingSpaceLarge() const
    {
        return 32.0;
    }
    constexpr qreal defaultLeadingSpaceExtraLarge() const
    {
        return 48.0;
    }
    constexpr qreal narrowLeadingSpaceExtraSmall() const
    {
        return 4.0;
    }
    constexpr qreal narrowLeadingSpaceSmall() const
    {
        return 4.0;
    }
    constexpr qreal narrowLeadingSpaceMedium() const
    {
        return 12.0;
    }
    constexpr qreal narrowLeadingSpaceLarge() const
    {
        return 16.0;
    }
    constexpr qreal narrowLeadingSpaceExtraLarge() const
    {
        return 32.0;
    }
    constexpr qreal wideLeadingSpaceExtraSmall() const
    {
        return 10.0;
    }
    constexpr qreal wideLeadingSpaceSmall() const
    {
        return 14.0;
    }
    constexpr qreal wideLeadingSpaceMedium() const
    {
        return 24.0;
    }
    constexpr qreal wideLeadingSpaceLarge() const
    {
        return 48.0;
    }
    constexpr qreal wideLeadingSpaceExtraLarge() const
    {
        return 72.0;
    }
    constexpr qreal defaultTrailingSpaceExtraSmall() const
    {
        return defaultLeadingSpaceExtraSmall();
    }
    constexpr qreal defaultTrailingSpaceSmall() const
    {
        return defaultLeadingSpaceSmall();
    }
    constexpr qreal defaultTrailingSpaceMedium() const
    {
        return defaultLeadingSpaceMedium();
    }
    constexpr qreal defaultTrailingSpaceLarge() const
    {
        return defaultLeadingSpaceLarge();
    }
    constexpr qreal defaultTrailingSpaceExtraLarge() const
    {
        return defaultLeadingSpaceExtraLarge();
    }
    constexpr qreal narrowTrailingSpaceExtraSmall() const
    {
        return narrowLeadingSpaceExtraSmall();
    }
    constexpr qreal narrowTrailingSpaceSmall() const
    {
        return narrowLeadingSpaceSmall();
    }
    constexpr qreal narrowTrailingSpaceMedium() const
    {
        return narrowLeadingSpaceMedium();
    }
    constexpr qreal narrowTrailingSpaceLarge() const
    {
        return narrowLeadingSpaceLarge();
    }
    constexpr qreal narrowTrailingSpaceExtraLarge() const
    {
        return narrowLeadingSpaceExtraLarge();
    }
    constexpr qreal wideTrailingSpaceExtraSmall() const
    {
        return wideLeadingSpaceExtraSmall();
    }
    constexpr qreal wideTrailingSpaceSmall() const
    {
        return wideLeadingSpaceSmall();
    }
    constexpr qreal wideTrailingSpaceMedium() const
    {
        return wideLeadingSpaceMedium();
    }
    constexpr qreal wideTrailingSpaceLarge() const
    {
        return wideLeadingSpaceLarge();
    }
    constexpr qreal wideTrailingSpaceExtraLarge() const
    {
        return wideLeadingSpaceExtraLarge();
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
    constexpr ShapeValue containerShapeRound() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr ShapeValue containerShapeSquareExtraSmall() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue containerShapeSquareSmall() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue containerShapeSquareMedium() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue containerShapeSquareLarge() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr ShapeValue containerShapeSquareExtraLarge() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr ShapeValue pressedContainerShapeExtraSmall() const
    {
        return ShapeTokens{ }.cornerSmall();
    }
    constexpr ShapeValue pressedContainerShapeSmall() const
    {
        return ShapeTokens{ }.cornerSmall();
    }
    constexpr ShapeValue pressedContainerShapeMedium() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue pressedContainerShapeLarge() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue pressedContainerShapeExtraLarge() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue selectedContainerShapeRoundExtraSmall() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue selectedContainerShapeRoundSmall() const
    {
        return ShapeTokens{ }.cornerMedium();
    }
    constexpr ShapeValue selectedContainerShapeRoundMedium() const
    {
        return ShapeTokens{ }.cornerLarge();
    }
    constexpr ShapeValue selectedContainerShapeRoundLarge() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr ShapeValue selectedContainerShapeRoundExtraLarge() const
    {
        return ShapeTokens{ }.cornerExtraLarge();
    }
    constexpr ShapeValue selectedContainerShapeSquare() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr qreal disabledContainerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal disabledIconOpacity() const
    {
        return 0.38;
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
};

} // namespace Fluid
