// SPDX-FileCopyrightText: 2018 Michael Spencer <sonrisesoftware@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QObject>
#include <QClipboard>
#include <QtQml/qqmlregistration.h>

/*!
    \brief Clipboard.
*/
class Clipboard : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    QML_ELEMENT
public:
    explicit Clipboard(QObject *parent = nullptr);

    /*!
        This property holds the clipboard text.
    */
    QString text() const;

    /*!
        Clear the global clipboard contents.
    */
    Q_INVOKABLE void clear();

public Q_SLOTS:
    void setText(const QString &text);

Q_SIGNALS:
    void textChanged();

private:
    QClipboard *m_clipboard = nullptr;
};
