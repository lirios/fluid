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

#ifndef DATESELECTOR_H
#define DATESELECTOR_H

#include <QDate>
#include <QQuickItem>

class DateSelector : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QLocale locale READ locale WRITE setLocale NOTIFY localeChanged FINAL)
    Q_PROPERTY(QQuickItem *contentItem READ contentItem CONSTANT FINAL)
    Q_PROPERTY(QQuickItem *navigator READ navigator WRITE setNavigator NOTIFY navigatorChanged FINAL)
    Q_PROPERTY(QQuickItem *calendar READ calendar WRITE setCalendar NOTIFY calendarChanged FINAL)
    Q_PROPERTY(bool dayOfWeekRowVisible READ dayOfWeekRowVisible WRITE setDayOfWeekRowVisible RESET resetDayOfWeekRowVisible NOTIFY dayOfWeekRowVisibleChanged FINAL)
    Q_PROPERTY(bool weekNumberVisible READ weekNumberVisible WRITE setWeekNumberVisible RESET resetWeekNumberVisible NOTIFY weekNumberVisibleChanged FINAL)
    Q_PROPERTY(QDate from READ from WRITE setFrom RESET resetFrom NOTIFY fromChanged FINAL)
    Q_PROPERTY(QDate to READ to WRITE setTo RESET resetTo NOTIFY toChanged FINAL)
    Q_PROPERTY(QDate selectedDate READ selectedDate WRITE setSelectedDate NOTIFY selectedDateChanged FINAL)
    Q_DISABLE_COPY(DateSelector)
public:
    explicit DateSelector(QQuickItem *parent = nullptr);

    QLocale locale() const;
    void setLocale(const QLocale &locale);

    QQuickItem *contentItem() const;

    QQuickItem *navigator() const;
    void setNavigator(QQuickItem *item);

    QQuickItem *calendar() const;
    void setCalendar(QQuickItem *item);

    bool dayOfWeekRowVisible() const;
    void setDayOfWeekRowVisible(bool value);
    void resetDayOfWeekRowVisible();

    bool weekNumberVisible() const;
    void setWeekNumberVisible(bool value);
    void resetWeekNumberVisible();

    QDate from() const;
    void setFrom(const QDate &date);
    void resetFrom();

    QDate to() const;
    void setTo(const QDate &date);
    void resetTo();

    QDate selectedDate() const;
    void setSelectedDate(const QDate &date);

Q_SIGNALS:
    void localeChanged();
    void navigatorChanged();
    void calendarChanged();
    void dayOfWeekRowVisibleChanged();
    void weekNumberVisibleChanged();
    void fromChanged();
    void toChanged();
    void selectedDateChanged();

private:
    QLocale m_locale;
    QQuickItem *m_contentItem = nullptr;
    QQuickItem *m_navigator = nullptr;
    QQuickItem *m_calendar = nullptr;
    bool m_dayOfWeekRowVisible = true;
    bool m_weekNumberVisible = true;
    QDate m_from;
    QDate m_to;
    QDate m_selectedDate;

private Q_SLOTS:
    void updateLayout();
};

QML_DECLARE_TYPE(DateSelector)

#endif // DATESELECTOR_H
