#pragma once

#include <Fluid/DateUtils>
#include <QtCore/QObject>

class DateUtils : public QObject
{
    Q_OBJECT

public:
    enum DurationFormat
    {
        Long,
        Short
    };
    Q_ENUM(DurationFormat)

    enum DurationType
    {
        Seconds,
        Minutes,
        Hours,
        Any
    };
    Q_ENUM(DurationType)

    DateUtils(QObject *parent = nullptr);

    Q_INVOKABLE QString formatDuration(qlonglong duration,
                                       DurationFormat format = DurationFormat::Short,
                                       DurationType type = DurationType::Any) const;
};
