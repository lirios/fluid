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

#ifndef SETTINGS_H
#define SETTINGS_H

#include <QQuickItem>

class VSettings;

class SettingsItem : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString schema READ schema WRITE setSchema NOTIFY schemaChanged)
    Q_PROPERTY(QString group READ group WRITE setGroup NOTIFY groupChanged)
public:
    SettingsItem(QQuickItem *parent = 0);
    ~SettingsItem();

    QString schema() const;
    void setSchema(const QString &schema);

    QString group() const;
    void setGroup(const QString &group);

    Q_INVOKABLE QVariant value(const QString &key);
    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);

signals:
    void schemaChanged();
    void groupChanged();
    void valueChanged();

private:
    VSettings *m_settings;
    QString m_group;
};

#endif // SETTINGS_H
