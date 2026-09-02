// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import Fluid.Private as P
import "../internal/MotionAnimation.js" as MotionAnimation
import QtQuick
import QtQuick.Templates as T

/*!
    \class TextField
    \brief A single-line Material Design 3 text field.

    TextField provides filled and outlined containers, a floating label,
    placeholder and supporting text, error presentation, textual affixes, and
    optional leading and trailing content. Logical placement mirrors in
    right-to-left layouts.

    The inherited text-input API remains available without alteration. Use
    \c text for the value, \c placeholderText for an input hint, \c validator
    and \c acceptableInput for validation, \c echoMode for obscured input,
    and \c readOnly to prevent editing. Selection APIs such as \c selectAll(),
    \c selectedText, \c selectionStart, and \c selectionEnd are preserved, as
    are the inherited \c accepted(), \c editingFinished(), and \c textEdited()
    signals.

    \code{.qml}
    MD.TextField {
        label: qsTr("Email address")
        placeholderText: qsTr("name@example.com")
        supportingText: qsTr("Used for account notifications")
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/text-fields/overview">Material Design 3 text-field specification</a>.
*/
T.TextField {
    id: control
    objectName: "textField"

    //! Selects the Material text-field container style.
    enum FieldStyle {
        //! Filled field with a surface container and bottom active indicator.
        Filled = 0,
        //! Transparent field with a surrounding outline.
        Outlined = 1
    }

    //! Container style; defaults to \c MD.TextField.Filled.
    property int fieldStyle: MD.TextField.Filled

    /*!
        \brief Whether logical leading and trailing placement is mirrored.

        This read-only value follows the effective \c LayoutMirroring state
        and the current locale's text direction.
    */
    readonly property bool mirrored: LayoutMirroring.enabled
                                     || Qt.locale().textDirection === Qt.RightToLeft

    //! Optional label. It floats while the field has focus or contains text.
    property string label: ""

    //! Supporting text displayed below the container when there is no error.
    property string supportingText: ""

    //! Error message displayed below the container while \c error is true.
    property string errorText: ""

    //! Whether the field uses its error colors and displays \c errorText.
    property bool error: false

    //! Text displayed immediately before the editable value.
    property string prefixText: ""

    //! Text displayed immediately after the editable value.
    property string suffixText: ""

    /*!
        \brief Component instantiated in the logical leading slot.

        The slot reserves the Material minimum target independently of the
        component's visible artwork. Use \c leadingContentColor for artwork
        that follows the field's enabled state.
    */
    property Component leading: null

    /*!
        \brief Component instantiated in the logical trailing slot.

        Interactive content retains its own accessibility node. Use
        \c trailingContentColor for artwork that follows error and enabled
        states.
    */
    property Component trailing: null

    //! Resolved semantic color for content in the logical leading slot.
    readonly property color leadingContentColor: !enabled
                                                 ? control.MD.Style.onSurfaceColor
                                                 : control.MD.Style.onSurfaceVariantColor

    //! Resolved semantic color for content in the logical trailing slot.
    readonly property color trailingContentColor: !enabled
                                                  ? control.MD.Style.onSurfaceColor
                                                  : error && hovered
                                                    ? control.MD.Style.onErrorContainerColor
                                                  : error
                                                    ? control.MD.Style.errorColor
                                                    : control.MD.Style.onSurfaceVariantColor

    //! \internal Whether the filled presentation is selected.
    readonly property bool _filledField: fieldStyle === MD.TextField.Filled
    //! \internal Whether the outlined presentation is selected.
    readonly property bool _outlinedField: fieldStyle === MD.TextField.Outlined
    //! \internal Whether focus should emphasize the field.
    readonly property bool _fieldActive: enabled && activeFocus
    //! \internal Height reserved below the field container.
    readonly property real _supportingAreaHeight: decoration.supportingAreaHeight
    //! \internal Width at the logical leading edge before affix text.
    readonly property real _leadingBaseReservation: leading !== null
                                                     ? Math.max(
                                                         MD.Tokens.textField.iconTargetSize,
                                                         decoration.leadingImplicitWidth)
                                                     : MD.Tokens.textField.horizontalPadding
    //! \internal Width at the logical trailing edge after affix text.
    readonly property real _trailingBaseReservation: trailing !== null
                                                      ? Math.max(
                                                          MD.Tokens.textField.iconTargetSize,
                                                          decoration.trailingImplicitWidth)
                                                      : MD.Tokens.textField.horizontalPadding
    //! \internal Total logical leading reservation used by the editable text.
    readonly property real _leadingReservation: _leadingBaseReservation
                                                + (prefixText.length > 0
                                                   ? decoration.prefixImplicitWidth
                                                     + MD.Tokens.textField.prefixSuffixTextSpace
                                                   : 0)
    //! \internal Total logical trailing reservation used by the editable text.
    readonly property real _trailingReservation: _trailingBaseReservation
                                                 + (suffixText.length > 0
                                                    ? decoration.suffixImplicitWidth
                                                      + MD.Tokens.textField.prefixSuffixTextSpace
                                                    : 0)
    //! \internal Center line shared by input text, placeholder, and affixes.
    readonly property real _inputCenterY: MD.Tokens.textField.containerHeight / 2
                                          + (_filledField
                                             ? MD.Tokens.typescale.bodySmall.lineHeight / 2
                                               * decoration.labelProgress
                                             : 0)
    //! \internal Effective field label color.
    readonly property color _labelColor: !enabled
                                         ? control.MD.Style.onSurfaceColor
                                         : error && hovered
                                           ? control.MD.Style.onErrorContainerColor
                                         : error
                                           ? control.MD.Style.errorColor
                                         : _fieldActive
                                           ? control.MD.Style.primaryColor
                                         : hovered && _outlinedField
                                           ? control.MD.Style.onSurfaceColor
                                           : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective indicator or outline color.
    readonly property color _indicatorColor: !enabled
                                             ? control.MD.Style.onSurfaceColor
                                             : error && hovered
                                               ? control.MD.Style.onErrorContainerColor
                                             : error
                                               ? control.MD.Style.errorColor
                                             : _fieldActive
                                               ? control.MD.Style.primaryColor
                                             : hovered
                                               ? control.MD.Style.onSurfaceColor
                                             : _outlinedField
                                               ? control.MD.Style.outlineColor
                                               : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective supporting or error text color.
    readonly property color _supportingColor: !enabled
                                              ? control.MD.Style.onSurfaceColor
                                              : error
                                                ? control.MD.Style.errorColor
                                                : control.MD.Style.onSurfaceVariantColor

    implicitWidth: MD.Tokens.textField.minimumWidth
    implicitHeight: MD.Tokens.textField.containerHeight + _supportingAreaHeight
    leftPadding: mirrored ? _trailingReservation : _leadingReservation
    rightPadding: mirrored ? _leadingReservation : _trailingReservation
    topPadding: _filledField
                ? (MD.Tokens.typescale.bodySmall.lineHeight
                   + MD.Tokens.textField.contentVerticalPadding)
                  * decoration.labelProgress
                : 0
    bottomPadding: _supportingAreaHeight
    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    selectByMouse: true
    horizontalAlignment: mirrored ? Text.AlignRight : Text.AlignLeft
    verticalAlignment: TextInput.AlignVCenter

    color: enabled
           ? control.MD.Style.onSurfaceColor
           : MD.Color.transparent(control.MD.Style.onSurfaceColor,
                                  MD.Tokens.textField.disabledContentOpacity)
    selectionColor: control.MD.Style.primaryColor
    selectedTextColor: control.MD.Style.onPrimaryColor
    placeholderTextColor: "transparent"
    font.family: control.MD.Style.plainFontFamily
    font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
    font.weight: MD.Tokens.typescale.bodyLarge.fontWeight
    font.letterSpacing: MD.Tokens.typescale.bodyLarge.tracking

    Accessible.name: label.length > 0 ? label : placeholderText
    Accessible.description: error && errorText.length > 0 ? errorText : supportingText
    Accessible.role: Accessible.EditableText
    Accessible.editable: enabled && !readOnly
    Accessible.readOnly: readOnly
    Accessible.passwordEdit: echoMode !== TextInput.Normal

    background: Loader {
        sourceComponent: decoration.backgroundComponent
    }

    P.FieldDecoration {
        id: decoration
        objectName: "textFieldDecoration"
        anchors.fill: parent

        containerObjectName: "textFieldContainer"
        activeIndicatorObjectName: "textFieldActiveIndicator"
        labelNotchObjectName: "textFieldLabelNotch"
        labelObjectName: "textFieldLabel"
        placeholderObjectName: "textFieldPlaceholder"
        prefixObjectName: "textFieldPrefix"
        suffixObjectName: "textFieldSuffix"
        leadingSlotObjectName: "textFieldLeadingSlot"
        trailingSlotObjectName: "textFieldTrailingSlot"
        supportingObjectName: "textFieldSupportingText"
        errorObjectName: "textFieldErrorText"
        mirrored: control.mirrored
        outlined: control._outlinedField
        fieldFocused: control.activeFocus
        fieldEnabled: control.enabled
        error: control.error
        containerTransitionsEnabled: true
        labelTransitionsEnabled: true
        indicatorTransitionsEnabled: control.enabled
        applySlotDisabledOpacity: true
        backgroundImplicitWidth: MD.Tokens.textField.minimumWidth
        containerHeight: MD.Tokens.textField.containerHeight
        horizontalPadding: MD.Tokens.textField.horizontalPadding
        contentVerticalPadding: MD.Tokens.textField.contentVerticalPadding
        supportingTextTopSpace: MD.Tokens.textField.supportingTextTopSpace
        supportingTextMinimumHeight: MD.Tokens.textField.supportingTextMinimumHeight
        outlinedLabelHorizontalPadding: MD.Tokens.textField.outlinedLabelHorizontalPadding
        disabledContentOpacity: MD.Tokens.textField.disabledContentOpacity
        leadingSlotMinimumSize: MD.Tokens.textField.iconTargetSize
        trailingSlotMinimumSize: MD.Tokens.textField.iconTargetSize
        inputCenterY: control._inputCenterY
        inputBaselineY: control.baselineOffset
        alignInputDecorationsToBaseline: true
        leadingReservation: control._leadingBaseReservation
        trailingReservation: control._trailingBaseReservation
        inputLeftPadding: control.leftPadding
        inputRightPadding: control.rightPadding
        labelLeadingPosition: control._leadingBaseReservation
        labelTrailingPosition: control._trailingBaseReservation
        fullShapeValue: MD.Tokens.shape.cornerValueFull
        labelText: control.label
        placeholderText: control.placeholderText
        inputText: control.text
        prefixText: control.prefixText
        suffixText: control.suffixText
        supportingText: control.supportingText
        errorText: control.errorText
        containerColor: control._filledField
                        ? control.enabled
                          ? control.MD.Style.surfaceContainerHighestColor
                          : MD.Color.transparent(
                                control.MD.Style.onSurfaceColor,
                                MD.Tokens.textField.filledDisabledContainerOpacity)
                        : "transparent"
        outlineColor: control.enabled
                      ? control._indicatorColor
                      : MD.Color.transparent(
                            control.MD.Style.onSurfaceColor,
                            MD.Tokens.textField.outlinedDisabledOutlineOpacity)
        indicatorColor: control._indicatorColor
        labelColor: control._labelColor
        inputDecorationColor: control.enabled
                              ? control.MD.Style.onSurfaceVariantColor
                              : control.MD.Style.onSurfaceColor
        supportingColor: control._supportingColor
        notchColor: control.MD.Style.surfaceColor
        containerShape: control._filledField
                        ? MD.Tokens.textField.filledContainerShape
                        : MD.Tokens.textField.outlinedContainerShape
        outlineWidth: control._outlinedField
                      ? !control.enabled
                        ? MD.Tokens.textField.outlinedDisabledOutlineWidth
                        : control._fieldActive
                          ? MD.Tokens.textField.outlinedFocusOutlineWidth
                          : control.hovered
                            ? MD.Tokens.textField.outlinedHoverOutlineWidth
                            : MD.Tokens.textField.outlinedOutlineWidth
                      : 0
        activeIndicatorVisible: control._filledField
        activeIndicatorHeight: !control.enabled
                               ? MD.Tokens.textField.filledDisabledActiveIndicatorHeight
                               : control._fieldActive
                                 ? MD.Tokens.textField.filledFocusActiveIndicatorHeight
                                 : control.hovered
                                   ? MD.Tokens.textField.filledHoverActiveIndicatorHeight
                                   : MD.Tokens.textField.filledActiveIndicatorHeight
        activeIndicatorOpacity: control.enabled
                                ? 1
                                : MD.Tokens.textField.filledDisabledActiveIndicatorOpacity
        fontFamily: control.MD.Style.plainFontFamily
        bodyLargeTypeScale: MD.Tokens.typescale.bodyLarge
        bodySmallTypeScale: MD.Tokens.typescale.bodySmall
        supportingWrapMode: Text.Wrap
        supportingElide: Text.ElideNone
        effectsDuration: MotionAnimation.expressiveFastEffectsDuration
        slowEffectsDuration: MotionAnimation.expressiveSlowEffectsDuration
        spatialDuration: MotionAnimation.expressiveFastSpatialDuration
        effectsCurve: MotionAnimation.expressiveFastEffectsCurve
        slowEffectsCurve: MotionAnimation.expressiveSlowEffectsCurve
        spatialCurve: MotionAnimation.expressiveFastSpatialCurve
        leading: control.leading
        trailing: control.trailing
    }
}
