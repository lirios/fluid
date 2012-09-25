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
        Item

Imports:
        QtQuick 2.0
        AppManager.js

Description:
        A simple tab button which is using the  plasma theme.

Properties:
        Item tab:
        The reference to the tab content (one of the children of a TabGroup,
        usually a Page) that is activated when this TabButton is clicked.

        bool checked:
        True if the button is checked,otherwise false.

        bool pressed:
        True if the button is being pressed,otherwise false.

        string text:
        Sets the text for the button.

        string iconSource:
        Icon for the button. It can be a Freedesktop icon name, a full path to a ong/svg file,
        or any name for which the application has an image handler registered.

Signals:
        onClicked:
        The signal is emmited when the button is clicked.
**/

import QtQuick 2.0
import "private/AppManager.js" as Utils
import "private" as Private

Item {
    id: root

    // Common Public API
    property Item tab
    property bool checked: (internal.tabGroup == null) ? (root.parent.parent.currentTab == root) : (internal.tabGroup.currentTab == tab)

    property bool pressed: mouseArea.pressed == true && mouseArea.containsMouse
    property alias text: label.text
    property alias iconSource: imageLoader.source

    signal clicked

    implicitWidth: label.paintedWidth + (internal.portrait ? 0 : (iconSource != null ? 16 : 0))
    implicitHeight: label.paintedHeight + (internal.portrait ? (iconSource != null ? 16 : 0) : 0)

    opacity: enabled ? 1 : 0.6
    //long notation to not make it overwritten by implementations
    Connections {
        target: root
        onPressedChanged: {
            //TabBar is the granparent
            root.parent.parent.currentTab = root
            root.parent.parent.forceActiveFocus()
        }
        onVisibleChanged: root.parent.childrenChanged()
    }

    QtObject {
        id: internal

        property Item tabGroup: Utils.findParent(tab, "currentTab")
        property bool portrait: root.height >= label.paintedHeight + 16

        function click() {
            root.clicked()
            if (internal.tabGroup) {
                internal.tabGroup.currentTab = tab
            }
        }

        Component.onCompleted: {
            if (internal.tabGroup && internal.tabGroup.currentTab == tab) {
                internal.tabGroup.currentTab = tab
            }
        }
    }

    Label {
        id: label

        objectName: "label"

        anchors {
            top: internal.portrait && iconSource != null ? imageLoader.bottom : parent.top
            left: internal.portrait || iconSource == null ? parent.left : imageLoader.right
            leftMargin: iconSource == null ? 0 : parent.parent.anchors.leftMargin
            right: parent.right
            bottom: parent.bottom
        }

        elide: Text.ElideRight
        horizontalAlignment: !internal.portrait && iconSource != null ? Text.AlignLeft : Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: root.checked ? theme.buttonTextColor : theme.windowTextColor
    }

    Private.IconLoader {
        id: imageLoader

        implicitWidth: internal.portrait ? Math.max(theme.smallIconSize, root.height - (label.text ? label.height : 0)) : Math.max(theme.smallIconSize, root.height)
        implicitHeight: implicitWidth

        anchors {
            left: internal.portrait ? undefined : parent.left
            horizontalCenter: internal.portrait ? parent.horizontalCenter : undefined
            verticalCenter: internal.portrait ? undefined : parent.verticalCenter
        }
    }

    MouseArea {
        id: mouseArea

        onClicked: {
            root.clicked()
            if (internal.tabGroup) {
                internal.tabGroup.currentTab = tab
            }
            //TabBar is the granparent, done here too in case of no tabgroup
            root.parent.parent.currentTab = root
        }

        anchors.fill: parent
    }
}
