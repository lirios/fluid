/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.5
import Fluid.Core 1.0

/*!
   \qmltype Action
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Represents an action shown in an action bar, context menu, or list.

   One of the most common uses of actions is displaying actions in the action bar of a page
   using the \l Page::actions property. See the example for \l Page for more details.
 */
Object {
    id: action

    /*!
        Set to \c false to disable the action in the UI.
     */
    property bool enabled: true

    /*!
        Icon name from the \l{http://google.github.io/material-design-icons/}{Material Design icon collection} or the
        \l{http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html}{freedesktop icon naming specification}.
    */
    property string iconName

    /*!
        A URL pointing to an image to display as the icon. By default, this is
        a special URL representing the icon named by \l iconName from the Material Design
        icon collection. The icon will be colorized using the specificed color,
        unless you put ".color." in the filename, for example, "app-icon.color.svg".

        \sa iconName
        \sa Icon
    */
    property url iconSource: Utils.getSourceForIconName(iconName)

    /*!
        \qmlproperty keysequence shortcut

        This property holds the shortcut bound to the action.
        The keysequence can be a string or a standard key.
    */
    property alias shortcut: shortcutItem.sequence

    /*!
        The text displayed for the action.
    */
    property string text

    /*!
        The tool tip displayed for the action.
    */
    property string toolTip

    /*!
        The tool tip displayed for the action.
        This property is obsolete and will be removed in the next version.
    */
    property string tooltip: toolTip

    /*!
        Set to \c false to hide the action in the UI.
    */
    property bool visible: true

    /*!
        Set to \c true to display a divider after the control bound to this action.

        This property is \c false by default.
    */
    property bool hasDividerAfter: false

    /*!
        Set to \c true to rotate the icon 90 degrees on mouseover.

        This property is \c false by default.
     */
    property bool hoverAnimation: false

    /*!
        Emitted when a button or menu item bound to this action have been activated.
        Includes the object that triggered the even, if relevant.

        The corresponding handler is \c onTriggered.
    */
    signal triggered(var source)

    Shortcut {
        id: shortcutItem
        onActivated: action.triggered(shortcutItem)
    }
}
