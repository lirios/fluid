// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtCore/qstring.h>
#include <QtQml/qqmlregistration.h>

class QQmlEngine;
class QJSEngine;

namespace Fluid {

/*! \brief Private grapheme-aware badge text formatting. */
class BadgeText : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit BadgeText(QObject *parent = nullptr);

    Q_INVOKABLE QString elide(const QString &text, int maximumCharacters) const;

    static BadgeText *create(QQmlEngine *engine, QJSEngine *jsEngine);
};

} // namespace Fluid
