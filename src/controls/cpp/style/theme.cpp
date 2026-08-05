// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QFontDatabase>

#include "theme.h"

Theme::Theme(QObject *parent)
    : QObject(parent)
{
    registerFonts();
}

Theme::~Theme()
{
    unregisterFonts();
}

QString Theme::symbolsOutlinedFontFamily() const
{
    if (m_symbolsOutlinedFontId == -1)
        return QString();
    return QFontDatabase::applicationFontFamilies(m_symbolsOutlinedFontId).value(0);
}

QString Theme::symbolsRoundedFontFamily() const
{
    if (m_symbolsRoundedFontId == -1)
        return QString();
    return QFontDatabase::applicationFontFamilies(m_symbolsRoundedFontId).value(0);
}

QString Theme::symbolsSharpFontFamily() const
{
    if (m_symbolsSharpFontId == -1)
        return QString();
    return QFontDatabase::applicationFontFamilies(m_symbolsSharpFontId).value(0);
}

void Theme::registerFonts()
{
    if (m_symbolsOutlinedFontId == -1)
        m_symbolsOutlinedFontId = QFontDatabase::addApplicationFont(
                ":/Fluid/assets/fonts/MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].woff2");
    if (m_symbolsRoundedFontId == -1)
        m_symbolsRoundedFontId = QFontDatabase::addApplicationFont(
                ":/Fluid/assets/fonts/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].woff2");
    if (m_symbolsSharpFontId == -1)
        m_symbolsSharpFontId = QFontDatabase::addApplicationFont(
                ":/Fluid/assets/fonts/MaterialSymbolsSharp[FILL,GRAD,opsz,wght].woff2");
}

void Theme::unregisterFonts()
{
    if (m_symbolsOutlinedFontId != -1) {
        QFontDatabase::removeApplicationFont(m_symbolsOutlinedFontId);
        m_symbolsOutlinedFontId = -1;
    }
    if (m_symbolsRoundedFontId != -1) {
        QFontDatabase::removeApplicationFont(m_symbolsRoundedFontId);
        m_symbolsRoundedFontId = -1;
    }
    if (m_symbolsSharpFontId != -1) {
        QFontDatabase::removeApplicationFont(m_symbolsSharpFontId);
        m_symbolsSharpFontId = -1;
    }
}