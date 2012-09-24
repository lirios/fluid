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

var allContainers = []
var allContents = []

function hasContainer(content) {
    for (var i = 0; i < allContainers.length; ++i) {
        if (allContainers[i].children[0] == content)
            return true
    }
    return false
}

function addContent(content) {
    for (var i = 0; i < allContents.length; ++i) {
        if (allContents[i] == content)
            return false
    }
    allContents.push(content)
    return true
}

function ensureContainers() {
    var somethingChanged = false

    // check if we need to create a container
    for (var i = 0; i < root.privateContents.length; ++i) {
        var content = root.privateContents[i]
        addContent(content)
        if (!hasContainer(content)) {
            var newContainer = tabContainerComponent.createObject(containerHost)
            content.parent = newContainer
            allContainers.push(newContainer)
            somethingChanged = true
        }
    }
    return somethingChanged
}

function addTab(content) {
    if (addContent(content)) {
        var newContainer = tabContainerComponent.createObject(containerHost)
        content.parent = newContainer
        allContainers.push(newContainer)
    }
}

function removeTab(content) {
    var foundIndex = -1
    for (var i = 0; i < allContents.length && foundIndex == -1; ++i) {
        if (allContents[i] == content)
            foundIndex = i
    }

    if (foundIndex != -1)
        allContents.splice(foundIndex, 1)

    if (hasContainer(content))
        content.parent = null // this causes deletion of container
}

function removeContainer(container) {
    var foundIndex = -1
    for (var i = 0; i < allContainers.length && foundIndex == -1; ++i) {
        if (allContainers[i] == container)
            foundIndex = i
    }

    if (foundIndex != -1) {
        var deletedContainer = allContainers[foundIndex]
        if (deletedContainer.children.length > 0)
            removeTab(deletedContainer.children[0])
        allContainers.splice(foundIndex, 1)
        deletedContainer.destroy()
    }
}

