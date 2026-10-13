// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QtCore/qregularexpression.h>
#include <QtCore/qtextboundaryfinder.h>
#include <QtCore/private/qunicodetables_p.h>

#include "badgetext.h"

namespace Fluid {

namespace {

bool isGraphemeContinuation(QStringView text)
{
    for (const char32_t character : text.toString().toUcs4()) {
        const auto type = QUnicodeTables::graphemeBreakClass(character);
        if (type != QUnicodeTables::GraphemeBreak_Extend
            && type != QUnicodeTables::GraphemeBreak_SpacingMark
            && type != QUnicodeTables::GraphemeBreak_ZWJ) {
            return false;
        }
    }
    return !text.isEmpty();
}

} // namespace

BadgeText::BadgeText(QObject *parent)
    : QObject(parent)
{
}

QString BadgeText::elide(const QString &text, int maximumCharacters) const
{
    if (maximumCharacters <= 0)
        return {};

    QTextBoundaryFinder finder(QTextBoundaryFinder::Grapheme, text);
    // Qt 6.12 can split regional-indicator flags and omit boundaries between
    // them after ZWJ emoji. Validate finder candidates against PCRE's native
    // extended-grapheme endpoints, restoring omitted boundaries as well as
    // rejecting false ones without approximating code-unit or code-point cuts.
    // PCRE can omit Extend characters following an RI pair. Accept Qt's longer
    // boundary only when its gap consists of exact native GB9/GB9a classes.
    // https://www.unicode.org/reports/tr29/#Grapheme_Cluster_Boundary_Rules
    static const QRegularExpression extendedGrapheme(QStringLiteral("\\X"));
    auto graphemes = extendedGrapheme.globalMatch(text);
    int count = 0;
    qsizetype prefixEnd = 0;
    while (graphemes.hasNext()) {
        qsizetype boundary = finder.toNextBoundary();
        const qsizetype extendedBoundary = graphemes.next().capturedEnd();
        if (boundary != extendedBoundary) {
            if (boundary > extendedBoundary
                && isGraphemeContinuation(QStringView(text).mid(
                    extendedBoundary, boundary - extendedBoundary))) {
                while (graphemes.hasNext() && graphemes.peekNext().capturedEnd() <= boundary)
                    graphemes.next();
            } else {
                boundary = extendedBoundary;
            }
            finder.setPosition(boundary);
        }
        ++count;
        if (count < maximumCharacters)
            prefixEnd = boundary;
        if (count > maximumCharacters)
            return text.left(prefixEnd) + QChar(0x2026);
    }
    return text;
}

BadgeText *BadgeText::create(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)
    return new BadgeText();
}

} // namespace Fluid
