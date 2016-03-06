/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2013-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

/*!
    \qmltype Icon
    \inqmlmodule FluidUi 0.2
    \ingroup ui
    \brief Displays an icon from the icon theme or another (local or remote) location.

    An icon from the icon theme can be specified with the \c iconName property
    otherwise an icon from a local or remote source can be specified with the
    \c iconSource property.  Icons can also be colorized, set the \c color
    property to change all pixels with the \c originalColor color.

    Icon themes are a set of icons referred to by a standard name defined in the
    \l{http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html}{Freedesktop Icon Naming Specification}
    to improve consistency between applications.

    Icon themes also respect the
    \l{http://standards.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html}{Freedesktop Icon Theme Specification}.

    Example of icon from the icon theme:
    \code
    Icon {
        iconName: "gimp"
        width: 64
        height: 64
    }
    \endcode

    Example of icon from a local source:
    \code
    Icon {
        iconSource: "edit-cut.png"
        width: 16
        height: 16
    }
    \endcode

    Example of colorization:
    \code
    Icon {
        iconName: "edit-cut-symbolic"
        width: 16
        height: 16
        color: "green"
    }
    \endcode
*/
Item {
    id: root

    /*! This property holds the icon name according to the Freedesktop
        icon naming specification.

        To set icons you either set this property or \c iconSource.
    */
    property string iconName

    /*! This property holds the source URL of the icon to display.

        To set icons you either set this property or \c iconSource.
    */
    property url iconSource

    /*! Original color of the icon.

        When \c color will be set, this component will render the icon
        by replacing all pixels of \c originalColor color to \c color.

        This is set to \l #bebebe by default but can be changed
        to match the original color of the icon.
    */
    property alias originalColor: effect.keyColor

    /*! Output color of the icon.

        Colors that were originally of \c originalColor color will be
        changed to this color.

        Symbolic icons are simplified icons that usually are monochrome.
        Don't set this property for non-symbolic icons unless you know
        what you are doing.
    */
    property alias color: effect.outputColor

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
    property alias status: image.status

    /*!
        Specifies whether the image should be cached.
        The default value is true.

        Setting cache to false is useful when dealing with large images,
        to make sure that they aren't cached at the expense of small
        'ui element' images.
    */
    property alias cache: image.cache

    Image {
        id: image
        anchors.fill: parent
        source: {
            // Don't load an image until this component is ready
            if (width <= 0 || height <= 0)
                return "";

            // Icon names have precedence over icon URLs
            if (root.iconName != "")
                return "image://desktoptheme/" + root.iconName;
            if (root.iconSource != "")
                return root.iconSource;
            return "";
        }
        sourceSize.width: width
        sourceSize.height: height
        cache: true
        smooth: true
        visible: !effect.visible
    }

    ShaderEffect {
        property Image source: visible ? image : null
        property color keyColor: "#bebebe"
        property color outputColor: Qt.rgba(0, 0, 0, 0)
        property real sensitivity: 0.05
        property real smoothing: 0.01

        id: effect
        anchors.fill: parent
        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform highp vec4 keyColor;
            uniform highp vec4 outputColor;
            uniform lowp float sensitivity;
            uniform lowp float smoothing;
            uniform lowp float qt_Opacity;

            void main() {
                lowp vec4 sourceColor = texture2D(source, qt_TexCoord0);
                lowp float blendValue = smoothstep(sensitivity, sensitivity + smoothing,
                                                   distance(sourceColor.rgb / sourceColor.a, keyColor.rgb));
                gl_FragColor = mix(outputColor * sourceColor.a, sourceColor, blendValue) * qt_Opacity;
            }
        "
        visible: outputColor != Qt.rgba(0, 0, 0, 0) && image.status == Image.Ready
    }
}
