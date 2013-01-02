/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2011 Marco Martin <mart@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Marco Martin
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

#include <QDebug>
#include <QDir>
#include <QFile>
#include <QStandardPaths>

#include "fallbackcomponent.h"

FallbackComponent::FallbackComponent(QObject *parent)
    : QObject(parent)
{
}

QString FallbackComponent::basePath() const
{
    return m_basePath;
}

void FallbackComponent::setBasePath(const QString &basePath)
{
    if (basePath != m_basePath) {
        m_basePath = basePath;
        emit basePathChanged();
    }
}

QStringList FallbackComponent::candidates() const
{
    return m_candidates;
}

void FallbackComponent::setCandidates(const QStringList &candidates)
{
    m_candidates = candidates;
    emit candidatesChanged();
}

QString FallbackComponent::filePath(const QString &key)
{
    QString resolved;

    foreach(const QString & path, m_candidates) {
        qDebug() << "Searching for:" << path + path;
        if (m_possiblePaths.contains(path + key)) {
            resolved = *m_possiblePaths.object(path + key);
            if (!resolved.isEmpty())
                break;
            else
                continue;
        }

        QDir tmpPath(m_basePath);

        if (tmpPath.isAbsolute())
            resolved = m_basePath + path + key;
        else
            resolved = QStandardPaths::locate(QStandardPaths::GenericDataLocation,
                                              m_basePath + QLatin1Char('/') + path + key);

        m_possiblePaths.insert(path + key, new QString(resolved));
        if (!resolved.isEmpty())
            break;
    }

    return resolved;
}

#include "moc_fallbackcomponent.cpp"
