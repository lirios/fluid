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
import QtQuick.Controls 2.3 as QQC2
import Fluid.Core 1.0

/*!
   \qmltype Action
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Represents an action shown in an action bar, context menu, or list.

   One of the most common uses of actions is displaying actions in the action bar of a page
   using the \l Page::actions property. See the example for \l Page for more details.

   Actions may contain \l text, an \l icon, a \l toolTip and a \l shortcut.

   \snippet fluidcontrols-action.qml action
*/
QQC2.Action {
    id: action

    /*!
        \qmlproperty string toolTip

        The tool tip displayed for the action.
    */
    property string toolTip

    /*!
        \qmlproperty bool visible

        Set to \c false to hide the action in the UI.

        This property is \c true by default.
    */
    property bool visible: true

    /*!
        \qmlproperty bool hasDividerAfter

        Set to \c true to display a divider after the control bound to this action.

        This property is \c false by default.
    */
    property bool hasDividerAfter: false

    /*!
        \qmlproperty bool hoverAnimation

        Set to \c true to rotate the icon 90 degrees on mouseover.

        This property is \c false by default.
     */
    property bool hoverAnimation: false
}
