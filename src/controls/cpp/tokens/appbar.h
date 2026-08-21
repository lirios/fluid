// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

struct AppBar
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal avatarSize READ avatarSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconButtonSpace READ iconButtonSpace CONSTANT FINAL)
    Q_PROPERTY(qreal leadingSpace READ leadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal trailingSpace READ trailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal mediumContainerHeight READ mediumContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal largeContainerHeight READ largeContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal onScrollContainerElevation READ onScrollContainerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal smallContainerHeight READ smallContainerHeight CONSTANT FINAL)
    Q_PROPERTY(
            qreal mediumFlexibleContainerHeight READ mediumFlexibleContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal mediumFlexibleContainerHeightWithSubtitle READ
                       mediumFlexibleContainerHeightWithSubtitle CONSTANT FINAL)
    Q_PROPERTY(qreal largeFlexibleContainerHeight READ largeFlexibleContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal largeFlexibleContainerHeightWithSubtitle READ
                       largeFlexibleContainerHeightWithSubtitle CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainerHeight READ searchContainerHeight CONSTANT FINAL)
    Q_PROPERTY(qreal horizontalPadding READ horizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal titleInset READ titleInset CONSTANT FINAL)
    Q_PROPERTY(qreal mediumTitleBottomPadding READ mediumTitleBottomPadding CONSTANT FINAL)
    Q_PROPERTY(qreal largeTitleBottomPadding READ largeTitleBottomPadding CONSTANT FINAL)
    Q_PROPERTY(qreal mediumTitleSubtitleGap READ mediumTitleSubtitleGap CONSTANT FINAL)
    Q_PROPERTY(qreal largeTitleSubtitleGap READ largeTitleSubtitleGap CONSTANT FINAL)
    Q_PROPERTY(qreal minimumInteractiveSize READ minimumInteractiveSize CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal searchOuterHorizontalPadding READ searchOuterHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal searchOuterFieldMargin READ searchOuterFieldMargin CONSTANT FINAL)
    Q_PROPERTY(qreal searchAdaptiveBreakpoint READ searchAdaptiveBreakpoint CONSTANT FINAL)
    Q_PROPERTY(qreal searchAdaptiveWidthFraction READ searchAdaptiveWidthFraction CONSTANT FINAL)
    Q_PROPERTY(qreal searchLeadingSpace READ searchLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal searchTrailingSpace READ searchTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainedLeadingMargin READ searchContainedLeadingMargin CONSTANT FINAL)
    Q_PROPERTY(
            qreal searchContainedTrailingMargin READ searchContainedTrailingMargin CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainedLeadingSpace READ searchContainedLeadingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainedTrailingSpace READ searchContainedTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainedNoActionsLeadingSpace READ searchContainedNoActionsLeadingSpace
                       CONSTANT FINAL)
    Q_PROPERTY(qreal searchContainedNoActionsTrailingSpace READ
                       searchContainedNoActionsTrailingSpace CONSTANT FINAL)
    Q_PROPERTY(qreal searchIconLabelGap READ searchIconLabelGap CONSTANT FINAL)
    Q_PROPERTY(qreal searchAvatarTargetSize READ searchAvatarTargetSize CONSTANT FINAL)
    Q_PROPERTY(qreal searchAvatarSize READ searchAvatarSize CONSTANT FINAL)
    Q_PROPERTY(qreal searchTrailingActionsGap READ searchTrailingActionsGap CONSTANT FINAL)
    Q_PROPERTY(qreal searchTrailingActionsLeadingSpace READ searchTrailingActionsLeadingSpace
                       CONSTANT FINAL)
    Q_PROPERTY(qreal searchTrailingActionsTrailingSpace READ searchTrailingActionsTrailingSpace
                       CONSTANT FINAL)
    Q_PROPERTY(qreal overflowItemHeight READ overflowItemHeight CONSTANT FINAL)
    Q_PROPERTY(qreal overflowHorizontalPadding READ overflowHorizontalPadding CONSTANT FINAL)
    Q_PROPERTY(qreal overflowIconLabelGap READ overflowIconLabelGap CONSTANT FINAL)
    Q_PROPERTY(qreal overflowMinimumWidth READ overflowMinimumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal overflowMaximumWidth READ overflowMaximumWidth CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledContentOpacity READ disabledContentOpacity CONSTANT FINAL)

