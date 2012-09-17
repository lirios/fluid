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

.pragma library

Qt.include("Utils.js");
Qt.include("UIConstants.js");

var popup = null;

function init(item)
{
    if (popup != null)
        return true;

    var root = findRootItem(item);

    // create root popup
    var component = Qt.createComponent("SelectionHandles.qml");

    // due the pragma we cannot access Component.Ready
    if (component)
        popup = component.createObject(root);

    return popup != null;
}

/*
  Open a shared edit selectionArea for a given input item.

  All operations and changes will be binded to the
  given item.
*/
function open(input)
{
    if (!input)
        return false;

    if (!init(input))
        return false;

    // need to set before checking capabilities
    popup.textInput = input;

    popup.state = "opened";

    return popup.textInput != null;
}

/*
  Close the shared edit selectionArea for a given input item.
*/
function close(input)
{
    if (!popup || !input || popup.textInput != input)
        return false;

    if ( popup.privateIgnoreClose )
        return false;

    return closePopup(popup);
}

/*
  Check if the shared edit selectionArea is opened for the
  given input item.
*/
function isOpened(input)
{
    return (popup && popup.textInput == input);
}

/*
  Close a given selectionArea.
*/
function closePopup(selectionArea)
{
    if (selectionArea == null || selectionArea.textInput == null)
        return false;

    selectionArea.state = "closed";
    selectionArea.textInput = null;
    return true;
}

/*
  Check whether a given point is located inside the area of the left selection handle.
*/
function leftHandleContains( hitPoint )
{
    if (popup == null)
        return;

    if (    hitPoint.x > popup.leftSelectionHandle.pos.x
         && hitPoint.x < popup.leftSelectionHandle.pos.x + popup.leftSelectionHandle.width
         && hitPoint.y > popup.leftSelectionHandle.pos.y
         && hitPoint.y < popup.leftSelectionHandle.pos.y + popup.leftSelectionHandle.height )
         return true;
    return false;
}
/*
  Return the geometry of the left selection handle as a rectangle.
*/
function leftHandleRect()
{
    if (popup == null)
        return;

    var handle = popup.leftSelectionHandle;
    var rect = {"left": handle.pos.x,
        "right": handle.pos.x + handle.width,
        "top": handle.pos.y,
        "bottom": handle.pos.y + handle.height};

    return rect;
}

/*
  Check whether a given point is located inside the area of the right selection handle.
*/
function rightHandleContains( hitPoint )
{
    if (popup == null)
        return;

    if (    hitPoint.x > popup.rightSelectionHandle.pos.x
         && hitPoint.x < popup.rightSelectionHandle.pos.x + popup.rightSelectionHandle.width
         && hitPoint.y > popup.rightSelectionHandle.pos.y
         && hitPoint.y < popup.rightSelectionHandle.pos.y + popup.rightSelectionHandle.height )
         return true;
    return false;
}
/*
  Return the geometry of the right selection handle as a rectangle.
*/
function rightHandleRect()
{
    if (popup == null)
        return;

    var handle = popup.rightSelectionHandle;
    var rect = {"left": handle.pos.x,
        "right": handle.pos.x + handle.width,
        "top": handle.pos.y,
        "bottom": handle.pos.y + handle.height};

    return rect;
}

/*
  Adjust SelectionHandles position to fit into the visible area.
*/
function adjustPosition(handles)
{
    if (handles === undefined)
        handles = popup;

    if (handles == null)
        return;

    if (handles.textInput == null) return;

    var input = handles.textInput;

    var rect = handles.privateRect;
    var viewport = rect.parent;

    if (viewport == null || input == null)
        return;

    var selectionStartRect = input.positionToRectangle( input.selectionStart );
    var selectionEndRect = input.positionToRectangle( input.selectionEnd );

    handles.selectionStartPoint = viewport.mapFromItem( input, selectionStartRect.x, selectionStartRect.y );
    handles.selectionEndPoint = viewport.mapFromItem( input, selectionEndRect.x, selectionEndRect.y )
}

function handlesIntersectWith(rect){
    if ( rect == undefined ) return undefined;
    return ( intersects(rect, leftHandleRect()) || intersects(rect, rightHandleRect()) )
}
