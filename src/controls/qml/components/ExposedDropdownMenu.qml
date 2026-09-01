// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation
import QtQuick
import QtQuick.Templates as T
import QtQuick.Window

/*!
    \class ExposedDropdownMenu
    \brief A Material Design 3 text field with an anchored selection menu.

    ExposedDropdownMenu combines a filled or outlined text field with an
    Expressive, scrollable menu. It supports selection-only and editable input,
    model roles for rich default options, custom delegates, flat presentation,
    keyboard interaction, and right-to-left layouts.

    \code{.qml}
    MD.ExposedDropdownMenu {
        label: qsTr("Country")
        textRole: "name"
        model: countries
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/menus/specs">Material Design 3 menu specification</a>.
*/
T.ComboBox {
    id: control
    objectName: "exposedDropdownMenu"

    //! Selects the Material text-field container style.
    enum FieldStyle {
        //! Filled field with an active bottom indicator.
        Filled = 0,
        //! Transparent field with a surrounding outline.
        Outlined = 1
    }

    //! Selects the semantic popup color family.
    enum MenuColorStyle {
        //! Neutral popup surface with tertiary selection.
        Standard = 0,
        //! Tertiary popup surface and stronger selection.
        Vibrant = 1
    }

    //! Field container style; defaults to \c MD.ExposedDropdownMenu.Filled.
    property int fieldStyle: MD.ExposedDropdownMenu.Filled
    //! Popup color family; defaults to \c MD.ExposedDropdownMenu.Standard.
    property int menuColorStyle: MD.ExposedDropdownMenu.Standard
    //! Optional field label. It floats while the field is active or non-empty.
    property string label: ""
    //! Placeholder shown when the input is empty.
    property string placeholderText: ""
    //! Supporting text shown below the field when there is no error.
    property string supportingText: ""
    //! Error message shown below the field while \c error is true.
    property string errorText: ""
    //! Whether the field displays its error state.
    property bool error: false
    //! Material symbol name displayed in the field's optional leading slot.
    property string leadingIconName: ""
    //! Image URL displayed in the field's optional leading slot.
    property url leadingIconSource
    //! Optional model role controlling whether an option is enabled.
    property string enabledRole: ""
    //! Optional model role providing each option's symbol name or image URL.
    property string leadingIconRole: ""
    //! Optional model role providing each option's supporting text.
    property string supportingTextRole: ""
    //! Optional model role providing each option's trailing text.
    property string trailingTextRole: ""
    //! Optional model role providing each option's textual badge content.
    property string badgeRole: ""

    //! \internal Whether the field uses the Filled enum value.
    readonly property bool _filledField: fieldStyle === MD.ExposedDropdownMenu.Filled
    //! \internal Whether the field uses the Outlined enum value.
    readonly property bool _outlinedField: fieldStyle === MD.ExposedDropdownMenu.Outlined
    //! \internal Whether the popup uses the Vibrant enum value.
    readonly property bool _vibrantMenu: menuColorStyle === MD.ExposedDropdownMenu.Vibrant
    //! \internal Whether the field has either supported leading icon form.
    readonly property bool _hasLeadingIcon: leadingIconName.length > 0
                                            || leadingIconSource.toString().length > 0
    //! \internal Whether the label uses its floated presentation.
    readonly property bool _labelFloated: label.length > 0
                                          && (displayText.length > 0 || editText.length > 0
                                              || activeFocus || popup.visible)
    //! \internal Whether the field or its popup currently owns focus state.
    readonly property bool _fieldActive: activeFocus || popup.visible
    //! \internal Effective input text color.
    readonly property color _inputColor: control.MD.Style.onSurfaceColor
    //! \internal Effective field label color.
    readonly property color _labelColor: !enabled ? control.MD.Style.onSurfaceColor
                                         : error && hovered
                                           ? control.MD.Style.onErrorContainerColor
                                         : error ? control.MD.Style.errorColor
                                         : _fieldActive ? control.MD.Style.primaryColor
                                         : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective leading icon color.
    readonly property color _leadingIconColor: !enabled ? control.MD.Style.onSurfaceColor
                                                        : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective trailing dropdown icon color.
    readonly property color _trailingIconColor: !enabled ? control.MD.Style.onSurfaceColor
                                             : error && hovered
                                               ? control.MD.Style.onErrorContainerColor
                                             : error ? control.MD.Style.errorColor
                                             : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective active-indicator or outline color.
    readonly property color _indicatorColor: !enabled ? control.MD.Style.onSurfaceColor
                                         : error && hovered
                                           ? control.MD.Style.onErrorContainerColor
                                         : error ? control.MD.Style.errorColor
                                         : _fieldActive ? control.MD.Style.primaryColor
                                         : hovered ? control.MD.Style.onSurfaceColor
                                         : _outlinedField
                                           ? control.MD.Style.outlineColor
                                           : control.MD.Style.onSurfaceVariantColor
    //! \internal Effective supporting text color.
    readonly property color _supportingColor: !enabled ? control.MD.Style.onSurfaceColor
                                                       : error ? control.MD.Style.errorColor
                                                       : control.MD.Style.onSurfaceVariantColor
    //! \internal Size of the leading icon for the selected field style.
    readonly property real _leadingIconSize: _filledField
                                             ? MD.Tokens.exposedDropdownMenu.filledLeadingIconSize
                                             : MD.Tokens.exposedDropdownMenu.outlinedLeadingIconSize
    //! \internal Width reserved at the logical leading edge.
    readonly property real _leadingReservation: MD.Tokens.exposedDropdownMenu.horizontalPadding
                                                + (_hasLeadingIcon
                                                   ? _leadingIconSize
                                                     + MD.Tokens.exposedDropdownMenu.leadingIconContentSpace
                                                   : 0)
    //! \internal Width reserved at the logical trailing edge.
    readonly property real _trailingReservation: MD.Tokens.exposedDropdownMenu.horizontalPadding
                                                 + MD.Tokens.exposedDropdownMenu.trailingIconSize
                                                 + MD.Tokens.exposedDropdownMenu.trailingIconContentSpace
    //! \internal Height reserved below the field for supporting or error text.
    readonly property real _supportingAreaHeight: (error && errorText.length > 0)
                                                   || (!error && supportingText.length > 0)
                                                   ? MD.Tokens.exposedDropdownMenu.supportingTextTopSpace
                                                     + supportingLabel.implicitHeight
                                                   : 0

    //! \internal Returns a model role value without requiring a particular model type.
    function _roleValue(row, roleName, rowModel) {
        if (roleName.length === 0 || row < 0)
            return undefined;
        if (rowModel && rowModel[roleName] !== undefined)
            return rowModel[roleName];
        if (model && typeof model.get === "function") {
            const data = model.get(row);
            return data ? data[roleName] : undefined;
        }
        if (model && model[row] !== undefined && model[row] !== null)
            return model[row][roleName];
        return undefined;
    }

    //! \internal Converts an optional role value to display text.
    function _roleText(row, roleName, rowModel) {
        const value = _roleValue(row, roleName, rowModel);
        return value === undefined || value === null ? "" : value.toString();
    }

    //! \internal Returns the enabled state supplied by the optional role.
    function _roleEnabled(row, rowModel) {
        const value = _roleValue(row, enabledRole, rowModel);
        return value === undefined || value === null ? true : Boolean(value);
    }

    //! \internal Whether a role-provided icon value denotes an image URL.
    function _isIconSource(value) {
        if (value === undefined || value === null)
            return false;
        const stringValue = value.toString();
        return stringValue.indexOf(":") >= 0 || stringValue.indexOf("/") >= 0
               || stringValue.indexOf(".") >= 0;
    }

    implicitWidth: Math.max(MD.Tokens.exposedDropdownMenu.minimumWidth,
                            MD.Tokens.exposedDropdownMenu.preferredWidth)
    implicitHeight: MD.Tokens.exposedDropdownMenu.fieldHeight
                    + _supportingAreaHeight
    leftPadding: mirrored ? _trailingReservation : _leadingReservation
    rightPadding: mirrored ? _leadingReservation : _trailingReservation
    topPadding: 0
    bottomPadding: _supportingAreaHeight
    focusPolicy: Qt.StrongFocus
    hoverEnabled: true

    Accessible.name: label.length > 0 ? label : placeholderText
    Accessible.description: error && errorText.length > 0 ? errorText : supportingText
    Accessible.editable: editable

    delegate: T.ItemDelegate {
        id: optionDelegate
        required property int index
        required property var model

        //! \internal Role-provided supporting text.
        readonly property string supportingText: control._roleText(
                                                     index, control.supportingTextRole, model)
        //! \internal Role-provided trailing text.
        readonly property string trailingText: control._roleText(
                                                   index, control.trailingTextRole, model)
        //! \internal Role-provided badge content.
        readonly property var badgeContent: control._roleValue(index, control.badgeRole, model)
        //! \internal Role-provided icon value.
        readonly property var iconValue: control._roleValue(index, control.leadingIconRole, model)
        //! \internal Whether this option is selected.
        readonly property bool selected: control.currentIndex === index
        //! \internal Whether textual badge content is present.
        readonly property bool hasBadge: badgeContent !== undefined && badgeContent !== null
                                         && badgeContent.toString().length > 0
        //! \internal Whether a role-provided option icon is present.
        readonly property bool hasIcon: iconValue !== undefined && iconValue !== null
                                        && iconValue.toString().length > 0
        //! \internal Shape selected from group position and selection.
        readonly property var containerShape: {
            if (selected)
                return MD.Tokens.menu.verticalSelectedItemShape;
            if (control.count <= 1)
                return MD.Tokens.menu.verticalOnlyItemShape;
            if (index === 0)
                return MD.Tokens.menu.verticalFirstItemShape;
            if (index === control.count - 1)
                return MD.Tokens.menu.verticalLastItemShape;
            return MD.Tokens.menu.verticalMiddleItemShape;
        }
        //! \internal Primary option content color.
        readonly property color contentColor: control._vibrantMenu
                                              ? selected
                                                ? control.MD.Style.onTertiaryColor
                                                : control.MD.Style.onTertiaryContainerColor
                                              : selected
                                                ? control.MD.Style.onTertiaryContainerColor
                                                : control.MD.Style.onSurfaceColor
        //! \internal Secondary option content color.
        readonly property color secondaryColor: selected ? contentColor
                                                 : control._vibrantMenu
                                                   ? control.MD.Style.onTertiaryContainerColor
                                                   : control.MD.Style.onSurfaceVariantColor
        //! \internal Effective content opacity.
        readonly property real contentOpacity: enabled ? 1
                                                       : MD.Tokens.menu.disabledContentOpacity

        width: ListView.view ? ListView.view.width : implicitWidth
        text: control.textAt(index)
        enabled: control._roleEnabled(index, model)
        highlighted: control.highlightedIndex === index
        implicitHeight: Math.max(MD.Tokens.menu.verticalItemHeight,
                                 optionLabels.implicitHeight
                                 + MD.Tokens.menu.verticalItemTopPadding
                                 + MD.Tokens.menu.verticalItemBottomPadding)
        leftPadding: MD.Tokens.menu.verticalItemLeadingSpace
        rightPadding: MD.Tokens.menu.verticalItemTrailingSpace
        topPadding: MD.Tokens.menu.verticalItemTopPadding
        bottomPadding: MD.Tokens.menu.verticalItemBottomPadding
        spacing: MD.Tokens.menu.verticalItemBetweenSpace
        hoverEnabled: control.hoverEnabled
        focusPolicy: Qt.StrongFocus
        LayoutMirroring.enabled: control.mirrored
        LayoutMirroring.childrenInherit: true

        contentItem: Row {
            spacing: optionDelegate.spacing

            Item {
                id: optionIcon
                objectName: "menuItemIcon"
                width: MD.Tokens.menu.verticalIconSize
                height: width
                anchors.verticalCenter: parent.verticalCenter
                // Keep the selection/icon slot stable so labels do not move
                // when currentIndex changes.
                visible: true

                MD.Symbol {
                    objectName: "menuItemSelection"
                    anchors.fill: parent
                    name: MD.SymbolNames.symbolCheck
                    iconWidth: parent.width
                    iconHeight: parent.height
                    color: optionDelegate.secondaryColor
                    opacity: optionDelegate.contentOpacity
                    visible: optionDelegate.selected
                }
                Image {
                    anchors.fill: parent
                    source: control._isIconSource(optionDelegate.iconValue)
                            ? optionDelegate.iconValue : ""
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: optionDelegate.contentOpacity
                    visible: !optionDelegate.selected
                             && control._isIconSource(optionDelegate.iconValue)
                }
                MD.Symbol {
                    anchors.fill: parent
                    name: optionDelegate.hasIcon
                          && !control._isIconSource(optionDelegate.iconValue)
                          ? optionDelegate.iconValue.toString() : ""
                    iconWidth: parent.width
                    iconHeight: parent.height
                    color: optionDelegate.secondaryColor
                    opacity: optionDelegate.contentOpacity
                    visible: !optionDelegate.selected && optionDelegate.hasIcon
                             && !control._isIconSource(optionDelegate.iconValue)
                }
            }

            Column {
                id: optionLabels
                width: Math.max(0, parent.width
                                - (optionIcon.visible ? optionIcon.width
                                                        + optionDelegate.spacing : 0)
                                - (optionTrailing.visible ? optionTrailing.implicitWidth
                                                            + optionDelegate.spacing : 0)
                                - (optionBadge.visible ? optionBadge.implicitWidth
                                                        + optionDelegate.spacing : 0))
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0
                MD.Label {
                    objectName: "menuItemLabel"
                    width: parent.width
                    text: optionDelegate.text
                    typescale: MD.Tokens.typescale.labelLarge
                    color: optionDelegate.contentColor
                    opacity: optionDelegate.contentOpacity
                    horizontalAlignment: optionDelegate.mirrored ? Text.AlignRight : Text.AlignLeft
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }
                MD.Label {
                    objectName: "menuItemSupportingText"
                    width: parent.width
                    text: optionDelegate.supportingText
                    typescale: MD.Tokens.typescale.bodySmall
                    color: optionDelegate.secondaryColor
                    opacity: optionDelegate.contentOpacity
                    horizontalAlignment: optionDelegate.mirrored ? Text.AlignRight : Text.AlignLeft
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    visible: text.length > 0
                }
            }

            MD.Label {
                id: optionTrailing
                objectName: "menuItemTrailingText"
                anchors.verticalCenter: parent.verticalCenter
                text: optionDelegate.trailingText
                typescale: MD.Tokens.typescale.labelLarge
                color: optionDelegate.secondaryColor
                opacity: optionDelegate.contentOpacity
                visible: text.length > 0
            }
            MD.Label {
                id: optionBadge
                objectName: "menuItemBadge"
                anchors.verticalCenter: parent.verticalCenter
                text: optionDelegate.hasBadge ? optionDelegate.badgeContent.toString() : ""
                typescale: MD.Tokens.typescale.labelSmall
                color: optionDelegate.secondaryColor
                opacity: optionDelegate.contentOpacity
                visible: optionDelegate.hasBadge
            }
        }

        background: Rectangle {
            objectName: "menuItemBackground"
            color: optionDelegate.selected
                   ? control._vibrantMenu
                     ? control.MD.Style.tertiaryColor
                     : control.MD.Style.tertiaryContainerColor
                   : "transparent"
            topLeftRadius: UiMetrics.resolveShapeRadius(
                               optionDelegate.containerShape.topLeft, width, height)
            topRightRadius: UiMetrics.resolveShapeRadius(
                                optionDelegate.containerShape.topRight, width, height)
            bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                  optionDelegate.containerShape.bottomLeft, width, height)
            bottomRightRadius: UiMetrics.resolveShapeRadius(
                                   optionDelegate.containerShape.bottomRight, width, height)

            MD.Ripple {
                objectName: "menuItemStateLayer"
                anchors.fill: parent
                pressed: optionDelegate.pressed
                pressX: optionDelegate.pressX
                pressY: optionDelegate.pressY
                color: optionDelegate.contentColor
                topLeftRadius: parent.topLeftRadius
                topRightRadius: parent.topRightRadius
                bottomLeftRadius: parent.bottomLeftRadius
                bottomRightRadius: parent.bottomRightRadius
                stateOpacity: {
                    if (!optionDelegate.enabled)
                        return 0;
                    if (optionDelegate.pressed)
                        return MD.Tokens.menu.pressedStateLayerOpacity;
                    if (optionDelegate.visualFocus || optionDelegate.highlighted)
                        return MD.Tokens.menu.focusStateLayerOpacity;
                    if (optionDelegate.hovered)
                        return MD.Tokens.menu.hoverStateLayerOpacity;
                    return 0;
                }
            }
        }
    }

    contentItem: T.TextField {
        id: field
        objectName: "exposedDropdownField"
        x: control.leftPadding
        y: 0
        width: Math.max(0, control.width - control.leftPadding - control.rightPadding)
        height: MD.Tokens.exposedDropdownMenu.fieldHeight
        text: control.editable ? control.editText : control.displayText
        enabled: control.editable && control.enabled
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
        selectByMouse: control.selectTextByMouse
        color: control.enabled
               ? control._inputColor
               : MD.Color.transparent(control.MD.Style.onSurfaceColor,
                                      MD.Tokens.exposedDropdownMenu.disabledContentOpacity)
        selectionColor: control.MD.Style.primaryColor
        selectedTextColor: control.MD.Style.onPrimaryColor
        font.family: control.MD.Style.plainFontFamily
        font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
        font.weight: MD.Tokens.typescale.bodyLarge.fontWeight
        font.letterSpacing: MD.Tokens.typescale.bodyLarge.tracking
        horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: 0
        rightPadding: 0
        topPadding: control._labelFloated
                    && control._filledField
                    ? fieldLabel.implicitHeight + MD.Tokens.exposedDropdownMenu.labelInputTextSpace
                    : 0
        bottomPadding: 0
        background: Item {}
        Accessible.ignored: true

        Rectangle {
            objectName: "exposedDropdownLabelNotch"
            x: fieldLabel.x - MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding
            y: fieldLabel.y
            width: fieldLabel.width
                   + MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding * 2
            height: fieldLabel.height
            color: control.MD.Style.surfaceColor
            visible: control._labelFloated
                     && control._outlinedField
        }

        MD.Label {
            id: fieldLabel
            objectName: "exposedDropdownLabel"
            readonly property bool outlinedFloating: control._labelFloated
                                                     && control._outlinedField
            x: outlinedFloating
               ? control.mirrored
                 ? parent.width - width
                   - MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding
                 : MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding
               : 0
            y: outlinedFloating ? -height / 2
               : control._labelFloated ? MD.Tokens.exposedDropdownMenu.contentVerticalPadding
               : (parent.height - height) / 2
            width: outlinedFloating
                   ? Math.min(fieldLabelFontMetrics.advanceWidth(text),
                              parent.width
                              - MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding * 2)
                   : parent.width
            text: control.label
            typescale: control._labelFloated ? MD.Tokens.typescale.bodySmall
                                             : MD.Tokens.typescale.bodyLarge
            color: control._labelColor
            opacity: control.enabled ? 1
                                     : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
            horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            visible: text.length > 0

            FontMetrics {
                id: fieldLabelFontMetrics
                font: fieldLabel.font
            }
        }

        MD.Label {
            objectName: "exposedDropdownPlaceholder"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.baseline: parent.baseline
            text: control.placeholderText
            typescale: MD.Tokens.typescale.bodyLarge
            color: control.enabled ? control.MD.Style.onSurfaceVariantColor
                                   : control.MD.Style.onSurfaceColor
            opacity: control.enabled ? 1
                                     : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
            horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
            elide: Text.ElideRight
            visible: field.text.length === 0 && text.length > 0
                     && (control.label.length === 0 || control._labelFloated)
        }
    }

    indicator: Item {
        objectName: "exposedDropdownIndicator"
        x: control.mirrored ? MD.Tokens.exposedDropdownMenu.horizontalPadding
                            : control.width - width
                              - MD.Tokens.exposedDropdownMenu.horizontalPadding
        y: (MD.Tokens.exposedDropdownMenu.fieldHeight - height) / 2
        width: MD.Tokens.exposedDropdownMenu.trailingIconSize
        height: width
        opacity: control.enabled ? 1 : MD.Tokens.exposedDropdownMenu.disabledContentOpacity

        MD.Symbol {
            anchors.fill: parent
            name: MD.SymbolNames.symbolArrowDropDown
            iconWidth: parent.width
            iconHeight: parent.height
            color: control._trailingIconColor
            rotation: control.popup.visible ? 180 : 0
            Behavior on rotation {
                NumberAnimation {
                    duration: MotionAnimation.expressiveFastEffectsDuration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
                }
            }
        }
    }

    background: Item {
        Rectangle {
            id: fieldContainer
            objectName: "exposedDropdownBackground"
            width: parent.width
            height: MD.Tokens.exposedDropdownMenu.fieldHeight
            readonly property var fieldShape: control._filledField
                                              ? MD.Tokens.exposedDropdownMenu.filledContainerShape
                                              : MD.Tokens.exposedDropdownMenu.outlinedContainerShape
            color: control.flat || control._outlinedField
                   ? "transparent"
                   : !control.enabled
                     ? MD.Color.transparent(
                           control.MD.Style.onSurfaceColor,
                           MD.Tokens.exposedDropdownMenu.filledDisabledContainerOpacity)
                     : control.MD.Style.surfaceContainerHighestColor
            border.color: !control.enabled
                            ? MD.Color.transparent(
                                  control.MD.Style.onSurfaceColor,
                                  MD.Tokens.exposedDropdownMenu.outlinedDisabledOutlineOpacity)
                            : control._indicatorColor
            border.width: control._outlinedField && !control.flat
                          ? control._fieldActive
                            ? MD.Tokens.exposedDropdownMenu.outlinedFocusOutlineWidth
                            : control.hovered
                              ? MD.Tokens.exposedDropdownMenu.outlinedHoverOutlineWidth
                              : MD.Tokens.exposedDropdownMenu.outlinedOutlineWidth
                          : 0
            topLeftRadius: UiMetrics.resolveShapeRadius(fieldShape.topLeft, width, height)
            topRightRadius: UiMetrics.resolveShapeRadius(fieldShape.topRight, width, height)
            bottomLeftRadius: UiMetrics.resolveShapeRadius(fieldShape.bottomLeft, width, height)
            bottomRightRadius: UiMetrics.resolveShapeRadius(fieldShape.bottomRight, width, height)

            Rectangle {
                objectName: "exposedDropdownActiveIndicator"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: control._fieldActive
                        ? MD.Tokens.exposedDropdownMenu.filledFocusActiveIndicatorHeight
                        : control.hovered
                          ? MD.Tokens.exposedDropdownMenu.filledHoverActiveIndicatorHeight
                          : MD.Tokens.exposedDropdownMenu.filledActiveIndicatorHeight
                color: control._indicatorColor
                opacity: control.enabled ? 1 : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
                visible: control._filledField && !control.flat
            }
        }

        Item {
            id: leadingIcon
            objectName: "exposedDropdownLeadingIcon"
            x: control.mirrored
               ? parent.width - width - MD.Tokens.exposedDropdownMenu.horizontalPadding
               : MD.Tokens.exposedDropdownMenu.horizontalPadding
            y: (MD.Tokens.exposedDropdownMenu.fieldHeight - height) / 2
            width: control._leadingIconSize
            height: width
            visible: control._hasLeadingIcon
            opacity: control.enabled ? 1 : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
            Image {
                anchors.fill: parent
                source: control.leadingIconSource
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
                visible: source.toString().length > 0
            }
            MD.Symbol {
                anchors.fill: parent
                name: control.leadingIconName
                iconWidth: parent.width
                iconHeight: parent.height
                    color: control._leadingIconColor
                visible: control.leadingIconSource.toString().length === 0
                         && control.leadingIconName.length > 0
            }
        }

        MD.Label {
            id: supportingLabel
            objectName: "exposedDropdownSupportingText"
            x: MD.Tokens.exposedDropdownMenu.horizontalPadding
            y: MD.Tokens.exposedDropdownMenu.fieldHeight
               + MD.Tokens.exposedDropdownMenu.supportingTextTopSpace
            width: parent.width - MD.Tokens.exposedDropdownMenu.horizontalPadding * 2
            text: control.supportingText
            typescale: MD.Tokens.typescale.bodySmall
            color: control._supportingColor
            opacity: control.enabled ? 1 : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
            horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
            elide: Text.ElideRight
            visible: !control.error && text.length > 0
            Accessible.ignored: true
        }

        MD.Label {
            objectName: "exposedDropdownErrorText"
            x: supportingLabel.x
            y: supportingLabel.y
            width: supportingLabel.width
            text: control.errorText
            typescale: MD.Tokens.typescale.bodySmall
            color: control._supportingColor
            opacity: control.enabled ? 1 : MD.Tokens.exposedDropdownMenu.disabledContentOpacity
            horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
            elide: Text.ElideRight
            visible: control.error && text.length > 0
            Accessible.ignored: true
        }
    }

    popup: T.Popup {
        id: dropdownPopup
        objectName: "exposedDropdownPopup"

        //! Index highlighted by keyboard navigation in the popup list.
        property alias currentIndex: menuList.currentIndex
        //! \internal Window-relative top coordinate of the field.
        readonly property real _fieldWindowY: control.mapToItem(null, 0, 0).y
        //! \internal Window containing the field, when it has one.
        readonly property var _window: control.parent ? control.parent.Window.window : null
        //! \internal Space available below the field inside viewport margins.
        readonly property real _availableBelow: _window
                                                ? _window.height - _fieldWindowY
                                                  - MD.Tokens.exposedDropdownMenu.fieldHeight
                                                  - MD.Tokens.menu.verticalViewportMargin
                                                  - MD.Tokens.exposedDropdownMenu.popupAnchorGap
                                                : Number.POSITIVE_INFINITY
        //! \internal Space available above the field inside viewport margins.
        readonly property real _availableAbove: _window
                                                ? _fieldWindowY
                                                  - MD.Tokens.menu.verticalViewportMargin
                                                  - MD.Tokens.exposedDropdownMenu.popupAnchorGap
                                                : Number.POSITIVE_INFINITY
        //! \internal Unconstrained popup content height.
        readonly property real _naturalHeight: menuList.contentHeight + topPadding + bottomPadding
        //! \internal Whether the popup is placed beneath the field.
        readonly property bool _opensBelow: _availableBelow >= _naturalHeight
                                            || _availableBelow >= _availableAbove
        //! \internal Height available on the selected side of the field.
        readonly property real _availableHeight: Math.max(0, _opensBelow
                                                             ? _availableBelow
                                                             : _availableAbove)

        //! Returns the instantiated option delegate at \a row, or null.
        function itemAt(row) {
            return menuList.itemAtIndex(row);
        }

        x: control.mirrored ? control.width - width : 0
        y: _opensBelow
           ? MD.Tokens.exposedDropdownMenu.fieldHeight
             + MD.Tokens.exposedDropdownMenu.popupAnchorGap
           : -implicitHeight - MD.Tokens.exposedDropdownMenu.popupAnchorGap
        width: control.width
        implicitWidth: control.width
        implicitHeight: Math.min(_naturalHeight, _availableHeight)
        margins: 0
        leftMargin: MD.Tokens.menu.horizontalViewportMargin
        rightMargin: MD.Tokens.menu.horizontalViewportMargin
        topMargin: MD.Tokens.menu.verticalViewportMargin
        bottomMargin: MD.Tokens.menu.verticalViewportMargin
        topPadding: MD.Tokens.menu.verticalGroupPadding
        bottomPadding: MD.Tokens.menu.verticalGroupPadding
        leftPadding: MD.Tokens.menu.verticalGroupPadding
        rightPadding: MD.Tokens.menu.verticalGroupPadding
        focus: true
        modal: false
        closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside
        transformOrigin: _opensBelow ? Item.Top : Item.Bottom

        contentItem: ListView {
            id: menuList
            objectName: "menuListView"
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            interactive: contentHeight + dropdownPopup.topPadding + dropdownPopup.bottomPadding
                         > dropdownPopup.height
            boundsBehavior: Flickable.StopAtBounds
            spacing: MD.Tokens.menu.verticalSegmentedGap
            clip: true
            ScrollIndicator.vertical: MD.ScrollIndicator {}
        }

        background: MD.ElevationRectangle {
            objectName: "exposedDropdownPopupBackground"
            color: control._vibrantMenu
                   ? control.MD.Style.tertiaryContainerColor
                   : control.MD.Style.surfaceContainerLowColor
            topLeftRadius: UiMetrics.resolveShapeRadius(
                               MD.Tokens.exposedDropdownMenu.popupContainerShape.topLeft,
                               width, height)
            topRightRadius: UiMetrics.resolveShapeRadius(
                                MD.Tokens.exposedDropdownMenu.popupContainerShape.topRight,
                                width, height)
            bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                  MD.Tokens.exposedDropdownMenu.popupContainerShape.bottomLeft,
                                  width, height)
            bottomRightRadius: UiMetrics.resolveShapeRadius(
                                   MD.Tokens.exposedDropdownMenu.popupContainerShape.bottomRight,
                                   width, height)
            elevation: MD.Tokens.exposedDropdownMenu.popupContainerElevation
        }

        enter: Transition {
            NumberAnimation {
                property: "scale"
                from: MD.Tokens.menu.closedScale
                to: 1
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
            }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: MotionAnimation.expressiveFastEffectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "scale"
                from: 1
                to: MD.Tokens.menu.closedScale
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
            }
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: MotionAnimation.expressiveFastEffectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
            }
        }
    }
}
