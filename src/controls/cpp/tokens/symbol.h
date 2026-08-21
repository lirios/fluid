// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

/*! \brief Material Symbols icon tokens. */
struct Symbol
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal size READ size CONSTANT FINAL)

public:
    constexpr qreal size() const
    {
        return 24.0;
    }
};

} // namespace Fluid
