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

Description:
 TODO

Properties:

**/

import QtQuick 2.0

Item {
    id: root

    Component.onCompleted: priv.layoutChildren()
    onChildrenChanged: priv.layoutChildren()
    onWidthChanged: priv.layoutChildren()
    onHeightChanged: priv.layoutChildren()

    Keys.onPressed: {
        if (event.key == Qt.Key_Right || event.key == Qt.Key_Left) {
            var oldIndex = priv.currentButtonIndex();
            if (event.key == Qt.Key_Right || priv.mirrored) {
                if (oldIndex != root.children.length - 1) {
                    priv.setCurrentButtonIndex(oldIndex + 1)
                    event.accepted = true
                }
            } else if (event.key == Qt.Key_Left || priv.mirrored) {
                if (oldIndex != 0) {
                    priv.setCurrentButtonIndex(oldIndex -1)
                    event.accepted = true
                }
            }
        }
    }

    focus: true

    QtObject {
        id: priv
        property Item firstButton: root.children.length > 0 ? root.children[0] : null
        property Item firstTab: firstButton ? (firstButton.tab != null ? firstButton.tab : null) : null
        property Item tabGroup: firstTab ? (firstTab.parent ? firstTab.parent.parent.parent : null) : null
        property bool mirrored: root.LayoutMirroring.enabled

        onMirroredChanged: layoutChildren()

        function currentButtonIndex() {
            for (var i = 0; i < root.children.length; ++i) {
                if (root.children[i] == root.parent.currentTab)
                    return i
            }
            return -1
        }

        function setCurrentButtonIndex(index) {
            if (tabGroup) {
                tabGroup.currentTab = root.children[index].tab
            }
            root.parent.currentTab = root.children[index]
        }

        function layoutChildren() {
            var childCount = root.children.length
            var visibleChildCount = childCount
            var contentWidth = 0
            var contentHeight = 0
            var maxChildWidth = 0
            if (childCount != 0) {
                //not too much efficient but the loop over children needs to be done two times to get the proper child width
                for (var i = 0; i < childCount; ++i) {
                    if (!root.children[i].visible || root.children[i].text === undefined) {
                        --visibleChildCount
                    }
                }
                var itemWidth = (root.width - (visibleChildCount-1)*10) / visibleChildCount
                var itemIndex = mirrored ? childCount - 1 : 0
                var increment = mirrored ? - 1 : 1
                var visibleIndex = 0

                for (var i = 0; i < childCount; ++i, itemIndex += increment) {
                    var child = root.children[itemIndex]
                    if (!child.visible || root.children[i].text === undefined) {
                        continue
                    }

                    child.x = visibleIndex * itemWidth + visibleIndex*10
                    ++visibleIndex
                    child.y = 0
                    child.width = itemWidth
                    child.height = root.height

                    if (child.implicitWidth != undefined) {
                        maxChildWidth = Math.max(maxChildWidth, child.implicitWidth)
                        contentWidth = Math.max(contentWidth + i*10, (maxChildWidth + buttonFrame.margins.left + buttonFrame.margins.right) * childCount)
                        contentHeight = Math.max(contentHeight, (child.implicitHeight + buttonFrame.margins.top + buttonFrame.margins.bottom))
                    }
                }
            }
            root.implicitWidth = contentWidth
            root.implicitHeight = contentHeight
        }
    }
}
