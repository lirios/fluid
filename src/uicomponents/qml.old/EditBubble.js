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
    var component = Qt.createComponent("EditBubble.qml");

    // due the pragma we cannot access Component.Ready
    if (component)
        popup = component.createObject(root);

    return popup != null;
}

/*
  Open a shared edit bubble for a given input item.

  All operations and changes will be binded to the
  given item.
*/
function open(input,position)
{
    if (!input)
        return false;

    // don't create an EditBubble when no EditBubble is needed
    var canPaste = !input.readOnly && input.canPaste;
    var textSelected = input.selectedText !== "";
    var canCopy = textSelected && (input.echoMode === undefined || input.echoMode === 0 /* = TextInput.Normal */);
    var canCut = !input.readOnly && canCopy;

    if (!(canPaste || canCopy || canCut))
        return false;

    if (!init(input))
        return false;

    // Position when text not selected.
    popup.position = position;

    // need to set before checking capabilities
    popup.textInput = input;

    if (popup.valid) {
        popup.state = "opened";
        popup.privateRect.outOfView = false;
    }
    else
        popup.textInput = null;

    return popup.textInput != null;
}

/*
  Close the shared edit bubble for a given input item.
*/
function close(input)
{
    if (!popup || !input || popup.textInput != input)
        return false;

    return closePopup(popup);
}

/*
  Check if the shared edit bubble is opened for the
  given input item.
*/
function isOpened(input)
{
    return (popup && popup.textInput == input);
}

/*
  Check if the bubble is in the middle of a text
  change operation.
*/
function isChangingInput()
{
    return (popup && popup.privateRect.changingText);
}

/*
  Close a given edit bubble.
*/
function closePopup(bubble)
{
    if (bubble == null || bubble.textInput == null)
        return false;

    bubble.state = "closed";
    bubble.textInput = null;
    return true;
}

/*
  Adjust EditBubble position to fit in the visible area.

  If no argument is passed, it will adjust the shared
  bubble position if already initialized.
*/
function adjustPosition(bubble)
{
    if (bubble === undefined)
        bubble = popup;

    if (bubble == null)
        return;

    var input = bubble.textInput;
    var rect = bubble.privateRect;
    var viewport = rect.parent;

    if (viewport == null || input == null)
        return;

    var irect = input.positionToRectangle(input.selectionStart);
    var frect = input.positionToRectangle(input.selectionEnd);
    var mid = rect.width / 2;

    if (input.selectionStart == input.selectionEnd) {
        irect.x = popup.position.x;
        irect.y = popup.position.y;
        frect.x = popup.position.x;
        frect.y = popup.position.y;
   }

    var ipoint = viewport.mapFromItem(input, irect.x, irect.y);
    var fpoint = viewport.mapFromItem(input, frect.x, frect.y);

    var px = ipoint.x + (fpoint.x - ipoint.x) / 2 - mid;
    var py = ipoint.y - rect.height;

    var SHADOW_SIZE = 6

    rect.x = Math.min(Math.max(px, MARGIN_XLARGE - SHADOW_SIZE), viewport.width - rect.width);

    if (py > SHADOW_SIZE + statusBarCoveredHeight(bubble)) {
        rect.y = py - SHADOW_SIZE;
        rect.arrowDown = true;
    } else {
        if (rect.positionOffset == 0) {
            rect.y = Math.min(Math.max(ipoint.y + irect.height, 0),
                              fpoint.y + frect.height);
        }
        else {
            rect.y = Math.max(ipoint.y + irect.height, fpoint.y + frect.height) + rect.positionOffset;
        }
        rect.arrowDown = false;
    }

    var boundX = mid - rect.arrowBorder;
    rect.arrowOffset = Math.min(Math.max(-boundX, px - rect.x), boundX);
}
function enableOffset(enabled){
    if (popup == null)
        return;
    popup.privateRect.positionOffset = enabled ? 40 : 0;
}

function offsetEnabled(){
    if (popup == null)
        return false;
    return popup.privateRect.positionOffset != 0;
}

function updateButtons(row)
{
    var children = row.children;
    var visibleItems = new Array();

    for (var i = 0, j = 0; i < children.length; i++) {
        var child = children[i];

        if (child.visible)
            visibleItems[j++] = child;
    }

    for (var i = 0; i < visibleItems.length; i++) {
        if (visibleItems.length == 1)
            visibleItems[i].platformStyle.position = "";
        else {
            if (i == 0)
                visibleItems[i].platformStyle.position = "horizontal-left";
            else if (i == visibleItems.length - 1)
                visibleItems[i].platformStyle.position = "horizontal-right";
            else
                visibleItems[i].platformStyle.position = "horizontal-center";
        }
    }
}

function geometry()
{
    if (popup == null)
      return;

    var bubbleContent = popup.privateRect;
    var rect = {"left": bubbleContent.pos.x,
        "right": bubbleContent.pos.x + bubbleContent.width,
        "top": bubbleContent.pos.y,
        "bottom": bubbleContent.pos.y + bubbleContent.height};

    return rect;
}

function hasPastingText()
{
    return (popup !== null && popup.privateRect.pastingText);
}

function clearPastingText()
{
    if (popup !== null && popup.privateRect.pastingText) {
        popup.privateRect.pastingText = false;
    }
}
