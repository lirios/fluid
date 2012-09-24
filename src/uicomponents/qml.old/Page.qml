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

// The Page item is intended for use as a root item in QML items that make
// up pages to use with the PageStack.

import QtQuick 2.0
import "." 1.0
import "UIConstants.js" as UI

Item {
    id: root

    visible: false

    // Note we do not use anchor fill here because it will force us to relayout
    // hidden children when rotating the screen as well
    width: visible && parent ? parent.width - anchors.leftMargin - anchors.rightMargin : __prevWidth
    height: visible && parent ? parent.height  - anchors.topMargin - anchors.bottomMargin : __prevHeight
    x: parent ? anchors.leftMargin : 0
    y: parent ? anchors.topMargin : 0

    onWidthChanged: __prevWidth = visible ? width : __prevWidth
    onHeightChanged: __prevHeight = visible ? height : __prevHeight

    property int __prevWidth: 0
    property int __prevHeight: 0

    property bool __isPage: true

    anchors.margins: 0 // Page margins should generally be 16 pixels as defined by UI.MARGIN_XLARGE

    // The status of the page. One of the following:
    //      PageStatus.Inactive - the page is not visible
    //      PageStatus.Activating - the page is transitioning into becoming the active page
    //      PageStatus.Active - the page is the current active page
    //      PageStatus.Deactivating - the page is transitioning into becoming inactive
    property int status: PageStatus.Inactive
    
    // Defines the tools for the page; null for none.
    property Item tools: null
    
    // The page stack that the page is in.
    property PageStack pageStack

    // Defines if page is locked in landscape.
    property bool lockInLandscape: false // Deprecated
    onLockInLandscapeChanged: console.log("warning: Page.lockInLandscape is deprecated, use Page.orientationLock")

    // Defines if page is locked in portrait.
    property bool lockInPortrait: false // Deprecated
    onLockInPortraitChanged: console.log("warning: Page.lockInPortrait is deprecated, use Page.orientationLock")

    // Defines orientation lock for a page
    property int orientationLock: PageOrientation.Automatic

    onStatusChanged: {
        if (status == PageStatus.Activating) {
            __updateOrientationLock()
        }
    }

    onOrientationLockChanged: {
        __updateOrientationLock()
    }

    function __updateOrientationLock() {
        switch (orientationLock) {
        case PageOrientation.Automatic:
            screen.setAllowedOrientations(Screen.Portrait | Screen.Landscape);
            break
        case PageOrientation.LockPortrait:
            screen.setAllowedOrientations(Screen.Portrait);
            break
        case PageOrientation.LockLandscape:
            screen.setAllowedOrientations(Screen.Landscape);
            break
        case PageOrientation.LockPrevious:
            // Allowed orientation should be changed to current
            // if previously it was locked, it will remain locked
            // if previously it was not locked, it will be locked to current
            screen.setAllowedOrientations(screen.currentOrientation);
            break
        }
    }
}

