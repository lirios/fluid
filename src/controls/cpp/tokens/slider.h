// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QQmlEngine>

namespace Fluid {

/*!
    \brief Material Design 3 Expressive slider tokens.
*/
struct Slider
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal activeTrackHeightExtraSmall READ activeTrackHeightExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackHeightSmall READ activeTrackHeightSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackHeightMedium READ activeTrackHeightMedium CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackHeightLarge READ activeTrackHeightLarge CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackHeightExtraLarge READ activeTrackHeightExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackLeadingCornerRadiusExtraSmall READ
                       activeTrackLeadingCornerRadiusExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackLeadingCornerRadiusSmall READ
                       activeTrackLeadingCornerRadiusSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackLeadingCornerRadiusMedium READ
                       activeTrackLeadingCornerRadiusMedium CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackLeadingCornerRadiusLarge READ
                       activeTrackLeadingCornerRadiusLarge CONSTANT FINAL)
    Q_PROPERTY(qreal activeTrackLeadingCornerRadiusExtraLarge READ
                       activeTrackLeadingCornerRadiusExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleHeightExtraSmall READ activeHandleHeightExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleHeightSmall READ activeHandleHeightSmall CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleHeightMedium READ activeHandleHeightMedium CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleHeightLarge READ activeHandleHeightLarge CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleHeightExtraLarge READ activeHandleHeightExtraLarge CONSTANT FINAL)

    Q_PROPERTY(qreal handleWidth READ handleWidth CONSTANT FINAL)
    Q_PROPERTY(qreal pressedHandleWidth READ pressedHandleWidth CONSTANT FINAL)
    Q_PROPERTY(qreal focusHandleWidth READ focusHandleWidth CONSTANT FINAL)
    Q_PROPERTY(qreal handleHeight READ handleHeight CONSTANT FINAL)
    Q_PROPERTY(qreal activeHandleLeadingSpace READ activeHandleLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal handleTrackGap READ handleTrackGap CONSTANT FINAL)

    Q_PROPERTY(qreal stopIndicatorSize READ stopIndicatorSize CONSTANT FINAL)
    Q_PROPERTY(qreal tickSize READ tickSize CONSTANT FINAL)
    Q_PROPERTY(qreal tickMinSpacing READ tickMinSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal trackInsideCornerRadius READ trackInsideCornerRadius CONSTANT FINAL)

    Q_PROPERTY(qreal trackIconSizeMedium READ trackIconSizeMedium CONSTANT FINAL)
    Q_PROPERTY(qreal trackIconSizeLarge READ trackIconSizeLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trackIconSizeExtraLarge READ trackIconSizeExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal trackIconPadding READ trackIconPadding CONSTANT FINAL)

    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal defaultLength READ defaultLength CONSTANT FINAL)
    Q_PROPERTY(qreal visibleOpacity READ visibleOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hiddenOpacity READ hiddenOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledActiveTrackOpacity READ disabledActiveTrackOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledInactiveTrackOpacity READ disabledInactiveTrackOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledHandleOpacity READ disabledHandleOpacity CONSTANT FINAL)

    Q_PROPERTY(qreal valueIndicatorMinWidth READ valueIndicatorMinWidth CONSTANT FINAL)
    Q_PROPERTY(qreal valueIndicatorMinHeight READ valueIndicatorMinHeight CONSTANT FINAL)
    Q_PROPERTY(qreal valueIndicatorHorizontalPadding READ valueIndicatorHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal valueIndicatorVerticalPadding READ valueIndicatorVerticalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal valueIndicatorActiveBottomSpace READ valueIndicatorActiveBottomSpace CONSTANT FINAL)

public:
    qreal activeTrackHeightExtraSmall() const;
    qreal activeTrackHeightSmall() const;
    qreal activeTrackHeightMedium() const;
    qreal activeTrackHeightLarge() const;
    qreal activeTrackHeightExtraLarge() const;
    qreal activeTrackLeadingCornerRadiusExtraSmall() const;
    qreal activeTrackLeadingCornerRadiusSmall() const;
    qreal activeTrackLeadingCornerRadiusMedium() const;
    qreal activeTrackLeadingCornerRadiusLarge() const;
    qreal activeTrackLeadingCornerRadiusExtraLarge() const;
    qreal activeHandleHeightExtraSmall() const;
    qreal activeHandleHeightSmall() const;
    qreal activeHandleHeightMedium() const;
    qreal activeHandleHeightLarge() const;
    qreal activeHandleHeightExtraLarge() const;

    qreal handleWidth() const;
    qreal pressedHandleWidth() const;
    qreal focusHandleWidth() const;
    qreal handleHeight() const;
    qreal activeHandleLeadingSpace() const;
    qreal handleTrackGap() const;

    qreal stopIndicatorSize() const;
    qreal tickSize() const;
    qreal tickMinSpacing() const;
    qreal trackInsideCornerRadius() const;

    qreal trackIconSizeMedium() const;
    qreal trackIconSizeLarge() const;
    qreal trackIconSizeExtraLarge() const;
    qreal trackIconPadding() const;

    qreal minimumInteractiveSize() const;
    qreal defaultLength() const;
    qreal visibleOpacity() const;
    qreal hiddenOpacity() const;
    qreal hoverStateLayerOpacity() const;
    qreal focusStateLayerOpacity() const;
    qreal pressedStateLayerOpacity() const;
    qreal disabledActiveTrackOpacity() const;
    qreal disabledInactiveTrackOpacity() const;
    qreal disabledHandleOpacity() const;

    qreal valueIndicatorMinWidth() const;
    qreal valueIndicatorMinHeight() const;
    qreal valueIndicatorHorizontalPadding() const;
    qreal valueIndicatorVerticalPadding() const;
    qreal valueIndicatorActiveBottomSpace() const;
};

} // namespace Fluid
