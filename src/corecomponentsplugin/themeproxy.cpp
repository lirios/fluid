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

#include "themeproxy.h"

class FontProxySingleton
{
public:
    FontProxySingleton()
        : defaultFont(new FontProxy(Fluid::Theme::DefaultFont)),
          desktopFont(new FontProxy(Fluid::Theme::DesktopFont)),
          smallestFont(new FontProxy(Fluid::Theme::SmallestFont)) {
    }

    ~FontProxySingleton() {
        delete defaultFont;
        delete desktopFont;
        delete smallestFont;
    }

    FontProxy *defaultFont;
    FontProxy *desktopFont;
    FontProxy *smallestFont;
};

Q_GLOBAL_STATIC(FontProxySingleton, privateFontProxySingleton)

FontProxy::FontProxy(Fluid::Theme::FontRole role, QObject *parent)
    : QObject(parent),
      m_fontRole(role)
{
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(boldChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(capitalizationChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(familyChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(italicChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(letterSpacingChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(pixelSizeChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(pointSizeChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(strikeoutChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(underlineChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(weightChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(wordSpacingChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()),
            this, SIGNAL(mSizeChanged()));
}

FontProxy::~FontProxy()
{
}

FontProxy *FontProxy::defaultFont()
{
    return privateFontProxySingleton()->defaultFont;
}

FontProxy *FontProxy::desktopFont()
{
    return privateFontProxySingleton()->desktopFont;
}

FontProxy *FontProxy::smallestFont()
{
    return privateFontProxySingleton()->smallestFont;
}

bool FontProxy::bold() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).bold();
}

FontProxy::Capitalization FontProxy::capitalization() const
{
    return (FontProxy::Capitalization)Fluid::Theme::defaultTheme()->font(m_fontRole).capitalization();
}

QString FontProxy::family() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).family();
}

bool FontProxy::italic() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).italic();
}

qreal FontProxy::letterSpacing() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).letterSpacing();
}

int FontProxy::pixelSize() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).pixelSize();
}

qreal FontProxy::pointSize() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).pointSizeF();
}

bool FontProxy::strikeout() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).strikeOut();
}

bool FontProxy::underline() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).underline();
}

FontProxy::Weight FontProxy::weight() const
{
    return (FontProxy::Weight)Fluid::Theme::defaultTheme()->font(m_fontRole).weight();
}

qreal FontProxy::wordSpacing() const
{
    return Fluid::Theme::defaultTheme()->font(m_fontRole).wordSpacing();
}

QSize FontProxy::mSize() const
{
    return QFontMetrics(Fluid::Theme::defaultTheme()->font(m_fontRole)).boundingRect("M").size();
}


//********** Theme *************

ThemeProxy::ThemeProxy(QObject *parent)
    : QObject(parent)
{
#if 0
    m_defaultIconSize = KIconLoader::global()->currentSize(KIconLoader::Desktop);
#else
    // TODO: from VSettings
    m_defaultIconSize = 64;
#endif

    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()), this, SIGNAL(themeChanged()));
#if 0
    connect(KIconLoader::global(), SIGNAL(iconLoaderSettingsChanged()), this, SLOT(iconLoaderSettingsChanged()));
#endif
}

ThemeProxy::~ThemeProxy()
{
}

QString ThemeProxy::themeName() const
{
    return Fluid::Theme::defaultTheme()->themeName();
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
    return Fluid::Theme::defaultTheme()->windowTranslucencyEnabled();
}

QUrl ThemeProxy::homepage() const
{
    return Fluid::Theme::defaultTheme()->homepage();
}

bool ThemeProxy::useGlobalSettings() const
{
    return Fluid::Theme::defaultTheme()->useGlobalSettings();
}

#if 0
QColor ThemeProxy::textColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::TextColor);
}

QColor ThemeProxy::highlightColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::HighlightColor);
}

QColor ThemeProxy::backgroundColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::BackgroundColor);
}

QColor ThemeProxy::buttonTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ButtonTextColor);
}

QColor ThemeProxy::buttonBackgroundColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ButtonBackgroundColor);
}

QColor ThemeProxy::linkColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::LinkColor);
}

QColor ThemeProxy::visitedLinkColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::VisitedLinkColor);
}

QColor ThemeProxy::buttonHoverColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ButtonHoverColor);
}

QColor ThemeProxy::buttonFocusColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ButtonFocusColor);
}

QColor ThemeProxy::viewTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ViewTextColor);
}

QColor ThemeProxy::viewBackgroundColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ViewBackgroundColor);
}

QColor ThemeProxy::viewHoverColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ViewHoverColor);
}

QColor ThemeProxy::viewFocusColor() const
{
    return Fluid::Theme::defaultTheme()->color(Fluid::Theme::ViewFocusColor);
}
#endif

QString ThemeProxy::styleSheet() const
{
    return Fluid::Theme::defaultTheme()->styleSheet(QString());
}

int ThemeProxy::smallIconSize() const
{
#if 0
    return KIconLoader::SizeSmall;
#endif
    return 16;
}

int ThemeProxy::smallMediumIconSize() const
{
#if 0
    return KIconLoader::SizeSmallMedium;
#endif
    return 24;
}

int ThemeProxy::mediumIconSize() const
{
#if 0
    return KIconLoader::SizeMedium;
#endif
    return 32;
}

int ThemeProxy::largeIconSize() const
{
#if 0
    return KIconLoader::SizeLarge;
#endif
    return 48;
}

int ThemeProxy::hugeIconSize() const
{
#if 0
    return KIconLoader::SizeHuge;
#endif
    return 64;
}

int ThemeProxy::enormousIconSize() const
{
#if 0
    return KIconLoader::SizeEnormous;
#endif
    return 128;
}

void ThemeProxy::iconLoaderSettingsChanged()
{
#if 0
    if (m_defaultIconSize == KIconLoader::global()->currentSize(KIconLoader::Desktop))
        return;

    m_defaultIconSize = KIconLoader::global()->currentSize(KIconLoader::Desktop);

    emit defaultIconSizeChanged();
#endif
}

int ThemeProxy::defaultIconSize() const
{
    return m_defaultIconSize;
}

#include "moc_themeproxy.cpp"
