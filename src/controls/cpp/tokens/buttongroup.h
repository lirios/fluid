// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

#include "shapetokens.h"

// Component values map to the AndroidX Material 3 generated tokens:
// ConnectedButtonGroupSmallTokens.kt. Standard spacing and pressed expansion
// are the expressive button-group layout values shared by every size.

namespace Fluid {

/*! \brief Material Design 3 Expressive button-group tokens. */
struct ButtonGroup
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal standardSpacing READ standardSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal connectedSpacing READ connectedSpacing CONSTANT FINAL)
    Q_PROPERTY(qreal smallReferenceHeight READ smallReferenceHeight CONSTANT FINAL)
    Q_PROPERTY(
            Fluid::ShapeValue connectedContainerShape READ connectedContainerShape CONSTANT FINAL)
    Q_PROPERTY(qreal connectedInnerCorner READ connectedInnerCorner CONSTANT FINAL)
    Q_PROPERTY(qreal pressedInnerCorner READ pressedInnerCorner CONSTANT FINAL)
    Q_PROPERTY(
            qreal selectedInnerCornerPercentage READ selectedInnerCornerPercentage CONSTANT FINAL)
    Q_PROPERTY(
            qreal standardPressedExpansionRatio READ standardPressedExpansionRatio CONSTANT FINAL)

public:
    constexpr qreal standardSpacing() const
    {
        return 12.0;
    }
    constexpr qreal connectedSpacing() const
    {
        return 2.0;
    }
    constexpr qreal smallReferenceHeight() const
    {
        return 40.0;
    }
    constexpr ShapeValue connectedContainerShape() const
    {
        return ShapeTokens{ }.cornerFull();
    }
    constexpr qreal connectedInnerCorner() const
    {
        return ShapeTokens{ }.cornerValueSmall();
    }
    constexpr qreal pressedInnerCorner() const
    {
        return ShapeTokens{ }.cornerValueExtraSmall();
    }
    constexpr qreal selectedInnerCornerPercentage() const
    {
        return 50.0;
    }
    constexpr qreal standardPressedExpansionRatio() const
    {
        return 0.15;
    }
};

} // namespace Fluid
