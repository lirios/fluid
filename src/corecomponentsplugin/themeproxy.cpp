/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2010 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QVariant>
#include <VSettings>

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
    m_settings = new VSettings("org.hawaii.desktop");
    m_defaultIconSize = m_settings->value("interface/huge-icon-size").toInt();

    connect(m_settings, SIGNAL(changed()), this, SLOT(settingsChanged()));
    connect(Fluid::Theme::defaultTheme(), SIGNAL(themeChanged()), this, SIGNAL(themeChanged()));
}

ThemeProxy::~ThemeProxy()
{
    delete m_settings;
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

QColor ThemeProxy::windowColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Window);
}

QColor ThemeProxy::windowTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::WindowText);
}

QColor ThemeProxy::baseColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Base);
}

QColor ThemeProxy::alternateBaseColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::AlternateBase);
}

QColor ThemeProxy::toolTipBaseColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::ToolTipBase);
}

QColor ThemeProxy::toolTipTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::ToolTipText);
}

QColor ThemeProxy::textColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Text);
}

QColor ThemeProxy::buttonColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Button);
}

QColor ThemeProxy::buttonTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::ButtonText);
}

QColor ThemeProxy::brightTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::BrightText);
}

QColor ThemeProxy::lightColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Light);
}

QColor ThemeProxy::midlightColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Midlight);
}

QColor ThemeProxy::darkColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Dark);
}

QColor ThemeProxy::midColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Mid);
}

QColor ThemeProxy::shadowColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Shadow);
}

QColor ThemeProxy::highlightColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Highlight);
}

QColor ThemeProxy::highlightedTextColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::HighlightedText);
}

QColor ThemeProxy::linkColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::Link);
}

QColor ThemeProxy::linkVisitedColor() const
{
    return Fluid::Theme::defaultTheme()->color(QPalette::Active, QPalette::LinkVisited);
}

QString ThemeProxy::styleSheet() const
{
    return Fluid::Theme::defaultTheme()->styleSheet(QString());
}

int ThemeProxy::smallIconSize() const
{
    return m_settings->value("interface/small-icon-size").toInt();
}

int ThemeProxy::smallMediumIconSize() const
{
    return m_settings->value("interface/small-medium-icon-size").toInt();
}

int ThemeProxy::mediumIconSize() const
{
    return m_settings->value("interface/medium-icon-size").toInt();
}

int ThemeProxy::largeIconSize() const
{
    return m_settings->value("interface/large-icon-size").toInt();
}

int ThemeProxy::hugeIconSize() const
{
    return m_settings->value("interface/huge-icon-size").toInt();
}

int ThemeProxy::enormousIconSize() const
{
    return m_settings->value("interface/enormous-icon-size").toInt();
}

void ThemeProxy::settingsChanged()
{
    m_defaultIconSize = m_settings->value("interface/huge-icon-size").toInt();
    emit themeChanged();
}

int ThemeProxy::defaultIconSize() const
{
    return m_defaultIconSize;
}

#include "moc_themeproxy.cpp"
