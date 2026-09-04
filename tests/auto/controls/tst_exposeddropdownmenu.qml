// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Templates as T
import QtTest

TestCase {
    id: testCase

    name: "ExposedDropdownMenuTests"
    width: 480
    height: 360
    visible: true
    when: windowShown

    Component {
        id: menuComponent

        MD.ExposedDropdownMenu {
            width: 240
            label: "Fruit"
            placeholderText: "Choose fruit"
            supportingText: "Required"
            model: [
                {
                    "name": "Apple",
                    "value": "apple",
                    "enabled": true,
                    "icon": MD.Symbols.favorite,
                    "supporting": "Crisp",
                    "trailing": "1",
                    "badge": "New"
                },
                {
                    "name": "Banana",
                    "value": "banana",
                    "enabled": true,
                    "icon": MD.Symbols.star,
                    "supporting": "Sweet",
                    "trailing": "2",
                    "badge": ""
                },
                {
                    "name": "Cherry",
                    "value": "cherry",
                    "enabled": false,
                    "icon": MD.Symbols.favorite,
                    "supporting": "Tart",
                    "trailing": "3",
                    "badge": "Limited"
                }
            ]
            textRole: "name"
            valueRole: "value"
            enabledRole: "enabled"
            leadingIconRole: "icon"
            supportingTextRole: "supporting"
            trailingTextRole: "trailing"
            badgeRole: "badge"
        }
    }

    Component {
        id: dynamicMenuComponent

        MD.ExposedDropdownMenu {
            property alias options: options

            width: 240
            label: "Dynamic"
            textRole: "name"
            valueRole: "value"
            model: ListModel {
                id: options
            }
        }
    }

    Component {
        id: editableMenuComponent

        MD.ExposedDropdownMenu {
            width: 240
            label: "Number"
            editable: true
            inputMethodHints: Qt.ImhDigitsOnly
            validator: IntValidator {
                bottom: 10
                top: 99
            }
            model: ["10", "20", "30"]
        }
    }

    Component {
        id: customDelegateMenuComponent

        MD.ExposedDropdownMenu {
            width: 240
            label: "Custom delegate"
            model: [{ "name": "One" }, { "name": "Two" }]
            textRole: "name"

            delegate: T.ItemDelegate {
                required property var model

                objectName: "customDropdownDelegate"
                text: model.name
                width: ListView.view ? ListView.view.width : implicitWidth
            }
        }
    }

    Component {
        id: tallMenuComponent

        MD.ExposedDropdownMenu {
            width: 220
            label: "Many choices"
            model: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"]
        }
    }

    Component {
        id: rtlMenuComponent

        Item {
            property alias menu: menu

            width: 300
            height: 120
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.ExposedDropdownMenu {
                id: menu

                width: 240
                label: "Direction"
                model: ["Forward", "Back"]
            }
        }
    }

    Component {
        id: sharedFieldHostComponent

        Item {
            property alias textField: textField
            property alias dropdown: dropdown

            width: 580
            height: 120

            MD.TextField {
                id: textField

                width: 280
                label: "Shared field"
                text: "Value"
                supportingText: "Supporting text"
            }

            MD.ExposedDropdownMenu {
                id: dropdown

                x: 300
                width: 280
                label: "Shared field"
                supportingText: "Supporting text"
                model: ["Value"]
            }
        }
    }

    function createMenu(component, properties) {
        return createTemporaryObject(component || menuComponent, testCase, properties || {});
    }

    function open(menu) {
        menu.forceActiveFocus();
        mouseClick(menu, menu.width / 2, menu.height / 2);
        tryCompare(menu.popup, "visible", true);
        tryCompare(menu.popup, "scale", 1.0);
    }

    function close(menu) {
        if (menu.popup.visible) {
            keyClick(Qt.Key_Escape);
            tryCompare(menu.popup, "visible", false);
        }
    }

    function dropdownItemAt(menu, index) {
        const list = findChild(menu.popup, "menuListView");
        verify(list);
        return list.itemAtIndex(index);
    }

    function test_defaults_semantics_and_accessibility() {
        const menu = createMenu();
        verify(menu);
        compare(menu.fieldStyle, MD.ExposedDropdownMenu.Filled);
        compare(menu.menuColorStyle, MD.ExposedDropdownMenu.Standard);
        compare(menu.label, "Fruit");
        compare(menu.placeholderText, "Choose fruit");
        compare(menu.supportingText, "Required");
        compare(menu.errorText, "");
        verify(!menu.error);
        verify(menu.popup);
        compare(menu.focusPolicy, Qt.StrongFocus);
        verify(findChild(menu, "exposedDropdownFieldDecoration"));
        const label = findChild(menu, "exposedDropdownLabel");
        const placeholder = findChild(menu, "exposedDropdownPlaceholder");
        const supporting = findChild(menu, "exposedDropdownSupportingText");
        verify(label);
        verify(placeholder);
        verify(supporting);
        compare(label.text, menu.label);
        compare(placeholder.text, menu.placeholderText);
        compare(supporting.text, menu.supportingText);
    }

    function test_shared_field_decoration_parity() {
        const host = createMenu(sharedFieldHostComponent);
        verify(host);
        const textField = host.textField;
        const dropdown = host.dropdown;
        const textContainer = findChild(textField, "textFieldContainer");
        const dropdownContainer = findChild(dropdown, "exposedDropdownBackground");
        const textIndicator = findChild(textField, "textFieldActiveIndicator");
        const dropdownIndicator = findChild(dropdown, "exposedDropdownActiveIndicator");
        const textLabel = findChild(textField, "textFieldLabel");
        const dropdownLabel = findChild(dropdown, "exposedDropdownLabel");
        const textSupporting = findChild(textField, "textFieldSupportingText");
        const dropdownSupporting = findChild(dropdown, "exposedDropdownSupportingText");
        verify(textContainer);
        verify(dropdownContainer);
        verify(textIndicator);
        verify(dropdownIndicator);
        verify(textLabel);
        verify(dropdownLabel);
        verify(textSupporting);
        verify(dropdownSupporting);

        compare(textContainer.color, dropdownContainer.color);
        compare(textContainer.topLeftRadius, dropdownContainer.topLeftRadius);
        compare(textContainer.topRightRadius, dropdownContainer.topRightRadius);
        compare(textContainer.bottomLeftRadius, dropdownContainer.bottomLeftRadius);
        compare(textContainer.bottomRightRadius, dropdownContainer.bottomRightRadius);
        compare(textIndicator.height, dropdownIndicator.height);
        compare(textIndicator.color, dropdownIndicator.color);
        compare(textLabel.mapToItem(host, 0, 0).x,
                dropdownLabel.mapToItem(host, 0, 0).x - dropdown.x);
        compare(textLabel.mapToItem(host, 0, 0).y,
                dropdownLabel.mapToItem(host, 0, 0).y);
        compare(textSupporting.y, dropdownSupporting.y);

        textField.fieldStyle = MD.TextField.Outlined;
        dropdown.fieldStyle = MD.ExposedDropdownMenu.Outlined;
        tryCompare(textIndicator, "visible", false);
        tryCompare(dropdownIndicator, "visible", false);
        tryCompare(textContainer.border, "width",
                   MD.Tokens.textField.outlinedOutlineWidth);
        tryCompare(dropdownContainer.border, "width",
                   MD.Tokens.exposedDropdownMenu.outlinedOutlineWidth);
        tryVerify(() => Math.abs(
                      dropdownLabel.mapToItem(host, 0, 0).x - dropdown.x
                      - textLabel.mapToItem(host, 0, 0).x
                      - MD.Tokens.exposedDropdownMenu.outlinedLabelHorizontalPadding) < 0.01);

        textField.enabled = false;
        dropdown.enabled = false;
        tryCompare(textLabel, "opacity", MD.Tokens.textField.disabledContentOpacity);
        tryCompare(dropdownLabel, "opacity",
                   MD.Tokens.exposedDropdownMenu.disabledContentOpacity);

        dropdown.enabled = true;
        dropdown.fieldStyle = MD.ExposedDropdownMenu.Filled;
        dropdown.flat = true;
        tryCompare(dropdownContainer, "color", Qt.rgba(0, 0, 0, 0));
        tryCompare(dropdownContainer.border, "width", 0);
        compare(dropdownIndicator.visible, false);
    }

    function test_leading_icon_name_and_source() {
        const menu = createMenu();
        verify(menu);
        menu.leadingIconName = MD.Symbols.search;
        compare(menu.leadingIconName, MD.Symbols.search);
        const icon = findChild(menu, "exposedDropdownLeadingIcon");
        verify(icon);
        compare(icon.visible, true);

        const source = Qt.resolvedUrl(
                             "../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");
        menu.leadingIconSource = source;
        compare(menu.leadingIconSource.toString(), source.toString());

        menu.fieldStyle = MD.ExposedDropdownMenu.Outlined;
        const field = findChild(menu, "exposedDropdownField");
        verify(field);
        compare(field.height, MD.Tokens.exposedDropdownMenu.fieldHeight);
        compare(field.mapToItem(menu, 0, field.height / 2).y,
                icon.mapToItem(menu, 0, icon.height / 2).y);

        menu.enabled = false;
        compare(icon.opacity, MD.Tokens.exposedDropdownMenu.disabledContentOpacity);
    }

    function test_filled_floating_label_and_placeholder_geometry() {
        const menu = createMenu(menuComponent, {
            "currentIndex": -1,
            "fieldStyle": MD.ExposedDropdownMenu.Filled,
            "leadingIconName": MD.Symbols.language
        });
        verify(menu);
        const field = findChild(menu, "exposedDropdownField");
        const decoration = findChild(menu, "exposedDropdownFieldDecoration");
        const label = findChild(menu, "exposedDropdownLabel");
        const placeholder = findChild(menu, "exposedDropdownPlaceholder");
        verify(field);
        verify(decoration);
        verify(label);
        verify(placeholder);

        menu.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(menu, "activeFocus", true);
        tryCompare(placeholder, "visible", true);
        tryCompare(decoration, "labelProgress", 1);
        tryCompare(decoration, "placeholderOpacity", 1);
        compare(placeholder.mapToItem(menu, 0, placeholder.baselineOffset).y,
                field.mapToItem(menu, 0, field.baselineOffset).y);
        verify(placeholder.mapToItem(menu, 0, 0).y
               >= label.mapToItem(menu, 0, label.height).y);
    }

    function test_expressive_field_transitions_and_trailing_icon() {
        const menu = createMenu(menuComponent, {
            "currentIndex": -1,
            "fieldStyle": MD.ExposedDropdownMenu.Outlined
        });
        verify(menu);
        const decoration = findChild(menu, "exposedDropdownFieldDecoration");
        const label = findChild(menu, "exposedDropdownLabel");
        const placeholder = findChild(menu, "exposedDropdownPlaceholder");
        const background = findChild(menu, "exposedDropdownBackground");
        const trailingIcon = findChild(menu, "exposedDropdownTrailingIcon");
        verify(decoration);
        verify(label);
        verify(placeholder);
        verify(background);
        verify(trailingIcon);
        compare(decoration.labelProgress, 0);
        compare(decoration.placeholderOpacity, 0);
        compare(label.font.pixelSize, MD.Tokens.typescale.bodyLarge.fontSize);
        compare(background.border.width,
                MD.Tokens.exposedDropdownMenu.outlinedOutlineWidth);
        compare(trailingIcon.rotation, 0);

        menu.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(menu, "activeFocus", true);
        wait(40);
        verify(decoration.labelProgress > 0 && decoration.labelProgress < 1);
        verify(decoration.placeholderOpacity > 0 && decoration.placeholderOpacity < 1);
        verify(background.border.width
               > MD.Tokens.exposedDropdownMenu.outlinedOutlineWidth);
        verify(background.border.width
               < MD.Tokens.exposedDropdownMenu.outlinedFocusOutlineWidth);
        compare(label.font.pixelSize,
                Math.round(MD.Tokens.typescale.bodyLarge.fontSize
                           + (MD.Tokens.typescale.bodySmall.fontSize
                              - MD.Tokens.typescale.bodyLarge.fontSize)
                             * decoration.labelProgress));
        tryCompare(decoration, "labelProgress", 1);
        tryCompare(decoration, "placeholderOpacity", 1);
        tryCompare(background.border, "width",
                   MD.Tokens.exposedDropdownMenu.outlinedFocusOutlineWidth);

        mouseClick(menu, menu.width / 2, menu.height / 2);
        compare(menu.popup.visible, true);
        compare(trailingIcon.rotation, 180);
        keyClick(Qt.Key_Escape);
        tryCompare(menu.popup, "visible", false);
        compare(trailingIcon.rotation, 0);
    }

    function test_unlabeled_field_remains_centered() {
        const menu = createMenu(menuComponent, {
            "currentIndex": -1,
            "label": "",
            "placeholderText": "Choose fruit"
        });
        verify(menu);
        const decoration = findChild(menu, "exposedDropdownFieldDecoration");
        const field = findChild(menu, "exposedDropdownField");
        const placeholder = findChild(menu, "exposedDropdownPlaceholder");
        verify(decoration);
        verify(field);
        verify(placeholder);
        compare(decoration.labelProgress, 0);
        compare(field.topPadding, 0);
        compare(placeholder.mapToItem(menu, 0, placeholder.baselineOffset).y,
                field.mapToItem(menu, 0, field.baselineOffset).y);
    }

    function test_model_roles_current_text_and_value() {
        const menu = createMenu();
        verify(menu);
        tryCompare(menu, "count", 3);
        compare(menu.currentIndex, 0);
        compare(menu.currentText, "Apple");
        compare(menu.currentValue, "apple");
        compare(menu.enabledRole, "enabled");
        compare(menu.leadingIconRole, "icon");
        compare(menu.supportingTextRole, "supporting");
        compare(menu.trailingTextRole, "trailing");
        compare(menu.badgeRole, "badge");

        menu.currentIndex = 1;
        compare(menu.currentText, "Banana");
        compare(menu.currentValue, "banana");

        menu.currentIndex = 2;
        compare(menu.currentText, "Cherry");
        compare(menu.currentValue, "cherry");
    }

    function test_empty_and_dynamic_models() {
        const menu = createMenu(dynamicMenuComponent);
        verify(menu);
        compare(menu.count, 0);
        compare(menu.currentIndex, -1);
        verify(!menu.popup.visible);

        menu.options.append({ "name": "First", "value": 1 });
        menu.options.append({ "name": "Second", "value": 2 });
        tryCompare(menu, "count", 2);
        compare(menu.currentIndex, -1);
        menu.currentIndex = 0;
        compare(menu.currentText, "First");
        compare(menu.currentValue, 1);

        menu.options.remove(1);
        tryCompare(menu, "count", 1);
        compare(menu.currentIndex, 0);
        compare(menu.currentText, "First");
        compare(menu.currentValue, 1);

        menu.options.clear();
        tryCompare(menu, "count", 0);
        compare(menu.currentIndex, -1);
        compare(menu.currentText, "");
    }

    function test_activation_and_disabled_options() {
        const menu = createMenu();
        const activatedSpy = createTemporaryObject(signalSpyComponent, menu, { "target": menu });
        verify(activatedSpy);

        open(menu);
        const banana = dropdownItemAt(menu, 1);
        const cherry = dropdownItemAt(menu, 2);
        verify(banana);
        verify(cherry);
        verify(cherry.enabled === false);
        const clickedSpy = createTemporaryObject(signalSpyComponent, banana,
                                                 { "target": banana, "signalName": "clicked" });
        verify(clickedSpy);
        compare(findChild(banana, "menuItemSupportingText").text, "Sweet");
        compare(findChild(banana, "menuItemTrailingText").text, "2");
        compare(findChild(banana, "menuItemBadge").visible, false);
        compare(findChild(cherry, "menuItemSupportingText").text, "Tart");
        compare(findChild(cherry, "menuItemBadge").text, "Limited");

        const optionList = findChild(menu.popup, "menuListView");
        verify(optionList);
        mouseClick(optionList, banana.x + banana.width / 2, banana.y + banana.height / 2);
        tryCompare(clickedSpy, "count", 1);
        tryCompare(activatedSpy, "count", 1);
        compare(menu.currentIndex, 1);
        compare(menu.currentValue, "banana");
        tryCompare(menu.popup, "visible", false);

        open(menu);
        mouseClick(optionList, cherry.x + cherry.width / 2, cherry.y + cherry.height / 2);
        compare(activatedSpy.count, 1);
        compare(menu.currentIndex, 1);
        close(menu);
    }

    function test_editable_validator_and_keyboard_input() {
        const menu = createMenu(editableMenuComponent);
        verify(menu);
        verify(menu.editable);
        compare(menu.validator.bottom, 10);
        compare(menu.validator.top, 99);
        const field = findChild(menu, "exposedDropdownField");
        verify(field);
        compare(field.inputMethodHints, Qt.ImhDigitsOnly);

        menu.editText = "9";
        tryCompare(field, "text", "9");
        tryVerify(() => !field.acceptableInput);
        menu.editText = "42";
        tryCompare(field, "text", "42");
        tryVerify(() => field.acceptableInput);
        compare(menu.editText, "42");
    }

    function test_custom_delegate_is_used() {
        const menu = createMenu(customDelegateMenuComponent);
        verify(menu);
        open(menu);
        const first = dropdownItemAt(menu, 0);
        const second = dropdownItemAt(menu, 1);
        verify(first);
        verify(second);
        compare(first.objectName, "customDropdownDelegate");
        compare(second.objectName, "customDropdownDelegate");
        compare(first.text, "One");
        compare(second.text, "Two");
        close(menu);
    }

    function test_field_menu_styles_error_and_disabled() {
        const menu = createMenu();
        verify(menu);
        const background = findChild(menu, "exposedDropdownBackground");
        const activeIndicator = findChild(menu, "exposedDropdownActiveIndicator");
        const field = findChild(menu, "exposedDropdownField");
        const fieldLabel = findChild(menu, "exposedDropdownLabel");
        const labelNotch = findChild(menu, "exposedDropdownLabelNotch");
        const supporting = findChild(menu, "exposedDropdownSupportingText");
        const errorLabel = findChild(menu, "exposedDropdownErrorText");
        verify(background);
        verify(activeIndicator);
        verify(field);
        verify(fieldLabel);
        verify(labelNotch);
        verify(supporting);
        verify(errorLabel);

        menu.fieldStyle = MD.ExposedDropdownMenu.Outlined;
        compare(menu.fieldStyle, MD.ExposedDropdownMenu.Outlined);
        tryCompare(background.border, "width",
                   MD.Tokens.exposedDropdownMenu.outlinedOutlineWidth);
        compare(activeIndicator.visible, false);
        tryVerify(() => fieldLabel.y < 0);
        tryCompare(labelNotch, "visible", true);

        menu.forceActiveFocus(Qt.TabFocusReason);
        tryCompare(menu, "activeFocus", true);
        tryCompare(background.border, "width",
                   MD.Tokens.exposedDropdownMenu.outlinedFocusOutlineWidth);
        tryCompare(fieldLabel, "color", menu.MD.Style.primaryColor);

        menu.menuColorStyle = MD.ExposedDropdownMenu.Vibrant;
        compare(menu.menuColorStyle, MD.ExposedDropdownMenu.Vibrant);
        menu.error = true;
        menu.errorText = "Choose a valid fruit";
        verify(menu.error);
        compare(menu.errorText, "Choose a valid fruit");
        compare(supporting.visible, false);
        compare(errorLabel.visible, true);
        compare(errorLabel.text, menu.errorText);
        compare(field.color, menu.MD.Style.onSurfaceColor);
        tryCompare(fieldLabel, "color", menu.MD.Style.errorColor);

        testCase.forceActiveFocus();
        mouseMove(menu, menu.width / 2, menu.height / 2);
        tryCompare(menu, "hovered", true);
        tryCompare(fieldLabel, "color", menu.MD.Style.onErrorContainerColor);
        tryCompare(background.border, "color", menu.MD.Style.onErrorContainerColor);

        menu.fieldStyle = MD.ExposedDropdownMenu.Filled;
        compare(activeIndicator.visible, true);

        menu.flat = true;
        tryCompare(background, "color", Qt.rgba(0, 0, 0, 0));
        tryCompare(background.border, "width", 0);
        compare(activeIndicator.visible, false);
        menu.flat = false;

        menu.enabled = false;
        verify(!menu.enabled);
        compare(background.opacity, 1);
        tryCompare(background, "color",
                   MD.Color.transparent(
                       menu.MD.Style.onSurfaceColor,
                       MD.Tokens.exposedDropdownMenu.filledDisabledContainerOpacity));
        tryCompare(fieldLabel, "opacity",
                   MD.Tokens.exposedDropdownMenu.disabledContentOpacity);
        mouseClick(menu, menu.width / 2, menu.height / 2);
        verify(!menu.popup.visible);
    }

    function test_vibrant_popup_colors_and_focus_state_layer() {
        const menu = createMenu();
        verify(menu);
        menu.menuColorStyle = MD.ExposedDropdownMenu.Vibrant;
        open(menu);

        const popupBackground = findChild(menu.popup, "exposedDropdownPopupBackground");
        const selectedItem = dropdownItemAt(menu, menu.currentIndex);
        const selectedBackground = findChild(selectedItem, "menuItemBackground");
        const stateLayer = findChild(selectedItem, "menuItemStateLayer");
        verify(popupBackground);
        verify(selectedItem);
        verify(selectedBackground);
        verify(stateLayer);
        compare(findChild(selectedItem, "menuItemFocusIndicator"), null);
        compare(popupBackground.color, menu.MD.Style.tertiaryContainerColor);
        compare(selectedBackground.color, menu.MD.Style.tertiaryColor);
        compare(stateLayer.stateOpacity, MD.Tokens.menu.focusStateLayerOpacity);
        close(menu);
    }

    function test_popup_width_height_scroll_and_vertical_placement() {
        const below = createMenu(tallMenuComponent, { "x": 20, "y": 0 });
        verify(below);
        open(below);
        verify(below.popup.width >= below.width);
        verify(below.popup.height > 0);
        verify(below.popup.y >= below.y + below.height);

        const list = findChild(below.popup, "menuListView");
        verify(list);
        tryVerify(() => list.contentHeight > below.popup.height);
        compare(list.interactive, true);
        compare(list.clip, true);
        close(below);

        const above = createMenu(tallMenuComponent, { "x": 20, "y": testCase.height - 56 });
        verify(above);
        open(above);
        tryVerify(() => above.popup.y < 0);
        close(above);
    }

    function test_keyboard_escape_and_focus_restoration() {
        const menu = createMenu();
        verify(menu);
        menu.forceActiveFocus();
        keyClick(Qt.Key_Space);
        tryCompare(menu.popup, "visible", true);
        verify(menu.popup.activeFocus || menu.popup.contentItem.activeFocus);

        keyClick(Qt.Key_Down);
        tryVerify(() => menu.popup.currentIndex >= 0);
        keyClick(Qt.Key_Escape);
        tryCompare(menu.popup, "visible", false);
        tryCompare(menu, "activeFocus", true);
    }

    function test_rtl_and_default_delegate_geometry() {
        const wrapper = createTemporaryObject(rtlMenuComponent, testCase);
        verify(wrapper);
        const rtl = wrapper.menu;
        compare(rtl.mirrored, true);
        open(rtl);
        const rtlItem = dropdownItemAt(rtl, 0);
        verify(rtlItem);
        compare(rtlItem.mirrored, true);
        close(rtl);

        const menu = createMenu();
        menu.currentIndex = 1;
        open(menu);
        const first = dropdownItemAt(menu, 0);
        const middle = dropdownItemAt(menu, 1);
        const last = dropdownItemAt(menu, 2);
        verify(first);
        verify(middle);
        verify(last);
        compare(first.x, middle.x);
        compare(middle.x, last.x);
        compare(first.width, middle.width);
        compare(middle.width, last.width);
        compare(middle.y, first.y + first.height + MD.Tokens.menu.verticalSegmentedGap);
        compare(last.y, middle.y + middle.height + MD.Tokens.menu.verticalSegmentedGap);
        compare(first.background.topLeftRadius, MD.Tokens.menu.verticalFirstItemShape.topLeft);
        compare(first.background.bottomRightRadius,
                MD.Tokens.menu.verticalFirstItemShape.bottomRight);
        compare(middle.background.topLeftRadius,
                MD.Tokens.menu.verticalSelectedItemShape.topLeft);
        compare(middle.background.bottomRightRadius,
                MD.Tokens.menu.verticalSelectedItemShape.bottomRight);
        compare(last.background.topLeftRadius, MD.Tokens.menu.verticalLastItemShape.topLeft);
        compare(last.background.bottomRightRadius,
                MD.Tokens.menu.verticalLastItemShape.bottomRight);
        const firstLabel = findChild(first, "menuItemLabel");
        const middleLabel = findChild(middle, "menuItemLabel");
        const lastLabel = findChild(last, "menuItemLabel");
        verify(firstLabel);
        verify(middleLabel);
        verify(lastLabel);
        compare(firstLabel.mapToItem(first, 0, 0).x,
                middleLabel.mapToItem(middle, 0, 0).x);
        compare(middleLabel.mapToItem(middle, 0, 0).x,
                lastLabel.mapToItem(last, 0, 0).x);
        compare(menu.popup.currentIndex, 1);
        close(menu);
    }

    Component {
        id: signalSpyComponent

        SignalSpy {
            signalName: "activated"
        }
    }
}
