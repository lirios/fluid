// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick.Templates as T

/*!
    \class Action
    \brief Describes a reusable Fluid action.

    Action extends the Qt Quick Templates action API with optional supporting,
    trailing, and badge content used by Material controls. The inherited
    properties provide the primary text, icon, enabled and checkable state,
    shortcut, and triggered signal.

    Menu's default delegate presents the extended fields automatically. Other
    controls may use or ignore them according to their supported layout.

    \code{.qml}
    MD.Menu {
        MD.Action {
            text: qsTr("Open")
            supportingText: qsTr("Open the selected document")
            trailingText: qsTr("Local")
            badgeContent: 3
            onTriggered: openDocument()
        }
    }
    \endcode

    \sa Menu, MenuItem, AppBarAction, RichToolTip
*/
T.Action {
    //! Optional secondary text displayed below the inherited \c text. The default is empty.
    property string supportingText: ""

    //! Optional text displayed in a control's trailing area. The default is empty.
    property string trailingText: ""

    //! Optional textual or numeric badge content. The default is empty; numeric zero is valid.
    property var badgeContent: ""
}
