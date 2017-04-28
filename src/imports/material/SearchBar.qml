/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Magnus Groß <magnus.gross21@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.1
import Fluid.Controls 1.0
import Fluid.Material 1.0

/*!
  \qmltype SearchBar
  \inqmlmodule Fluid.Material
  \brief Provides a searchbar, that supports autocompletion and displays search results using cards.
*/

Flickable {
    id: searchBar

    /*!
      The current search text in the search bar typed in so far.
    */
    property alias searchText: searchTextField.text

    /*!
      The suggestions to display.
      \sa textRole
      \sa suggestionDelegate
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
    property int cardWidth: searchBar.width - 128

    /*!
      The viewable area of the suggestions list until it begins scrolling.
    */
    property int suggestionsHeight: 300

    /*!
      The background color of the expanded search bar.
    */
    property color waveColor: Material.accentColor

    /*!
      Is emitted, when the user searches for a query. The \a query parameter contains the search query as string. Use this signal to provide search results.
    */
    signal search(string query)

    /*!
      Opens the search bar
    */
    function open() {
        searchWave.open(openSearchButton.x, openSearchButton.y);
        searchTextField.forceActiveFocus();
    }

    /*!
      Closes the search bar
    */
    function close() {
        searchWave.close(searchWave.initialX, searchWave.initialY);
        searchSuggestions.clear();
        searchResults.clear();
    }

    anchors {left: parent.left; right: parent.right; top: parent.top}
    height: 64

    Item {
        anchors.fill: parent
        clip: true
        IconButton {
            id: openSearchButton
            iconName: "action/search"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 8
            onClicked: open()
        }
        Wave {
            id: searchWave
            color: waveColor
            Card {
                id: searchCard
                x: searchWave.size/2 - width
                y: searchWave.size/2 + openSearchButton.height/2 - height/2
                width: cardWidth
                height: openSearchButton.height
                IconButton {
                    id: dismissSearchButton
                    iconName: "navigation/arrow_back"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: searchWave.opened ? 0 : 180
                    onClicked: close()
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
                    Keys.onEscapePressed: close()
                    Keys.onDownPressed: suggestionsListView.forceActiveFocus()
                    onTextChanged: {
                        searchResults.clear();
                        searchSuggestions.clear();
                    }
                }
                Label {
                    text: searchPlaceHolder
                    visible: searchTextField.text === ""
                    anchors.fill: searchTextField
                    font.pixelSize: searchTextField.font.pixelSize
                    color: Material.color(Material.Grey, Material.Shade400)
                }

                IconButton {
                    id: resetSearchButton
                    opacity: searchTextField.text !== ""
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    iconName: "navigation/close"
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
        visible: searchResults.count === 0
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
            iconName: "action/search"
        }
    }
}
