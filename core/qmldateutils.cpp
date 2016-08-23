#include "qmldateutils.h"

DateUtils::DateUtils(QObject *parent)
    : QObject(parent)
{
}

QString DateUtils::formatDuration(qlonglong duration, DurationFormat format,
                                  DurationType type) const
{
    return Fluid::DateUtils::formatDuration(duration,
                                            static_cast<Fluid::DateUtils::DurationFormat>(format),
                                            static_cast<Fluid::DateUtils::DurationType>(type));
}
