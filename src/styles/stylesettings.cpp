/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2012-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <QtCore/QDir>
#include <QtCore/QStandardPaths>

#include "stylesettings.h"
#include "cmakedirs.h"

StyleSettings::StyleSettings(QObject *parent)
    : QObject(parent)
    , m_settings(new QStaticConfiguration(this))
{
    m_settings->setCategory(QStringLiteral("shell"));
    connect(m_settings, &QStaticConfiguration::valueChanged,
            this, &StyleSettings::settingChanged);
}

QString StyleSettings::path() const
{
    //QString style = m_settings->style();
    QString style = QStringLiteral("Aluminium");

    QStringList paths =
            QStandardPaths::locateAll(QStandardPaths::GenericDataLocation,
                                      QStringLiteral("hawaii/styles/") + style,
                                      QStandardPaths::LocateDirectory);
    for (QString path: paths) {
        QDir dir(path);
        if (dir.exists())
            return QUrl::fromLocalFile(path).toString();
    }

    return QString("file://%1/%2").arg(INSTALL_STYLESDIR).arg(style);
}

extern Q_GUI_EXPORT int qt_defaultDpiX();

qreal StyleSettings::dpiScaleFactor() const
{
    return (qreal(qt_defaultDpiX()) / 96.0);
}

void StyleSettings::settingChanged(const QString &key, const QVariant &value)
{
    Q_UNUSED(value);

    if (key == QStringLiteral("style"))
        Q_EMIT pathChanged();
}

#include "moc_stylesettings.cpp"
