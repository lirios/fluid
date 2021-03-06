/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:FDL$
 *
 * Permission is granted to copy, distribute and/or modify this document
 * under the terms of the GNU Free Documentation License, Version 1.3
 * or any later version published by the Free Software Foundation;
 * with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
 * A copy of the license is included in the section entitled "GNU
 * Free Documentation License".
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.10
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

Item {
    //! [action]
    FluidControls.Action {
        id: copyAction
        text: qsTr("&Copy")
        icon.source: FluidCore.Utils.iconUrl("content/content_copy")
        shortcut: StandardKey.Copy
        onTriggered: window.activeFocusItem.copy()
    }
    //! [action]
}
