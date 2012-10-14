/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
 *
 * $END_LICENSE$
 ***************************************************************************/

// ToolBarLayout is a container for items on a toolbar that automatically
// implements an appropriate layout for its children.

/**Documented API
Inherits:
        Row

Imports:
        QtQuick 2.0

Description:
        ToolBarLayout is a container for items on a toolbar that automatically implements an appropriate layout for its children.
**/

import QtQuick 2.0

Row {
    id: root

    visible: false

    Item {
        id: spacer
        width: 10
        height: 10
    }

    QtObject {
        id: internal
        property bool layouting: false
        function layoutChildren()
        {
            var numChildren = root.children.length
            if (layouting || parent == null ||
                root.width == 0 || numChildren < 2) {
                return
            }

            layouting = true
            spacer.parent = null

            spacer.width = root.parent.width - root.childrenRect.width -10

            var last = root.children[numChildren-2]
            last.parent = null
            spacer.parent = root
            last.parent = root
            layouting = false
        }
    }

    Component.onCompleted: internal.layoutChildren()
    onChildrenChanged: internal.layoutChildren()
    onWidthChanged: internal.layoutChildren()
}
