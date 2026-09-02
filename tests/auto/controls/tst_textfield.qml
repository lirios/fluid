// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtTest

TestCase {
    id: testCase

    name: "TextFieldTests"
    width: 720
    height: 520
    visible: true
    when: windowShown

    Component {
        id: fieldComponent

        MD.TextField {
            width: 280
            label: "Name"
            placeholderText: "Enter a name"
            supportingText: "Shown to other people"
        }
    }

    Component {
        id: adornedFieldComponent

        MD.TextField {
            id: adornedField

            width: 320
            label: "Amount"
            prefixText: "$"
            suffixText: "USD"

            leading: Rectangle {
                objectName: "customLeading"
                implicitWidth: 24
                implicitHeight: 24
                color: adornedField.leadingContentColor
            }

            trailing: Rectangle {
                property int clickCount: 0

                objectName: "customTrailing"
                implicitWidth: 20
                implicitHeight: 20
                color: adornedField.trailingContentColor

                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.clickCount++
                }
            }
        }
    }

    Component {
        id: validatedFieldComponent

        MD.TextField {
            width: 280
            label: "PIN"
            inputMethodHints: Qt.ImhDigitsOnly
            validator: IntValidator {
                bottom: 10
                top: 99
            }
        }
    }

    Component {
        id: rtlFieldComponent

        Item {
            property alias field: field

            width: 360
            height: 120
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.TextField {
                id: field

                width: parent.width
                label: "المبلغ"
                prefixText: "ر.س"
                suffixText: "فقط"

                leading: Rectangle {
                    objectName: "rtlLeading"
                    implicitWidth: 24
                    implicitHeight: 24
                }

                trailing: Rectangle {
                    objectName: "rtlTrailing"
                    implicitWidth: 24
                    implicitHeight: 24
                }
            }
        }
    }

    function createField(component, properties) {
        return createTemporaryObject(component || fieldComponent, testCase, properties || {});
    }

    function verifyShape(rectangle, shape) {
        compare(rectangle.topLeftRadius, shape.topLeft);
        compare(rectangle.topRightRadius, shape.topRight);
        compare(rectangle.bottomRightRadius, shape.bottomRight);
        compare(rectangle.bottomLeftRadius, shape.bottomLeft);
    }

    function test_defaults_and_accessibility() {
        const field = createField();
        verify(field);
        compare(field.fieldStyle, MD.TextField.Filled);
        compare(field.label, "Name");
        compare(field.supportingText, "Shown to other people");
        compare(field.errorText, "");
        verify(!field.error);
        compare(field.prefixText, "");
        compare(field.suffixText, "");
        compare(field.leading, null);
        compare(field.trailing, null);
        compare(field.focusPolicy, Qt.StrongFocus);
        verify(findChild(field, "textFieldDecoration"));
        compare(field.Accessible.role, Accessible.EditableText);
        compare(field.Accessible.name, "Name");
        compare(field.Accessible.description, "Shown to other people");
        compare(field.implicitWidth, MD.Tokens.textField.minimumWidth);
        verify(field.implicitHeight
               >= MD.Tokens.textField.containerHeight
                  + MD.Tokens.textField.supportingTextTopSpace
                  + MD.Tokens.textField.supportingTextMinimumHeight);
    }

    function test_filled_and_outlined_geometry() {
        const field = createField(fieldComponent, { "supportingText": "" });
        const container = findChild(field, "textFieldContainer");
        const indicator = findChild(field, "textFieldActiveIndicator");
        verify(container);
        verify(indicator);
        compare(container.height, MD.Tokens.textField.containerHeight);
        verifyShape(container, MD.Tokens.textField.filledContainerShape);
        compare(indicator.height, MD.Tokens.textField.filledActiveIndicatorHeight);
        verify(indicator.visible);

        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        tryCompare(indicator, "height", MD.Tokens.textField.filledFocusActiveIndicatorHeight);

        field.fieldStyle = MD.TextField.Outlined;
        tryCompare(indicator, "visible", false);
        verifyShape(container, MD.Tokens.textField.outlinedContainerShape);
        tryCompare(container.border, "width", MD.Tokens.textField.outlinedFocusOutlineWidth);
        tryCompare(container, "color", Qt.rgba(0, 0, 0, 0));
    }

    function test_expressive_input_phase_transitions() {
        const field = createField(adornedFieldComponent, {
            "placeholderText": "0.00"
        });
        const decoration = findChild(field, "textFieldDecoration");
        const label = findChild(field, "textFieldLabel");
        const placeholder = findChild(field, "textFieldPlaceholder");
        const prefix = findChild(field, "textFieldPrefix");
        const suffix = findChild(field, "textFieldSuffix");
        const indicator = findChild(field, "textFieldActiveIndicator");
        verify(decoration);
        verify(label);
        verify(placeholder);
        verify(prefix);
        verify(suffix);
        verify(indicator);
        compare(decoration.labelProgress, 0);
        compare(decoration.placeholderOpacity, 0);
        compare(decoration.affixOpacity, 0);
        compare(label.font.pixelSize, MD.Tokens.typescale.bodyLarge.fontSize);

        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        wait(40);
        verify(decoration.labelProgress > 0 && decoration.labelProgress < 1);
        verify(decoration.placeholderOpacity > 0 && decoration.placeholderOpacity < 1);
        verify(decoration.affixOpacity > 0 && decoration.affixOpacity < 1);
        verify(indicator.height > MD.Tokens.textField.filledActiveIndicatorHeight
               && indicator.height < MD.Tokens.textField.filledFocusActiveIndicatorHeight);
        compare(label.font.pixelSize,
                Math.round(MD.Tokens.typescale.bodyLarge.fontSize
                           + (MD.Tokens.typescale.bodySmall.fontSize
                              - MD.Tokens.typescale.bodyLarge.fontSize)
                             * decoration.labelProgress));
        verify(placeholder.visible);
        verify(prefix.visible);
        verify(suffix.visible);

        tryCompare(decoration, "labelProgress", 1);
        tryCompare(decoration, "placeholderOpacity", 1);
        tryCompare(decoration, "affixOpacity", 1);
        tryCompare(indicator, "height",
                   MD.Tokens.textField.filledFocusActiveIndicatorHeight);
        compare(label.font.pixelSize, MD.Tokens.typescale.bodySmall.fontSize);

        testCase.forceActiveFocus();
        tryCompare(field, "activeFocus", false);
        wait(40);
        verify(decoration.labelProgress > 0 && decoration.labelProgress < 1);
        verify(decoration.placeholderOpacity > 0 && decoration.placeholderOpacity < 1);
        verify(decoration.affixOpacity > 0 && decoration.affixOpacity < 1);
        verify(placeholder.visible);
        verify(prefix.visible);
        verify(suffix.visible);
        tryCompare(decoration, "placeholderOpacity", 0);
        tryCompare(decoration, "affixOpacity", 0);
        tryCompare(decoration, "labelProgress", 0);
        verify(!placeholder.visible);
        verify(!prefix.visible);
        verify(!suffix.visible);

        field.text = "25";
        wait(40);
        verify(decoration.labelProgress > 0 && decoration.labelProgress < 1);
        verify(decoration.affixOpacity > 0 && decoration.affixOpacity < 1);
        verify(!placeholder.visible);
        tryCompare(decoration, "labelProgress", 1);
        tryCompare(decoration, "affixOpacity", 1);
        field.text = "";
        wait(40);
        verify(decoration.labelProgress > 0 && decoration.labelProgress < 1);
        verify(decoration.affixOpacity > 0 && decoration.affixOpacity < 1);
        tryCompare(decoration, "labelProgress", 0);
        tryCompare(decoration, "affixOpacity", 0);

        const unlabeled = createField(fieldComponent, {
            "label": "",
            "text": "Value",
            "placeholderText": "Slow reveal",
            "supportingText": ""
        });
        const unlabeledDecoration = findChild(unlabeled, "textFieldDecoration");
        const unlabeledPlaceholder = findChild(unlabeled, "textFieldPlaceholder");
        verify(unlabeledDecoration);
        verify(unlabeledPlaceholder);
        compare(unlabeledDecoration.placeholderOpacity, 0);
        unlabeled.text = "";
        wait(180);
        verify(unlabeledDecoration.placeholderOpacity > 0
               && unlabeledDecoration.placeholderOpacity < 1);
        verify(unlabeledPlaceholder.visible);
        tryCompare(unlabeledDecoration, "placeholderOpacity", 1);
    }

    function test_label_placeholder_and_affix_visibility() {
        const field = createField(adornedFieldComponent);
        const label = findChild(field, "textFieldLabel");
        const placeholder = findChild(field, "textFieldPlaceholder");
        const prefix = findChild(field, "textFieldPrefix");
        const suffix = findChild(field, "textFieldSuffix");
        verify(label);
        verify(placeholder);
        verify(prefix);
        verify(suffix);
        verify(label.visible);
        verify(!placeholder.visible);
        verify(!prefix.visible);
        verify(!suffix.visible);

        field.placeholderText = "0.00";
        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        tryCompare(placeholder, "visible", true);
        tryCompare(prefix, "visible", true);
        tryCompare(suffix, "visible", true);

        field.focus = false;
        field.text = "25";
        tryCompare(label, "visible", true);
        tryCompare(prefix, "visible", true);
        tryCompare(suffix, "visible", true);

        const unlabeled = createField(fieldComponent, {
            "label": "",
            "placeholderText": "Always visible",
            "supportingText": ""
        });
        const unlabeledPlaceholder = findChild(unlabeled, "textFieldPlaceholder");
        const unlabeledDecoration = findChild(unlabeled, "textFieldDecoration");
        verify(unlabeledPlaceholder);
        verify(unlabeledDecoration);
        verify(unlabeledPlaceholder.visible);
        compare(unlabeledDecoration.labelProgress, 0);
        compare(unlabeled.topPadding, 0);
    }

    function test_input_decoration_baselines_data() {
        return [
            { "tag": "filled", "fieldStyle": MD.TextField.Filled },
            { "tag": "outlined", "fieldStyle": MD.TextField.Outlined }
        ];
    }

    function test_input_decoration_baselines(data) {
        const field = createField(adornedFieldComponent, {
            "fieldStyle": data.fieldStyle,
            "placeholderText": "0.00",
            "supportingText": "",
            "text": "25"
        });
        const decoration = findChild(field, "textFieldDecoration");
        const placeholder = findChild(field, "textFieldPlaceholder");
        const prefix = findChild(field, "textFieldPrefix");
        const suffix = findChild(field, "textFieldSuffix");
        verify(decoration);
        verify(placeholder);
        verify(prefix);
        verify(suffix);

        tryCompare(decoration, "labelProgress", 1);
        verify(prefix.visible);
        verify(suffix.visible);
        compare(prefix.mapToItem(field, 0, prefix.baselineOffset).y,
                field.baselineOffset);
        compare(suffix.mapToItem(field, 0, suffix.baselineOffset).y,
                field.baselineOffset);
        compare(field.leftPadding
                - prefix.mapToItem(field, prefix.width, 0).x,
                MD.Tokens.textField.prefixSuffixTextSpace);
        compare(suffix.mapToItem(field, 0, 0).x
                - (field.width - field.rightPadding),
                MD.Tokens.textField.prefixSuffixTextSpace);

        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        field.text = "";
        tryCompare(decoration, "placeholderOpacity", 1);
        verify(placeholder.visible);
        compare(placeholder.mapToItem(field, 0, placeholder.baselineOffset).y,
                field.baselineOffset);
    }

    function test_hover_readonly_and_error_visual_states() {
        const field = createField(fieldComponent, {
            "x": 100,
            "y": 100,
            "fieldStyle": MD.TextField.Outlined,
            "supportingText": ""
        });
        const container = findChild(field, "textFieldContainer");
        const label = findChild(field, "textFieldLabel");
        verify(container);
        verify(label);

        mouseMove(testCase, 1, 1);
        tryCompare(field, "hovered", false);
        mouseMove(field, field.width / 2, field.height / 2);
        tryCompare(field, "hovered", true);
        tryCompare(container, "effectiveBorderColor", field.MD.Style.onSurfaceColor);

        field.error = true;
        tryCompare(container, "effectiveBorderColor",
                   field.MD.Style.onErrorContainerColor);
        tryCompare(label, "color", field.MD.Style.onErrorContainerColor);

        field.error = false;
        field.readOnly = true;
        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        verify(field.enabled);
        tryCompare(container, "effectiveBorderWidth",
                   MD.Tokens.textField.outlinedFocusOutlineWidth);
        tryCompare(container, "effectiveBorderColor", field.MD.Style.primaryColor);
    }

    function test_supporting_error_disabled_and_wrapping() {
        const field = createField(fieldComponent, {
            "width": 180,
            "supportingText": "A supporting message that wraps onto more than one line",
            "errorText": "Enter a valid and sufficiently descriptive name"
        });
        const supporting = findChild(field, "textFieldSupportingText");
        const error = findChild(field, "textFieldErrorText");
        const container = findChild(field, "textFieldContainer");
        const indicator = findChild(field, "textFieldActiveIndicator");
        verify(supporting);
        verify(error);
        verify(supporting.visible);
        verify(!error.visible);
        verify(field.implicitHeight
               > MD.Tokens.textField.containerHeight
                 + MD.Tokens.textField.supportingTextTopSpace
                 + MD.Tokens.textField.supportingTextMinimumHeight);

        field.error = true;
        tryCompare(supporting, "visible", false);
        tryCompare(error, "visible", true);
        compare(field.Accessible.description, field.errorText);
        tryCompare(indicator, "color", field.MD.Style.errorColor);

        field.enabled = false;
        tryCompare(container, "color",
                   MD.Color.transparent(field.MD.Style.onSurfaceColor,
                                        MD.Tokens.textField.filledDisabledContainerOpacity));
        compare(indicator.opacity, MD.Tokens.textField.filledDisabledActiveIndicatorOpacity);
    }

    function test_slots_reserve_space_and_follow_state() {
        const field = createField(adornedFieldComponent);
        const leadingSlot = findChild(field, "textFieldLeadingSlot");
        const trailingSlot = findChild(field, "textFieldTrailingSlot");
        const leading = findChild(field, "customLeading");
        const trailing = findChild(field, "customTrailing");
        verify(leadingSlot);
        verify(trailingSlot);
        verify(leading);
        verify(trailing);
        verify(leadingSlot.width >= MD.Tokens.textField.iconTargetSize);
        verify(trailingSlot.width >= MD.Tokens.textField.iconTargetSize);
        compare(leading.color, field.leadingContentColor);
        compare(trailing.color, field.trailingContentColor);
        verify(leading.mapToItem(field, 0, 0).x
               < trailing.mapToItem(field, 0, 0).x);
        compare(trailing.clickCount, 0);
        mouseClick(trailing, trailing.width / 2, trailing.height / 2);
        compare(trailing.clickCount, 1);

        field.error = true;
        compare(trailing.color, field.MD.Style.errorColor);
        field.enabled = false;
        compare(leadingSlot.enabled, false);
        compare(trailingSlot.enabled, false);
        compare(leadingSlot.opacity, MD.Tokens.textField.disabledContentOpacity);
        compare(trailingSlot.opacity, MD.Tokens.textField.disabledContentOpacity);

        field.enabled = true;
        const adornedLeftPadding = field.leftPadding;
        const adornedRightPadding = field.rightPadding;
        field.leading = null;
        field.trailing = null;
        tryCompare(leadingSlot, "visible", false);
        tryCompare(trailingSlot, "visible", false);
        verify(field.leftPadding < adornedLeftPadding);
        verify(field.rightPadding < adornedRightPadding);
    }

    function test_validator_keyboard_readonly_and_password() {
        const field = createField(validatedFieldComponent);
        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        keyClick(Qt.Key_4);
        keyClick(Qt.Key_2);
        compare(field.text, "42");
        compare(field.acceptableInput, true);

        field.selectAll();
        keyClick(Qt.Key_9);
        compare(field.acceptableInput, false);
        field.readOnly = true;
        keyClick(Qt.Key_8);
        compare(field.text, "9");
        field.echoMode = TextInput.Password;
        compare(field.echoMode, TextInput.Password);
    }

    function test_rtl_logical_layout() {
        const host = createField(rtlFieldComponent);
        verify(host);
        const field = host.field;
        const leading = findChild(field, "rtlLeading");
        const trailing = findChild(field, "rtlTrailing");
        const prefix = findChild(field, "textFieldPrefix");
        const suffix = findChild(field, "textFieldSuffix");
        verify(field.mirrored);
        field.fieldStyle = MD.TextField.Outlined;
        field.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(field, "activeFocus", true);
        verify(leading.mapToItem(field, 0, 0).x
               > trailing.mapToItem(field, 0, 0).x);
        verify(prefix.mapToItem(field, 0, 0).x
               > suffix.mapToItem(field, 0, 0).x);
        compare(prefix.mapToItem(field, 0, 0).x
                - (field.width - field.rightPadding),
                MD.Tokens.textField.prefixSuffixTextSpace);
        compare(field.leftPadding
                - suffix.mapToItem(field, suffix.width, 0).x,
                MD.Tokens.textField.prefixSuffixTextSpace);
        compare(field.horizontalAlignment, Text.AlignRight);
        const label = findChild(field, "textFieldLabel");
        const notch = findChild(field, "textFieldLabelNotch");
        const decoration = findChild(field, "textFieldDecoration");
        verify(label);
        verify(notch);
        verify(decoration);
        tryCompare(decoration, "labelProgress", 1);
        tryCompare(notch, "visible", true);
        verify(notch.x <= label.x);
        verify(notch.x + notch.width >= label.x + label.width);

        keyClick(Qt.Key_1);
        compare(field.text, "1");
    }
}
