/*
 * This file is part of Fluid.
 *
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
import Fluid.Effects 1.0

/*!
    \qmltype CircleImage
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Circular image.

    An \l Image with a \l CircleMask.
*/
Item {
    id: item

    /*!
        \qmlproperty url source

        URL of the image to load.

        \sa Image::source
    */
    property alias source: image.source

    /*!
        \qmlproperty enumeration status
        \list
            \li Image.Null - no image has been set
            \li Image.Ready - the image has been loaded
            \li Image.Loading - the image is currently being loaded
            \li Image.Error - an error occurred while loading the image
        \endlist

        Status of the image loading.

        \sa Image::status
    */
    property alias status: image.status

    /*!
        \qmlproperty size sourceSize

        Actual width and height of the loaded image.

        \sa Image::sourceSize
    */
    property alias sourceSize: image.sourceSize

    /*!
        \qmlproperty bool asynchronous

        Specify whether the image should be loaded asynchronously.

        \sa Image::asynchronous
    */
    property alias asynchronous: image.asynchronous

    /*!
        \qmlproperty bool cache

        Specify whether the image should be cached.

        \sa Image::cache
    */
    property alias cache: image.cache

    /*!
        \qmlproperty enumeration fillMode

        Set this property to define what happens when the source image
        has a different size than the item.

        \sa Image::fillMode
    */
    property alias fillMode: image.fillMode

    width: image.implicitWidth
    height: image.implicitHeight

    Image {
        id: image
        anchors.fill: parent
        visible: false
    }

    CircleMask {
        anchors.fill: image
        source: image
    }
}
