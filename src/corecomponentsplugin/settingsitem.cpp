/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <VSettings>

#include "settingsitem.h"

SettingsItem::SettingsItem(QQuickItem *parent)
    : QQuickItem(parent)
    , m_settings(0)
{
}

SettingsItem::~SettingsItem()
{
    delete m_settings;
}

QString SettingsItem::schema() const
{
    if (m_settings)
        return m_settings->schemaName();
    return QString();
}

void SettingsItem::setSchema(const QString &schema)
{
    if (schema.isEmpty())
        return;

    delete m_settings;
    m_settings = new VSettings(schema);
    emit schemaChanged();
    connect(m_settings, SIGNAL(changed()), this, SIGNAL(valueChanged()));
}

QString SettingsItem::group() const
{
    return m_group;
}

void SettingsItem::setGroup(const QString &group)
{
    if (group.isEmpty())
        return;

    m_group = group;
    emit groupChanged();
}

QVariant SettingsItem::value(const QString &key)
{
    if (m_group.isEmpty())
        return QVariant();

    if (m_settings)
        return m_settings->value(m_group + QLatin1Char('/') + key);
    return QVariant();
}

void SettingsItem::setValue(const QString &key, const QVariant &value)
{
    if (m_group.isEmpty())
        return;

    if (m_settings)
        m_settings->setValue(m_group + QLatin1Char('/') + key, value);
}

#include "moc_settingsitem.cpp"
