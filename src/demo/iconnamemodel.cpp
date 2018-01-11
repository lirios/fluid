/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QFile>
#include <QTextStream>

#include "iconnamemodel.h"

IconNameModel::IconNameModel(QObject *parent)
    : QAbstractListModel(parent)
{
    readFile();
}

QString IconNameModel::category() const
{
    return m_category;
}

void IconNameModel::setCategory(const QString &category)
{
    if (m_category == category)
        return;

    beginResetModel();
    m_category = category;
    Q_EMIT categoryChanged();
    endResetModel();
}

QHash<int, QByteArray> IconNameModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles.insert(Category, QByteArrayLiteral("category"));
    roles.insert(Name, QByteArrayLiteral("name"));
    return roles;
}

int IconNameModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    if (m_category.isEmpty())
        return 0;
    if (m_items.contains(m_category))
        return m_items[m_category].size();
    return 0;
}

QVariant IconNameModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (m_category.isEmpty())
        return QVariant();

    QString iconName = m_items[m_category].at(index.row());

    switch (role) {
    case Qt::DisplayRole:
    case Name:
        return iconName;
    case Category:
        return m_category;
    default:
        break;
    }

    return QVariant();
}

void IconNameModel::readFile()
{
    beginResetModel();
    m_items.clear();
    endResetModel();

    QString lastCategory;

    QFile file(QStringLiteral(":/qml/icons.txt"));
    if (file.open(QFile::ReadOnly)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();

            if (line.startsWith(QLatin1Char('\t'))) {
                beginInsertRows(QModelIndex(), m_items[lastCategory].size(), m_items[lastCategory].size());
                m_items[lastCategory].append(line.replace(QLatin1Char('\t'), QLatin1String("")));
                endInsertRows();
            } else {
                m_items[line] = QStringList();
                lastCategory = line;
            }
        }
        file.close();
    } else {
        qCritical("Unable to open icons list: %s", file.errorString().toLocal8Bit().constData());
    }
}
