#pragma once

#include <Fluid/fluid_export.h>
#include <QtCore/QObject>

namespace Fluid
{
class FLUID_EXPORT DateUtils : public QObject
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

    static QString formatDuration(qlonglong duration, DurationFormat format = Short,
                                  DurationType type = Any);
};
}
