/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

/*!
    \class RangeModel
    \brief The RangeModel class, helps users to build components that depend
           on some value and/or position to be in a certain range previously defined

    With this class, the user sets a value range and a position range, which
    represent the valid values/positions the model can assume. It is worth telling
    that the value property always has priority over the position property. A nice use
    case, would be a Slider implementation with the help of RangeModel. If the user sets
    a value range to [0,100], a position range to [50,100] and sets the value
    to 80, the equivalent position would be 90. After that, if the user decides to
    resize the slider, the value would be the same, but the knob position would
    be updated due to the new position range.

    \ingroup uicomponents
*/

#include <QEvent>

#ifndef QT_NO_ACCESSIBILITY
#include <QAccessible>
#endif

#include "rangemodel.h"
#include "rangemodel_p.h"

namespace FluidUi
{
    RangeModelPrivate::RangeModelPrivate(RangeModel *qq)
        : q_ptr(qq)
    {
    }

    RangeModelPrivate::~RangeModelPrivate()
    {
    }

    void RangeModelPrivate::init()
    {
        minimum = 0;
        maximum = 99;
        stepSize = 0;
        value = 0;
        pos = 0;
        posatmin = 0;
        posatmax = 0;
        inverted = false;
    }

    /*!
        Calculates the position that is going to be seen outside by the component
        that is using RangeModel. It takes into account the \l stepSize,
        \l positionAtMinimum, \l positionAtMaximum properties
        and \a position that is passed as parameter.
    */

    qreal RangeModelPrivate::publicPosition(qreal position) const
    {
        // Calculate the equivalent stepSize for the position property.
        const qreal min = effectivePosAtMin();
        const qreal max = effectivePosAtMax();
        const qreal valueRange = maximum - minimum;
        const qreal positionValueRatio = valueRange ? (max - min) / valueRange : 0;
        const qreal positionStep = stepSize * positionValueRatio;

        if (positionStep == 0)
            return (min < max) ? qBound(min, position, max) : qBound(max, position, min);

        const int stepSizeMultiplier = (position - min) / positionStep;

        // Test whether value is below minimum range
        if (stepSizeMultiplier < 0)
            return min;

        qreal leftEdge = (stepSizeMultiplier * positionStep) + min;
        qreal rightEdge = ((stepSizeMultiplier + 1) * positionStep) + min;

        if (min < max) {
            leftEdge = qMin(leftEdge, max);
            rightEdge = qMin(rightEdge, max);
        } else {
            leftEdge = qMax(leftEdge, max);
            rightEdge = qMax(rightEdge, max);
        }

        if (qAbs(leftEdge - position) <= qAbs(rightEdge - position))
            return leftEdge;
        return rightEdge;
    }

    /*!
        Calculates the value that is going to be seen outside by the component
        that is using RangeModel. It takes into account the \l stepSize,
        \l minimumValue, \l maximumValue properties
        and \a value that is passed as parameter.
    */

    qreal RangeModelPrivate::publicValue(qreal value) const
    {
        // It is important to do value-within-range check this
        // late (as opposed to during setPosition()). The reason is
        // QML bindings; a position that is initially invalid because it lays
        // outside the range, might become valid later if the range changes.

        if (stepSize == 0)
            return qBound(minimum, value, maximum);

        const int stepSizeMultiplier = (value - minimum) / stepSize;

        // Test whether value is below minimum range
        if (stepSizeMultiplier < 0)
            return minimum;

        const qreal leftEdge = qMin(maximum, (stepSizeMultiplier * stepSize) + minimum);
        const qreal rightEdge = qMin(maximum, ((stepSizeMultiplier + 1) * stepSize) + minimum);
        const qreal middle = (leftEdge + rightEdge) / 2;

        return (value <= middle) ? leftEdge : rightEdge;
    }

    /*!
        Checks if the \l value or \l position, that is seen by the user, has changed and emits the changed signal if it
        has changed.
    */

    void RangeModelPrivate::emitValueAndPositionIfChanged(const qreal oldValue, const qreal oldPosition)
    {
        Q_Q(RangeModel);

        // Effective value and position might have changed even in cases when e.g. d->value is
        // unchanged. This will be the case when operating with values outside range:
        const qreal newValue = q->value();
        const qreal newPosition = q->position();
        if (!qFuzzyCompare(newValue, oldValue))
            emit q->valueChanged(newValue);
        if (!qFuzzyCompare(newPosition, oldPosition))
            emit q->positionChanged(newPosition);
    }

    /*!
        Constructs a RangeModel with \a parent
    */

