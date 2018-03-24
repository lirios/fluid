/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Magnus Groß <magnus.gross21@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Fluid.Controls 1.0 as FluidControls

/*!
  \qmltype SearchBar
  \inqmlmodule Fluid.Controls
  \ingroup fluidcontrols

  \brief Provides a searchbar, that supports autocompletion and displays search results using cards.
*/
Item {
    id: searchBar

    /*!
        \qmlproperty string searchText

        The current search text in the search bar typed in so far.
    */
    property alias searchText: searchTextField.text

    /*!
        \qmlproperty any model

        The suggestions to display.

        \sa SearchBar::suggestionTextRole
        \sa SearchBar::suggestionDelegate
    */
    property alias searchSuggestions: suggestionsListView.model

    /*!
      The delegate item for the suggestion list view.
      \sa searchSuggestions
    */
    property alias suggestionDelegate: suggestionsListView.delegate

    /*!
      The model type that contains the text to display in the suggestion delegate
      \sa searchSuggestions
    */
    property string suggestionTextRole: "text"

    /*!
      The string to display when the search field is empty
    */
    property string searchPlaceHolder: qsTr("Search")

    /*!
      The width of the search card. By default the search bar centers in the parent with a margin of 64 each side
    */
    property int cardWidth: searchBar.width - Units.largeSpacing

    /*!
      The viewable area of the suggestions list until it begins scrolling.
    */
    property int suggestionsHeight: 300

    /*!
      The background color of the expanded search bar.
    */
    property color waveColor: Material.accentColor

    /*!
      Whether the SearchBar is persistent or expandable
    */
    property bool persistent: false

    /*!
      Whether the SearchBar is currently open
    */
    readonly property alias expanded: searchWave.open

    /*!
      The model containing the search results
    */
    property var searchResults: ListModel {}

    /*!
      Is emitted, when the user searches for a query. The \a query parameter contains the search query as string. Use this signal to provide search results.
    */
    signal search(string query)

    /*!
      Opens the search bar
    */
    function open() {
        searchWave.openWave(openSearchButton.x, openSearchButton.y);
        searchTextField.forceActiveFocus();
    }

    /*!
      Closes the search bar
    */
    function close() {

        if (persistent)
            return;

        searchWave.closeWave(searchWave.initialX, searchWave.initialY);
        searchSuggestions.clear();
        searchResults.clear();
        searchTextField.focus = false;
    }

    anchors {left: parent.left; right: parent.right; top: parent.top}
    height: 64

    Item {
        anchors.fill: parent
        FluidControls.ToolButton {
            id: openSearchButton

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 8

            icon.source: FluidControls.Utils.iconUrl("action/search")

            onClicked: open()
        }

        FluidControls.Wave {
            id: searchWave
            anchors.fill: parent
            size: persistent ? diameter : 0
            visible: persistent
            Rectangle {
                anchors.fill: parent
                color: waveColor
            }
            FluidControls.Card {
                id: searchCard
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: Units.smallSpacing
                width: cardWidth
                height: openSearchButton.height
                FluidControls.ToolButton {
                    id: dismissSearchButton
                    icon.source: FluidControls.Utils.iconUrl(persistent ? "action/search" : "navigation/arrow_back")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: persistent ? 0 : searchWave.open ? 0 : 180
                    onClicked: {
                        if (persistent)
                            search(searchTextField.text);
                        else
                            close();
                    }

                    Behavior on rotation {
                        NumberAnimation {
                            easing.type: Easing.InOutCubic
                            duration: 150
                        }
                    }
                }
                TextInput {
                    id: searchTextField
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: dismissSearchButton.right
                    anchors.right: resetSearchButton.left
                    font.pixelSize: parent.height/2
                    Keys.onReturnPressed: search(text)
                    Keys.onEscapePressed: {
                        if (!persistent)
                            close();
                    }
                    Keys.onDownPressed: suggestionsListView.forceActiveFocus()
                    onTextChanged: {
                        searchResults.clear();
                        searchSuggestions.clear();
                    }
                    inputMethodHints: Qt.ImhNoPredictiveText
                }
                Label {
                    text: searchPlaceHolder
                    visible: searchTextField.displayText === ""
                    anchors.fill: searchTextField
                    verticalAlignment: Label.AlignVCenter
                    font.pixelSize: searchTextField.font.pixelSize
                    color: Material.color(Material.Grey, Material.Shade400)
                }

                FluidControls.ToolButton {
                    id: resetSearchButton
                    opacity: searchTextField.displayText !== ""
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    icon.source: FluidControls.Utils.iconUrl("navigation/close")
                    rotation: opacity*90
                    onClicked: {
                        searchTextField.clear();
                        searchTextField.forceActiveFocus();
                    }
                    Behavior on opacity {
                        NumberAnimation {
                            easing.type: Easing.InOutCubic
                            duration: 200
                        }
                    }
                }
            }
        }
    }
    ListView {
        id: suggestionsListView
        visible: searchResults.count === 0 && searchSuggestions.count !== 0
        anchors.top: parent.bottom
        x: searchCard.x
        width: cardWidth
        height: suggestionsHeight
        model: ListModel {}
        clip: true
        Keys.onUpPressed: {
            if (currentIndex == 0) {
                searchTextField.forceActiveFocus();
            } else {
                decrementCurrentIndex();
            }
        }
        delegate: ListItem {
            text: model[suggestionTextRole]
            highlighted: suggestionsListView.focus === true && suggestionsListView.currentIndex === index
            function autoComplete() {
                searchTextField.text = this.text;
                searchTextField.forceActiveFocus();
            }
            Keys.onReturnPressed: autoComplete();
            onClicked: autoComplete();
            icon.source: FluidControls.Utils.iconUrl("action/search")
        }
    }
}
