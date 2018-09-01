/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

FocusScope {
    property var showAnimation
    property var hideAnimation

    id: root
    visible: false
    onHideAnimationChanged: {
        // Automatically set animation target when it's possible
        if (showAnimation && showAnimation.target != undefined)
            showAnimation.target = root;
        if (hideAnimation && hideAnimation.target != undefined)
            hideAnimation.target = root;

        // Hide the item when the animation is over
        if (hideAnimation) {
            hideAnimation.runningChanged.connect(function() {
                if (!hideAnimation.running)
                    root.visible = false;
            });
        }
    }

    function show() {
        // Stop hide animation if it's still running
        if (hideAnimation != undefined && hideAnimation.running)
            hideAnimation.stop();

        // Show the item otherwise we won't see the animation
        visible = true;

        // Restart show animation if available
        if (showAnimation != undefined && !showAnimation.running)
            showAnimation.restart();
    }

    function hide() {
        // Stop show animation if it's still running
        if (showAnimation != undefined && showAnimation.running)
            showAnimation.stop();

        // Restart hide animation if available
        if (hideAnimation != undefined && !hideAnimation.running)
            hideAnimation.restart();
    }
}
