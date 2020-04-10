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

#pragma once

#include <QAbstractListModel>

class IconNameModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
public:
    enum Role {
        Category = Qt::UserRole + 1,
        Name
    };

    explicit IconNameModel(QObject *parent = nullptr);

    QString category() const;
    void setCategory(const QString &category);

    QHash<int, QByteArray> roleNames() const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

Q_SIGNALS:
    void categoryChanged();

private:
    QMap<QString, QStringList> m_items;
    QString m_category;

private Q_SLOTS:
    void readFile();
};
