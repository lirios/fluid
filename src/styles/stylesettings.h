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

#ifndef STYLESETTINGS_H
#define STYLESETTINGS_H

#include <QtQml/QQmlEngine>

#include <QtConfiguration/QStaticConfiguration>

class StyleSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path NOTIFY pathChanged)
    Q_PROPERTY(qreal dpiScaleFactor READ dpiScaleFactor CONSTANT)
public:
    StyleSettings(QObject *parent = 0);

    QString path() const;

    qreal dpiScaleFactor() const;

Q_SIGNALS:
    void pathChanged();

private:
    QStaticConfiguration *m_settings;

private Q_SLOTS:
    void settingChanged(const QString &key, const QVariant &value);
};

#endif // STYLESETTINGS_H
