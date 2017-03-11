/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0

/*!
    \qmltype SmoothFadeImage
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Displays an image and smoothly fade when the source is changed.

    This component can be used in place of an Image when a smooth fade animation
    between two sources is needed.

    When the source is changed and the fade animation ends, the image loaded before
    is unloaded; this means that only one image at a time is loaded.

    Images are loaded asynchronously and are not cache, so unlike the Image
    component the \c asynchronous and \c cache properties are not available.

    Example of usage:
    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0

    Item {
        width: 128
        height: 128

        SmoothFadeImage {
            anchors.fill: parent
            source: "http://www.maui-project.org/images/logos/m.png"
            fillMode: Image.PreserveAspectFit
            smooth: true
            fadeDuration: 400

            MouseArea {
                anchors.fill: parent
                onClicked: parent.source = "http://www.maui-project.org/images/logos/qt.png"
            }
        }
    }
    \endcode
*/
Item {
    id: root

    /*!
        The image being displayed.
        SmoothFadeImage can handle any image format supported by Qt, loaded
        from any URL scheme supported by Qt.

        \sa Image::source
    */
    property url source

    /*!
        \qmlproperty enumeration fillMode

        Set this property to define what happens when the source image has a
        different size than the item.

        \list
          \li Image.Stretch - the image is scaled to fit (default)
          \li Image.PreserveAspectFit - the image is scaled uniformly to fit without cropping
          \li Image.PreserveAspectCrop - the image is scaled uniformly to fill, cropping if necessary
          \li Image.Tile - the image is duplicated horizontally and vertically
          \li Image.TileVertically - the image is stretched horizontally and tiled vertically
          \li Image.TileHorizontally - the image is stretched vertically and tiled horizontally
          \li Image.Pad - the image is not transformed
        \endlist

        Defaults to \c Image.Stretch.

        Note that \c clip is false by default which means that the item might
        paint outside its bounding rectangle even if the fillMode is set to PreserveAspectCrop.
    */
    property int fillMode : Image.Stretch

    /*!
        Set this to change the fade animation time (in milliseconds).
        Default value is 250 ms.
    */
    property int fadeDuration: 250

    /*!
        This property holds whether the fade animation is running or not.
    */
    readonly property bool running: animation.running

    /*!
        Set this property to false to disable the fade animation.
        If the animation is disable, SmoothFadeImage behaves like a normal Image.

        The fade animation is enabled by default.
    */
    property bool animationEnabled: true

    /*!
        This property holds the actual width and height of the loaded image.

        Unlike the \c width and \c height properties, which scale the painting of the
        image, this property sets the actual number of pixels stored for the
        loaded image so that large images do not use more memory than necessary.

        For example, this ensures the image in memory is no larger than
        1024x1024 pixels, regardless of the SmoothFadeImage's width and height values:

        \code
            Rectangle {
                width: ...
                height: ...

                Image {
                    anchors.fill: parent
                    source: "reallyBigImage.jpg"
                    sourceSize.width: 1024
                    sourceSize.height: 1024
                }
            }
        \endcode

        If the image's actual size is larger than the sourceSize, the image is
        scaled down. If only one dimension of the size is set to greater than 0,
        the other dimension is set in proportion to preserve the source image's
        aspect ratio. (The \c fillMode is independent of this.)

        If both the sourceSize.width and sourceSize.height are set the image
        will be scaled down to fit within the specified size, maintaining the
        image's aspect ratio. The actual size of the image after scaling is
        available via \c Item::implicitWidth and \c Item::implicitHeight.

        If the source is an intrinsically scalable image (eg. SVG), this property
        determines the size of the loaded image regardless of intrinsic size.
        Avoid changing this property dynamically; rendering an SVG is slow compared
        to an image.

        If the source is a non-scalable image (eg. JPEG), the loaded image will be
        no greater than this property specifies. For some formats (currently only
        JPEG), the whole image will never actually be loaded into memory.

        sourceSize can be cleared to the natural size of the image by setting
        sourceSize to undefined.

        Note: Changing this property dynamically causes the image source to be
        reloaded, potentially even from the network, if it is not in the disk cache.
    */
    property alias sourceSize: __priv.sourceSize

    /*!
        \qmlproperty enumeration status

        This property holds the status of image loading. It can be one of:

        \list
          \li Image.Null - no image has been set
          \li Image.Ready - the image has been loaded
          \li Image.Loading - the image is currently being loaded
          \li Image.Error - an error occurred while loading the image
        \endlist
    */
    readonly property int status: __priv.loadingImage ? __priv.loadingImage.status : Image.Null

    /*!
        This property holds whether the image is smoothly filtered when scaled or
        transformed. Smooth filtering gives better visual quality, but it may be
        slower on some hardware.

        If the image is displayed at its natural size, this property has no
        visual or performance effect.

        By default, this property is set to \c true.
    */
    property bool smooth: true

    /*!
        This signal is emitted when the swap between the old source and the new
        one has happened.
    */
    signal imageSwapped()

    QtObject {
        id: __priv

        property size sourceSize: undefined

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
