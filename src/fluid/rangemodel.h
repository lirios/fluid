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

#ifndef RANGEMODEL_H
#define RANGEMODEL_H

#include <QObject>
#include <QtQml/qqml.h>

#include <Fluid/FluidExport>

namespace Fluid
{
    class RangeModelPrivate;

    class FLUID_EXPORT RangeModel : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged USER true)
        Q_PROPERTY(qreal minimumValue READ minimum WRITE setMinimum NOTIFY minimumChanged)
        Q_PROPERTY(qreal maximumValue READ maximum WRITE setMaximum NOTIFY maximumChanged)
        Q_PROPERTY(qreal stepSize READ stepSize WRITE setStepSize NOTIFY stepSizeChanged)
        Q_PROPERTY(qreal position READ position WRITE setPosition NOTIFY positionChanged)
        Q_PROPERTY(qreal positionAtMinimum READ positionAtMinimum WRITE setPositionAtMinimum NOTIFY positionAtMinimumChanged)
        Q_PROPERTY(qreal positionAtMaximum READ positionAtMaximum WRITE setPositionAtMaximum NOTIFY positionAtMaximumChanged)
        Q_PROPERTY(bool inverted READ inverted WRITE setInverted NOTIFY invertedChanged)

    public:
        RangeModel(QObject *parent = 0);
        virtual ~RangeModel();

        void setRange(qreal min, qreal max);
        void setPositionRange(qreal min, qreal max);

        void setStepSize(qreal stepSize);
        qreal stepSize() const;

        void setMinimum(qreal min);
        qreal minimum() const;

        void setMaximum(qreal max);
        qreal maximum() const;

        void setPositionAtMinimum(qreal posAtMin);
        qreal positionAtMinimum() const;

        void setPositionAtMaximum(qreal posAtMax);
        qreal positionAtMaximum() const;

        void setInverted(bool inverted);
        bool inverted() const;

        qreal value() const;
        qreal position() const;

        Q_INVOKABLE qreal valueForPosition(qreal position) const;
        Q_INVOKABLE qreal positionForValue(qreal value) const;

    public Q_SLOTS:
        void toMinimum();
        void toMaximum();
        void setValue(qreal value);
        void setPosition(qreal position);

    Q_SIGNALS:
        void valueChanged(qreal value);
        void positionChanged(qreal position);

        void stepSizeChanged(qreal stepSize);

        void invertedChanged(bool inverted);

        void minimumChanged(qreal min);
        void maximumChanged(qreal max);
        void positionAtMinimumChanged(qreal min);
        void positionAtMaximumChanged(qreal max);

    protected:
        RangeModel(RangeModelPrivate &dd, QObject *parent);
        RangeModelPrivate *d_ptr;

    private:
        Q_DISABLE_COPY(RangeModel)
        Q_DECLARE_PRIVATE(RangeModel)

    };
}

QML_DECLARE_TYPE(Fluid::RangeModel)

#endif // RANGEMODEL_H
