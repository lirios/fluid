/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Fluid.Core 1.0

/*!
   \qmltype Action
   \inqmlmodule Fluid.UI 1.0

   \brief Represents an action shown in an action bar, context menu, or list.

   One of the most common uses of actions is displaying actions in the action bar of a page
   using the \l Page::actions property. See the example for \l Page for more details.
 */
QtObject {
    id: action

    /*!
       Set to \c false to disable the action in the UI.
     */
    property bool enabled: true

    property string iconName

    /*!
       A URL pointing to an image to display as the icon. By default, this is
       a special URL representing the icon named by \l iconName from the Material Design
       icon collection or FontAwesome. The icon will be colorized using the specificed \l color,
       unless you put ".color." in the filename, for example, "app-icon.color.svg".

       \sa iconName
       \sa Icon
     */
    property url iconSource: Utils.getSourceForIconName(iconName)

    /*!
       The text displayed for the action.
     */
    property string text

    /*!
       The tooltip displayed for the action.
     */
    property string tooltip

    /*!
       Set to \c false to hide the action in the UI.
     */
    property bool visible: true

    signal triggered(var source)
}
