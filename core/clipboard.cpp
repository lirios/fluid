/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include "clipboard.h"

#include <QGuiApplication>

Clipboard::Clipboard(QObject *parent)
    : QObject(parent)
    , m_clipboard(QGuiApplication::clipboard())
{
    connect(m_clipboard, &QClipboard::dataChanged, this, &Clipboard::textChanged);
}

QString Clipboard::text() const
{
    return m_clipboard->text();
}

void Clipboard::clear()
{
    m_clipboard->clear();
}

void Clipboard::setText(const QString &text)
{
    m_clipboard->setText(text);
}
