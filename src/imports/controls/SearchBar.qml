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

Item {
    id: searchBar

    property alias searchText: searchTextField.text

    property alias searchSuggestions: suggestionsListView.model

    property alias suggestionDelegate: suggestionsListView.delegate

    property string suggestionTextRole: "text"

    property string searchPlaceHolder: qsTr("Search")

    property int cardWidth: searchBar.width - Units.largeSpacing

    property int suggestionsHeight: 300

    property color waveColor: Material.accentColor

    property bool persistent: false

    readonly property alias expanded: searchWave.open

    property var searchResults: ListModel {}

    signal search(string query)

    function open() {
        searchWave.openWave(openSearchButton.x, openSearchButton.y);
        searchTextField.forceActiveFocus();
    }

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
