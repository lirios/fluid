/*
*   Copyright (C) 21.0 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU Library General Public License as
*   published by the Free Software Foundation; either version 2, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details
*
*   You should have received a copy of the GNU Library General Public
*   License along with this program; if not, write to the
*   Free Software Foundation, Inc.,
*   51 Franklin Street, Fifth Floor, Boston, MA  1.011.0301, USA.
*/

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0
        FluidCore 1.0

Description:
        Creates a simple plasma theme based text area.
        Like kates..

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

      * enumeration horizontalAlignment:
      * enumeration verticalAlignment:
        Sets the horizontal and vertical alignment of the text within the TextArea item's width and height.
    By default, the text alignment follows the natural alignment of the text,
    for example text that is read from left to right will be aligned to the left.

    Valid values for horizontalAlignment are:

        * TextEdit.AlignLeft (default)
        * TextEdit.AlignRight
        * TextEdit.AlignHCenter
        * TextEdit.AlignJustify

    Valid values for verticalAlignment are:

        * TextEdit.AlignTop (default)
        * TextEdit.AlignBottom
        * TextEdit.AlignVCenter

      * bool readOnly:
        This property holds if the TextArea can be modified by the user interaction.
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
        This property holds the entire text in the TextArea.

      * enumeration textFormat:
        The way the text property should be displayed.

        * TextEdit.AutoText
        * TextEdit.PlainText
        * TextEdit.RichText
        * TextEdit.StyledText

    The default is TextEdit.AutoText. If the text format is TextEdit.AutoText the text edit will automatically determine whether the text should be treated as rich text. This determination is made using Qt::mightBeRichText().

      * enumeration wrapMode:
        Set this property to wrap the text to the TextArea item's width. The text will only wrap if an explicit width has been set.
        * TextEdit.NoWrap - no wrapping will be performed.
            If the text contains insufficient newlines, then implicitWidth will exceed a set width.
        * TextEdit.WordWrap - wrapping is done on word boundaries only.
            If a word is too long, implicitWidth will exceed a set width.
        * TextEdit.WrapAnywhere - wrapping is done at any point on a line, even if it occurs in the middle of a word.
        * TextEdit.Wrap - if possible, wrapping occurs at a word boundary; otherwise it will occur at the appropriate point on the line, even in the middle of a word.

    The default is TextEdit.NoWrap. If you set a width, consider using TextEdit.Wrap.

      * string placeholderText:
        This property holds the text displayed in when the text is empty.
    The default value is empty string, meaning no placeholderText shown.


Plasma properties:

      * bool interactive:
        This property describes whether the user can interact with the TextArea flicking content.
    A user cannot drag or flick a TextArea that is not interactive.
    This property is useful for temporarily disabling flicking.

      * int contentMaxWidth:
        This property holds the maximum width that the text content can have.

      * int contentMaxHeight:
        This property holds the maximum height that the text content can have.

      * property real scrollWidth:
        This property holds the stepSize of the ScrollBar present at the TextArea
    when it's content are bigger than it's size.

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
         This function returns the character position at x pixels from the left of the TextArea.
     Position 0 is before the first character, position 1 is after the first character but before the second,
     and so on until position text.length, which is after all characters.
     This means that for all x values before the first character this function returns 0,
     and for all x values after the last character this function returns text.length.

       * rectangle positionToRectangle(position):
         Returns the rectangle at the given position in the text.
     The x, y, and height properties correspond to the cursor that would describe that position.

**/

import QtQuick 2.0
import FluidCore 1.0
import "private" as Private

