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

#ifndef YEARMODEL_H
#define YEARMODEL_H

#include <QAbstractListModel>
#include <QDate>
#include <QtQml>

class YearModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QDate from READ from WRITE setFrom NOTIFY fromChanged FINAL)
    Q_PROPERTY(QDate to READ to WRITE setTo NOTIFY toChanged FINAL)
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged FINAL)
    Q_DISABLE_COPY(YearModel)
public:
    explicit YearModel(QObject *parent = nullptr);

    QDate from() const;
    void setFrom(const QDate &date);

    QDate to() const;
    void setTo(const QDate &date);

    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    Q_INVOKABLE int get(int index) const;

    void reset();

Q_SIGNALS:
    void fromChanged();
    void toChanged();
    void countChanged();

private:
    QDate m_from;
    QDate m_to;
    QVector<int> m_list;
};

QML_DECLARE_TYPE(YearModel)

#endif // YEARMODEL_H
