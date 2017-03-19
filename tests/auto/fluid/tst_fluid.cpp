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

#include <QtCore/QString>
#include <QtTest/QtTest>

#include <Fluid/DateUtils>

using namespace Fluid;

class FluidLib : public QObject
{
    Q_OBJECT
public:
    FluidLib();

private Q_SLOTS:
    void initTestCase();
    void testFormattedDate();
    void testFormatDuration();
    void testFriendlyTime();
    void testDayOfWeek();

private:
    QDate m_today;
    QString m_todayDOW;
    QDate m_tomorrow;
    QString m_tomorrowDOW;
    QDateTime m_now;
    QDate m_date;
    QDateTime m_dateTime;
};

FluidLib::FluidLib()
{
}

void FluidLib::initTestCase()
{
    QLocale::setDefault(QLocale(QLatin1String("C")));

    m_today = QDate::currentDate();
    m_todayDOW = m_today.toString(QLatin1String("dddd"));

    m_tomorrow = QDate::currentDate().addDays(1);
    m_tomorrowDOW = m_tomorrow.toString(QLatin1String("dddd"));

    m_now = QDateTime::currentDateTime();

    m_date = QDate(2012, 12, 21);
    m_dateTime = QDateTime(QDate(2012, 12, 21), QTime(13, 37));
}

void FluidLib::testFormattedDate()
{
    QCOMPARE(DateUtils::formattedDate(m_today), QStringLiteral("Today (%1)").arg(m_todayDOW));
    QCOMPARE(DateUtils::formattedDate(m_tomorrow), QStringLiteral("Tomorrow (%1)").arg(m_tomorrowDOW));
    QCOMPARE(DateUtils::formattedDate(m_date), QLatin1String("21 Dec 2012"));
}

void FluidLib::testFormatDuration()
{
    QCOMPARE(DateUtils::formatDuration(24 * 60000, DateUtils::Short, DateUtils::Any), QLatin1String("24:00"));
    QCOMPARE(DateUtils::formatDuration(32000, DateUtils::Short, DateUtils::Seconds), QLatin1String("0:00:32"));
    QCOMPARE(DateUtils::formatDuration(121000, DateUtils::Short, DateUtils::Minutes), QLatin1String("0:02"));
    QCOMPARE(DateUtils::formatDuration(3610000, DateUtils::Short, DateUtils::Hours), QLatin1String("1"));

    QCOMPARE(DateUtils::formatDuration(24 * 60000, DateUtils::Long, DateUtils::Any), QLatin1String("24m 0s"));
    QCOMPARE(DateUtils::formatDuration(32000, DateUtils::Long, DateUtils::Seconds), QLatin1String("0h 0m 32s"));
    QCOMPARE(DateUtils::formatDuration(121000, DateUtils::Long, DateUtils::Minutes), QLatin1String("0h 2m"));
    QCOMPARE(DateUtils::formatDuration(3610000, DateUtils::Long, DateUtils::Hours), QLatin1String("1h"));
}

void FluidLib::testFriendlyTime()
{
    QCOMPARE(DateUtils::friendlyTime(m_now, true), QLatin1String("Now"));
    QCOMPARE(DateUtils::friendlyTime(m_now, false), QLatin1String("now"));
    QCOMPARE(DateUtils::friendlyTime(m_dateTime, true), QLatin1String("21 Dec 2012 13:37:00"));
    QCOMPARE(DateUtils::friendlyTime(m_dateTime, false), QLatin1String("on 21 Dec 2012 13:37:00"));
}

void FluidLib::testDayOfWeek()
{
    QCOMPARE(DateUtils::dayOfWeek(m_today), m_todayDOW);
    QCOMPARE(DateUtils::dayOfWeek(m_tomorrow), m_tomorrowDOW);
}

QTEST_APPLESS_MAIN(FluidLib)

#include "tst_fluid.moc"
