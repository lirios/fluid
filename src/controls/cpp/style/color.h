// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QColor>
#include <QObject>
#include <QQmlEngine>

/*!
    \brief Utility functions for colors.

    Utility functions to manipulate colors.
*/
class Color : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit Color(QObject *parent = nullptr);

    /*!
        A utility method for changing the \a alpha on \a color.
        Returns a new object, and does not modify the original color at all.
    */
    Q_INVOKABLE QColor transparent(const QColor &color, qreal alpha);

    /*!
        Blend \a color1 and \a color2 together and set alpha to \a alpha.
    */
    Q_INVOKABLE QColor blend(const QColor &color1, const QColor &color2, qreal alpha);

    /*!
        Calculate luminance of \a color.
    */
    Q_INVOKABLE qreal luminance(const QColor &color);

    /*!
        Returns \c true if \a color is dark and should have light content on top.
    */
    Q_INVOKABLE bool isDarkColor(const QColor &color);

    /*!
        Select a color depending on whether \a background color is light or dark.
        Returns \a lightColor if \a background is a light color, otherwise
        returns \a darkColor.
    */
    Q_INVOKABLE QColor lightDark(const QColor &background, const QColor &lightColor,
                                 const QColor &darkColor);

    static Color *create(QQmlEngine *engine, QJSEngine *jsEngine);
};
