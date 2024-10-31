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

import QtQuick
import QtQuick.Controls as C

/*!
    \brief Represents an action shown in an action bar, context menu, or list.

    One of the most common uses of actions is displaying actions in the action bar of a page
    using the \ref Page::actions property. See the example for \ref Page for more details.

    Actions may contain \ref QtQuick::Controls::Action::text, an \ref QtQuick::Controls::Action::icon, a \ref toolTip and a \ref QtQuick::Controls::Action::shortcut.

    \code{.qml}
    Fluid.Action {
        id: copyAction
        text: qsTr("&Copy")
        icon.source: Fluid.Utils.iconUrl("content/content_copy")
        shortcut: StandardKey.Copy
        onTriggered: window.activeFocusItem.copy()
    }
    \endcode

    \sa <a href="https://doc.qt.io/qt-6/qml-qtquick-controls-action.html">QtQuick::Controls::Action QML Type</a>
    \sa <a href="https://doc.qt.io/qt-6/qml-qtquick-controls-action.html#text-prop">QtQuick::Controls::Action text</a> documentation
    \sa <a href="https://doc.qt.io/qt-6/qml-qtquick-controls-action.html#icon-prop">QtQuick::Controls::Action::icon</a> documentation
    \sa <a href="https://doc.qt.io/qt-6/qml-qtquick-controls-action.html#shortcut-prop">QtQuick::Controls::Action::shortcut</a> documentation
*/
C.Action {
    id: action

    /*!
        The tool tip displayed for the action.
    */
    property string toolTip

    /*!
        Set to \c false to hide the action in the UI.

        This property is \c true by default.
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
}
