// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QPointer>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

// Normalize Enter to the template's native Space path without owning button state.
class TabKeyBridge : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QObject *target READ target WRITE setTarget NOTIFY targetChanged FINAL)

public:
    explicit TabKeyBridge(QObject *parent = nullptr);
    QObject *target() const;
    void setTarget(QObject *target);

Q_SIGNALS:
    void targetChanged();

protected:
    bool eventFilter(QObject *watched, QEvent *event) override;

private:
    QPointer<QObject> m_target;
};

} // namespace Fluid
