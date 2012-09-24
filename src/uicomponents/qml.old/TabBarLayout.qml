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
import "." 1.0

Item {
    id: root
    width: visible && parent ? parent.width : 0
    height: visible && parent ? parent.height : 0
    
    Component.onCompleted: {
        __layout()
        print("Warning, TabBarLayout has been deprecated from the API.")
        print("To fix your code, please use:")
        print("    tools: ToolBarLayout { ToolItem{} ButtonRow{TabButton{} ... } } instead.")
    }
    onChildrenChanged: __layout()
    onWidthChanged: __layout()
    onHeightChanged: __layout()
    
    function __layout() {
        if (parent == null || width == 0)
            return;

        var orientation = screen.currentOrientation == Screen.Landscape || screen.currentOrientation == Screen.LandscapeInverted ? "landscape" : "portrait",
            padding = orientation == "landscape" ? 80 : 15;

        for (var i = 0, childCount = children.length, tabCount = 0, widthOthers = 0; i < childCount; i++) {
            if (children[i].tab !== undefined) {
                children[i].platformStyle.position = (tabCount++ === 0) ? "horizontal-left" : "horizontal-center";
                children[i].platformStyle.screenOrientation = orientation;
            } else {
                widthOthers += children[i].width;
                children[i].y = (height - children[i].height) / 2;
            }
        }
        // Check if last item is a tab button and set appropriate position
        tabCount && (children[children[0].tab ? tabCount - 1 : tabCount].platformStyle.position = "horizontal-right");

        widthOthers += children[0].tab ? padding : 0;
        widthOthers += children[childCount - 1].tab ? padding : 0;

        var tabWidth = Math.round((width - widthOthers) / tabCount),
            offset = children[0].tab ? padding : children[0].width;

        for (var i = children[0].tab ? 0 : 1, index = 0; i < childCount; i++, index++) {
            children[i].x = tabWidth * index + offset;
            children[i].tab && (children[i].width = tabWidth);
        }
    }
}

