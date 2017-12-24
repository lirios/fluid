/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
#include "yearselector.h"

YearSelector::YearSelector(QQuickItem *parent)
    : QQuickItem(parent)
    , m_model(new YearModel(this))
    , m_from(QDate::fromString(QLatin1String("1976-01-01"), QLatin1String("yyyy-MM-dd")))
    , m_to(QDate::fromString(QLatin1String("2150-12-31"), QLatin1String("yyyy-MM-dd")))
    , m_selectedDate(QDate::currentDate())
{
    m_model->setFrom(m_from);
    m_model->setTo(m_to);
}

YearModel *YearSelector::model() const
{
    return m_model;
}

int YearSelector::count() const
{
    return m_model->rowCount();
}

QQuickItem *YearSelector::contentItem() const
{
    return m_contentItem;
}

void YearSelector::setContentItem(QQuickItem *item)
{
    if (m_contentItem == item)
        return;

    if (m_contentItem)
        m_contentItem->setParentItem(nullptr);

    m_contentItem = item;
    m_contentItem->setParentItem(this);
    Q_EMIT contentItemChanged();
}

QQmlComponent *YearSelector::delegate() const
{
    return m_delegate;
}

void YearSelector::setDelegate(QQmlComponent *delegate)
{
    if (m_delegate == delegate)
        return;

    m_delegate = delegate;
    Q_EMIT delegateChanged();
}

int YearSelector::visibleItemCount() const
{
    return m_visibleItemCount;
}

void YearSelector::setVisibleItemCount(int visibleItemCount)
{
    if (m_visibleItemCount == visibleItemCount)
        return;

    m_visibleItemCount = visibleItemCount;
    Q_EMIT visibleItemCountChanged();
}

void YearSelector::resetVisibleItemCount()
{
    setVisibleItemCount(7);
}

QDate YearSelector::from() const
{
    return m_from;
}

void YearSelector::setFrom(const QDate &date)
{
    if (m_from == date)
        return;

    m_from = date;
    Q_EMIT fromChanged();

    m_model->setFrom(m_from);
    m_model->reset();
    Q_EMIT modelChanged();
    Q_EMIT countChanged();
}

void YearSelector::resetFrom()
{
    setFrom(QDate::fromString(QLatin1String("1976-01-01"), QLatin1String("yyyy-MM-dd")));
}

QDate YearSelector::to() const
{
    return m_to;
}

void YearSelector::setTo(const QDate &date)
{
    if (m_to == date)
        return;

    m_to = date;
    Q_EMIT toChanged();

    m_model->setTo(m_to);
    m_model->reset();
    Q_EMIT modelChanged();
    Q_EMIT countChanged();
}

void YearSelector::resetTo()
{
    setTo(QDate::fromString(QLatin1String("2150-12-31"), QLatin1String("yyyy-MM-dd")));
}

QDate YearSelector::selectedDate() const
{
    return m_selectedDate;
}

void YearSelector::setSelectedDate(const QDate &date)
{
    if (m_selectedDate == date)
        return;

    m_selectedDate = date;
    Q_EMIT selectedDateChanged();
}
