// Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QQmlEngine>

class Theme : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Theme)

    Q_PROPERTY(QString symbolsOutlinedFontFamily READ symbolsOutlinedFontFamily CONSTANT FINAL)
    Q_PROPERTY(QString symbolsRoundedFontFamily READ symbolsRoundedFontFamily CONSTANT FINAL)
    Q_PROPERTY(QString symbolsSharpFontFamily READ symbolsSharpFontFamily CONSTANT FINAL)

    QML_SINGLETON
    QML_ELEMENT
    QML_ADDED_IN_VERSION(2, 0)
public:
    explicit Theme(QObject *parent = nullptr);
    ~Theme();

    QString symbolsOutlinedFontFamily() const;
    QString symbolsRoundedFontFamily() const;
    QString symbolsSharpFontFamily() const;

private:
    int m_symbolsOutlinedFontId = -1;
    int m_symbolsRoundedFontId = -1;
    int m_symbolsSharpFontId = -1;

    void registerFonts();
    void unregisterFonts();
};