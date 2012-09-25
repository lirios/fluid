/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlComponent>

#include <Fluid/RangeModel>

#include "corecomponentsplugin.h"
#include "framesvgitem.h"
#include "svgitem.h"
#include "themeproxy.h"

void CoreComponentsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidCore"));

    qmlRegisterType<Fluid::FrameSvg>(uri, 1, 0, "FrameSvg");
    qmlRegisterType<FrameSvgItem>(uri, 1, 0, "FrameSvgItem");
    qmlRegisterType<Fluid::RangeModel>(uri, 1, 0, "RangeModel");
    qmlRegisterType<Fluid::Svg>(uri, 1, 0, "Svg");
    qmlRegisterType<SvgItem>(uri, 1, 0, "SvgItem");
    qmlRegisterType<ThemeProxy>(uri, 1, 0, "Theme");
}

void CoreComponentsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidCore"));

    QQmlContext *context = engine->rootContext();

    ThemeProxy *theme = new ThemeProxy(context);
    context->setContextProperty("theme", theme);
}

#include "moc_corecomponentsplugin.cpp"
