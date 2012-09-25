/***************************************************************************
 *   Copyright 2010 Marco Martin <mart@kde.org>                            *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

#ifndef THEME_PROXY_H
#define THEME_PROXY_H

#include <QObject>
#include <QUrl>
#include <QFont>
#include <QColor>

#include <Fluid/Theme>

class FontProxy : public QObject
{
    Q_OBJECT

    /**
     * true if the font is bold
     */
    Q_PROPERTY(bool bold READ bold NOTIFY boldChanged)

    /**
     * One of
     * MixedCase: The text is not changed
     * AllUppercase: the text becomes UPPERCASE
     * AllLowercase: the text becomes all lowercase
     * SmallCaps: the lowercase characters becomes smaller uppercase ones
     * Capitalize: the first letter of all words are uppercase
     */
    Q_PROPERTY(Capitalization capitalization READ capitalization  NOTIFY capitalizationChanged)

    /**
     * name of the font family
     */
    Q_PROPERTY(QString family READ family NOTIFY familyChanged)

    /**
     * true if the font is italic
     */
    Q_PROPERTY(bool italic READ italic NOTIFY italicChanged)

    /**
     * horizontal space between letters
     */
    Q_PROPERTY(qreal letterSpacing READ letterSpacing NOTIFY letterSpacingChanged)

    /**
     * Size of the font in pixels: settings this is strongly discouraged.
     * @see pointSize
     */
    Q_PROPERTY(int pixelSize READ pixelSize NOTIFY pixelSizeChanged)

    /**
     * Size of the font in points
     */
    Q_PROPERTY(qreal pointSize READ pointSize NOTIFY pointSizeChanged)

    /**
     * True if the text is striked out with an horizontal line
     */
    Q_PROPERTY(bool strikeout READ strikeout NOTIFY strikeoutChanged)

    /**
     * True if all the text will be underlined
     */
    Q_PROPERTY(bool underline READ underline NOTIFY underlineChanged)

    /**
     * One of:
     * Light
     * Normal
     * DemiBold
     * Bold
     * Black
     */
    Q_PROPERTY(Weight weight READ weight NOTIFY weightChanged)

    /**
     * Horizontal space between words
     */
    Q_PROPERTY(qreal wordSpacing READ wordSpacing NOTIFY wordSpacingChanged)

    /**
     * Size in pixels of an uppercase "M" letter
     */
    Q_PROPERTY(QSize mSize READ mSize NOTIFY mSizeChanged)

    Q_ENUMS(Capitalization)
    Q_ENUMS(Weight)

public:
    enum Capitalization {
        MixedCase = 0,
        AllUppercase = 1,
        AllLowercase = 2,
        SmallCaps = 3,
        Capitalize = 4
    };

    enum Weight {
        Light = 25,
        Normal = 50,
        DemiBold = 63,
        Bold = 75,
        Black = 87
    };

    FontProxy(Fluid::Theme::FontRole role, QObject *parent = 0);
    ~FontProxy();
    static FontProxy *defaultFont();
    static FontProxy *desktopFont();
    static FontProxy *smallestFont();

    bool bold() const;
    Capitalization capitalization() const;
    QString family() const;
    bool italic() const;
    qreal letterSpacing() const;
    int pixelSize() const;
    qreal pointSize() const;
    bool strikeout() const;
    bool underline() const;
    Weight weight() const;
    qreal wordSpacing() const;

    /**
     * @return The size of an uppercase M in this font
     */
    QSize mSize() const;

Q_SIGNALS:
    void boldChanged();
    void capitalizationChanged();
    void familyChanged();
    void italicChanged();
    void letterSpacingChanged();
    void pixelSizeChanged();
    void pointSizeChanged();
    void strikeoutChanged();
    void underlineChanged();
    void weightChanged();
    void wordSpacingChanged();
    void mSizeChanged();

private:
    Fluid::Theme::FontRole m_fontRole;
};

