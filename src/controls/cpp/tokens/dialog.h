// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 dialog tokens. */
struct Dialog
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal containerElevation READ containerElevation CONSTANT FINAL)
    Q_PROPERTY(qreal containerShape READ containerShape CONSTANT FINAL)
    Q_PROPERTY(qreal withIconIconSize READ withIconIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal actionHoverStateLayerOpacity READ actionHoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal actionFocusStateLayerOpacity READ actionFocusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal actionPressedStateLayerOpacity READ actionPressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal containerElevation() const
    {
        return 6.0;
    }
    constexpr qreal containerShape() const
    {
        return 28.0;
    }
    constexpr qreal withIconIconSize() const
    {
        return 24.0;
    }
    constexpr qreal actionHoverStateLayerOpacity() const
    {
        return 0.08;
    }
    constexpr qreal actionFocusStateLayerOpacity() const
    {
        return 0.1;
    }
    constexpr qreal actionPressedStateLayerOpacity() const
    {
        return 0.1;
    }
};

} // namespace Fluid
