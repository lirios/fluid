// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

struct ShapeValue
{
    Q_GADGET
    QML_ELEMENT
    QML_VALUE_TYPE(shapeValue)

    Q_PROPERTY(qreal topLeft MEMBER topLeft CONSTANT FINAL)
    Q_PROPERTY(qreal topRight MEMBER topRight CONSTANT FINAL)
    Q_PROPERTY(qreal bottomRight MEMBER bottomRight CONSTANT FINAL)
    Q_PROPERTY(qreal bottomLeft MEMBER bottomLeft CONSTANT FINAL)

public:
    constexpr ShapeValue(qreal topLeft = 0.0, qreal topRight = 0.0, qreal bottomRight = 0.0,
                         qreal bottomLeft = 0.0)
        : topLeft(topLeft)
        , topRight(topRight)
        , bottomRight(bottomRight)
        , bottomLeft(bottomLeft)
    {
    }

    qreal topLeft;
    qreal topRight;
    qreal bottomRight;
    qreal bottomLeft;
};

/*!
    \brief Material Design 3 system shape tokens.

    Shape values use the same physical corner names as QML Rectangle radius properties.

    For more information see the
    <a href="https://m3.material.io/styles/shape/corner-radius-scale">Material Design 3
    shape guidelines</a>.
*/
struct ShapeTokens
{
    Q_GADGET
    QML_ANONYMOUS

    Q_PROPERTY(Fluid::ShapeValue cornerExtraExtraLarge READ cornerExtraExtraLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerExtraLarge READ cornerExtraLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerExtraLargeIncreased READ cornerExtraLargeIncreased CONSTANT
                       FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerExtraLargeTop READ cornerExtraLargeTop CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerExtraSmall READ cornerExtraSmall CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerExtraSmallTop READ cornerExtraSmallTop CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerFull READ cornerFull CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerLarge READ cornerLarge CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerLargeEnd READ cornerLargeEnd CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerLargeIncreased READ cornerLargeIncreased CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerLargeStart READ cornerLargeStart CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerLargeTop READ cornerLargeTop CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerMedium READ cornerMedium CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerNone READ cornerNone CONSTANT FINAL)
    Q_PROPERTY(Fluid::ShapeValue cornerSmall READ cornerSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueExtraExtraLarge READ cornerValueExtraExtraLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueExtraLarge READ cornerValueExtraLarge CONSTANT FINAL)
    Q_PROPERTY(
            qreal cornerValueExtraLargeIncreased READ cornerValueExtraLargeIncreased CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueExtraSmall READ cornerValueExtraSmall CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueFull READ cornerValueFull CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueLarge READ cornerValueLarge CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueLargeIncreased READ cornerValueLargeIncreased CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueMedium READ cornerValueMedium CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueNone READ cornerValueNone CONSTANT FINAL)
    Q_PROPERTY(qreal cornerValueSmall READ cornerValueSmall CONSTANT FINAL)

public:
    constexpr ShapeValue cornerExtraExtraLarge() const
    {
        return { m_cornerValueExtraExtraLarge, m_cornerValueExtraExtraLarge,
                 m_cornerValueExtraExtraLarge, m_cornerValueExtraExtraLarge };
    }
    constexpr ShapeValue cornerExtraLarge() const
    {
        return { m_cornerValueExtraLarge, m_cornerValueExtraLarge, m_cornerValueExtraLarge,
                 m_cornerValueExtraLarge };
    }
    constexpr ShapeValue cornerExtraLargeIncreased() const
    {
        return { m_cornerValueExtraLargeIncreased, m_cornerValueExtraLargeIncreased,
                 m_cornerValueExtraLargeIncreased, m_cornerValueExtraLargeIncreased };
    }
    constexpr ShapeValue cornerExtraLargeTop() const
    {
        return { m_cornerValueExtraLarge, m_cornerValueExtraLarge, m_cornerValueNone,
                 m_cornerValueNone };
    }
    constexpr ShapeValue cornerExtraSmall() const
    {
        return { m_cornerValueExtraSmall, m_cornerValueExtraSmall, m_cornerValueExtraSmall,
                 m_cornerValueExtraSmall };
    }
    constexpr ShapeValue cornerExtraSmallTop() const
    {
        return { m_cornerValueExtraSmall, m_cornerValueExtraSmall, m_cornerValueNone,
                 m_cornerValueNone };
    }