    RangeModel::RangeModel(QObject *parent)
        : QObject(parent), d_ptr(new RangeModelPrivate(this))
    {
        Q_D(RangeModel);
        d->init();
    }

    /*!
        \internal
        Constructs a RangeModel with private class pointer \a dd and \a parent
    */

    RangeModel::RangeModel(RangeModelPrivate &dd, QObject *parent)
        : QObject(parent), d_ptr(&dd)
    {
        Q_D(RangeModel);
        d->init();
    }

    /*!
        Destroys the RangeModel
    */

    RangeModel::~RangeModel()
    {
        delete d_ptr;
        d_ptr = 0;
    }

    /*!
        Sets the range of valid positions, that \l position can assume externally, with
        \a min and \a max.
        Such range is represented by \l positionAtMinimum and \l positionAtMaximum
    */

    void RangeModel::setPositionRange(qreal min, qreal max)
    {
        Q_D(RangeModel);

        bool emitPosAtMinChanged = !qFuzzyCompare(min, d->posatmin);
        bool emitPosAtMaxChanged = !qFuzzyCompare(max, d->posatmax);

        if (!(emitPosAtMinChanged || emitPosAtMaxChanged))
            return;

        const qreal oldPosition = position();
        d->posatmin = min;
        d->posatmax = max;

        // When a new positionRange is defined, the position property must be updated based on the value property.
        // For instance, imagine that you have a valueRange of [0,100] and a position range of [20,100],
        // if a user set the value to 50, the position would be 60. If this positionRange is updated to [0,100], then
        // the new position, based on the value (50), will be 50.
        // If the newPosition is different than the old one, it must be updated, in order to emit
        // the positionChanged signal.
        d->pos = d->equivalentPosition(d->value);

        if (emitPosAtMinChanged)
            emit positionAtMinimumChanged(d->posatmin);
        if (emitPosAtMaxChanged)
            emit positionAtMaximumChanged(d->posatmax);

        d->emitValueAndPositionIfChanged(value(), oldPosition);
    }
    /*!
        Sets the range of valid values, that \l value can assume externally, with
        \a min and \a max. The range has the following constraint: \a min must be less or equal \a max
        Such range is represented by \l minimumValue and \l maximumValue
    */

    void RangeModel::setRange(qreal min, qreal max)
    {
        Q_D(RangeModel);

        bool emitMinimumChanged = !qFuzzyCompare(min, d->minimum);
        bool emitMaximumChanged = !qFuzzyCompare(max, d->maximum);

        if (!(emitMinimumChanged || emitMaximumChanged))
            return;

        const qreal oldValue = value();
        const qreal oldPosition = position();

        d->minimum = min;
        d->maximum = qMax(min, max);

        // Update internal position if it was changed. It can occurs if internal value changes, due to range update
        d->pos = d->equivalentPosition(d->value);

        if (emitMinimumChanged)
            emit minimumChanged(d->minimum);
        if (emitMaximumChanged)
            emit maximumChanged(d->maximum);

        d->emitValueAndPositionIfChanged(oldValue, oldPosition);
    }

    /*!
        \property RangeModel::minimumValue
        \brief the minimum value that \l value can assume

        This property's default value is 0
    */

    void RangeModel::setMinimum(qreal min)
    {
        Q_D(const RangeModel);
        setRange(min, d->maximum);
    }

    qreal RangeModel::minimum() const
    {
        Q_D(const RangeModel);
        return d->minimum;
    }

    /*!
        \property RangeModel::maximumValue
        \brief the maximum value that \l value can assume

        This property's default value is 99
    */

    void RangeModel::setMaximum(qreal max)
    {
        Q_D(const RangeModel);
        // if the new maximum value is smaller than
        // minimum, update minimum too
        setRange(qMin(d->minimum, max), max);
    }

    qreal RangeModel::maximum() const
    {
        Q_D(const RangeModel);
        return d->maximum;
    }

    /*!
        \property RangeModel::stepSize
        \brief the value that is added to the \l value and \l position property

        Example: If a user sets a range of [0,100] and stepSize
        to 30, the valid values that are going to be seen externally would be: 0, 30, 60, 90, 100.
    */

    void RangeModel::setStepSize(qreal stepSize)
    {
        Q_D(RangeModel);

        stepSize = qMax(qreal(0.0), stepSize);
        if (qFuzzyCompare(stepSize, d->stepSize))
            return;

        const qreal oldValue = value();
        const qreal oldPosition = position();
        d->stepSize = stepSize;

        emit stepSizeChanged(d->stepSize);
        d->emitValueAndPositionIfChanged(oldValue, oldPosition);
    }

