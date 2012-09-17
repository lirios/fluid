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

#ifndef RANGEMODEL_P_H
#define RANGEMODEL_P_H

//
//  W A R N I N G
//  -------------
//
// This file is not part of the Qt Components API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.
//

#include "rangemodel.h"

namespace FluidUi
{
    class RangeModelPrivate
    {
        Q_DECLARE_PUBLIC(RangeModel)
    public:
        RangeModelPrivate(RangeModel *qq);
        virtual ~RangeModelPrivate();

        void init();

        qreal posatmin, posatmax;
        qreal minimum, maximum, stepSize, pos, value;

        uint inverted : 1;

        RangeModel *q_ptr;

        inline qreal effectivePosAtMin() const {
            return inverted ? posatmax : posatmin;
        }

        inline qreal effectivePosAtMax() const {
            return inverted ? posatmin : posatmax;
        }

        inline qreal equivalentPosition(qreal value) const {
            // Return absolute position from absolute value
            const qreal valueRange = maximum - minimum;
            if (valueRange == 0)
                return effectivePosAtMin();

            const qreal scale = (effectivePosAtMax() - effectivePosAtMin()) / valueRange;
            return (value - minimum) * scale + effectivePosAtMin();
        }

        inline qreal equivalentValue(qreal pos) const {
            // Return absolute value from absolute position
            const qreal posRange = effectivePosAtMax() - effectivePosAtMin();
            if (posRange == 0)
                return minimum;

            const qreal scale = (maximum - minimum) / posRange;
            return (pos - effectivePosAtMin()) * scale + minimum;
        }

        qreal publicPosition(qreal position) const;
        qreal publicValue(qreal value) const;
        void emitValueAndPositionIfChanged(const qreal oldValue, const qreal oldPosition);
    };
}

#endif // RANGEMODEL_P_H
