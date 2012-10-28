/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Daker Fernandes Pinheiro
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Daker Fernandes Pinheiro <dakerfp@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0

Description:
        Creates a simple plasma theme based text field widget.

Properties:
      * font font:
        This property holds the font used in the text field.
    The default font value is the font from plasma desktop theme.

      * Qt::InputMethodHints inputMethodHints:
        This property holds the the currently supported input method hints
     for the text field.
     The default values is Qt.ImhNone.

      * bool errorHighlight:
        This property holds if the text field is highlighted or not
    If it is true then the problematic lines will be highlighted.
    This feature is defined in the Common API but is unimplemented in plasma components.

      * int cursorPosition:
        This property holds the current cursor position.

      * bool readOnly:
        This property holds if the text field can be modified by the user interaction.
    The default value is false.

      * string selectedText:
        This property holds the text selected by the user.
    If no text is selected it holds an empty string.
    This property is read-only.

      * int selectionEnd:
        This property holds the cursor position after the last character in the current selection.
    This property is read-only.

      * int selectionStart:
        This property holds the cursor position before the first character in the current selection.
    This property is read-only.

      * string text:
        This property holds the entire text in the text field.

      * string placeholderText:
        This property holds the text displayed in when the text is empty.
    The default value is empty string, meaning no placeholderText shown.

      * bool passwordMode:
        This property holds if the text field displays asterixes instead of characters.

      * enumeration echoMode:
        This property specifies how the text should be displayed in the TextField.
    The acceptable values are:
        - TextInput.Normal - Displays the text as it is. (Default)
        - TextInput.Password - Displays asterixes instead of characters.
        - TextInput.NoEcho - Displays nothing.
        - TextInput.PasswordEchoOnEdit - Displays all but the current character as asterixes.
    The default value is TextInput.Normal

      * string inputMask:
        Allows you to set an input mask on the TextField, restricting the allowable text inputs.
    See QLineEdit::inputMask for further details, as the exact same mask strings are used by TextInput.

      * Validator validator:
        Allows you to set a validator on the TextField. When a validator is set the TextField
    will only accept input which leaves the text property in an acceptable or intermediate state.
    The accepted signal will only be sent if the text is in an acceptable state when enter is pressed.
    Currently supported validators are IntValidator, DoubleValidator and RegExpValidator.
    An example of using validators is shown below, which allows input of integers
    between 11 and 31 into the text input:
    <code>
    import QtQuick 2.0
    TextInput {
        validator: IntValidator { bottom: 11; top: 31 }
        focus: true
    }
    </code>

      * int maximumLength:
        The maximum permitted length of the text in the TextField.
    If the text is too long, it is truncated at the limit.
    By default, this property contains a value of 32767.

       * bool acceptableInput:
         This property is always true unless a validator or input mask has been set.
    If a validator or input mask has been set, this property will only be true if the current
    text is acceptable to the validator or input mask as a final string (not as an intermediate string).
    This property is always true unless a validator has been set.
    If a validator has been set, this property will only be true if the current text is acceptable to the
    validator as a final string (not as an intermediate string).
    This property is read-only.

       * bool clearButtonShown:
         Holds if the button to clear the text from TextField is visible.
Signals:
       * accepted():
        This signal is emitted when the text input is accepted.

Methods:
       * void copy():
         Copies the currently selected text to the system clipboard.

       * void cut():
         Moves the currently selected text to the system clipboard.

       * void deselect():
         Removes active text selection.

       * void paste():
         Replaces the currently selected text by the contents of the system clipboard.

       * void select(int start, int end):
         Causes the text from start to end to be selected.
     If either start or end is out of range, the selection is not changed.
     After calling this, selectionStart will become the lesser and selectionEnd will become the greater
     (regardless of the order passed to this method).

       * void selectAll():
         Causes all text to be selected.

       * void selectWord():
         Causes the word closest to the current cursor position to be selected.

       * void positionAt(int position):
         This function returns the character position at x pixels from the left of the TextField.
     Position 0 is before the first character, position 1 is after the first character but before the second,
     and so on until position text.length, which is after all characters.
     This means that for all x values before the first character this function returns 0,
     and for all x values after the last character this function returns text.length.

       * rectangle positionToRectangle(position):
         Returns the rectangle at the given position in the text.
     The x, y, and height properties correspond to the cursor that would describe that position.
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import "private" as Private