    qreal RangeModel::stepSize() const
    {
        Q_D(const RangeModel);
        return d->stepSize;
    }

    /*!
        Returns a valid position, respecting the \l positionAtMinimum,
        \l positionAtMaximum and the \l stepSize properties.
        Such calculation is based on the parameter \a value (which is valid externally).
    */

    qreal RangeModel::positionForValue(qreal value) const
    {
        Q_D(const RangeModel);

        const qreal unconstrainedPosition = d->equivalentPosition(value);
        return d->publicPosition(unconstrainedPosition);
    }

    /*!
        \property RangeModel::position
        \brief the current position of the model

        Represents a valid external position, based on the \l positionAtMinimum,
        \l positionAtMaximum and the \l stepSize properties.
        The user can set it internally with a position, that is not within the current position range,
        since it can become valid if the user changes the position range later.
    */

    qreal RangeModel::position() const
    {
        Q_D(const RangeModel);

        // Return the internal position but observe boundaries and
        // stepSize restrictions.
        return d->publicPosition(d->pos);
    }

    void RangeModel::setPosition(qreal newPosition)
    {
        Q_D(RangeModel);

        if (qFuzzyCompare(newPosition, d->pos))
            return;

        const qreal oldPosition = position();
        const qreal oldValue = value();

        // Update position and calculate new value
        d->pos = newPosition;
        d->value = d->equivalentValue(d->pos);
        d->emitValueAndPositionIfChanged(oldValue, oldPosition);
    }

    /*!
        \property RangeModel::positionAtMinimum
        \brief the minimum value that \l position can assume

        This property's default value is 0
    */

    void RangeModel::setPositionAtMinimum(qreal min)
    {
        Q_D(RangeModel);
        setPositionRange(min, d->posatmax);
    }

    qreal RangeModel::positionAtMinimum() const
    {
        Q_D(const RangeModel);
        return d->posatmin;
    }

    /*!
        \property RangeModel::positionAtMaximum
        \brief the maximum value that \l position can assume

        This property's default value is 0
    */

    void RangeModel::setPositionAtMaximum(qreal max)
    {
        Q_D(RangeModel);
        setPositionRange(d->posatmin, max);
    }

    qreal RangeModel::positionAtMaximum() const
    {
        Q_D(const RangeModel);
        return d->posatmax;
    }

    /*!
        Returns a valid value, respecting the \l minimumValue,
        \l maximumValue and the \l stepSize properties.
        Such calculation is based on the parameter \a position (which is valid externally).
    */

    qreal RangeModel::valueForPosition(qreal position) const
    {
        Q_D(const RangeModel);

        const qreal unconstrainedValue = d->equivalentValue(position);
        return d->publicValue(unconstrainedValue);
    }

    /*!
        \property RangeModel::value
        \brief the current value of the model

        Represents a valid external value, based on the \l minimumValue,
        \l maximumValue and the \l stepSize properties.
        The user can set it internally with a value, that is not within the current range,
        since it can become valid if the user changes the range later.
    */

    qreal RangeModel::value() const
    {
        Q_D(const RangeModel);

        // Return internal value but observe boundaries and
        // stepSize restrictions
        return d->publicValue(d->value);
    }

    void RangeModel::setValue(qreal newValue)
    {
        Q_D(RangeModel);

        if (qFuzzyCompare(newValue, d->value))
            return;

        const qreal oldValue = value();
        const qreal oldPosition = position();

        // Update relative value and position
        d->value = newValue;
        d->pos = d->equivalentPosition(d->value);
        d->emitValueAndPositionIfChanged(oldValue, oldPosition);
    }

    /*!
        \property RangeModel::inverted
        \brief the model is inverted or not

        The model can be represented with an inverted behavior, e.g. when \l value assumes
        the maximum value (represented by \l maximumValue) the \l position will be at its
        minimum (represented by \l positionAtMinimum).
    */

    void RangeModel::setInverted(bool inverted)
    {
        Q_D(RangeModel);
        if (inverted == d->inverted)
            return;

        d->inverted = inverted;
        emit invertedChanged(d->inverted);

        // After updating the internal value, the position property can change.
        setPosition(d->equivalentPosition(d->value));
    }

    bool RangeModel::inverted() const
    {
        Q_D(const RangeModel);
        return d->inverted;
    }

    /*!
        Sets the \l value to \l minimumValue.
    */

    void RangeModel::toMinimum()
    {
        Q_D(const RangeModel);
        setValue(d->minimum);
    }

    /*!
        Sets the \l value to \l maximumValue.
    */

    void RangeModel::toMaximum()
    {
        Q_D(const RangeModel);
        setValue(d->maximum);
    }
}
