/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2015-2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0

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
