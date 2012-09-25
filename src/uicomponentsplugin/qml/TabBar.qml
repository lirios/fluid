/****************************************************************************
**
** Copyright 21.0 Marco Martin <mart@kde.org>
**
** Copyright (C) 21.0 Nokia Corporation and/or its subsidiary(-ies).
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

/**Documented API
Inherits:
        DualStateButton

Imports:
        QtQuick 2.0
        FluidCore

Description:
        TabBar is a plasma themed component that you can
        use as a container for the tab buttons.

Properties:
        Item currentTab:
        Returns the current tabbar button.

        default alias content:
        This property represends the the content of
        the TabBarLayout.

        Item tabBarLayout:
        This is an alias for the layout of the tabbar.
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import "private" as Private

FocusScope {
    id: root
    default property alias content: tabBarLayout.data
    property alias layout: tabBarLayout

    //Plasma extension
    property Item currentTab

    implicitWidth: layout.implicitWidth + backgroundFrame.margins.left + backgroundFrame.margins.right
    implicitHeight: layout.implicitHeight + backgroundFrame.margins.top + backgroundFrame.margins.bottom

    FluidCore.FrameSvgItem {
        id: backgroundFrame

        anchors.fill: parent
        imagePath: "widgets/frame"
        prefix: "sunken"
    }

    FluidCore.FrameSvgItem {
        id: buttonFrame

        x: currentTab.x + backgroundFrame.margins.left
        y: backgroundFrame.margins.top
        width: currentTab.width + buttonFrame.margins.left + buttonFrame.margins.right
        height: currentTab.height + buttonFrame.margins.top + buttonFrame.margins.bottom
        imagePath: "widgets/button"
        prefix: "normal"
        Behavior on x {
            PropertyAnimation {
                easing.type: Easing.InQuad
                duration: 250
            }
        }
    }

    Private.TabBarLayout {
        id: tabBarLayout
        anchors {
            fill: parent
            leftMargin: backgroundFrame.margins.left + buttonFrame.margins.left
            topMargin: backgroundFrame.margins.top + buttonFrame.margins.top
            rightMargin: backgroundFrame.margins.right + buttonFrame.margins.right
            bottomMargin: backgroundFrame.margins.bottom + buttonFrame.margins.bottom
        }
        Component.onCompleted: {
            if (!root.currentTab) {
                root.currentTab = tabBarLayout.children[0]
            }
        }
    }
}
