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

import QtQuick 2.0

Item {
    // relative (0..1) position of top and bottom
    property real positionRatio
    property real sizeRatio
    
    // max position and min size
    property real maxPosition
    property real minSize
    
    // size underflow
    property real sizeUnderflow: (sizeRatio * maxPosition) < minSize ? minSize - (sizeRatio * maxPosition) : 0
    
    // raw start and end position considering minimum size
    property real rawStartPos: positionRatio * (maxPosition - sizeUnderflow)
    property real rawEndPos: (positionRatio + sizeRatio) * (maxPosition - sizeUnderflow) + sizeUnderflow
    
    // overshoot amount at start and end
    property real overshootStart: rawStartPos < 0 ? -rawStartPos : 0
    property real overshootEnd: rawEndPos > maxPosition ? rawEndPos - maxPosition : 0
    
    // overshoot adjusted start and end
    property real adjStartPos: rawStartPos + overshootStart
    property real adjEndPos: rawEndPos - overshootStart - overshootEnd
    
    // final position and size of thumb
    property int position: 0.5 + (adjStartPos + minSize > maxPosition ? maxPosition - minSize : adjStartPos)
    property int size: 0.5 + ((adjEndPos - position) < minSize ? minSize : (adjEndPos - position))
}

