/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#pragma once

#include <QObject>
#include <QClipboard>

class Clipboard : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    explicit Clipboard(QObject *parent = nullptr);

    QString text() const;

    Q_INVOKABLE void clear();

public Q_SLOTS:
    void setText(const QString &text);

Q_SIGNALS:
    void textChanged();

private:
    QClipboard *m_clipboard = nullptr;
};
