/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import Fluid.Core 1.0

Item {
    id: tab

    /*!
       The title of this tab.
     */
    property string title

    /*!
       The icon displayed for this tab. This can be a Material Design icon or an icon from
       FontAwesome. See \l Icon from more details.
     */
	property string iconName

	/*!
       A URL pointing to an image to display as the icon of this tab. By default, this is
       a special URL representing the icon named by \l iconName from the Material Design
       icon collection. The icon will be colorized using the specificed \l color,
       unless you put ".color." in the filename, for example, "app-icon.color.svg".

       \sa iconName
       \sa Icon
     */
    property string iconSource: Utils.getSourceForIconName(iconName)

    /*!
     * Controls whether a close button will be shown for this tab.
     */
    property bool canRemove: false
}
