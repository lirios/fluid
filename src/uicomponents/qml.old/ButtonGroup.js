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

/// Helper code that is shared between ButtonRow.qml and ButtonColumn.qml.

var self = undefined;
var checkedButton = null;
var buttons = [];
var firstVisible = -1;
var lastVisible = -1;
var visibleButtons = 0;
var buttonHandlers = [];
var styleComponent = undefined;
var params = undefined;

function isButton(item) {
    return (item && item.hasOwnProperty("__buttonType"));
}

function hasChecked(item) {
    return (item && item.hasOwnProperty("checked"));
}

function cleanup() {
    buttons.forEach(function(button, i) {
        if (button.visible && params.exclusive) {
            button.checkedChanged.disconnect(buttonHandlers[i]);
        }
        if (isButton(button))
            button.visibleChanged.disconnect(buttonVisibleChanged);
    });
    buttons = [];
    buttonHandlers = [];
}

function updateButtons() {
    cleanup();

    params.exclusive = self.exclusive;

    checkedButton = null;
    var length = self.children.length;
    for (var i = 0; i < length; i++) {
        var item = self.children[i];
        if (!hasChecked(item))
            continue;
        buttons.push(item);

        item.visibleChanged.connect(buttonVisibleChanged);

        if (item.checked) {
            if (!checkedButton && (self.checkedButton === item || self.checkedButton == undefined))
                checkedButton = item;
            else if (params.exclusive && self.checkedButton != item)
                item.checked = false;
        } else if (self.checkedButton === item) {
            if (checkedButton && params.exclusive)
                checkedButton.checked = false;
            checkedButton = item;
        }

        if (isButton(item)) {
            if (styleComponent)
                item.platformStyle = styleComponent.createObject(item)

            // Only ButtonRow supports tab buttons and care about screen orientation
            if (params.orientation == Qt.Horizontal &&  item.platformStyle.hasOwnProperty("screenOrientation"))
                switch (screen.currentOrientation) {
                case Screen.Portrait:
                case Screen.PortraitInverted:
                    item.platformStyle.screenOrientation = "portrait";
                    break;
                case Screen.Landscape:
                case Screen.LandscapeInverted:
                    item.platformStyle.screenOrientation = "landscape";
                    break;
                }
        }
        if (params.exclusive) {
            if (item["checkable"] !== undefined)
                item.checkable = true;
            var last = buttonHandlers.push(checkExclusive(item));
            item.checkedChanged.connect(buttonHandlers[last - 1]);
        }
    }

    if (!checkedButton && buttons.length > 0 && params.exclusive) {
        checkedButton = buttons[0];
        checkedButton.checked = true;
    }
    self.checkedButton = checkedButton;

    buttonVisibleChanged();
}

var blockCheckedChanged = false;

function checkExclusive(item) {
    var button = item;
    return function() {
        if (blockCheckedChanged)
            return;
        if (!button.checked) {
            if (self.checkedButton === button) {
                blockCheckedChanged = true;
                button.checked = true;
                blockCheckedChanged = false;
            }
            return;
        }
        if (self.checkedButton === button)
            return;
        if (self.checkedButton) {
            blockCheckedChanged = true;
            self.checkedButton.checked = false;
            blockCheckedChanged = false;
        }
        checkedButton = button;
        self.checkedButton = button;
    }
}

function checkedButtonChanged() {
    if (checkedButton === self.checkedButton)
        return;
    blockCheckedChanged = true;
    if (params.exclusive && checkedButton)
        checkedButton.checked = false;
    if (self.checkedButton)
        self.checkedButton.checked = true;
    blockCheckedChanged = false;
    checkedButton = self.checkedButton;
}

function buttonVisibleChanged() {
    visibleButtons = 0;
    firstVisible = -1;
    lastVisible = -1;
    buttons.forEach(function (button, i) {
        if (button.visible) {
            if (firstVisible === -1)
                firstVisible = i;
            lastVisible = i;
            visibleButtons++;
        }
    });

    updateGroupPosition();
    resizeChildren();
}

function updateGroupPosition() {
    if (visibleButtons === 0)
        return;

    // Fix the children group position
    if (visibleButtons == 1) {
        if (isButton(buttons[firstVisible]))
            buttons[firstVisible].platformStyle.position = params.singlePos;
    } else {
        if (isButton(buttons[firstVisible]))
            buttons[firstVisible].platformStyle.position = params.firstPos;
        for (var i = firstVisible + 1; i < lastVisible; i++) {
            if (buttons[i].visible && isButton(buttons[i]))
                buttons[i].platformStyle.position = params.middlePos;
        }
        if (isButton(buttons[lastVisible]))
            buttons[lastVisible].platformStyle.position = params.lastPos;
    }
}

var resizing = false;  // resizeChildren() may trigger reentrant calls

function resizeChildren() {
    if (resizing || visibleButtons === 0)
        return;

    if (typeof params.resizeChildren === "function") {
        resizing = true;
        params.resizeChildren(self);
        resizing = false;
    }
}

function create(s, p) {
    if (!s) {
        console.log("Error creating ButtonGroup: invalid owner.");
        return;
    }
    if (!s.hasOwnProperty("checkedButton")) {
        console.log("Error creating ButtonGroup: owner has no 'checkedButton' property.");
        return;
    }

    self = s;
    params = p;

    styleComponent = params.styleComponent;

    if (styleComponent && styleComponent.status != Component.Ready) {
        console.log("Error loading style:", styleComponent.errorString());
        return
    }

    updateButtons();
    self.checkedButtonChanged.connect(checkedButtonChanged);
    self.childrenChanged.connect(updateButtons);
    self.exclusiveChanged.connect(updateButtons);
    self.widthChanged.connect(resizeChildren);
}

function destroy() {
    if (self) {
        self.checkedButtonChanged.disconnect(checkedButtonChanged);
        self.childrenChanged.disconnect(updateButtons);
        self.exclusiveChanged.disconnect(updateButtons);
        self.widthChanged.disconnect(resizeChildren);
        self = undefined;
    }
    if (styleComponent) {
        styleComponent.destroy();
        styleComponent = undefined;
    }
    cleanup();
}

