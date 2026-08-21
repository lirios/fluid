// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Design 3 switch tokens. */
struct Switch
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal trackWidth READ trackWidth CONSTANT FINAL)
    Q_PROPERTY(qreal trackHeight READ trackHeight CONSTANT FINAL)
    Q_PROPERTY(qreal trackShape READ trackShape CONSTANT FINAL)
    Q_PROPERTY(qreal trackOutlineWidth READ trackOutlineWidth CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerSize READ stateLayerSize CONSTANT FINAL)
    Q_PROPERTY(qreal stateLayerShape READ stateLayerShape CONSTANT FINAL)
    Q_PROPERTY(qreal selectedHandleSize READ selectedHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedHandleSize READ unselectedHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal withIconHandleSize READ withIconHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal pressedHandleSize READ pressedHandleSize CONSTANT FINAL)
    Q_PROPERTY(qreal handleShape READ handleShape CONSTANT FINAL)
    Q_PROPERTY(qreal selectedIconSize READ selectedIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal unselectedIconSize READ unselectedIconSize CONSTANT FINAL)
    Q_PROPERTY(qreal disabledTrackOpacity READ disabledTrackOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal disabledSelectedHandleOpacity READ disabledSelectedHandleOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal disabledUnselectedHandleOpacity READ disabledUnselectedHandleOpacity CONSTANT
                       FINAL)
    Q_PROPERTY(qreal disabledSelectedIconOpacity READ disabledSelectedIconOpacity CONSTANT FINAL)
    Q_PROPERTY(
            qreal disabledUnselectedIconOpacity READ disabledUnselectedIconOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal hoverStateLayerOpacity READ hoverStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal focusStateLayerOpacity READ focusStateLayerOpacity CONSTANT FINAL)
    Q_PROPERTY(qreal pressedStateLayerOpacity READ pressedStateLayerOpacity CONSTANT FINAL)

public:
    constexpr qreal trackWidth() const
    {
        return 52.0;
    }
    constexpr qreal trackHeight() const
    {
        return 32.0;
    }
    constexpr qreal trackShape() const
    {
        return 9999.0;
    }
    constexpr qreal trackOutlineWidth() const
    {
        return 2.0;
    }
    constexpr qreal stateLayerSize() const
    {
        return 40.0;
    }
    constexpr qreal stateLayerShape() const
    {
        return 9999.0;
    }
    constexpr qreal selectedHandleSize() const
    {
        return 24.0;
    }
    constexpr qreal unselectedHandleSize() const
    {
        return 16.0;
    }
    constexpr qreal withIconHandleSize() const
    {
        return 24.0;
    }
    constexpr qreal pressedHandleSize() const
    {
        return 28.0;
    }
    constexpr qreal handleShape() const
    {
        return 9999.0;
    }
    constexpr qreal selectedIconSize() const
    {
        return 16.0;
    }
    constexpr qreal unselectedIconSize() const
    {
        return 16.0;
    }
    constexpr qreal disabledTrackOpacity() const
    {
        return 0.12;
    }
    constexpr qreal disabledSelectedHandleOpacity() const
    {
        return 1.0;
    }
    constexpr qreal disabledUnselectedHandleOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledSelectedIconOpacity() const
    {
        return 0.38;
    }
    constexpr qreal disabledUnselectedIconOpacity() const
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