FocusScope {
    id: textField

    // Common API
    property bool errorHighlight: false // TODO
    property string placeholderText
    property alias inputMethodHints: textInput.inputMethodHints
    property alias font: textInput.font

    property alias cursorPosition: textInput.cursorPosition
    property alias readOnly: textInput.readOnly
    property bool passwordMode: false
    property alias echoMode: textInput.echoMode // Supports TextInput.Normal,TextInput.Password, TextInput.NoEcho, TextInput.PasswordEchoOnEdit
    property alias passwordCharacter: textInput.passwordCharacter
    property alias acceptableInput: textInput.acceptableInput // read-only
    property alias inputMask: textInput.inputMask
    property alias validator: textInput.validator
    property alias selectedText: textInput.selectedText // read-only
    property alias selectionEnd: textInput.selectionEnd // read-only
    property alias selectionStart: textInput.selectionStart // read-only
    property alias text: textInput.text
    property alias maximumLength: textInput.maximumLength

    signal accepted()

    //Plasma api
    property bool clearButtonShown: false

    function copy() {
        textInput.copy();
    }

    function paste() {
        textInput.paste();
    }

    function cut() {
        textInput.cut();
    }

    function select(start, end) {
        textInput.select(start, end);
    }

    function selectAll() {
        textInput.selectAll();
    }

    function selectWord() {
        textInput.selectWord();
    }

    function positionAt(pos) {
        return textInput.positionAt(pos);
    }

    function positionToRectangle(pos) {
        return textInput.positionToRectangle(pos);
    }


    // Set active focus to it's internal textInput.
    // Overriding QtQuick.Item forceActiveFocus function.
    function forceActiveFocus() {
        textInput.forceActiveFocus();
    }

    // Overriding QtQuick.Item activeFocus property.
    // FIXME: Bails out with Cannot override FINAL property
    //property alias activeFocus: textInput.activeFocus

    // TODO: fix default size
    implicitWidth: theme.defaultFont.mSize.width*12
    implicitHeight: theme.defaultFont.mSize.height*1.6
    // TODO: needs to define if there will be specific graphics for
    //     disabled text fields
    opacity: enabled ? 1.0 : 0.5

    Private.TextFieldFocus {
        id: hover
        state: textInput.activeFocus ? "focus" : (mouseWatcher.containsMouse ? "hover" : "hidden")
        anchors.fill: base
    }

    FluidCore.FrameSvgItem {
        id: base

        // TODO: see what is the correct policy for margins
        anchors.fill: parent
        imagePath: "widgets/lineedit"
        prefix: "base"
    }

    MouseArea {
        id: mouseWatcher
        anchors.fill: hover
        hoverEnabled: true
        onClicked: {
            // If we don't set focus on click here then clicking between the
            // line of text and the bottom or top of the widget will not focus
            // it.
            textInput.forceActiveFocus();
        }
    }

    Text {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 2 * base.margins.left
            rightMargin: 2 * base.margins.right
        }
        text: placeholderText
        visible: textInput.text == "" && !textField.activeFocus
        // XXX: using textColor and low opacity for theming placeholderText
        color: theme.textColor
        opacity: 0.5
        elide: Text.ElideRight
        clip: true
        font.capitalization: theme.defaultFont.capitalization
        font.family: theme.defaultFont.family
        font.italic: theme.defaultFont.italic
        font.letterSpacing: theme.defaultFont.letterSpacing
        font.pointSize: theme.defaultFont.pointSize
        font.strikeout: theme.defaultFont.strikeout
        font.underline: theme.defaultFont.underline
        font.weight: theme.defaultFont.weight
        font.wordSpacing: theme.defaultFont.wordSpacing
    }

    TextInput {
        id: textInput

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            // TODO: see what is the correct policy for margins
            leftMargin: 2 * base.margins.left
            rightMargin: 2 * base.margins.right + (clearButton.opacity > 0 ? clearButton.width : 0)
        }
        echoMode: passwordMode ? TextInput.Password : TextInput.Normal
        passwordCharacter: "•"
        selectByMouse: true
        color: theme.textColor
        enabled: textField.enabled
        clip: true
        focus: true
        onActiveFocusChanged: {
            if (!textField.activeFocus) {
                textInput.closeSoftwareInputPanel()
            }
        }
        onAccepted: textField.accepted()
    }

    Private.IconLoader {
        id: clearButton
        source: "edit-clear-locationbar-rtl"
        height: Math.max(textInput.height, theme.smallIconSize)
        width: height
        opacity: (textInput.text != "" && clearButtonShown) ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
        anchors {
            right: parent.right
            rightMargin: y
            verticalCenter: textInput.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                textInput.text = ""
                textInput.forceActiveFocus()
            }
        }
    }
}
