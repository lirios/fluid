// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick

/*!
    \class FieldDecoration
    \internal
    \brief Shared visual decoration for Material 3 text-field templates.

    FieldDecoration is intentionally independent from the public Fluid module.
    Public controls provide all component tokens, semantic colors, content,
    state, and motion values explicitly. The background component is loaded by
    the owning template while labels and slots remain in this overlay so
    interactive slot content retains pointer and accessibility behavior.
*/
Item {
    id: decoration

    required property string containerObjectName
    required property string activeIndicatorObjectName
    required property string labelNotchObjectName
    required property string labelObjectName
    required property string placeholderObjectName
    required property string prefixObjectName
    required property string suffixObjectName
    required property string leadingSlotObjectName
    required property string trailingSlotObjectName
    required property string supportingObjectName
    required property string errorObjectName

    required property bool mirrored
    required property bool outlined
    required property bool fieldFocused
    required property bool fieldEnabled
    required property bool error
    required property bool containerTransitionsEnabled
    required property bool labelTransitionsEnabled
    required property bool indicatorTransitionsEnabled
    required property bool applySlotDisabledOpacity

    required property real backgroundImplicitWidth
    required property real containerHeight
    required property real horizontalPadding
    required property real contentVerticalPadding
    required property real supportingTextTopSpace
    required property real supportingTextMinimumHeight
    required property real outlinedLabelHorizontalPadding
    required property real disabledContentOpacity
    required property real leadingSlotMinimumSize
    required property real trailingSlotMinimumSize
    required property real inputCenterY
    required property real inputBaselineY
    required property bool alignInputDecorationsToBaseline
    required property real leadingReservation
    required property real trailingReservation
    required property real inputLeftPadding
    required property real inputRightPadding
    required property real labelLeadingPosition
    required property real labelTrailingPosition
    required property real fullShapeValue

    required property string labelText
    required property string placeholderText
    required property string inputText
    required property string prefixText
    required property string suffixText
    required property string supportingText
    required property string errorText

    required property color containerColor
    required property color outlineColor
    required property color indicatorColor
    required property color labelColor
    required property color inputDecorationColor
    required property color supportingColor
    required property color notchColor
    required property var containerShape
    required property real outlineWidth
    required property bool activeIndicatorVisible
    required property real activeIndicatorHeight
    required property real activeIndicatorOpacity

    required property string fontFamily
    required property var bodyLargeTypeScale
    required property var bodySmallTypeScale
    required property int supportingWrapMode
    required property int supportingElide

    required property int effectsDuration
    required property int slowEffectsDuration
    required property int spatialDuration
    required property var effectsCurve
    required property var slowEffectsCurve
    required property var spatialCurve

    property Component leading: null
    property Component trailing: null

    readonly property Component backgroundComponent: fieldBackgroundComponent
    readonly property real leadingImplicitWidth: leadingLoader.implicitWidth
    readonly property real trailingImplicitWidth: trailingLoader.implicitWidth
    readonly property real prefixImplicitWidth: prefixLabel.implicitWidth
    readonly property real suffixImplicitWidth: suffixLabel.implicitWidth
    readonly property real labelImplicitHeight: fieldLabel.implicitHeight
    readonly property bool unfocusedEmpty: !fieldFocused && inputText.length === 0
    readonly property real targetLabelProgress: labelText.length > 0 && !unfocusedEmpty ? 1 : 0
    readonly property real targetPlaceholderOpacity: fieldFocused
                                                          || (unfocusedEmpty
                                                              && labelText.length === 0)
                                                       ? 1 : 0
    readonly property real targetAffixOpacity: labelText.length === 0
                                               || fieldFocused
                                               || inputText.length > 0
                                               ? 1 : 0
    property real labelProgress: targetLabelProgress
    property real placeholderOpacity: targetPlaceholderOpacity
    property real affixOpacity: targetAffixOpacity
    readonly property real supportingImplicitHeight: supportingLabel.implicitHeight
    readonly property real errorImplicitHeight: errorLabel.implicitHeight
    readonly property bool hasSupportingContent: error
                                                 ? errorText.length > 0
                                                 : supportingText.length > 0
    readonly property real supportingAreaHeight: hasSupportingContent
                                                  ? supportingTextTopSpace
                                                    + Math.max(
                                                        supportingTextMinimumHeight,
                                                        error
                                                        ? errorImplicitHeight
                                                        : supportingImplicitHeight)
                                                  : 0

    Behavior on labelProgress {
        enabled: decoration.labelTransitionsEnabled

        NumberAnimation {
            duration: decoration.spatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: decoration.spatialCurve
        }
    }

    Behavior on placeholderOpacity {
        enabled: decoration.labelTransitionsEnabled

        NumberAnimation {
            duration: decoration.targetPlaceholderOpacity > 0
                      ? decoration.slowEffectsDuration
                      : decoration.effectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: decoration.targetPlaceholderOpacity > 0
                                ? decoration.slowEffectsCurve
                                : decoration.effectsCurve
        }
    }

    Behavior on affixOpacity {
        enabled: decoration.labelTransitionsEnabled

        NumberAnimation {
            duration: decoration.effectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: decoration.effectsCurve
        }
    }

    function resolveShapeRadius(value, width, height) {
        if (width <= 0 || height <= 0)
            return 0;
        return value === fullShapeValue ? Math.min(width, height) / 2 : value;
    }

    function decorationY(item) {
        return alignInputDecorationsToBaseline
                ? inputBaselineY - item.baselineOffset
                : inputCenterY - item.height / 2;
    }

    Component {
        id: fieldBackgroundComponent

        Item {
            implicitWidth: decoration.backgroundImplicitWidth
            implicitHeight: decoration.containerHeight + decoration.supportingAreaHeight

            Rectangle {
                objectName: decoration.containerObjectName
                width: parent.width
                height: decoration.containerHeight

                readonly property color effectiveBorderColor: border.color
                readonly property real effectiveBorderWidth: border.width

                color: decoration.containerColor
                border.color: decoration.outlineColor
                border.width: decoration.outlineWidth
                topLeftRadius: decoration.resolveShapeRadius(
                                   decoration.containerShape.topLeft, width, height)
                topRightRadius: decoration.resolveShapeRadius(
                                    decoration.containerShape.topRight, width, height)
                bottomLeftRadius: decoration.resolveShapeRadius(
                                      decoration.containerShape.bottomLeft, width, height)
                bottomRightRadius: decoration.resolveShapeRadius(
                                       decoration.containerShape.bottomRight, width, height)

                Behavior on color {
                    enabled: decoration.containerTransitionsEnabled

                    ColorAnimation {
                        duration: decoration.effectsDuration
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: decoration.effectsCurve
                    }
                }

                Behavior on border.color {
                    enabled: decoration.indicatorTransitionsEnabled

                    ColorAnimation {
                        duration: decoration.effectsDuration
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: decoration.effectsCurve
                    }
                }

                Behavior on border.width {
                    enabled: decoration.indicatorTransitionsEnabled

                    NumberAnimation {
                        duration: decoration.spatialDuration
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: decoration.spatialCurve
                    }
                }

                Rectangle {
                    objectName: decoration.activeIndicatorObjectName
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: decoration.activeIndicatorHeight
                    color: decoration.indicatorColor
                    opacity: decoration.activeIndicatorOpacity
                    visible: decoration.activeIndicatorVisible
                    Accessible.ignored: true

                    Behavior on height {
                        enabled: decoration.indicatorTransitionsEnabled

                        NumberAnimation {
                            duration: decoration.spatialDuration
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: decoration.spatialCurve
                        }
                    }

                    Behavior on color {
                        enabled: decoration.indicatorTransitionsEnabled

                        ColorAnimation {
                            duration: decoration.effectsDuration
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: decoration.effectsCurve
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        objectName: decoration.labelNotchObjectName
        readonly property real progress: Math.max(0, Math.min(1, decoration.labelProgress))
        readonly property real fullWidth: fieldLabel.width
                                          + decoration.outlinedLabelHorizontalPadding * 2

        x: fieldLabel.x + fieldLabel.width / 2 - width / 2
        y: fieldLabel.y
        width: fullWidth * progress
        height: fieldLabel.height
        color: decoration.notchColor
        visible: decoration.outlined && progress > 0 && fieldLabel.visible
        Accessible.ignored: true
    }

    Text {
        id: fieldLabel
        objectName: decoration.labelObjectName

        readonly property real availableWidth: Math.max(
                                                   0,
                                                   decoration.width
                                                   - decoration.labelLeadingPosition
                                                   - decoration.labelTrailingPosition)
        readonly property real progress: decoration.labelProgress
        readonly property real boundedProgress: Math.max(0, Math.min(1, progress))
        readonly property real naturalWidth: Math.min(
                                                  fieldLabelFontMetrics.advanceWidth(text),
                                                  availableWidth)

        x: decoration.mirrored
           ? decoration.width - decoration.labelLeadingPosition - width
           : decoration.labelLeadingPosition
        y: (decoration.containerHeight - height) / 2
           + ((decoration.outlined ? -height / 2 : decoration.contentVerticalPadding)
              - (decoration.containerHeight - height) / 2) * progress
        width: decoration.outlined
               ? availableWidth + (naturalWidth - availableWidth) * boundedProgress
               : availableWidth
        text: decoration.labelText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodyLargeTypeScale.fontSize
                        + (decoration.bodySmallTypeScale.fontSize
                           - decoration.bodyLargeTypeScale.fontSize) * progress
        font.weight: Math.round(decoration.bodyLargeTypeScale.fontWeight
                                + (decoration.bodySmallTypeScale.fontWeight
                                   - decoration.bodyLargeTypeScale.fontWeight) * progress)
        font.letterSpacing: decoration.bodyLargeTypeScale.tracking
                            + (decoration.bodySmallTypeScale.tracking
                               - decoration.bodyLargeTypeScale.tracking) * progress
        lineHeight: decoration.bodyLargeTypeScale.lineHeight
                    + (decoration.bodySmallTypeScale.lineHeight
                       - decoration.bodyLargeTypeScale.lineHeight) * progress
        lineHeightMode: Text.FixedHeight
        color: decoration.labelColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        visible: text.length > 0
        Accessible.ignored: true

        Behavior on color {
            enabled: decoration.labelTransitionsEnabled

            ColorAnimation {
                duration: decoration.effectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: decoration.effectsCurve
            }
        }

        Behavior on opacity {
            enabled: decoration.labelTransitionsEnabled

            NumberAnimation {
                duration: decoration.effectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: decoration.effectsCurve
            }
        }
    }

    FontMetrics {
        id: fieldLabelFontMetrics
        font: fieldLabel.font
    }

    Text {
        id: placeholderLabel
        objectName: decoration.placeholderObjectName
        x: decoration.inputLeftPadding
        y: decoration.decorationY(placeholderLabel)
        width: Math.max(0, decoration.width
                           - decoration.inputLeftPadding
                           - decoration.inputRightPadding)
        text: decoration.placeholderText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodyLargeTypeScale.fontSize
        font.weight: decoration.bodyLargeTypeScale.fontWeight
        font.letterSpacing: decoration.bodyLargeTypeScale.tracking
        lineHeight: decoration.bodyLargeTypeScale.lineHeight
        lineHeightMode: Text.FixedHeight
        color: decoration.inputDecorationColor
        opacity: decoration.placeholderOpacity
                 * (decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity)
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        visible: decoration.inputText.length === 0 && text.length > 0
                 && decoration.placeholderOpacity > 0
        Accessible.ignored: true
    }

    Text {
        id: prefixLabel
        objectName: decoration.prefixObjectName
        x: decoration.mirrored
           ? decoration.width - decoration.leadingReservation - width
           : decoration.leadingReservation
        y: decoration.decorationY(prefixLabel)
        text: decoration.prefixText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodyLargeTypeScale.fontSize
        font.weight: decoration.bodyLargeTypeScale.fontWeight
        font.letterSpacing: decoration.bodyLargeTypeScale.tracking
        lineHeight: decoration.bodyLargeTypeScale.lineHeight
        lineHeightMode: Text.FixedHeight
        color: decoration.inputDecorationColor
        opacity: decoration.affixOpacity
                 * (decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity)
        visible: text.length > 0 && decoration.affixOpacity > 0
        Accessible.ignored: true
    }

    Text {
        id: suffixLabel
        objectName: decoration.suffixObjectName
        x: decoration.mirrored
           ? decoration.trailingReservation
           : decoration.width - decoration.trailingReservation - width
        y: decoration.decorationY(suffixLabel)
        text: decoration.suffixText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodyLargeTypeScale.fontSize
        font.weight: decoration.bodyLargeTypeScale.fontWeight
        font.letterSpacing: decoration.bodyLargeTypeScale.tracking
        lineHeight: decoration.bodyLargeTypeScale.lineHeight
        lineHeightMode: Text.FixedHeight
        color: decoration.inputDecorationColor
        opacity: decoration.affixOpacity
                 * (decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity)
        visible: text.length > 0 && decoration.affixOpacity > 0
        Accessible.ignored: true
    }

    Item {
        objectName: decoration.leadingSlotObjectName
        x: decoration.mirrored ? decoration.width - width : 0
        y: (decoration.containerHeight - height) / 2
        width: decoration.leadingReservation
        height: Math.max(decoration.leadingSlotMinimumSize, leadingLoader.implicitHeight)
        enabled: decoration.fieldEnabled
        opacity: !decoration.applySlotDisabledOpacity || decoration.fieldEnabled
                 ? 1 : decoration.disabledContentOpacity
        visible: decoration.leading !== null

        Loader {
            id: leadingLoader
            anchors.centerIn: parent
            sourceComponent: decoration.leading
            active: decoration.leading !== null
        }
    }

    Item {
        objectName: decoration.trailingSlotObjectName
        x: decoration.mirrored ? 0 : decoration.width - width
        y: (decoration.containerHeight - height) / 2
        width: decoration.trailingReservation
        height: Math.max(decoration.trailingSlotMinimumSize, trailingLoader.implicitHeight)
        enabled: decoration.fieldEnabled
        opacity: !decoration.applySlotDisabledOpacity || decoration.fieldEnabled
                 ? 1 : decoration.disabledContentOpacity
        visible: decoration.trailing !== null

        Loader {
            id: trailingLoader
            anchors.centerIn: parent
            sourceComponent: decoration.trailing
            active: decoration.trailing !== null
        }
    }

    Text {
        id: supportingLabel
        objectName: decoration.supportingObjectName
        x: decoration.horizontalPadding
        y: decoration.containerHeight + decoration.supportingTextTopSpace
        width: Math.max(0, decoration.width - decoration.horizontalPadding * 2)
        height: Math.max(implicitHeight, decoration.supportingTextMinimumHeight)
        text: decoration.supportingText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodySmallTypeScale.fontSize
        font.weight: decoration.bodySmallTypeScale.fontWeight
        font.letterSpacing: decoration.bodySmallTypeScale.tracking
        lineHeight: decoration.bodySmallTypeScale.lineHeight
        lineHeightMode: Text.FixedHeight
        color: decoration.supportingColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: decoration.supportingWrapMode
        elide: decoration.supportingElide
        visible: !decoration.error && text.length > 0
        Accessible.ignored: true
    }

    Text {
        id: errorLabel
        objectName: decoration.errorObjectName
        x: supportingLabel.x
        y: supportingLabel.y
        width: supportingLabel.width
        height: Math.max(implicitHeight, decoration.supportingTextMinimumHeight)
        text: decoration.errorText
        textFormat: Text.PlainText
        antialiasing: true
        font.family: decoration.fontFamily
        font.pixelSize: decoration.bodySmallTypeScale.fontSize
        font.weight: decoration.bodySmallTypeScale.fontWeight
        font.letterSpacing: decoration.bodySmallTypeScale.tracking
        lineHeight: decoration.bodySmallTypeScale.lineHeight
        lineHeightMode: Text.FixedHeight
        color: decoration.supportingColor
        opacity: decoration.fieldEnabled ? 1 : decoration.disabledContentOpacity
        horizontalAlignment: decoration.mirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: decoration.supportingWrapMode
        elide: decoration.supportingElide
        visible: decoration.error && text.length > 0
        Accessible.ignored: true
    }
}