    // AndroidX uses CircleShape. 9999 is a radius sentinel that remains circular after sizing.
    constexpr ShapeValue cornerFull() const
    {
        return { m_cornerValueFull, m_cornerValueFull, m_cornerValueFull, m_cornerValueFull };
    }

    constexpr ShapeValue cornerLarge() const
    {
        return { m_cornerValueLarge, m_cornerValueLarge, m_cornerValueLarge, m_cornerValueLarge };
    }
    constexpr ShapeValue cornerLargeEnd() const
    {
        return { m_cornerValueNone, m_cornerValueLarge, m_cornerValueLarge, m_cornerValueNone };
    }
    constexpr ShapeValue cornerLargeIncreased() const
    {
        return { m_cornerValueLargeIncreased, m_cornerValueLargeIncreased,
                 m_cornerValueLargeIncreased, m_cornerValueLargeIncreased };
    }
    constexpr ShapeValue cornerLargeStart() const
    {
        return { m_cornerValueLarge, m_cornerValueNone, m_cornerValueNone, m_cornerValueLarge };
    }
    constexpr ShapeValue cornerLargeTop() const
    {
        return { m_cornerValueLarge, m_cornerValueLarge, m_cornerValueNone, m_cornerValueNone };
    }
    constexpr ShapeValue cornerMedium() const
    {
        return { m_cornerValueMedium, m_cornerValueMedium, m_cornerValueMedium,
                 m_cornerValueMedium };
    }
    constexpr ShapeValue cornerNone() const
    {
        return { m_cornerValueNone, m_cornerValueNone, m_cornerValueNone, m_cornerValueNone };
    }
    constexpr ShapeValue cornerSmall() const
    {
        return { m_cornerValueSmall, m_cornerValueSmall, m_cornerValueSmall, m_cornerValueSmall };
    }

    constexpr qreal cornerValueExtraExtraLarge() const
    {
        return m_cornerValueExtraExtraLarge;
    }
    constexpr qreal cornerValueExtraLarge() const
    {
        return m_cornerValueExtraLarge;
    }
    constexpr qreal cornerValueExtraLargeIncreased() const
    {
        return m_cornerValueExtraLargeIncreased;
    }
    constexpr qreal cornerValueExtraSmall() const
    {
        return m_cornerValueExtraSmall;
    }
    constexpr qreal cornerValueFull() const
    {
        return m_cornerValueFull;
    }
    constexpr qreal cornerValueLarge() const
    {
        return m_cornerValueLarge;
    }
    constexpr qreal cornerValueLargeIncreased() const
    {
        return m_cornerValueLargeIncreased;
    }
    constexpr qreal cornerValueMedium() const
    {
        return m_cornerValueMedium;
    }
    constexpr qreal cornerValueNone() const
    {
        return m_cornerValueNone;
    }
    constexpr qreal cornerValueSmall() const
    {
        return m_cornerValueSmall;
    }

private:
    static constexpr qreal m_cornerValueExtraExtraLarge = 48.0;
    static constexpr qreal m_cornerValueExtraLarge = 28.0;
    static constexpr qreal m_cornerValueExtraLargeIncreased = 32.0;
    static constexpr qreal m_cornerValueExtraSmall = 4.0;
    static constexpr qreal m_cornerValueFull = 9999.0;
    static constexpr qreal m_cornerValueLarge = 16.0;
    static constexpr qreal m_cornerValueLargeIncreased = 20.0;
    static constexpr qreal m_cornerValueMedium = 12.0;
    static constexpr qreal m_cornerValueNone = 0.0;
    static constexpr qreal m_cornerValueSmall = 8.0;
};

} // namespace Fluid
