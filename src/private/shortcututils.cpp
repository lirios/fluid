// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "shortcututils.h"

#include <QKeySequence>
#include <QMetaType>

ShortcutUtils::ShortcutUtils(QObject *parent)
    : QObject(parent)
{
}

QString ShortcutUtils::text(const QVariant &shortcut) const
{
    QKeySequence sequence;

    if (shortcut.metaType() == QMetaType::fromType<QKeySequence>()) {
        sequence = shortcut.value<QKeySequence>();
    } else if (shortcut.metaType().id() == QMetaType::QString) {
        sequence = QKeySequence::fromString(shortcut.toString(), QKeySequence::PortableText);
    } else {
        bool ok = false;
        const int value = shortcut.toInt(&ok);
        if (ok && value > QKeySequence::UnknownKey && value <= QKeySequence::Cancel)
            sequence = QKeySequence(static_cast<QKeySequence::StandardKey>(value));
    }

    return sequence.toString(QKeySequence::PortableText)
        .replace(QStringLiteral("Meta+"), QStringLiteral("⌘"));
}
