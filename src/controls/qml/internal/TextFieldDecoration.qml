// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "MotionAnimation.js" as MotionAnimation
import QtQuick

/*!
    \class TextFieldDecoration
    \internal
    \brief Lays out the visual decorations and content slots of a text field.

    All state, content, colors, and geometry are supplied explicitly by the
    public TextField. This delegate does not depend on its parent hierarchy.
*/
Item {
    id: decoration

    required property bool mirrored
    required property bool outlined
    required property bool labelFloated
    required property bool inputDecorationVisible
    required property bool fieldEnabled
    required property bool error
    required property real containerHeight
    required property real horizontalPadding
    required property real contentVerticalPadding
    required property real supportingTextTopSpace
    required property real supportingTextMinimumHeight
    required property real outlinedLabelHorizontalPadding
    required property real disabledContentOpacity
    required property real iconTargetSize
    required property real inputCenterY
    required property real leadingReservation
    required property real trailingReservation
    required property real inputLeftPadding
    required property real inputRightPadding
    required property string labelText
    required property string placeholderText
    required property string inputText
    required property string prefixText
    required property string suffixText
    required property string supportingText
    required property string errorText
    required property color labelColor
    required property color supportingColor
    required property color notchColor
    required property var bodyLargeTypeScale
    required property var bodySmallTypeScale

    property Component leading: null
    property Component trailing: null

    readonly property real leadingImplicitWidth: leadingLoader.implicitWidth
    readonly property real trailingImplicitWidth: trailingLoader.implicitWidth
    readonly property real supportingImplicitHeight: supportingLabel.implicitHeight
    readonly property real errorImplicitHeight: errorLabel.implicitHeight

    Rectangle {
        objectName: "textFieldLabelNotch"
        x: fieldLabel.x - decoration.outlinedLabelHorizontalPadding
        y: fieldLabel.y
        width: fieldLabel.width + decoration.outlinedLabelHorizontalPadding * 2
        height: fieldLabel.height
        color: decoration.notchColor
        visible: decoration.outlined && decoration.labelFloated && fieldLabel.visible
        Accessible.ignored: true
    }

    MD.Label {
        id: fieldLabel
        objectName: "textFieldLabel"

        readonly property real availableWidth: Math.max(
                                                   0,
                                                   decoration.width
                                                   - decoration.leadingReservation
                                                   - decoration.trailingReservation)

        x: decoration.mirrored
           ? decoration.width - decoration.leadingReservation - width
           : decoration.leadingReservation
        y: decoration.outlined && decoration.labelFloated
           ? -height / 2
           : decoration.labelFloated
             ? decoration.contentVerticalPadding
             : (decoration.containerHeight - height) / 2
        width: decoration.outlined && decoration.labelFloated
               ? Math.min(fieldLabelFontMetrics.advanceWidth(text), availableWidth)
               : availableWidth
        text: decoration.labelText
        typescale: decoration.labelFloated ? decoration.bodySmallTypeScale
                                           : decoration.bodyLargeTypeScale
        color: decoration.labelColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        visible: text.length > 0
        Accessible.ignored: true

        Behavior on x {
            NumberAnimation {
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: MotionAnimation.expressiveFastEffectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
            }
        }
    }

    FontMetrics {
        id: fieldLabelFontMetrics
        font: fieldLabel.font
    }

    MD.Label {
        objectName: "textFieldPlaceholder"
        x: decoration.inputLeftPadding
        y: decoration.inputCenterY - height / 2
        width: Math.max(0, decoration.width
                           - decoration.inputLeftPadding
                           - decoration.inputRightPadding)
        text: decoration.placeholderText
        typescale: decoration.bodyLargeTypeScale
        color: decoration.fieldEnabled ? decoration.MD.Style.onSurfaceVariantColor
                                       : decoration.MD.Style.onSurfaceColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        visible: decoration.inputText.length === 0 && text.length > 0
                 && decoration.inputDecorationVisible
        Accessible.ignored: true
    }

    MD.Label {
        objectName: "textFieldPrefix"
        x: decoration.mirrored
           ? decoration.width - decoration.leadingReservation - width
           : decoration.leadingReservation
        y: decoration.inputCenterY - height / 2
        text: decoration.prefixText
        typescale: decoration.bodyLargeTypeScale
        color: decoration.fieldEnabled ? decoration.MD.Style.onSurfaceVariantColor
                                       : decoration.MD.Style.onSurfaceColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        visible: text.length > 0 && decoration.inputDecorationVisible
        Accessible.ignored: true
    }

    MD.Label {
        objectName: "textFieldSuffix"
        x: decoration.mirrored
           ? decoration.trailingReservation
           : decoration.width - decoration.trailingReservation - width
        y: decoration.inputCenterY - height / 2
        text: decoration.suffixText
        typescale: decoration.bodyLargeTypeScale
        color: decoration.fieldEnabled ? decoration.MD.Style.onSurfaceVariantColor
                                       : decoration.MD.Style.onSurfaceColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        visible: text.length > 0 && decoration.inputDecorationVisible
        Accessible.ignored: true
    }

    Item {
        objectName: "textFieldLeadingSlot"
        x: decoration.mirrored ? decoration.width - width : 0
        y: (decoration.containerHeight - height) / 2
        width: decoration.leadingReservation
        height: Math.max(decoration.iconTargetSize, leadingLoader.implicitHeight)
        enabled: decoration.fieldEnabled
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        visible: decoration.leading !== null

        Loader {
            id: leadingLoader

            anchors.centerIn: parent
            sourceComponent: decoration.leading
            active: decoration.leading !== null
        }
    }

    Item {
        objectName: "textFieldTrailingSlot"
        x: decoration.mirrored ? 0 : decoration.width - width
        y: (decoration.containerHeight - height) / 2
        width: decoration.trailingReservation
        height: Math.max(decoration.iconTargetSize, trailingLoader.implicitHeight)
        enabled: decoration.fieldEnabled
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        visible: decoration.trailing !== null

        Loader {
            id: trailingLoader

            anchors.centerIn: parent
            sourceComponent: decoration.trailing
            active: decoration.trailing !== null
        }
    }

    MD.Label {
        id: supportingLabel
        objectName: "textFieldSupportingText"
        x: decoration.horizontalPadding
        y: decoration.containerHeight + decoration.supportingTextTopSpace
        width: Math.max(0, decoration.width - decoration.horizontalPadding * 2)
        height: Math.max(implicitHeight, decoration.supportingTextMinimumHeight)
        text: decoration.supportingText
        typescale: decoration.bodySmallTypeScale
        color: decoration.supportingColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.Wrap
        elide: Text.ElideNone
        visible: !decoration.error && text.length > 0
        Accessible.ignored: true
    }

    MD.Label {
        id: errorLabel
        objectName: "textFieldErrorText"
        x: supportingLabel.x
        y: supportingLabel.y
        width: supportingLabel.width
        height: Math.max(implicitHeight, decoration.supportingTextMinimumHeight)
        text: decoration.errorText
        typescale: decoration.bodySmallTypeScale
        color: decoration.supportingColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.Wrap
        elide: Text.ElideNone
        visible: decoration.error && text.length > 0
        Accessible.ignored: true
    }
}
