/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
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

#include <QObject>
#include <QDate>
#include <QDateTime>
#include <QQmlEngine>

class DateUtils : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    enum DurationFormat { Long, Short };
    Q_ENUM(DurationFormat)

    enum DurationType { Seconds, Minutes, Hours, Any };
    Q_ENUM(DurationType)

    DateUtils(QObject *parent = nullptr);

    Q_INVOKABLE QString formattedDate(const QDate &date) const;
    Q_INVOKABLE QString formatDuration(qlonglong duration,
                                       DateUtils::DurationFormat format = DateUtils::DurationFormat::Short,
                                       DateUtils::DurationType type = DateUtils::DurationType::Any) const;
    Q_INVOKABLE QString friendlyTime(const QDateTime &time, bool standalone) const;
    Q_INVOKABLE QString dayOfWeek(const QDate &date) const;

    static DateUtils *create(QQmlEngine *engine, QJSEngine *jsEngine);
};

