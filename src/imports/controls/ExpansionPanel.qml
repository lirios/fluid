/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates
import QtQuick.Controls.Material 2.3

/*!
    \qmltype ExpansionPanel
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief An expansion panel is a lightweight container that may either stand alone or be connected to a larger surface, such as a card.

    Expansion panels are best used for lightweight editing of an element, such as selecting a value for a setting.

    Expansion panels may be displayed in a sequence to form creation flows.

    The state of the panel could be controlled by the \l checked property.

    This component support ExlusiveGroup.

    For more information you can read the
    \l{https://material.io/guidelines/components/expansion-panels.html}{Material Design guidelines}.
*/
AbstractButton {
    id: root

    height: checked ? summaryRow.height + spacing*4 + contentLoader.height : summaryRow.height

    bottomPadding: topPadding
    leftPadding: 24
    rightPadding: leftPadding
    topPadding: spacing

    spacing: 16

    /*!
        \qmlproperty real summaryTitleWidthPercentage

        Percentage of the summary title label in terms of parent's width. Note: if \l summarySubtitle is null
        this value is ignored and the title's label will take all the available width.

        If the value is less than 0, or greater than 1, the default value will be used.

        Default value: 0.3
    */
    property real summaryTitleWidthPercentage: 0.3

    /*!
        \qmlproperty Component summaryDelegate

        Delegate of the summary row. By default it contains two labels, one for the \l summaryTitle, one for the \l summarySubtitle
    */
    property alias summaryDelegate: summaryLoader.sourceComponent

    /*!
        \qmlproperty Component expandedPanelDelegate

        Expanded panel content's delegate. By default is null
    */
    property alias expandedPanelDelegate: contentLoader.sourceComponent

    /*!
        \qmlproperty string summaryTitle

        Title of the panel, used only if the \l summaryDelegate is the default one
    */
    property string summaryTitle

    /*!
        \qmlproperty string summarySubtitle

        Subtitle of the panel, used only if the \l summaryDelegate is the default one
    */
    property string summarySubtitle

    FluidTemplates.Card {
        id: card

        width: parent.width

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: root.checked ? root.spacing : 0
        anchors.bottomMargin: anchors.topMargin
    }

    MouseArea {
        id: mouseArea

        width: parent.width
        height: summaryRow.height

        anchors.top: summaryRow.top

        onClicked: root.checked = !root.checked
    }

    Rectangle {
        width: card.width
        height: summaryRow.height

        anchors.top: summaryRow.top
        anchors.left: card.left

        color: mouseArea.pressed && !root.checked ? root.Material.listHighlightColor : "white"
    }

    Row {
        id: summaryRow

        height: summaryLoader.height

        anchors.top: parent.top
        anchors.topMargin: root.checked ? spacing : 0
        anchors.left: parent.left
        anchors.leftMargin: root.leftPadding
        anchors.right: parent.right
        anchors.rightMargin: root.rightPadding

        spacing: root.spacing

        Behavior on height { NumberAnimation { duration: 100 } }

        Loader {
            id: summaryLoader

            width: parent.width - expandedIndicatorIcon.width - parent.spacing

            sourceComponent: Row {

                height: root.checked ? 64 : 48

                spacing: summaryRow.spacing

                FluidControls.BodyLabel {
                    id: titleLabel

                    width: root.summarySubtitle ? parent.width * (0 <= root.summaryTitleWidthPercentage && root.summaryTitleWidthPercentage <= 1 ? root.summaryTitleWidthPercentage : 0.3 ) : parent.width
                    height: parent.height

                    verticalAlignment: FluidControls.BodyLabel.AlignVCenter

                    elide: FluidControls.BodyLabel.ElideRight

                    opacity: 0.87

                    text: root.summaryTitle
                }

                FluidControls.BodyLabel {
                    width: parent.width - parent.spacing - titleLabel.width
                    height: parent.height

                    verticalAlignment: FluidControls.BodyLabel.AlignVCenter

                    elide: FluidControls.BodyLabel.ElideRight

                    opacity: 0.54

                    text: root.summarySubtitle
                }
            }
        }

        FluidControls.Icon {
            id: expandedIndicatorIcon

            anchors.verticalCenter: parent.verticalCenter

            opacity: 0.54

            source: FluidControls.Utils.iconUrl(root.checked ? "hardware/keyboard_arrow_up" : "hardware/keyboard_arrow_down")
        }
    }

    Item {
        height: visible ? contentLoader.height : 0

        anchors.top: summaryRow.bottom
        anchors.topMargin: root.checked ? root.topPadding : 0
        anchors.left: parent.left
        anchors.leftMargin: root.leftPadding
        anchors.right: parent.right
        anchors.rightMargin: root.rightPadding

        visible: root.checked
        clip: true

        Behavior on height { NumberAnimation { duration: 100 } }

        Loader {
            id: contentLoader

            width: parent.width
        }
    }
}
