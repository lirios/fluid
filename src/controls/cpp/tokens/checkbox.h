// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 checkbox tokens. */
struct CheckBox
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerSize READ containerSize CONSTANT FINAL)
    Q_PROPERTY(qreal containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal iconSize READ iconSize CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerSize READ stateLayerSize CONSTANT FINAL)
    Q_PROPERTY(qreal selectedOutlineWidth READ selectedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedOutlineWidth READ unselectedOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal selectedDisabledContainerOpacity READ selectedDisabledContainerOpacity CONSTANT
                       FINAL)
    Q_PROPERTY(qreal unselectedDisabledContainerOpacity READ unselectedDisabledContainerOpacity
                       CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal containerSize() const
    {
        return 18.0;
    }
    constexpr qreal containerShape() const
    {
        return 2.0;
    }
    constexpr qreal iconSize() const
    {
        return 18.0;
    }
    constexpr qreal stateLayerSize() const
    {
        return 40.0;
    }
    constexpr qreal selectedOutlineWidth() const
    {
        return 0.0;
    }
    constexpr qreal unselectedOutlineWidth() const
    {
        return 2.0;
    }
    constexpr qreal selectedDisabledContainerOpacity() const
    {
        return 0.38;
    }
    constexpr qreal unselectedDisabledContainerOpacity() const
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
};

} // namespace Fluid
