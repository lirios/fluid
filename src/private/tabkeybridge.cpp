// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QCoreApplication>
#include <QKeyEvent>

#include "tabkeybridge.h"

namespace Fluid {

TabKeyBridge::TabKeyBridge(QObject *parent)
    : QObject(parent)
{
}

QObject *TabKeyBridge::target() const
{
    return m_target;
}

void TabKeyBridge::setTarget(QObject *target)
{
    if (m_target == target)
        return;
    if (m_target)
        m_target->removeEventFilter(this);
    m_target = target;
    if (m_target)
        m_target->installEventFilter(this);
    Q_EMIT targetChanged();
}

bool TabKeyBridge::eventFilter(QObject *watched, QEvent *event)
{
    if (watched != m_target
        || (event->type() != QEvent::KeyPress && event->type() != QEvent::KeyRelease))
        return false;

    const auto *key = static_cast<QKeyEvent *>(event);
    if (key->key() != Qt::Key_Return && key->key() != Qt::Key_Enter)
        return false;

    // Qt's platform ButtonPressKeys differs for Enter. Space always uses the native
    // press/release, Action, selection, repeat timer, and focus-out cancellation path.
    QKeyEvent space(event->type(), Qt::Key_Space, key->modifiers(), QStringLiteral(" "),
                    key->isAutoRepeat(), key->count());
    space.setTimestamp(key->timestamp());
    QCoreApplication::sendEvent(watched, &space);
    event->setAccepted(space.isAccepted());
    return true;
}

} // namespace Fluid
