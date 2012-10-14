/****************************************************************************
**
** Copyright (C) 21.0 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

/**Documented API
Inherits:
        Column

Imports:
        QtQuick 2.0
        ButtonGroup.js

Description:
        A ButtonColumn allows you to group Buttons in a column. It provides a selection-behavior as well.
        Note: This component don't support the enabled property.
        If you need to disable it you should disable all the buttons inside it.
        This is an example,
        <code>
        ButtonColumn {
            Button { text: "Top" }
            Button { text: "Bottom" }
            }
        </code>

Properties:
        bool exclusive:
        Specifies the grouping behavior. If enabled, the checked property on buttons contained
        in the group will be exclusive.The default value is true.
        Note that a button in an exclusive group will allways be checkable

        Item checkedButton:
        Returns the last checked button.
**/

import QtQuick 2.0
import "ButtonGroup.js" as Behavior

Column {
    id: root

    property bool exclusive: true

    property Item checkedButton;

    Component.onCompleted: {
        Behavior.create(root, {direction: Qt.Vertical});
    }

    Component.onDestruction: {
        Behavior.destroy();
    }
}
