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

import QtQuick 2.10

/*!
   \qmltype Tab
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Tab for tabbed pages.

   Tab of a \l TabbedPage.
 */
Item {
    id: tab

    /*!
        This property holds the tab icon information.
     */
    property QtObject icon: QtObject {
        property string name
        property url source
        property int width: 24
        property int height: 24
        property color color: "transparent"
    }

    /*!
       The title of this tab.
     */
    property string title

    /*!
        Controls whether a close button will be shown for this tab.
     */
    property bool canRemove: false
}
