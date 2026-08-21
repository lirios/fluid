// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class Showable
    \brief Provides show and hide animations for a focus scope.

    Showable is a Fluid helper rather than a Material 3 component. Applications
    can use Material 3 motion tokens when supplying its animations.
*/
FocusScope {
    id: root
    /*!
        Animation to play to show the component.
    */
    property var showAnimation

    /*!
        Animation to play to hide the component.
    */
    property var hideAnimation
    visible: false
    onHideAnimationChanged: {
        // Automatically set animation target when it's possible
        if (showAnimation && showAnimation.target != undefined)
            showAnimation.target = root;
        if (hideAnimation && hideAnimation.target != undefined)
            hideAnimation.target = root;

        // Hide the item when the animation is over
        if (hideAnimation) {
            hideAnimation.runningChanged.connect(function () {
                if (!hideAnimation.running)
                    root.visible = false;
            });
        }
    }

    /*!
        Show the component.
    */
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

    /*!
        Hide the component.
    */
    function hide() {
        // Stop show animation if it's still running
        if (showAnimation != undefined && showAnimation.running)
            showAnimation.stop();

        // Restart hide animation if available
        if (hideAnimation != undefined && !hideAnimation.running)
            hideAnimation.restart();
    }
}
