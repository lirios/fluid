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
Qt.include('Utils.js');

function animateContentY(animation, flickable, newContentY) {
    animation.target = flickable
    animation.to = newContentY
    animation.running = true
}

function locateFlickableY(flickable) {
    switch(screen.currentOrientation) {
    case Screen.Landscape:
        return flickable.mapToItem(null, flickable.x, flickable.y).y

    case Screen.LandscapeInverted:
        return screen.displayHeight - flickable.mapToItem(null, flickable.x, flickable.y).y

    case Screen.Portrait:
        return flickable.mapToItem(null, flickable.x, flickable.y).x

    case Screen.PortraitInverted:
        return screen.displayWidth - flickable.mapToItem(null, flickable.x, flickable.y).x
    }
}

function getMargin() {
    switch(screen.currentOrientation) {
    case Screen.Landscape:
    case Screen.LandscapeInverted:
        return 40
    case Screen.Portrait:
    case Screen.PortraitInverted:
        return 48
    }

    return 0
}

function repositionFlickable(animation) {
    var flickable = Utils.findFlickable(parent)

    inputContext.updateMicroFocus()

    if(flickable) {
        // Specifies area from bottom and top when repositioning should be triggered
        var margin = getMargin()
        var newContentY = flickable.contentY
        var flickableY = locateFlickableY(flickable)

        var mf = inputContext.microFocus

        if(mf.x == -1 && mf.y == -1) {
            /* This is to calculate read-only text area/field positions as
            they're not handled by micro-focus. */
            var window = findRootItem(root, 'contentArea');
            var vf = window.mapFromItem(root, 0, 0);

            mf = {x: vf.x, y: vf.y, width: root.width, height: root.height};

            if(screen.currentOrientation == Screen.Landscape) {
                mf.y += root.height / 2;
            } else if(screen.currentOrientation == Screen.Portrait) {
                mf.x += root.height / 2;
            }

            // Probably never happens, but should stop regressions if it does.
            if (!root.readOnly) return;
        }

        switch(screen.currentOrientation) {
        case Screen.Landscape:
            if(flickableY + flickable.height  - mf.height - margin < mf.y) {
                // Find dY just to make textfield visible
                var dY = mf.y - flickableY - flickable.height
                // Center textfield
                dY += flickable.height / 2
                newContentY += dY
            } else if(flickableY + margin > mf.y) {
                var dY = flickableY - mf.y
                dY += flickable.height / 2
                newContentY -= dY
            }

            break

        case Screen.LandscapeInverted:
            // In inverted screen we need to compensate for the focus height
            var invertedMfY = screen.displayHeight - mf.y - mf.height

            if(flickableY + flickable.height - mf.height - margin < invertedMfY) {
                var dY = invertedMfY - flickableY - flickable.height
                dY += flickable.height / 2 + mf.height / 2
            } else if(flickableY + margin > invertedMfY){
                var dY = flickableY - invertedMfY
                dY += flickable.height / 2 - mf.height / 2
                newContentY -= dY
            }

            break

        case Screen.Portrait:
            if(flickableY + flickable.height - mf.width - margin < mf.x) {
                var dY = mf.x - flickableY - flickable.height
                dY += flickable.height / 2
                newContentY += dY
            } else if(flickableY + margin > mf.x){
                var dY = flickableY - mf.x
                dY += flickable.height / 2
                newContentY -= dY
            }

            break

        case Screen.PortraitInverted:
            var invertedMfX = screen.displayWidth - mf.x - mf.width

            if(flickableY + flickable.height - mf.width - margin < invertedMfX) {
                var dY = invertedMfX - flickableY - flickable.height + mf.height
                dY += flickable.height / 2 + mf.height
                newContentY += dY
            } else if(flickableY + margin > invertedMfX){
                var dY = flickableY - invertedMfX
                dY += flickable.height / 2 - mf.height
                newContentY -= dY
            }

            break
        }

        // If overpanned, set contentY to max possible value (reached bottom)
        // Leave some additional space for the selection handles.
        if(newContentY > flickable.contentHeight + 40 - flickable.height)
            newContentY = flickable.contentHeight + 40 - flickable.height

        // If overpanned, set contentY to min possible value (reached top)
        if(newContentY < 0)
            newContentY = 0

        if(newContentY != flickable.contentY) {
            animateContentY(animation, flickable, newContentY)
        }
    }
}

function injectWordToPreedit(newCursorPosition, text) {
    var preeditStart = previousWordStart(newCursorPosition, text);
    var preeditEnd = nextWordEnd(newCursorPosition, text);

    // copy word to preedit text
    var preeditText = text.substring(preeditStart,preeditEnd);

    // inject preedit
    cursorPosition = preeditStart;

    var eventCursorPosition = newCursorPosition-preeditStart;

    return inputContext.setPreeditText(preeditText, eventCursorPosition, 0, preeditText.length);
}

function previousWordStart(pos, text) {
    var ret = pos;

    if (ret && atWordSeparator(ret - 1, text)) {
        ret--;
        while (ret && atWordSeparator(ret - 1, text))
            ret--;
    } else {
        while (ret && !atSpace(ret - 1, text) && !atWordSeparator(ret - 1, text))
            ret--;
    }

    return ret;
}

function nextWordEnd(pos, text) {
    var ret = pos;
    var len = text.length;

    if (ret < len && atWordSeparator(ret, text)) {
        ret++;
        while (ret < len && atWordSeparator(ret, text))
            ret++;
    } else {
        while (ret < len && !atSpace(ret, text) && !atWordSeparator(ret, text))
            ret++;
    }

    return ret;
}

function atSpace(pos, text) {
    var c = (text !== undefined) ? text.charAt(pos) : root.text.charAt(pos);
    return c == ' '
           || c == '\t'
           || c == '\n'
           ;
}

function atWordSeparator(pos, text) {
    switch (text.charAt(pos)) {
    case '.':
    case ',':
    case '?':
    case '!':
    case '@':
    case '#':
    case '$':
    case ':':
    case ';':
    case '-':
    case '<':
    case '>':
    case '[':
    case ']':
    case '(':
    case ')':
    case '{':
    case '}':
    case '=':
    case '/':
    case '+':
    case '%':
    case '&':
    case '^':
    case '*':
    case '\'':
    case '"':
    case '`':
    case '~':
    case '|':
        return true;
    default:
        return false;
    }
}

var MIN_UPDATE_INTERVAL = 30
var lastUpdateTime
function filteredInputContextUpdate() {
    var date = Date.now();
    if (date - lastUpdateTime > MIN_UPDATE_INTERVAL || !lastUpdateTime) {
        inputContext.update();
        lastUpdateTime = date;
    }
}
