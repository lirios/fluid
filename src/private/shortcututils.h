// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QVariant>
#include <QtQml/qqmlregistration.h>

class ShortcutUtils : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit ShortcutUtils(QObject *parent = nullptr);

    Q_INVOKABLE QString text(const QVariant &shortcut) const;
};
