/****************************************************************************
 * This file is part of Hawaii Framework.
 *
 * Copyright (C) 2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

import QtQuick 2.1
import QtQuick.Controls 1.2 as QtControls
import Hawaii.Components 1.0 as Components
import Hawaii.Shell.Controls.Styles 1.0 as Styles
import org.kde.plasma.core 2.0 as PlasmaCore

/**
 * A text field control with Hawaii style.
 * @inherit QtQuick.Controls.TextField
 */
QtControls.TextField {
    id: textField
    //style: Qt.createComponent(Styles.StyleSettings.path + "/TextFieldStyle.qml", textField)
    style: Qt.createComponent("Styles/" + Styles.StyleSettings.name + "/TextFieldStyle.qml", textField)

    /**
     * Whether the icon to clear the text is visible or not.
     */
    property bool clearButtonShown: false

    Components.Icon {
        id: clearButton
        anchors {
            right: parent.right
            rightMargin: units.smallSpacing
            verticalCenter: textField.verticalCenter
        }
        iconName: __style.clearButton.iconName
        iconSource: __style.clearButton.iconSource
        width: height
        height: Math.max(parent.height * 0.8, __style.clearButton.iconSize)
        opacity: (textField.text != "" && clearButtonShown && textField.enabled) ? 1 : 0
        color: iconName ? __style.clearButton.color : Qt.rgba(0, 0, 0, 0)

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: units.longDuration
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textField.text = "";
                textField.forceActiveFocus();
            }
        }
    }
}
