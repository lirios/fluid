/****************************************************************************
 * This file is part of Hawaii Framework.
 *
 * Copyright (C) 2013-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <QtQml/QQmlExtensionPlugin>
#include <QtQml/QQmlComponent>

#include "abstractstyle.h"
#include "padding.h"
#include "stylesettings.h"

class HawaiiShellStylesPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface/1.0")
public:
    void registerTypes(const char *uri);

    static QObject *styleSettingsProvider(QQmlEngine *engine, QJSEngine *jsEngine);
};

void HawaiiShellStylesPlugin::registerTypes(const char *uri)
{
    // @uri Hawaii.Shell.Styles
    qmlRegisterType<AbstractStyle>(uri, 1, 0, "AbstractStyle");
    qmlRegisterType<Padding>();
    qmlRegisterSingletonType<StyleSettings>(uri, 1, 0, "StyleSettings",
                                            HawaiiShellStylesPlugin::styleSettingsProvider);
}

QObject *HawaiiShellStylesPlugin::styleSettingsProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new StyleSettings();
}

#include "plugin.moc"
