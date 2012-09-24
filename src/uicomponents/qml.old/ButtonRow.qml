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

import "ButtonGroup.js" as Private
import "UIConstants.js" as UI

Row {
    id: root

    property bool exclusive: true
    property Item checkedButton

    property Component platformStyle: null
    property Component style: null

    property int __screenWidth: (screen.rotation === 0 || screen.rotation === 180 ? screen.displayWidth : screen.displayHeight) - 2 * UI.MARGIN_XLARGE
    property int __visibleButtons
    property bool __expanding: true // Layout hint used but ToolBarLayout
    property int __maxButtonSize: UI.BUTTON_WIDTH

    width: Math.min(__visibleButtons * UI.BUTTON_WIDTH, __screenWidth)
    Component.onCompleted: {
        Private.create(root, {
            "orientation": Qt.Horizontal,
            "exclusive": exclusive,
            "styleComponent": platformStyle? platformStyle : style,
            "singlePos": "",
            "firstPos": "horizontal-left",
            "middlePos": "horizontal-center",
            "lastPos": "horizontal-right",
            "resizeChildren": function(self) {
               self.__visibleButtons = Private.visibleButtons;
               var extraPixels = self.width % Private.visibleButtons;
               var buttonSize = Math.min(__maxButtonSize, (self.width - extraPixels) / Private.visibleButtons);
               Private.buttons.forEach(function(item, i) {
                   if (!item || !item.visible || !Private.isButton(item))
                       return;
                   if (extraPixels > 0) {
                       item.width = buttonSize + 1;
                       extraPixels--;
                   } else {
                       item.width = buttonSize;
                   }
               });
           }
        });
        screen.currentOrientationChanged.connect(Private.updateButtons);
    }

    Component.onDestruction: {
        screen.currentOrientationChanged.disconnect(Private.updateButtons);
        Private.destroy();
    }
}
