/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#ifndef CLIPBOARD_H
#define CLIPBOARD_H

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

#endif // CLIPBOARD_H
