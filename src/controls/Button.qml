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
import Hawaii.Shell.Controls.Styles 1.0 as Styles

/**
 * A button control with Hawaii style.
 * @inherit QtQuick.Controls.Button
 */
QtControls.Button {
    id: button
    //style: Qt.createComponent(Styles.StyleSettings.path + "/ToolButtonStyle.qml", button)
    style: Qt.createComponent("Styles/" + Styles.StyleSettings.name + "/ToolButtonStyle.qml", button)
}