class ThemeProxy : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString themeName READ themeName NOTIFY themeChanged)
    Q_PROPERTY(bool windowTranslucentEnabled READ windowTranslucencyEnabled NOTIFY themeChanged)
    Q_PROPERTY(QUrl homepage READ homepage NOTIFY themeChanged)
    Q_PROPERTY(bool useGlobalSettings READ useGlobalSettings NOTIFY themeChanged)

    //fonts
    Q_PROPERTY(QObject *defaultFont READ defaultFont CONSTANT)
    Q_PROPERTY(QObject *desktopFont READ desktopFont CONSTANT)
    Q_PROPERTY(QObject *smallestFont READ smallestFont CONSTANT)

#if 0
    // colors
    Q_PROPERTY(QColor textColor READ textColor NOTIFY themeChanged)
    Q_PROPERTY(QColor highlightColor READ highlightColor NOTIFY themeChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor NOTIFY themeChanged)
    Q_PROPERTY(QColor buttonTextColor READ buttonTextColor NOTIFY themeChanged)
    Q_PROPERTY(QColor buttonBackgroundColor READ buttonBackgroundColor NOTIFY themeChanged)
    Q_PROPERTY(QColor linkColor READ linkColor NOTIFY themeChanged)
    Q_PROPERTY(QColor visitedLinkColor READ visitedLinkColor NOTIFY themeChanged)
    Q_PROPERTY(QColor visitedLinkColor READ visitedLinkColor NOTIFY themeChanged)
    Q_PROPERTY(QColor buttonHoverColor READ buttonHoverColor NOTIFY themeChanged)
    Q_PROPERTY(QColor buttonFocusColor READ buttonFocusColor NOTIFY themeChanged)
    Q_PROPERTY(QColor viewTextColor READ viewTextColor NOTIFY themeChanged)
    Q_PROPERTY(QColor viewBackgroundColor READ viewBackgroundColor NOTIFY themeChanged)
    Q_PROPERTY(QColor viewHoverColor READ viewHoverColor NOTIFY themeChanged)
    Q_PROPERTY(QColor viewFocusColor READ viewFocusColor NOTIFY themeChanged)
#endif
    Q_PROPERTY(QString styleSheet READ styleSheet NOTIFY themeChanged)

    // icon sizes
    Q_PROPERTY(int smallIconSize READ smallIconSize CONSTANT)
    Q_PROPERTY(int smallMediumIconSize READ smallMediumIconSize CONSTANT)
    Q_PROPERTY(int mediumIconSize READ mediumIconSize CONSTANT)
    Q_PROPERTY(int largeIconSize READ largeIconSize CONSTANT)
    Q_PROPERTY(int hugeIconSize READ hugeIconSize CONSTANT)
    Q_PROPERTY(int enormousIconSize READ enormousIconSize CONSTANT)
    Q_PROPERTY(int defaultIconSize READ defaultIconSize NOTIFY defaultIconSizeChanged)

public:
    ThemeProxy(QObject *parent = 0);
    ~ThemeProxy();

    QString themeName() const;
    QObject *defaultFont() const;
    QObject *desktopFont() const;
    QObject *smallestFont() const;
    bool windowTranslucencyEnabled() const;
    QUrl homepage() const;
    bool useGlobalSettings() const;

#if 0
    QColor textColor() const;
    QColor highlightColor() const;
    QColor backgroundColor() const;
    QColor buttonTextColor() const;
    QColor buttonBackgroundColor() const;
    QColor linkColor() const;
    QColor visitedLinkColor() const;
    QColor buttonHoverColor() const;
    QColor buttonFocusColor() const;
    QColor viewTextColor() const;
    QColor viewBackgroundColor() const;
    QColor viewHoverColor() const;
    QColor viewFocusColor() const;
#endif
    QString styleSheet() const;

    int smallIconSize() const;
    int smallMediumIconSize() const;
    int mediumIconSize() const;
    int largeIconSize() const;
    int hugeIconSize() const;
    int enormousIconSize() const;
    int defaultIconSize() const;

private Q_SLOTS:
    void iconLoaderSettingsChanged();

Q_SIGNALS:
    void themeChanged();
    void defaultIconSizeChanged();

private:
    int m_defaultIconSize;
};

#endif // THEMEPROXY_H
