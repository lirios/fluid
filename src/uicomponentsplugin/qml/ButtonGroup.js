/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

var self;
var checkHandlers = [];
var visibleButtons = [];
var nonVisibleButtons = [];
var direction;

function create(that, options) {
    self = that;
    direction = options.direction || Qt.Horizontal;
    self.childrenChanged.connect(rebuild);
    self.exclusiveChanged.connect(rebuild);
//    self.widthChanged.connect(resizeChildren);
    build();
}

function isButton(item) {
    if (item && item.hasOwnProperty("__position"))
        return true;
    return false;
}

function hasChecked(item) {
    return (item && item.hasOwnProperty("checked"));
}

function destroy() {
    self.childrenChanged.disconnect(rebuild);
//    self.widthChanged.disconnect(resizeChildren);
    cleanup();
}

function build() {
    visibleButtons = [];
    nonVisibleButtons = [];

    for (var i = 0, item; (item = self.children[i]); i++) {
        if (!hasChecked(item))
            continue;

        item.visibleChanged.connect(rebuild); // Not optimal, but hardly a bottleneck in your app
        if (!item.visible) {
            nonVisibleButtons.push(item);
            continue;
        }
        visibleButtons.push(item);

        if (self.exclusive && item.hasOwnProperty("checkable"))
            item.checkable = true;

        if (self.exclusive) {
            checkHandlers.push(checkExclusive(item));
            item.checkedChanged.connect(checkHandlers[checkHandlers.length - 1]);
        }
        if (item.checked) {
            checkExclusive(item)()
            if (item.checked) self.checkedButton = item
        }
    }

    var nrButtons = visibleButtons.length;
    if (nrButtons == 0)
        return;

    if (self.checkedButton)
        self.checkedButton.checked = true;
    else if (self.exclusive) {
        self.checkedButton = visibleButtons[0];
        self.checkedButton.checked = true;
    }

    if (nrButtons == 1) {
        finishButton(visibleButtons[0], "only");
    } else {
        finishButton(visibleButtons[0], direction == Qt.Horizontal ? "leftmost" : "top");
        for (var i = 1; i < nrButtons - 1; i++)
            finishButton(visibleButtons[i], direction == Qt.Horizontal ? "h_middle": "v_middle");
        finishButton(visibleButtons[nrButtons - 1], direction == Qt.Horizontal ? "rightmost" : "bottom");
    }
}

function finishButton(button, position) {
    if (isButton(button)) {
        button.__position = position;
        if (direction == Qt.Vertical) {
            button.anchors.left = self.left     //mm How to make this not cause binding loops? see QTBUG-17162
            button.anchors.right = self.right
        }
    }
}

function cleanup() {
    visibleButtons.forEach(function(item, i) {
        if (checkHandlers[i])
            item.checkedChanged.disconnect(checkHandlers[i]);
        item.visibleChanged.disconnect(rebuild);
    });
    checkHandlers = [];

    nonVisibleButtons.forEach(function(item, i) {
        item.visibleChanged.disconnect(rebuild);
    });
}

function rebuild() {
    if (self == undefined)
        return;

    cleanup();
    build();
}

function resizeChildren() {
    if (direction != Qt.Horizontal)
        return;

    var extraPixels = self.width % visibleButtons;
    var buttonSize = (self.width - extraPixels) / visibleButtons;
    visibleButtons.forEach(function(item, i) {
        if (!item || !item.visible)
            return;
        item.width = buttonSize + (extraPixels > 0 ? 1 : 0);
        if (extraPixels > 0)
            extraPixels--;
    });
}

function checkExclusive(item) {
    var button = item;
    return function() {
        for (var i = 0, ref; (ref = visibleButtons[i]); i++) {
            if (ref.checked == (button === ref))
                continue;

            // Disconnect the signal to avoid recursive calls
            ref.checkedChanged.disconnect(checkHandlers[i]);
            ref.checked = !ref.checked;
            ref.checkedChanged.connect(checkHandlers[i]);
        }
        self.checkedButton = button;
    }
}
