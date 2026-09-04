// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import Fluid as MD

/*!
    \class IconLabel
    \brief Lays out an icon and text as a single reusable visual.

    IconLabel supports icon-only, text-only, side-by-side, and stacked layouts.
    It is useful as a content item for buttons and other controls.

    For more information see the Material Design 3
    <a href="https://m3.material.io/styles/icons/overview">icon</a> and
    <a href="https://m3.material.io/styles/typography/overview">typography</a> guidelines.
*/
Item {
    id: root
    Accessible.ignored: true

    /*!
        This property determines how the icon and text are laid out.
    */
    enum Display {
        IconOnly,
        TextOnly,
        TextBesideIcon,
        TextUnderIcon
    }

    component IconData: QtObject {
        property string name
        property url source
        property real width: -1
        property real height: -1
        property color color
    }

    //! The icon name or image source, dimensions, and color.
    property IconData icon: IconData {}

    //! The text displayed beside or below the icon.
    property alias text: label.text

    //! The Material type scale used for the text.
    property alias typescale: label.typescale

    //! The explicit text line height.
    property alias lineHeight: label.lineHeight

    //! The text color.
    property alias color: label.color

    //! The opacity applied to the text independently of the icon.
    property real textOpacity: 1.0

    //! Whether a side-by-side layout places the icon on the trailing edge.
    property bool mirrored: false

    //! Whether the icon graphic is horizontally mirrored with the layout.
    property bool mirrorIconInRtl: false

    /*!
        Whether the button has an icon. This is used to determine padding and layout.
    */
    readonly property bool hasIcon: icon.name.length > 0 || icon.source.toString().length > 0

    /*!
        Whether the icon should be shown. This is used to determine padding and layout.
    */
    readonly property bool showIcon: hasIcon && display !== IconLabel.TextOnly

    /*!
        Whether the text should be shown. This is used to determine padding and layout.
    */
    readonly property bool showText: text.length > 0 && display !== IconLabel.IconOnly

    /*!
        The display mode of the icon label.
    */
    property int display: IconLabel.TextBesideIcon

    /*!
        The effective display mode, which accounts for whether the icon is shown or not.
    */
    readonly property int effectiveDisplay: {
        switch (display) {
        case IconLabel.TextBesideIcon:
        case IconLabel.TextUnderIcon:
            if (showIcon && showText)
                return display;
            return showIcon ? IconLabel.IconOnly : IconLabel.TextOnly;
        default:
            return display;
        }
    }

    /*!
        The spacing between the icon and text.
    */
    property real spacing: MD.Tokens.measurement.space100

    /*!
        The effective spacing between the icon and text, which is 0 when either is not shown.
    */
    readonly property real effectiveSpacing: showIcon && showText ? spacing : 0

    implicitWidth: {
        switch (effectiveDisplay) {
        case IconLabel.IconOnly:
            return iconItem.implicitWidth;
        case IconLabel.TextOnly:
            return label.implicitWidth;
        case IconLabel.TextBesideIcon:
            return iconItem.implicitWidth + label.implicitWidth + effectiveSpacing;
        case IconLabel.TextUnderIcon:
            return Math.max(iconItem.implicitWidth, label.implicitWidth);
        }
    }
    implicitHeight: {
        switch (effectiveDisplay) {
        case IconLabel.IconOnly:
            return iconItem.implicitHeight;
        case IconLabel.TextOnly:
            return label.implicitHeight;
        case IconLabel.TextBesideIcon:
            return Math.max(iconItem.implicitHeight, label.implicitHeight);
        case IconLabel.TextUnderIcon:
            return iconItem.implicitHeight + label.implicitHeight + effectiveSpacing;
        }
    }

    Item {
        id: iconItem
        objectName: "iconLabelIcon"

        implicitWidth: root.icon.width
        implicitHeight: root.icon.height
        visible: root.showIcon

        transform: Scale {
            objectName: "iconLabelMirrorTransform"
            origin.x: iconItem.width / 2
            origin.y: iconItem.height / 2
            xScale: root.mirrorIconInRtl && root.mirrored ? -1 : 1
        }

        Image {
            objectName: "iconLabelSourceImage"
            anchors.fill: parent
            source: root.icon.source
            sourceSize: Qt.size(root.icon.width, root.icon.height)
            fillMode: Image.PreserveAspectFit
            visible: root.icon.source.toString().length > 0
        }

        MD.Symbol {
            objectName: "iconLabelSymbol"
            anchors.fill: parent
            name: root.icon.name
            iconWidth: root.icon.width
            iconHeight: root.icon.height
            color: root.icon.color.a > 0 ? root.icon.color : label.color
            visible: root.icon.source.toString().length === 0 && name.length > 0
        }
    }

    MD.Label {
        id: label
        objectName: "iconLabelText"

        font.pixelSize: typescale.fontSize
        font.weight: typescale.fontWeight
        //font.letterSpacing: typescale.tracking

        wrapMode: MD.Label.NoWrap
        elide: MD.Label.ElideRight
        opacity: root.textOpacity
        visible: root.showText && opacity > 0
    }

    states: [
        State {
            name: "iconOnly"
            when: root.effectiveDisplay === IconLabel.IconOnly

            AnchorChanges {
                target: iconItem
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: root.horizontalCenter
                anchors.verticalCenter: root.verticalCenter
            }

            AnchorChanges {
                target: label
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        },
        State {
            name: "textOnly"
            when: root.effectiveDisplay === IconLabel.TextOnly

            AnchorChanges {
                target: label
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: root.horizontalCenter
                anchors.verticalCenter: root.verticalCenter
            }

            AnchorChanges {
                target: iconItem
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        },
        State {
            name: "textBesideIcon"
            when: root.effectiveDisplay === IconLabel.TextBesideIcon && !root.mirrored

            AnchorChanges {
                target: iconItem
                anchors.left: root.left
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: root.verticalCenter
            }

            AnchorChanges {
                target: label
                anchors.left: iconItem.right
                anchors.right: undefined
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: root.verticalCenter
            }

            PropertyChanges {
                target: label
                anchors.leftMargin: root.effectiveSpacing
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }
        },
        State {
            name: "textBesideIconMirrored"
            when: root.effectiveDisplay === IconLabel.TextBesideIcon && root.mirrored

            AnchorChanges {
                target: iconItem
                anchors.left: undefined
                anchors.right: root.right
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: root.verticalCenter
            }

            AnchorChanges {
                target: label
                anchors.left: undefined
                anchors.right: iconItem.left
                anchors.top: undefined
                anchors.bottom: undefined
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: root.verticalCenter
            }

            PropertyChanges {
                target: label
                anchors.leftMargin: 0
                anchors.rightMargin: root.effectiveSpacing
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }
        },
        State {
            name: "textUnderIcon"
            when: root.effectiveDisplay === IconLabel.TextUnderIcon

            AnchorChanges {
                target: iconItem
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: root.top
                anchors.bottom: undefined
                anchors.horizontalCenter: root.horizontalCenter
                anchors.verticalCenter: undefined
            }

            AnchorChanges {
                target: label
                anchors.left: undefined
                anchors.right: undefined
                anchors.top: iconItem.bottom
                anchors.bottom: undefined
                anchors.horizontalCenter: root.horizontalCenter
                anchors.verticalCenter: undefined
            }

            PropertyChanges {
                target: label
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: root.effectiveSpacing
                anchors.bottomMargin: 0
            }
        }
    ]
}