public:
    constexpr qreal avatarSize() const
    {
        return 32.0;
    }
    constexpr qreal iconButtonSpace() const
    {
        return 0.0;
    }
    constexpr qreal leadingSpace() const
    {
        return 4.0;
    }
    constexpr qreal trailingSpace() const
    {
        return 4.0;
    }
    constexpr qreal containerShape() const
    {
        return 0.0;
    }
    constexpr qreal mediumContainerHeight() const
    {
        return 112.0;
    }
    constexpr qreal largeContainerHeight() const
    {
        return 152.0;
    }
    constexpr qreal containerElevation() const
    {
        return 0.0;
    }
    constexpr qreal onScrollContainerElevation() const
    {
        return 3.0;
    }
    constexpr qreal smallContainerHeight() const
    {
        return 64.0;
    }
    constexpr qreal mediumFlexibleContainerHeight() const
    {
        return 112.0;
    }
    constexpr qreal mediumFlexibleContainerHeightWithSubtitle() const
    {
        return 136.0;
    }
    constexpr qreal largeFlexibleContainerHeight() const
    {
        return 120.0;
    }
    constexpr qreal largeFlexibleContainerHeightWithSubtitle() const
    {
        return 152.0;
    }
    constexpr qreal searchContainerHeight() const
    {
        return 56.0;
    }
    constexpr qreal horizontalPadding() const
    {
        return 4.0;
    }
    constexpr qreal titleInset() const
    {
        return 16.0;
    }
    constexpr qreal mediumTitleBottomPadding() const
    {
        return 24.0;
    }
    constexpr qreal largeTitleBottomPadding() const
    {
        return 28.0;
    }
    constexpr qreal mediumTitleSubtitleGap() const
    {
        return 4.0;
    }
    constexpr qreal largeTitleSubtitleGap() const
    {
        return 8.0;
    }
    constexpr qreal minimumInteractiveSize() const
    {
        return 48.0;
    }
    constexpr qreal iconSize() const
    {
        return 24.0;
    }
    constexpr qreal searchOuterHorizontalPadding() const
    {
        return 4.0;
    }
    constexpr qreal searchOuterFieldMargin() const
    {
        return 8.0;
    }
    constexpr qreal searchAdaptiveBreakpoint() const
    {
        return 312.0;
    }
    constexpr qreal searchAdaptiveWidthFraction() const
    {
        return 0.5;
    }
    constexpr qreal searchLeadingSpace() const
    {
        return 8.0;
    }
    constexpr qreal searchTrailingSpace() const
    {
        return 8.0;
    }
    constexpr qreal searchContainedLeadingMargin() const
    {
        return 24.0;
    }
    constexpr qreal searchContainedTrailingMargin() const
    {
        return 24.0;
    }
    constexpr qreal searchContainedLeadingSpace() const
    {
        return 4.0;
    }
    constexpr qreal searchContainedTrailingSpace() const
    {
        return 4.0;
    }
    constexpr qreal searchContainedNoActionsLeadingSpace() const
    {
        return 16.0;
    }
    constexpr qreal searchContainedNoActionsTrailingSpace() const
    {
        return 16.0;
    }
    constexpr qreal searchIconLabelGap() const
    {
        return 4.0;
    }
    constexpr qreal searchAvatarTargetSize() const
    {
        return 48.0;
    }
    constexpr qreal searchAvatarSize() const
    {
        return 30.0;
    }
    constexpr qreal searchTrailingActionsGap() const
    {
        return 0.0;
    }
    constexpr qreal searchTrailingActionsLeadingSpace() const
    {
        return 4.0;
    }
    constexpr qreal searchTrailingActionsTrailingSpace() const
    {
        return 4.0;
    }
    constexpr qreal overflowItemHeight() const
    {
        return 48.0;
    }
    constexpr qreal overflowHorizontalPadding() const
    {
        return 12.0;
    }
    constexpr qreal overflowIconLabelGap() const
    {
        return 12.0;
    }
    constexpr qreal overflowMinimumWidth() const
    {
        return 112.0;
    }
    constexpr qreal overflowMaximumWidth() const
    {
        return 280.0;
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
    constexpr qreal disabledContentOpacity() const
    {
        return 0.38;
    }
};

} // namespace Fluid
