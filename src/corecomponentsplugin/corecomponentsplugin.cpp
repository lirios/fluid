/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlComponent>

#include "corecomponentsplugin.h"
#include "framesvgitem.h"
#include "svgitem.h"
#include "themeproxy.h"
#include "settingsitem.h"

void CoreComponentsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidCore"));

    qmlRegisterType<Fluid::FrameSvg>(uri, 1, 0, "FrameSvg");
    qmlRegisterType<FrameSvgItem>(uri, 1, 0, "FrameSvgItem");
    qmlRegisterType<Fluid::Svg>(uri, 1, 0, "Svg");
    qmlRegisterType<SvgItem>(uri, 1, 0, "SvgItem");
    qmlRegisterType<ThemeProxy>(uri, 1, 0, "Theme");
    qmlRegisterType<SettingsItem>(uri, 1, 0, "Settings");
}

void CoreComponentsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidCore"));

    QQmlContext *context = engine->rootContext();

    ThemeProxy *theme = new ThemeProxy(context);
    context->setContextProperty("theme", theme);
}

#include "moc_corecomponentsplugin.cpp"