Item {
    id: textArea

    // Common API
    property alias font: textEdit.font // alias to textEdit.font
    property int inputMethodHints
    property bool errorHighlight
    property alias cursorPosition: textEdit.cursorPosition
    property alias horizontalAlignment: textEdit.cursorPosition
    property alias verticalAlignment: textEdit.cursorPosition
    property alias readOnly: textEdit.readOnly
    property alias selectedText: textEdit.selectedText // read-only
    property alias selectionEnd: textEdit.selectionEnd // read-only
    property alias selectionStart: textEdit.selectionStart // read-only
    property alias text: textEdit.text
    property alias textFormat: textEdit.textFormat // enumeration
    property alias wrapMode: textEdit.wrapMode // enumeration
    property string placeholderText

    // functions
    function copy() {
        textEdit.copy();
    }

    function paste() {
        textEdit.paste();
    }

    function cut() {
        textEdit.cut();
    }

    function select(start, end) {
        textEdit.select(start, end);
    }

    function selectAll() {
        textEdit.selectAll();
    }

    function selectWord() {
        textEdit.selectWord();
    }

    function positionAt(pos) {
        return textEdit.positionAt(pos);
    }

    function positionToRectangle(pos) {
        return textEdit.positionToRectangle(pos);
    }

    // Plasma API
    property alias interactive: flickArea.interactive
    property alias contentMaxWidth: textEdit.width
    property alias contentMaxHeight: textEdit.height

    // Set active focus to it's internal textInput.
    // Overriding QtQuick.Item forceActiveFocus function.
    function forceActiveFocus() {
        textEdit.forceActiveFocus();
    }

    // Overriding QtQuick.Item activeFocus property.
    property alias activeFocus: textEdit.activeFocus

    opacity: enabled ? 1.0 : 0.5

    Private.TextFieldFocus {
        id: hover
        state: textArea.activeFocus ? "focus" : (mouseWatcher.containsMouse ? "hover" : "hidden")
        anchors.fill: base
    }

    MouseArea {
        id: mouseWatcher
        anchors.fill: hover
        hoverEnabled: true
    }

    FluidCore.FrameSvgItem {
        id: base

        // TODO: see what is the best policy for margins
        anchors {
            fill: parent
        }
        imagePath: "widgets/lineedit"
        prefix: "base"
    }

    Flickable {
        id: flickArea
        anchors {
            fill: parent
            leftMargin: 2 * base.margins.left
            rightMargin: 2 * base.margins.right + (verticalScroll.visible ? verticalScroll.width : 0)
            topMargin: 2 * base.margins.top
            bottomMargin: 2 * base.margins.bottom + (horizontalScroll.visible ? verticalScroll.width : 0)
        }
        interactive: !verticalScroll.interactive //textArea.activeFocus
        contentWidth: {
            if (textEdit.wrapMode == TextEdit.NoWrap)
                return textEdit.paintedWidth;

            return Math.min(textEdit.paintedWidth, textEdit.width);
        }
        contentHeight: Math.min(textEdit.paintedHeight, textEdit.height)
        clip: true

        TextEdit {
            id: textEdit

            width: flickArea.width
            height: flickArea.height
            clip: true
            wrapMode: TextEdit.Wrap
            enabled: textArea.enabled
            font.capitalization: theme.defaultFont.capitalization
            font.family: theme.defaultFont.family
            font.italic: theme.defaultFont.italic
            font.letterSpacing: theme.defaultFont.letterSpacing
            font.pointSize: theme.defaultFont.pointSize
            font.strikeout: theme.defaultFont.strikeout
            font.underline: theme.defaultFont.underline
            font.weight: theme.defaultFont.weight
            font.wordSpacing: theme.defaultFont.wordSpacing
            color: theme.buttonTextColor
            selectByMouse: verticalScroll.interactive

            onCursorPositionChanged: {
                if (cursorRectangle.x < flickArea.contentX) {
                    flickArea.contentX = cursorRectangle.x;
                    return;
                }

                if (cursorRectangle.x > flickArea.contentX +
                    flickArea.width - cursorRectangle.width) {
                    flickArea.contentX = cursorRectangle.x -
                        cursorRectangle.width;
                    return;
                }

                if (cursorRectangle.y < flickArea.contentY) {
                    flickArea.contentY = cursorRectangle.y;
                    return;
                }

                if (cursorRectangle.y > flickArea.contentY +
                    flickArea.height - cursorRectangle.height) {
                    flickArea.contentY = cursorRectangle.y -
                        cursorRectangle.height;
                    return;
                }
            }

            // Proxying keys events  is not required by the
            //     common API but is desired in the plasma API.
            Keys.onPressed: textArea.Keys.pressed(event);
            Keys.onReleased: textArea.Keys.released(event);

            Text {
                anchors.fill: parent
                text: textArea.placeholderText
                visible: textEdit.text == "" && !textArea.activeFocus
                color: theme.buttonTextColor
                opacity: 0.5
            }
            onActiveFocusChanged: {
                if (!textEdit.activeFocus) {
                    textEdit.closeSoftwareInputPanel()
                }
            }
        }
    }

    ScrollBar {
        id: horizontalScroll
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: flickArea.right
        }
        enabled: parent.enabled
        flickableItem: flickArea
        orientation: Qt.Horizontal
        stepSize: textEdit.font.pixelSize
    }

    ScrollBar {
        id: verticalScroll
        anchors {
            right: parent.right
            top: parent.top
            bottom: flickArea.bottom
        }
        enabled: parent.enabled
        flickableItem: flickArea
        orientation: Qt.Vertical
        stepSize: textEdit.font.pixelSize
    }
}
