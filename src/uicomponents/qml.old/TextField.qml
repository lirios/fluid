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
import "Utils.js" as Utils
import "UIConstants.js" as UI
import "EditBubble.js" as Popup
import "TextAreaHelper.js" as TextAreaHelper
import "Magnifier.js" as MagnifierPopup
import "SelectionHandles.js" as SelectionHandles

FocusScope {
    id: root

    // Common public API
    property alias text: textInput.text
    property alias placeholderText: prompt.text

    property alias inputMethodHints: textInput.inputMethodHints
    property alias font: textInput.font
    property alias cursorPosition: textInput.cursorPosition
    property alias maximumLength: textInput.maximumLength
    property alias readOnly: textInput.readOnly
    property alias acceptableInput: textInput.acceptableInput
    property alias inputMask: textInput.inputMask
    property alias validator: textInput.validator

    property alias selectedText: textInput.selectedText
    property alias selectionStart: textInput.selectionStart
    property alias selectionEnd: textInput.selectionEnd

    property alias echoMode: textInput.echoMode // ### TODO: declare own enum { Normal, Password }

    property bool errorHighlight: !acceptableInput
    // Property enableSoftwareInputPanel is DEPRECATED
    property alias enableSoftwareInputPanel: textInput.activeFocusOnPress

    property Item platformSipAttributes

    property bool platformEnableEditBubble: true
    property bool platformEnableMagnifier: true

    property QtObject platformStyle: TextFieldStyle {}

    property alias style: root.platformStyle

    property Component customSoftwareInputPanel

    property Component platformCustomSoftwareInputPanel

    property alias platformPreedit: inputMethodObserver.preedit

    //force a western numeric input panel even when vkb is set to arabic
    property alias platformWesternNumericInputEnforced: textInput.westernNumericInputEnforced
    property bool platformSelectable: true

    signal accepted

    onPlatformSipAttributesChanged: {
        platformSipAttributes.registerInputElement(textInput)
    }

    onCustomSoftwareInputPanelChanged: {
        console.log("TextField's property customSoftwareInputPanel is deprecated. Use property platformCustomSoftwareInputPanel instead.")
        platformCustomSoftwareInputPanel = customSoftwareInputPanel
    }

    onPlatformCustomSoftwareInputPanelChanged: {
        textInput.activeFocusOnPress = platformCustomSoftwareInputPanel == null
    }

    function copy() {
        textInput.copy()
    }

    Connections {
        target: platformWindow

        onActiveChanged: {
            if(platformWindow.active) {
                if (__hadFocusBeforeMinimization) {
                    __hadFocusBeforeMinimization = false
                    textInput.select( __priorSelectionStart, __priorSelectionEnd )
                    if (root.parent)
                        root.focus = true
                    else
                        textInput.focus = true
                }

                if (activeFocus) {
                    if ( Popup.isOpened() && platformEnableEditBubble )
                        Popup.open(textInput, textInput.positionToRectangle(textInput.cursorPosition));
                    if (textInput.selectionStart != textInput.selectionEnd && platformEnableEditBubble)
                        SelectionHandles.open(textInput);
                    if (!readOnly && platformCustomSoftwareInputPanel != null) {
                        platformOpenSoftwareInputPanel();
                    } else {
                        inputContext.simulateSipOpen();
                    }

                    repositionTimer.running = true;
                }
            } else {
                if (activeFocus) {
                    __priorSelectionStart = selectionStart
                    __priorSelectionEnd = selectionEnd
                    platformCloseSoftwareInputPanel();
                    Popup.close(textInput);
                    SelectionHandles.close(textInput);
                    if (textInput.selectionStart != textInput.selectionEnd)
                        textInput.deselect();

                    __hadFocusBeforeMinimization = true
                    if (root.parent)
                        root.parent.focus = true
                    else
                        textInput.focus = false
                }
                MagnifierPopup.clean(textInput);
            }
        }

        onAnimatingChanged: {
            if (!platformWindow.animating && root.activeFocus) {
                TextAreaHelper.repositionFlickable(contentMovingAnimation);
            }
        }
    }

    function paste() {
        textInput.paste()
    }

    function cut() {
        textInput.cut()
    }

    function select(start, end) {
        textInput.select(start, end)
    }

    function selectAll() {
        textInput.selectAll()
    }

    function selectWord() {
        textInput.selectWord()
    }

    function positionAt(x) {
        var p = mapToItem(textInput, x, 0);
        return textInput.positionAt(p.x)
    }

    function positionToRectangle(pos) {
        var rect = textInput.positionToRectangle(pos)
        rect.x = mapFromItem(textInput, rect.x, 0).x
        return rect;
    }

    // ensure propagation of forceActiveFocus
    function forceActiveFocus() {
        textInput.forceActiveFocus()
    }

    function closeSoftwareInputPanel() {
        console.log("TextField's function closeSoftwareInputPanel is deprecated. Use function platformCloseSoftwareInputPanel instead.")
        platformCloseSoftwareInputPanel()
    }

    function platformCloseSoftwareInputPanel() {
        inputContext.simulateSipClose();
        if (inputContext.customSoftwareInputPanelVisible) {
            inputContext.customSoftwareInputPanelVisible = false
            inputContext.customSoftwareInputPanelComponent = null
            inputContext.customSoftwareInputPanelTextField = null
        } else {
            textInput.closeSoftwareInputPanel();
        }
    }

    function openSoftwareInputPanel() {
        console.log("TextField's function openSoftwareInputPanel is deprecated. Use function platformOpenSoftwareInputPanel instead.")
        platformOpenSoftwareInputPanel()
    }

    function platformOpenSoftwareInputPanel() {
        inputContext.simulateSipOpen();
        if (platformCustomSoftwareInputPanel != null && !inputContext.customSoftwareInputPanelVisible) {
            inputContext.customSoftwareInputPanelTextField = root
            inputContext.customSoftwareInputPanelComponent = platformCustomSoftwareInputPanel
            inputContext.customSoftwareInputPanelVisible = true
        } else {
            textInput.openSoftwareInputPanel();
        }
    }

    // private
    property bool __expanding: true // Layout hint used but ToolBarLayout
    property int __preeditDisabledMask: Qt.ImhHiddenText|
                                        Qt.ImhNoPredictiveText|
                                        Qt.ImhDigitsOnly|
                                        Qt.ImhFormattedNumbersOnly|
                                        Qt.ImhDialableCharactersOnly|
                                        Qt.ImhEmailCharactersOnly|
                                        Qt.ImhUrlCharactersOnly 

    property bool __hadFocusBeforeMinimization: false
    property int __priorSelectionStart
    property int __priorSelectionEnd

    implicitWidth: platformStyle.defaultWidth
    implicitHeight: UI.FIELD_DEFAULT_HEIGHT

    onActiveFocusChanged: {
        if (activeFocus) {
            if (!readOnly && platformCustomSoftwareInputPanel != null) {
                platformOpenSoftwareInputPanel();
            } else {
                inputContext.simulateSipOpen();
            }

            repositionTimer.running = true;
        } else {                
            platformCloseSoftwareInputPanel();
            Popup.close(textInput);
            SelectionHandles.close(textInput);
        }

        if (!activeFocus)
            MagnifierPopup.close();
        background.source = pickBackground();
    }

    function pickBackground() {
        if (errorHighlight) {
            return platformStyle.backgroundError;
        }
        if (textInput.activeFocus) {
            return platformStyle.backgroundSelected;
        }
        if (readOnly) {
            return platformStyle.backgroundDisabled;
        }
        return platformStyle.background;
    }

    BorderImage {
        id: background
        source: pickBackground();
        anchors.fill: parent
        border.left: root.platformStyle.backgroundCornerMargin; border.top: root.platformStyle.backgroundCornerMargin
        border.right: root.platformStyle.backgroundCornerMargin; border.bottom: root.platformStyle.backgroundCornerMargin
    }

    Text {
        id: prompt

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: root.platformStyle.paddingLeft
            rightMargin: root.platformStyle.paddingRight
            verticalCenterOffset: root.platformStyle.baselineOffset
        }

        font: root.platformStyle.textFont
        color: root.platformStyle.promptTextColor
        elide: Text.ElideRight

        // opacity for default state
        opacity: 0.0

        states: [
            State {
                name: "unfocused"
                // memory allocation optimization: cursorPosition is checked to minimize displayText evaluations
                when: !root.activeFocus && textInput.cursorPosition == 0 && !textInput.text && prompt.text && !textInput.inputMethodComposing
                PropertyChanges { target: prompt; opacity: 1.0; }
            },
            State {
                name: "focused"
                // memory allocation optimization: cursorPosition is checked to minimize displayText evaluations
                when: root.activeFocus && textInput.cursorPosition == 0 && !textInput.text && prompt.text && !textInput.inputMethodComposing
                PropertyChanges { target: prompt; opacity: 0.6; }
            }
        ]

        transitions: [
            Transition {
                from: "unfocused"; to: "focused";
                reversible: true
                SequentialAnimation {
                    PauseAnimation { duration: 60 }
                    NumberAnimation { target: prompt; properties: "opacity"; duration: 150  }
                }
            },
            Transition {
                from: "focused"; to: "";
                reversible: true
                SequentialAnimation {
                    PauseAnimation { duration:  60 }
                    NumberAnimation { target: prompt; properties: "opacity"; duration: 100 }
                }
            }
        ]
    }

    MouseArea {
        enabled: !textInput.activeFocus
        z: enabled?1:0
        anchors.fill: parent
        anchors.margins: UI.TOUCH_EXPANSION_MARGIN
        onClicked: {
            if (!textInput.activeFocus) {
                textInput.forceActiveFocus();

                // activate to preedit and/or move the cursor
                var preeditDisabled = root.inputMethodHints &
                                      root.__preeditDisabledMask
                var injectionSucceeded = false;
                var newCursorPosition = textInput.positionAt(mapToItem(textInput, mouseX, mouseY).x,TextInput.CursorOnCharacter);
                if (!preeditDisabled) {
                    var beforeText = textInput.text
                    if (!TextAreaHelper.atSpace(newCursorPosition, beforeText)
                        && newCursorPosition != beforeText.length
                        && !(newCursorPosition == 0 || TextAreaHelper.atSpace(newCursorPosition - 1, beforeText))) {

                        injectionSucceeded = TextAreaHelper.injectWordToPreedit(newCursorPosition, beforeText);
                    }
                }
                if (!injectionSucceeded) {
                    textInput.cursorPosition=newCursorPosition;
                }
            }
        }
    }

    TextInput {
        id: textInput

        property alias preedit: inputMethodObserver.preedit
        property alias preeditCursorPosition: inputMethodObserver.preeditCursorPosition

        // this properties are evaluated by the input method framework
        property bool westernNumericInputEnforced: false
        property bool suppressInputMethod: !activeFocusOnPress

        onWesternNumericInputEnforcedChanged: {
            inputContext.update();
        }

        anchors {verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right}
        anchors.leftMargin: root.platformStyle.paddingLeft
        anchors.rightMargin: root.platformStyle.paddingRight
        anchors.verticalCenterOffset: root.platformStyle.baselineOffset

        passwordCharacter: "\u2022"
        font: root.platformStyle.textFont
        color: root.platformStyle.textColor
        selectByMouse: false
        selectedTextColor: root.platformStyle.selectedTextColor
        selectionColor: root.platformStyle.selectionColor
        mouseSelectionMode: TextInput.SelectWords
        focus: true

        Component.onDestruction: {
            SelectionHandles.close(textInput);
            Popup.close(textInput);
        }

        Connections {
            target: Utils.findFlickable(root.parent)

            onContentYChanged: if (root.activeFocus) TextAreaHelper.filteredInputContextUpdate();
            onContentXChanged: if (root.activeFocus) TextAreaHelper.filteredInputContextUpdate();
            onMovementEnded: inputContext.update();
        }

        Connections {
            target: inputContext

            onSoftwareInputPanelRectChanged: {
                if (activeFocus) {
                    repositionTimer.running = true
                }
            }
        }

        onTextChanged: {
            if(root.activeFocus) {
                TextAreaHelper.repositionFlickable(contentMovingAnimation)
            }

            if (Popup.isOpened(textInput)) {
                if (Popup.hasPastingText()) {
                    inputContext.clearClipboard();
                    Popup.clearPastingText();
                }
                if (!Popup.isChangingInput()) {
                    Popup.close(textInput);
                }
            }
            SelectionHandles.close(textInput);
        }

        onCursorPositionChanged: {
            if (MagnifierPopup.isOpened() &&
                Popup.isOpened()) {
                Popup.close(textInput);
            } else if (!mouseFilter.attemptToActivate ||
                textInput.cursorPosition == textInput.text.length) {
                if ( Popup.isOpened(textInput) &&
                !Popup.isChangingInput() && platformEnableEditBubble) {
                    Popup.close(textInput);
                    Popup.open(textInput,
                        textInput.positionToRectangle(textInput.cursorPosition));
                }
                if ( SelectionHandles.isOpened(textInput) && textInput.selectedText == "") {
                    SelectionHandles.close( textInput );
                }
                if ( !SelectionHandles.isOpened(textInput) && textInput.selectedText != ""
                     && platformEnableEditBubble == true ) {
                    SelectionHandles.open( textInput );
                }
                SelectionHandles.adjustPosition();
            }
        }

        onSelectedTextChanged: {
            if ( !platformSelectable )
                textInput.deselect(); // enforce deselection in all cases we didn't think of

            if (Popup.isOpened(textInput) && !Popup.isChangingInput()) {
                Popup.close(textInput);
            }
            if ( SelectionHandles.isOpened(textInput) && textInput.selectedText == "") {
                SelectionHandles.close( textInput )
            }
        }

        InputMethodObserver {
            id: inputMethodObserver

            onPreeditChanged: {
                if(root.activeFocus) {
                    TextAreaHelper.repositionFlickable(contentMovingAnimation)
                }

                if (Popup.isOpened(textInput) && !Popup.isChangingInput()) {
                    Popup.close(textInput);
                }
            }
        }

        Timer {
            id: repositionTimer
            interval: 350
            onTriggered: {
                TextAreaHelper.repositionFlickable(contentMovingAnimation)
            }
        }

        PropertyAnimation {
            id: contentMovingAnimation
            property: "contentY"
            duration: 200
            easing.type: Easing.InOutCubic
        }

        MouseFilter {
            id: mouseFilter
            anchors {
                fill: parent
                leftMargin:  UI.TOUCH_EXPANSION_MARGIN - root.platformStyle.paddingLeft
                rightMargin:  UI.TOUCH_EXPANSION_MARGIN - root.platformStyle.paddingRight
                topMargin: UI.TOUCH_EXPANSION_MARGIN - ((root.height - parent.height) / 2)
                bottomMargin:  UI.TOUCH_EXPANSION_MARGIN - ((root.height - parent.height) / 2)
            }
            property bool attemptToActivate: false
            property bool pressOnPreedit: false
            property int oldCursorPosition: 0

            property variant editBubblePosition: null

            onPressed: {
                var mousePosition = textInput.positionAt(mouse.x,TextInput.CursorOnCharacter);
                pressOnPreedit = textInput.cursorPosition==mousePosition
                oldCursorPosition = textInput.cursorPosition;
                var preeditDisabled = root.inputMethodHints &
                                      root.__preeditDisabledMask

                attemptToActivate = !pressOnPreedit && !root.readOnly && !preeditDisabled && root.activeFocus &&
                                    !(mousePosition == 0 || TextAreaHelper.atSpace(mousePosition - 1) || TextAreaHelper.atSpace(mousePosition));
                mouse.filtered = true;
            }

            onDelayedPressSent: {
                if (textInput.preedit) {
                    textInput.cursorPosition = oldCursorPosition;
                }
            }

            onHorizontalDrag: {
                // possible pre-edit word have to be commited before selection
                if (root.activeFocus || root.readOnly) {
                    inputContext.reset()                    
                    if( platformSelectable )
                        parent.selectByMouse = true
                    attemptToActivate = false
                }
            }

            onPressAndHold:{
                // possible pre-edit word have to be commited before showing the magnifier
                if (platformEnableMagnifier &&
                    (root.text != "" || inputMethodObserver.preedit != "") && root.activeFocus) {
                    inputContext.reset()
                    attemptToActivate = false
                    MagnifierPopup.open(root);
                    var magnifier = MagnifierPopup.popup;
                    var cursorPos = textInput.positionToRectangle(0);
                    var mappedPosMf = mapFromItem(parent,mouse.x,cursorPos.y+cursorPos.height/2+4);
                    magnifier.xCenter = mapToItem(magnifier.sourceItem,mappedPosMf.x,0).x;
                    var mappedPos =  mapToItem(magnifier.parent, mappedPosMf.x - magnifier.width / 2,
                                               textInput.y - 120 - UI.MARGIN_XLARGE - (height / 2));
                    var yAdjustment = -mapFromItem(magnifier.__rootElement, 0, 0).y < magnifier.height / 2.5 ? magnifier.height / 2.5 + mapFromItem(magnifier.__rootElement, 0,0).y : 0
                    magnifier.x = mappedPos.x;
                    magnifier.y = mappedPos.y + yAdjustment;
                    magnifier.yCenter = Math.round(mapToItem(magnifier.sourceItem,0,mappedPosMf.y).y);
                    parent.cursorPosition = textInput.positionAt(mouse.x)
                }
            }

            onReleased: {
                if (MagnifierPopup.isOpened()) {
                    MagnifierPopup.close();
                }

                if (attemptToActivate)
                    inputContext.reset();

                var newCursorPosition = textInput.positionAt(mouse.x,TextInput.CursorOnCharacter); 
                if (textInput.preedit.length == 0)
                    editBubblePosition = textInput.positionToRectangle(newCursorPosition);

                if (attemptToActivate) {
                    var beforeText = textInput.text;

                    textInput.cursorPosition = newCursorPosition;
                    var injectionSucceeded = false;

                    if (!TextAreaHelper.atSpace(newCursorPosition, beforeText)
                             && newCursorPosition != beforeText.length) {
                        injectionSucceeded = TextAreaHelper.injectWordToPreedit(newCursorPosition, beforeText);
                    }
                    if (injectionSucceeded) {
                        mouse.filtered=true;
                        if (textInput.preedit.length >=1 && textInput.preedit.length <= 4)
                            editBubblePosition = textInput.positionToRectangle(textInput.cursorPosition+1)
                    } else {
                        textInput.text=beforeText;
                        textInput.cursorPosition=newCursorPosition;
                    }
                } else if (!parent.selectByMouse) {
                    if (!pressOnPreedit) inputContext.reset();
                    textInput.cursorPosition = textInput.positionAt(mouse.x,TextInput.CursorOnCharacter);
                }
                parent.selectByMouse = false;
            }

            onFinished: {
                if (root.activeFocus && platformEnableEditBubble) {
                    if (textInput.preedit.length == 0)
                        editBubblePosition = textInput.positionToRectangle(textInput.cursorPosition);
                    if (editBubblePosition != null) {
                        Popup.open(textInput,editBubblePosition);
                        editBubblePosition = null
                    }
                    if (textInput.selectedText != "")
                        SelectionHandles.open( textInput );
                    SelectionHandles.adjustPosition();
                }
                attemptToActivate = false
            }

            onMousePositionChanged: {
                if (MagnifierPopup.isOpened() && !parent.selectByMouse) {
                    textInput.cursorPosition = textInput.positionAt(mouse.x)
                    var magnifier = MagnifierPopup.popup;
                    var mappedPosMf = mapFromItem(parent,mouse.x,0);
                    var mappedPos =  mapToItem(magnifier.parent,mappedPosMf.x - magnifier.width / 2.0, 0);
                    magnifier.xCenter = mapToItem(magnifier.sourceItem,mappedPosMf.x,0).x;
                    magnifier.x = mappedPos.x;
                }
                SelectionHandles.adjustPosition();
            }

            onDoubleClicked: {
                // possible pre-edit word have to be commited before selection
                inputContext.reset()
                // Ignore doubleclicks which occur outside the smallest rectangle around the full text of the textfield
                if (typeof showStatusBar !== "undefined" && locale.directionForText(textInput.text) === 1 /* RightToLef */) {
                    if ( platformSelectable && mouse.x > width - textInput.positionToRectangle( textInput.text.length ).x )
                        parent.selectByMouse = true;
                } else if ( platformSelectable && mouse.x <= textInput.positionToRectangle( textInput.text.length ).x )
                    parent.selectByMouse = true;
                attemptToActivate = false
            }
        }
    }

    InverseMouseArea {
        anchors.fill: parent
        anchors.margins: UI.TOUCH_EXPANSION_MARGIN
        enabled: textInput.activeFocus
        onClickedOutside: {
            if (Popup.isOpened(textInput) && ((mouseX > Popup.geometry().left && mouseX < Popup.geometry().right) &&
                                           (mouseY > Popup.geometry().top && mouseY < Popup.geometry().bottom))) {
                return;
            }
            root.parent.focus = true;
        }
    }

    Component.onCompleted: textInput.accepted.connect(accepted)
}
