#pragma once

#ifdef FLUID_LOCAL
    #define FLUID_EXPORT
#else
    #include <Fluid/fluid/fluid_export.h>
#endif
#include <QtCore/QObject>

namespace Fluid {
class FLUID_EXPORT DateUtils : public QObject
{
    Q_OBJECT

public:
    enum DurationFormat { Long, Short };
    Q_ENUM(DurationFormat)

    enum DurationType { Seconds, Minutes, Hours, Any };
    Q_ENUM(DurationType)

    static QString formatDuration(qlonglong duration, DurationFormat format = Short,
                                  DurationType type = Any);
};
}
