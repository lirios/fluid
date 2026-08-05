// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QGuiApplication>

#include "clipboard.h"

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

void Clipboard::setText(const QString &text)
{
    m_clipboard->setText(text);
}

void Clipboard::clear()
{
    m_clipboard->clear();
}
