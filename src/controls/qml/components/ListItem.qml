// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import Fluid as MD
import "../internal/MotionAnimation.js" as MotionAnimation
import "../core/UiMetrics.js" as UiMetrics

/*!
    \class ListItem
    \brief A Material Design 3 list item with leading, content, and trailing slots.

    A list item is composed of three slots: leading, content, and trailing.  The
    content slot is required and contains a label plus optional overline and
    supporting text.  The leading and trailing slots are optional and accept
    visual elements, selection controls, or any custom content.

    Height adapts automatically according to the MD3 baseline specification:
    one-line items are 56 dp tall, two-line items are 72 dp tall, and three-line
    items are 88 dp tall.

    \code
    MD.ListItem {
        text: "Primary label"
        supportingText: "Supporting line"

        leading: MD.Icon {
            name: MD.Symbols.accountCircle
        }

        trailing: MD.Icon {
            name: MD.Symbols.chevronRight
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/lists/overview">Material Design 3 list guidelines</a>.
*/
T.ItemDelegate {
    id: control

    /*!
        \brief Optional overline text displayed above the label.

        Rendered in \c labelSmall typescale and \c onSurfaceVariant color.
    */
    property string overline: ""

    /*!
        \brief Optional supporting text displayed below the label.

        Wraps up to two lines.  Rendered in \c bodyMedium typescale and
        \c onSurfaceVariant color.
    */
    property string supportingText: ""

    /*!
        \brief Component instantiated in the leading slot.

        Typical content includes an avatar, icon, image, thumbnail, checkbox,
        radio button, or switch.  Must be narrower than the content slot.
    */
    property Component leading: null

    /*!
        \brief Component instantiated in the trailing slot.

        Typical content includes an icon, icon button, trailing text, checkbox,
        radio button, or switch.  Must be narrower than the content slot.
    */
    property Component trailing: null

    /*!
        \brief If true, the item is rendered in M3 Expressive segmented style.

        In a segmented list, each item is visually separated from its neighbours
        by a gap rather than a divider line, and the container of every item is
        filled with the surface-container color.  The first item in the list
        receives rounded corners on its top edge and the last item receives
        rounded corners on its bottom edge, giving the list a card-like silhouette.
    */
    property bool segmented: false

    /*!
        \internal

        This property indicates whether this item is the first in the list,
        for the purpose of applying rounded corners in segmented style.

        ListView does not provide built-in attached properties for first/last,
        so we define our own read-only properties that check the view and index.

        This is safe to use even if the ListItem is not in a ListView,
        since it checks for view !== null before accessing the index.
    */
    readonly property bool _first: ListView.view !== null && index === 0

    /*!
        \internal

        This property indicates whether this item is the last in the list,
        for the purpose of applying rounded corners in segmented style.

        ListView does not provide built-in attached properties for first/last,
        so we define our own read-only properties that check the view and index.

        This is safe to use even if the ListItem is not in a ListView,
        since it checks for view !== null before accessing the index.
    */
    readonly property bool _last: ListView.view !== null && index === ListView.view.count - 1

    QtObject {
        id: internal

        // Active text row count: label (always 1) plus optional overline and
        // optional supporting text.  Determines the item's baseline height.
        readonly property int lineCount: 1 + (overline.length > 0 ? 1 : 0) + (supportingText.length > 0 ? 1 : 0)
    }

    implicitWidth: Math.max(parent ? parent.width : 0, implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    topPadding: MD.Tokens.listItem.topSpace
    bottomPadding: MD.Tokens.listItem.bottomSpace
    leftPadding: MD.Tokens.listItem.leadingSpace
    rightPadding: MD.Tokens.listItem.trailingSpace
    spacing: MD.Tokens.listItem.betweenSpace

    topInset: control.segmented && !control._first ? MD.Tokens.listItem.segmentedGap : 0
    bottomInset: control.segmented && !control._last ? MD.Tokens.listItem.segmentedGap : 0

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    Accessible.name: text
    Accessible.description: supportingText

    // -------------------------------------------------------------------------
    // State object — holds all interaction-driven visual values in one place
    // so the states array only needs PropertyChanges targets, not inline logic.
    // -------------------------------------------------------------------------
    QtObject {
        id: _state

        property color containerColor: control.segmented ? control.MD.Style.surfaceContainerColor : control.MD.Style.surfaceColor
        property color labelColor: control.MD.Style.onSurfaceColor
        property color overlineColor: control.MD.Style.onSurfaceVariantColor
        property color supportingTextColor: control.MD.Style.onSurfaceVariantColor
        property color stateLayerColor: "transparent"
        property real stateLayerOpacity: 0.0
        property real contentOpacity: 1.0
    }

    states: [
        State {
            name: "disabled"
            when: !control.enabled

            PropertyChanges {
                _state {
                    labelColor: control.MD.Style.onSurfaceColor
                    overlineColor: control.MD.Style.onSurfaceColor
                    supportingTextColor: control.MD.Style.onSurfaceColor
                    contentOpacity: MD.Tokens.listItem.disabledContentOpacity
                }
            }
        },
        State {
            name: "hovered"
            when: control.hovered && control.enabled

            PropertyChanges {
                _state {
                    stateLayerColor: control.MD.Style.onSurfaceColor
                    stateLayerOpacity: MD.Tokens.listItem.hoverStateLayerOpacity
                }
            }
        },
        State {
            name: "focused"
            when: control.visualFocus && control.enabled

            PropertyChanges {
                _state {
                    stateLayerColor: control.MD.Style.onSurfaceColor
                    stateLayerOpacity: MD.Tokens.listItem.focusStateLayerOpacity
                }
            }
        },
        State {
            name: "pressed"
            when: control.down && control.enabled

            PropertyChanges {
                _state {
                    stateLayerColor: control.MD.Style.onSurfaceColor
                    stateLayerOpacity: MD.Tokens.listItem.pressedStateLayerOpacity
                }
            }
        }
    ]

    // -------------------------------------------------------------------------
    // Content item: a RowLayout that arranges the three slots horizontally.
    //
    // The leading and trailing Loaders live as siblings to the RowLayout inside
    // this Item.  LayoutItemProxy nodes inside the RowLayout reference those
    // loaded items, forwarding their implicit sizes and any Layout-attached
    // properties to the row, and positioning the real items inside the slot.
    // -------------------------------------------------------------------------
    contentItem: Item {
        implicitWidth: _row.implicitWidth
        implicitHeight: _row.implicitHeight

        // Loaders are declared outside the RowLayout so that LayoutItemProxy
        // can position the instantiated items within the layout geometry while
        // the items remain direct children of this contentItem.
        Loader {
            id: _leadingLoader

            sourceComponent: control.leading
            active: control.leading !== null
            opacity: _state.contentOpacity
        }

        Loader {
            id: _trailingLoader

            sourceComponent: control.trailing
            active: control.trailing !== null
            opacity: _state.contentOpacity
        }

        RowLayout {
            id: _row

            anchors.fill: parent
            spacing: control.spacing

            // Leading slot — LayoutItemProxy positions the loaded item here and
            // forwards any Layout-attached properties it declares.
            LayoutItemProxy {
                target: _leadingLoader.item
                visible: _leadingLoader.item !== null

                // MD3: for three-line items the leading element aligns to the
                // top with a small top offset; otherwise it centres vertically.
                Layout.alignment: internal.lineCount >= 3 ? (Qt.AlignTop | Qt.AlignLeft) : Qt.AlignVCenter
                Layout.topMargin: internal.lineCount >= 3 ? 4 : 0
            }

            // Content column: overline → label → supporting text
            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                spacing: 0

                // Overline — optional, labelSmall typescale
                MD.Label {
                    Layout.fillWidth: true

                    typescale: MD.Tokens.typescale.labelSmall
                    text: control.overline
                    color: _state.overlineColor
                    opacity: _state.contentOpacity
                    // font.pixelSize: MD.Tokens.typescale.labelSmall.fontSize
                    // font.weight: MD.Tokens.typescale.labelSmall.fontWeight
                    // font.letterSpacing: MD.Tokens.typescale.labelSmall.tracking
                    elide: Text.ElideRight
                    visible: control.overline.length > 0
                    Accessible.ignored: true
                }

                // Label — required, bodyLarge typescale
                MD.Label {
                    Layout.fillWidth: true

                    typescale: MD.Tokens.typescale.bodyLarge
                    text: control.text
                    Accessible.ignored: true
                    color: _state.labelColor
                    opacity: _state.contentOpacity
                    // font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
                    // font.weight: MD.Tokens.typescale.bodyLarge.fontWeight
                    // font.letterSpacing: MD.Tokens.typescale.bodyLarge.tracking
                    elide: Text.ElideRight
                }

                // Supporting text — optional, bodyMedium typescale, ≤ 2 lines
                MD.Label {
                    Layout.fillWidth: true

                    typescale: MD.Tokens.typescale.bodyMedium
                    text: control.supportingText
                    color: _state.supportingTextColor
                    opacity: _state.contentOpacity
                    // font.pixelSize: MD.Tokens.typescale.bodyMedium.fontSize
                    // font.weight: MD.Tokens.typescale.bodyMedium.fontWeight
                    // font.letterSpacing: MD.Tokens.typescale.bodyMedium.tracking
                    maximumLineCount: 2
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    visible: control.supportingText.length > 0
                    Accessible.ignored: true
                }
            }

            // Trailing slot — LayoutItemProxy positions the loaded item here and
            // forwards any Layout-attached properties it declares.
            LayoutItemProxy {
                target: _trailingLoader.item
                visible: _trailingLoader.item !== null
                Layout.alignment: internal.lineCount >= 3 ? (Qt.AlignTop | Qt.AlignRight) : Qt.AlignVCenter
                Layout.topMargin: internal.lineCount >= 3 ? 4 : 0
            }
        }
    }

    // -------------------------------------------------------------------------
    // Background: surface container with an MD3 ripple state layer.
    // implicitHeight encodes the MD3 baseline heights: 56 / 72 / 88 dp.
    // -------------------------------------------------------------------------
    background: Rectangle {
        implicitWidth: 64
        implicitHeight: {
            if (internal.lineCount >= 3)
                return MD.Tokens.listItem.threeLineContainerHeight;
            if (internal.lineCount === 2)
                return MD.Tokens.listItem.twoLineContainerHeight;
            return MD.Tokens.listItem.oneLineContainerHeight;
        }

        topLeftRadius: control.segmented && control._first
                       ? UiMetrics.resolveShapeRadius(
                             MD.Tokens.listItem.selectedContainerExpressiveShape.topLeft,
                             width, height) : 0
        topRightRadius: control.segmented && control._first
                        ? UiMetrics.resolveShapeRadius(
                              MD.Tokens.listItem.selectedContainerExpressiveShape.topRight,
                              width, height) : 0
        bottomLeftRadius: control.segmented && control._last
                          ? UiMetrics.resolveShapeRadius(
                                MD.Tokens.listItem.selectedContainerExpressiveShape.bottomLeft,
                                width, height) : 0
        bottomRightRadius: control.segmented && control._last
                           ? UiMetrics.resolveShapeRadius(
                                 MD.Tokens.listItem.selectedContainerExpressiveShape.bottomRight,
                                 width, height) : 0

        color: _state.containerColor

        Behavior on topLeftRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on topRightRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on bottomLeftRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }
        Behavior on bottomRightRadius {
            NumberAnimation {
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                duration: MotionAnimation.expressiveFastSpatialDuration
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }

        MD.Ripple {
            anchors.fill: parent
            topLeftRadius: parent.topLeftRadius
            topRightRadius: parent.topRightRadius
            bottomLeftRadius: parent.bottomLeftRadius
            bottomRightRadius: parent.bottomRightRadius
            color: _state.stateLayerColor
            pressed: control.down
            pressX: control.pressX
            pressY: control.pressY
            stateOpacity: _state.stateLayerOpacity
        }
    }
}
