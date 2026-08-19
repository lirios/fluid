// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QQmlEngine>

namespace Fluid {

/*!
    \brief Material Design 3 divider tokens.
*/
struct Divider
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(qreal thickness READ thickness CONSTANT FINAL)
    Q_PROPERTY(qreal inset READ inset CONSTANT FINAL)

public:
    qreal thickness() const;
    qreal inset() const;
};

} // namespace Fluid
