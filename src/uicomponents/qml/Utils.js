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

/*
  Get the first flickable in hierarchy.
*/
function findFlickable(item)
{
    var next = item;

    while (next) {
        if (next.flicking !== undefined && next.flickableDirection !== undefined)
            return next;

        next = next.parent;
    }

    return null;
}

/*
  Get the root item given an element and root item's name.
  If root item name is not given, default is 'windowContent'.
*/
function findRootItem(item, objectName)
{
    var next = item;
    
    var rootItemName = "windowContent";
    if (typeof(objectName) != 'undefined') {
        rootItemName = objectName;
    }

    if (next) {
        while (next.parent) {
            next = next.parent;

            if (rootItemName == next.objectName) {
                break;
            }
        }
    }

    return next;
}

/*
  Get the root item for Notification banner
  It will return 'appWindowContent' or 'windowContent' element if found.
*/
function findRootItemNotificationBanner(item)
{
    var next = item;

    if (next) {
        while (next.parent) {
            if (next.objectName == "appWindowContent")
                break;

            if (next.objectName == "windowContent")
                break;

            next = next.parent;
        }
    }

    return next;
}

/*
  Get the height that is actually covered by the statusbar (0 if the statusbar is not shown.
*/
function statusBarCoveredHeight(item) {
    var pageStackWindow = findRootItem(item, "pageStackWindow");
    if ( pageStackWindow.objectName == "pageStackWindow" && pageStackWindow.__statusBarHeight != undefined )
        return pageStackWindow.__statusBarHeight;
    return 0
}

/*
  Get the height that is actually covered by the statusbar (0 if the statusbar is not shown.
*/
function toolBarCoveredHeight(item) {
    var pageStackWindow = findRootItem(item, "pageStackWindow");
    if ( pageStackWindow.objectName == "pageStackWindow" && pageStackWindow.showToolBar)
        return pageStackWindow.platformToolBarHeight
    return 0
}

function intersects(rect1, rect2) {
    return (rect1.left <= rect2.right && rect2.left <= rect1.right &&
            rect1.top <= rect2.bottom && rect2.top <= rect1.bottom)
}
