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

#include "yearmodel.h"

YearModel::YearModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
{
}

QDate YearModel::from() const
{
    return m_from;
}

void YearModel::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();
}

QDate YearModel::to() const
{
    return m_to;
}

void YearModel::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();
}

QHash<int, QByteArray> YearModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names.insert(Qt::DisplayRole, QByteArrayLiteral("year"));
    return names;
}

QVariant YearModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role);

    if (!index.isValid())
        return QVariant();

    return m_list.at(index.row());
}

int YearModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_list.count();
}

int YearModel::get(int index) const
{
    if (index < 0 || index >= m_list.size())
        return -1;
    return m_list.at(index);
}

void YearModel::reset()
{
    beginResetModel();

    m_list.clear();

    if (m_from < m_to) {
        for (int i = m_from.year(); i < m_to.year(); i++)
            m_list.append(i);
    }

    endResetModel();
}
