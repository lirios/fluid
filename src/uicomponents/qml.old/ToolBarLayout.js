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

/// Helper code that is needed by ToolBarLayout.

var connectedItems = [];

// Find item in an array
function contains(container, obj) {
  for (var i = 0 ; i < container.length; i++) {
    if (container[i] == obj)
        return true;
  }
  return false
}

// Remove item from an array
function remove(container, obj)
{
    for (var i = 0 ; i < container.length ; i++ )
        if (container[i] == obj)
            container.splice(i,1);
}

// Helper function to give us the sender id on slots
// This is needed to remove connectens on a reparent
Function.prototype.bind = function() {
    var func = this;
    var thisObject = arguments[0];
    var args = Array.prototype.slice.call(arguments, 1);
    return function() {
        return func.apply(thisObject, args);
    }
}

// Called whenever a child is added or removed in the toolbar
function childrenChanged() {
    for (var i = 0; i < children.length; i++) {
        if (!contains(connectedItems, children[i])) {
            connectedItems.push(children[i]);
            children[i].visibleChanged.connect(layout);
            children[i].parentChanged.connect(cleanup.bind(children[i]));
        }
    }
}

// Disconnects signals connected by this layout
function cleanup() {
    remove(connectedItems, this);
    this.visibleChanged.disconnect(layout);
    this.parentChanged.disconnect(arguments.callee);
}

// Main layout function
function layout() {

    if (parent === null || width === 0 || children === undefined)
        return;

    var i;
    var items = new Array();          // Keep track of visible items
    var expandingItems = new Array(); // Keep track of expandingItems for tabs
    var widthOthers = 0;

    for (i = 0; i < children.length; i++) {
        var child = children[i];

        if (child.visible) {
            // Center all items vertically
            child.anchors.verticalCenter = verticalCenter;

            // Find out which items are expanding
            if (child.__expanding) {
                expandingItems.push(child)
            } else {
                // Calculate the space that fixed size items take
                widthOthers += child.width;
            }

            items.push(child);
        }
    }

    if (items.length === 0)
        return;

    // Extra padding is applied if the leftMost or rightmost widget is expanding (note** removed on new design)
    var leftPadding = 0
    var rightPadding = 0 

    // In LandScape mode we add extra margin to keep contents centered
    // for two basic cases
    if (items.length == 2 && screen.currentOrientation == Screen.Landscape) {
        // expanding item on left
        if (expandingItems.length > 0 && items[0].__expanding && !items[items.length-1].__expanding)
            leftPadding += items[items.length-1].width

        // expanding item is on right
        if (expandingItems.length > 0 && items[items.length-1].__expanding && !items[0].__expanding)
            rightPadding += items[0].width
    }

    var width = toolbarLayout.width - leftPadding - rightPadding

    // Calc expandingItems and tabrows
    for (i = 0; i < expandingItems.length; i++)
        expandingItems[i].width = (width - widthOthers) / expandingItems.length

    var lastItem = items[items.length-1] ? items[items.length-1] : undefined;

    // Space to be divided between first and last items
    var toolBox = width - (items[0] ? items[0].width : 0) -
        (lastItem ? lastItem.width : 0);

    // |X  X  X| etc.
    var spacingBetween = toolBox;
    for (i = 1; i < items.length - 1; i++)
        spacingBetween -= items[i].width;
    items[0].x = leftPadding

    // Calculate spacing between items
    spacingBetween /= items.length - 1;

    // Starting after first item
    var dX = items[0].width + spacingBetween;
    for (i = 1; i < items.length; i++) {
        items[i].x = dX + leftPadding;
        dX += spacingBetween + items[i].width;
    }
}

