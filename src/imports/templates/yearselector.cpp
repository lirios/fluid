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
#include "yearselector.h"

YearSelector::YearSelector(QQuickItem *parent)
    : QQuickItem(parent)
    , m_model(new YearModel(this))
    , m_from(1, 1, 1)
    , m_to(275759, 9, 25)
    , m_selectedYear(QDate::currentDate().year())
{
    m_model->setFrom(m_from);
    m_model->setTo(m_to);
    m_model->reset();
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
    setFrom(QDate(1, 1, 1));
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
    setTo(QDate(275759, 9, 25));
}

int YearSelector::selectedYear() const
{
    return m_selectedYear;
}

void YearSelector::setSelectedYear(int year)
{
    if (m_selectedYear == year)
        return;

    m_selectedYear = year;
    Q_EMIT selectedYearChanged();
}
