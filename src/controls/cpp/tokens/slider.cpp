// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "slider.h"

namespace Fluid {

qreal Slider::activeTrackHeightExtraSmall() const
{
    return 16.0;
}

qreal Slider::activeTrackHeightSmall() const
{
    return 24.0;
}

qreal Slider::activeTrackHeightMedium() const
{
    return 40.0;
}

qreal Slider::activeTrackHeightLarge() const
{
    return 56.0;
}

qreal Slider::activeTrackHeightExtraLarge() const
{
    return 96.0;
}

qreal Slider::activeTrackLeadingCornerRadiusExtraSmall() const
{
    return 8.0;
}

qreal Slider::activeTrackLeadingCornerRadiusSmall() const
{
    return 8.0;
}

qreal Slider::activeTrackLeadingCornerRadiusMedium() const
{
    return 12.0;
}

qreal Slider::activeTrackLeadingCornerRadiusLarge() const
{
    return 16.0;
}

qreal Slider::activeTrackLeadingCornerRadiusExtraLarge() const
{
    return 28.0;
}

qreal Slider::activeHandleHeightExtraSmall() const
{
    return 44.0;
}

qreal Slider::activeHandleHeightSmall() const
{
    return 44.0;
}

qreal Slider::activeHandleHeightMedium() const
{
    return 44.0;
}

qreal Slider::activeHandleHeightLarge() const
{
    return 68.0;
}

qreal Slider::activeHandleHeightExtraLarge() const
{
    return 108.0;
}

qreal Slider::activeHandlePadding() const
{
    return 6.0;
}

qreal Slider::activeHandleTrailingSpace() const
{
    return 6.0;
}

qreal Slider::activeStopIndicatorContainerOpacity() const
{
    return 1.0;
}

qreal Slider::inactiveStopIndicatorContainerOpacity() const
{
    return 1.0;
}

qreal Slider::disabledHandleWidth() const
{
    return 4.0;
}

qreal Slider::hoverHandleWidth() const
{
    return 4.0;
}

qreal Slider::stopIndicatorTrailingSpace() const
{
    return 4.0;
}

qreal Slider::handleWidth() const
{
    return 4.0;
}

qreal Slider::pressedHandleWidth() const
{
    return 2.0;
}

qreal Slider::focusHandleWidth() const
{
    return 2.0;
}

qreal Slider::handleHeight() const
{
    return 44.0;
}

qreal Slider::activeHandleLeadingSpace() const
{
    return 6.0;
}

qreal Slider::handleTrackGap() const
{
    return activeHandleLeadingSpace();
}

qreal Slider::stopIndicatorSize() const
{
    return 4.0;
}

qreal Slider::tickSize() const
{
    return 4.0;
}

qreal Slider::tickMinSpacing() const
{
    return 8.0;
}

qreal Slider::trackInsideCornerRadius() const
{
    return 2.0;
}

qreal Slider::trackIconSizeMedium() const
{
    return 24.0;
}

qreal Slider::trackIconSizeLarge() const
{
    return 24.0;
}

qreal Slider::trackIconSizeExtraLarge() const
{
    return 32.0;
}

qreal Slider::trackIconPaddingMedium() const
{
    return 6.0;
}

qreal Slider::trackIconPaddingLarge() const
{
    return 6.0;
}

qreal Slider::trackIconPaddingExtraLarge() const
{
    return 8.0;
}

qreal Slider::trackIconPadding() const
{
    return trackIconPaddingMedium();
}

qreal Slider::minimumInteractiveSize() const
{
    return 48.0;
}

qreal Slider::defaultLength() const
{
    return 200.0;
}

qreal Slider::visibleOpacity() const
{
    return 1.0;
}

qreal Slider::hiddenOpacity() const
{
    return 0.0;
}

qreal Slider::hoverStateLayerOpacity() const
{
    return 0.08;
}

qreal Slider::focusStateLayerOpacity() const
{
    return 0.10;
}

qreal Slider::pressedStateLayerOpacity() const
{
    return 0.10;
}

qreal Slider::disabledActiveTrackOpacity() const
{
    return 0.38;
}

qreal Slider::disabledInactiveTrackOpacity() const
{
    return 0.12;
}

qreal Slider::disabledHandleOpacity() const
{
    return 0.38;
}

qreal Slider::valueIndicatorMinWidth() const
{
    return 32.0;
}

qreal Slider::valueIndicatorMinHeight() const
{
    return 32.0;
}

qreal Slider::valueIndicatorHorizontalPadding() const
{
    return 16.0;
}

qreal Slider::valueIndicatorVerticalPadding() const
{
    return 12.0;
}

qreal Slider::valueIndicatorActiveBottomSpace() const
{
    return 12.0;
}

} // namespace Fluid
