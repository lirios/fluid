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

Item {
    id: root

    property url source
    property int fillMode: Image.Stretch
    property int fadeDuration: 250
    readonly property bool running: animation.running
    property bool animationEnabled: true
    property alias sourceSize: __priv.sourceSize
    readonly property int status: __priv.loadingImage ? __priv.loadingImage.status : Image.Null
    property bool smooth: true

    signal imageSwapped()

    QtObject {
        id: __priv

        property size sourceSize: Qt.size(undefined, undefined)

        property Image currentImage: image1
        property Image nextImage: image2
        property Image loadingImage: currentImage

        onSourceSizeChanged: {
            // Change source size for both images
            image1.sourceSize = sourceSize;
            image2.sourceSize = sourceSize;
        }

        function swapImages() {
            // Swap images stacking order and start fading animation
            __priv.currentImage.z = 0;
            __priv.nextImage.z = 1;
            if (root.animationEnabled)
                animation.start();

            // Swap images pointers
            var oldImage = __priv.currentImage;
            __priv.currentImage = __priv.nextImage;
            __priv.nextImage = oldImage;
        }
    }

    onSourceChanged: {
        // Set image pointers at creation time
        if (__priv.currentImage === null) {
            __priv.currentImage = image1;
            __priv.nextImage = image2;
        }

        // Stop the animation if the source is changed while
        // it's still running
        animation.stop();

        // Unload both images
        if (root.source == "") {
            __priv.currentImage.source = "";
            __priv.nextImage.source = "";
            __priv.loadingImage = null;
            return;
        }

        if (__priv.currentImage.source == "") {
            // Assign the source to the current image for the first time
            __priv.currentImage.source = root.source;
            __priv.loadingImage = __priv.currentImage;
        } else {
            // Image source is changed, make sure the animation is not running
            animation.stop();

            // Prepare the next image
            __priv.nextImage.opacity = 0.0;
            __priv.nextImage.source = root.source;
            __priv.loadingImage = __priv.nextImage;

            // If the next image is still cached the status will already be Ready
            // otherwise it's not loaded, either way we need to swap
            if (__priv.nextImage.status === Image.Ready || __priv.nextImage.source === "")
                __priv.swapImages();
        }
    }

    Connections {
        target: __priv.nextImage
        onOpacityChanged: {
            if (__priv.nextImage.opacity == 1.0)
                root.imageSwapped();
        }
        onStatusChanged: {
            if (__priv.nextImage.status === Image.Ready)
                __priv.swapImages();
        }
    }

    Image {
        id: image1
        anchors.fill: parent
        cache: false
        asynchronous: true
        fillMode: root.fillMode
        smooth: root.smooth
        clip: root.clip
        z: 1
    }

    Image {
        id: image2
        anchors.fill: parent
        cache: false
        asynchronous: true
        fillMode: root.fillMode
        smooth: root.smooth
        clip: root.clip
        z: 0
    }

    NumberAnimation {
        id: animation
        target: __priv.nextImage
        property: "opacity"
        to: 1.0
        duration: root.fadeDuration
        onRunningChanged: {
            // When the fade animation stops, we unload the second image in
            // order to save some memory (only one image will be load at a time)
            if (!running)
                __priv.nextImage.source = "";
        }
    }
}
