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

#include "theme.h"

#include <KIconLoader>

class FontProxySingleton
{
public:
    FontProxySingleton()
        : defaultFont(Plasma::Theme::DefaultFont),
          desktopFont(Plasma::Theme::DesktopFont),
          smallestFont(Plasma::Theme::SmallestFont)
    {
    }

   FontProxy defaultFont;
   FontProxy desktopFont;
   FontProxy smallestFont;
};

K_GLOBAL_STATIC(FontProxySingleton, privateFontProxySingleton)

FontProxy::FontProxy(Plasma::Theme::FontRole role, QObject *parent)
    : QObject(parent),
      m_fontRole(role)
{
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(boldChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(capitalizationChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(familyChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(italicChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(letterSpacingChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(pixelSizeChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(pointSizeChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(strikeoutChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(underlineChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(weightChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(wordSpacingChanged()));
    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(mSizeChanged()));
}

FontProxy::~FontProxy()
{
}

FontProxy *FontProxy::defaultFont()
{
    return &privateFontProxySingleton->defaultFont;
}

FontProxy *FontProxy::desktopFont()
{
    return &privateFontProxySingleton->desktopFont;
}

FontProxy *FontProxy::smallestFont()
{
    return &privateFontProxySingleton->smallestFont;
}

bool FontProxy::bold() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).bold();
}

FontProxy::Capitalization FontProxy::capitalization() const
{
    return (FontProxy::Capitalization)Plasma::Theme::defaultTheme()->font(m_fontRole).capitalization();
}

QString FontProxy::family() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).family();
}

bool FontProxy::italic() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).italic();
}

qreal FontProxy::letterSpacing() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).letterSpacing();
}

int FontProxy::pixelSize() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).pixelSize();
}

qreal FontProxy::pointSize() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).pointSizeF();
}

bool FontProxy::strikeout() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).strikeOut();
}

bool FontProxy::underline() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).underline();
}

FontProxy::Weight FontProxy::weight() const
{
    return (FontProxy::Weight)Plasma::Theme::defaultTheme()->font(m_fontRole).weight();
}

qreal FontProxy::wordSpacing() const
{
    return Plasma::Theme::defaultTheme()->font(m_fontRole).wordSpacing();
}

QSize FontProxy::mSize() const
{
    return QFontMetrics(Plasma::Theme::defaultTheme()->font(m_fontRole)).boundingRect("M").size();
}


//********** Theme *************

ThemeProxy::ThemeProxy(QObject *parent)
    : QObject(parent)
{
    m_defaultIconSize = KIconLoader::global()->currentSize(KIconLoader::Desktop);

    connect(Plasma::Theme::defaultTheme(), SIGNAL(themeChanged()), this, SIGNAL(themeChanged()));
    connect(KIconLoader::global(), SIGNAL(iconLoaderSettingsChanged()), this, SLOT(iconLoaderSettingsChanged()));
}

ThemeProxy::~ThemeProxy()
{
}

QString ThemeProxy::themeName() const
{
    return Plasma::Theme::defaultTheme()->themeName();
}

QObject *ThemeProxy::defaultFont() const
{
    return FontProxy::defaultFont();
}

QObject *ThemeProxy::desktopFont() const
{
    return FontProxy::desktopFont();
}

QObject *ThemeProxy::smallestFont() const
{
    return FontProxy::smallestFont();
}

bool ThemeProxy::windowTranslucencyEnabled() const
{
    return Plasma::Theme::defaultTheme()->windowTranslucencyEnabled();
}

KUrl ThemeProxy::homepage() const
{
    return Plasma::Theme::defaultTheme()->homepage();
}

bool ThemeProxy::useGlobalSettings() const
{
    return Plasma::Theme::defaultTheme()->useGlobalSettings();
}

QString ThemeProxy::wallpaperPath() const
{
    return Plasma::Theme::defaultTheme()->wallpaperPath();
}

QString ThemeProxy::wallpaperPathForSize(int width, int height) const
{
    return Plasma::Theme::defaultTheme()->wallpaperPath(QSize(width, height));
}

QColor ThemeProxy::textColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::TextColor);
}

QColor ThemeProxy::highlightColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::HighlightColor);
}

QColor ThemeProxy::backgroundColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::BackgroundColor);
}

QColor ThemeProxy::buttonTextColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ButtonTextColor);
}

QColor ThemeProxy::buttonBackgroundColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ButtonBackgroundColor);
}

QColor ThemeProxy::linkColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::LinkColor);
}

QColor ThemeProxy::visitedLinkColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::VisitedLinkColor);
}

QColor ThemeProxy::buttonHoverColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ButtonHoverColor);
}

QColor ThemeProxy::buttonFocusColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ButtonFocusColor);
}

QColor ThemeProxy::viewTextColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ViewTextColor);
}

QColor ThemeProxy::viewBackgroundColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ViewBackgroundColor);
}

QColor ThemeProxy::viewHoverColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ViewHoverColor);
}

QColor ThemeProxy::viewFocusColor() const
{
    return Plasma::Theme::defaultTheme()->color(Plasma::Theme::ViewFocusColor);
}

QString ThemeProxy::styleSheet() const
{
    return Plasma::Theme::defaultTheme()->styleSheet(QString());
}

int ThemeProxy::smallIconSize() const
{
    return KIconLoader::SizeSmall;
}

int ThemeProxy::smallMediumIconSize() const
{
    return KIconLoader::SizeSmallMedium;
}

int ThemeProxy::mediumIconSize() const
{
    return KIconLoader::SizeMedium;
}

int ThemeProxy::largeIconSize() const
{
    return KIconLoader::SizeLarge;
}

int ThemeProxy::hugeIconSize() const
{
    return KIconLoader::SizeHuge;
}

int ThemeProxy::enormousIconSize() const
{
    return KIconLoader::SizeEnormous;
}

void ThemeProxy::iconLoaderSettingsChanged()
{
    if (m_defaultIconSize == KIconLoader::global()->currentSize(KIconLoader::Desktop)) {
        return;
    }

    m_defaultIconSize = KIconLoader::global()->currentSize(KIconLoader::Desktop);

    emit defaultIconSizeChanged();
}

int ThemeProxy::defaultIconSize() const
{
    return m_defaultIconSize;
}

#include "theme.moc"

