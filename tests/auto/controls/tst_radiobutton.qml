// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtTest
import Fluid as MD

Item {
    id: root

    width: 800
    height: 600

    Component {
        id: radioComponent

        MD.RadioButton {
            text: "Option"
        }
    }

    Component {
        id: siblingGroupComponent

        Item {
            property alias first: first
            property alias second: second

            width: 300
            height: 120

            MD.RadioButton {
                id: first
                text: "First"
            }
            MD.RadioButton {
                id: second
                y: 60
                text: "Second"
            }
        }
    }

    Component {
        id: explicitGroupComponent

        Item {
            property alias first: first
            property alias second: second

            width: 300
            height: 120

            ButtonGroup {
                id: group
            }

            Item {
                MD.RadioButton {
                    id: first
                    text: "First"
                    ButtonGroup.group: group
                }
            }
            Item {
                y: 60

                MD.RadioButton {
                    id: second
                    text: "Second"
                    ButtonGroup.group: group
                }
            }
        }
    }

    TestCase {
        name: "RadioButtonTests"
        when: windowShown

        function createRadio(properties) {
            return createTemporaryObject(radioComponent, root, properties);
        }

        function test_defaults_and_geometry() {
            const control = createRadio({ text: "" });
            verify(control);

            verify(control.autoExclusive);
            compare(control.focusPolicy, Qt.StrongFocus);
            compare(control.typescale.fontSize, MD.Tokens.typescale.labelLarge.fontSize);
            compare(control.implicitWidth, MD.Tokens.radioButton.minimumInteractiveSize);
            compare(control.implicitHeight, MD.Tokens.radioButton.minimumInteractiveSize);
            compare(control.indicator.implicitWidth, 24);
            compare(control.indicator.implicitHeight, 24);

            const ring = findChild(control, "radioOuterRing");
            const dot = findChild(control, "radioSelectedDot");
            const layer = findChild(control, "radioStateLayer");
            verify(ring);
            verify(dot);
            verify(layer);
            compare(ring.width, 20);
            compare(ring.height, 20);
            compare(ring.border.width, 2);
            compare(dot.width, 0);
            compare(layer.width, 40);
            compare(layer.height, 40);

            control.checked = true;
            tryCompare(dot, "width", 10);
            compare(dot.height, 10);
        }

        function test_mouse_and_keyboard_activation() {
            const mouseControl = createRadio({ text: "Mouse" });
            verify(mouseControl);
            mouseClick(mouseControl, mouseControl.width / 2, mouseControl.height / 2);
            verify(mouseControl.checked);
            mouseClick(mouseControl, mouseControl.width / 2, mouseControl.height / 2);
            verify(mouseControl.checked);

            const keyboardControl = createRadio({ text: "Keyboard" });
            verify(keyboardControl);
            keyboardControl.forceActiveFocus(Qt.TabFocusReason);
            verify(keyboardControl.activeFocus);
            keyClick(Qt.Key_Space);
            verify(keyboardControl.checked);
        }

        function test_disabled_rejects_input() {
            const control = createRadio({ enabled: false, checked: false });
            verify(control);
            mouseClick(control, control.width / 2, control.height / 2);
            verify(!control.checked);
        }

        function test_accessibility_contract() {
            const control = createRadio({ text: "Accessible option", checked: false });
            verify(control);

            compare(control.Accessible.role, Accessible.RadioButton);
            compare(control.Accessible.name, "Accessible option");
            verify(control.Accessible.checkable);
            verify(!control.Accessible.checked);
            verify(control.Accessible.focusable);
            verify(control.indicator.Accessible.ignored);
            verify(control.contentItem.Accessible.ignored);

            control.forceActiveFocus(Qt.TabFocusReason);
            verify(control.activeFocus);
            verify(control.Accessible.focused);

            control.Accessible.pressAction();
            verify(control.checked);
            verify(control.Accessible.checked);

            const disabled = createRadio({ enabled: false, checked: false });
            verify(disabled);
            verify(!disabled.Accessible.focusable);
            disabled.Accessible.pressAction();
            verify(!disabled.checked);
        }

        function test_sibling_auto_exclusivity() {
            const host = createTemporaryObject(siblingGroupComponent, root);
            verify(host);

            mouseClick(host.first, host.first.width / 2, host.first.height / 2);
            verify(host.first.checked);
            verify(!host.second.checked);

            mouseClick(host.second, host.second.width / 2, host.second.height / 2);
            verify(!host.first.checked);
            verify(host.second.checked);
        }

        function test_explicit_button_group() {
            const host = createTemporaryObject(explicitGroupComponent, root);
            verify(host);

            host.first.checked = true;
            verify(host.first.checked);
            verify(!host.second.checked);
            host.second.checked = true;
            verify(!host.first.checked);
            verify(host.second.checked);
        }

        function test_state_colors_and_opacities() {
            const normal = createRadio({ checked: false });
            verify(normal);
            compare(normal.indicator.color, normal.MD.Style.onSurfaceVariantColor);
            compare(normal.indicator.opacity, 1);

            normal.checked = true;
            compare(normal.indicator.color, normal.MD.Style.primaryColor);

            const hovered = createRadio({ checked: false, x: 200 });
            verify(hovered);
            mouseMove(hovered, hovered.width / 2, hovered.height / 2);
            tryVerify(function() { return hovered.hovered; });
            compare(hovered.indicator.color, hovered.MD.Style.onSurfaceColor);
            compare(findChild(hovered, "radioStateLayer").stateOpacity,
                    MD.Tokens.radioButton.hoverStateLayerOpacity);

            const focused = createRadio({ checked: false, x: 400 });
            verify(focused);
            focused.forceActiveFocus(Qt.TabFocusReason);
            verify(focused.visualFocus);
            compare(focused.indicator.color, focused.MD.Style.onSurfaceColor);
            compare(findChild(focused, "radioStateLayer").stateOpacity,
                    MD.Tokens.radioButton.focusStateLayerOpacity);

            const pressed = createRadio({ checked: false, x: 600 });
            verify(pressed);
            mousePress(pressed, pressed.width / 2, pressed.height / 2);
            verify(pressed.down);
            compare(pressed.indicator.color, pressed.MD.Style.onSurfaceColor);
            compare(findChild(pressed, "radioStateLayer").stateOpacity,
                    MD.Tokens.radioButton.pressedStateLayerOpacity);
            mouseRelease(pressed, pressed.width / 2, pressed.height / 2);

            const disabled = createRadio({ checked: true, enabled: false, y: 100 });
            verify(disabled);
            compare(disabled.indicator.color, disabled.MD.Style.onSurfaceColor);
            compare(disabled.indicator.opacity,
                    MD.Tokens.radioButton.selectedDisabledIconOpacity);
            compare(disabled.contentItem.opacity,
                    MD.Tokens.radioButton.selectedDisabledIconOpacity);

            const disabledUnselected = createRadio({
                checked: false,
                enabled: false,
                x: 200,
                y: 100
            });
            verify(disabledUnselected);
            compare(disabledUnselected.indicator.color,
                    disabledUnselected.MD.Style.onSurfaceColor);
            compare(disabledUnselected.indicator.opacity,
                    MD.Tokens.radioButton.unselectedDisabledIconOpacity);
        }

        function test_rtl_layout() {
            const control = createRadio({ text: "Option", width: 180 });
            verify(control);
            compare(control.indicator.x, control.leftPadding);
            compare(control.contentItem.leftPadding,
                    control.indicator.width + control.spacing);
            compare(control.contentItem.rightPadding, 0);

            control.LayoutMirroring.enabled = true;
            verify(control.mirrored);
            compare(control.indicator.x,
                    control.width - control.indicator.width - control.rightPadding);
            compare(control.contentItem.leftPadding, 0);
            compare(control.contentItem.rightPadding,
                    control.indicator.width + control.spacing);

            const iconOnly = createRadio({ text: "", width: 96, x: 240 });
            verify(iconOnly);
            const ltrX = iconOnly.indicator.x;
            iconOnly.LayoutMirroring.enabled = true;
            verify(iconOnly.mirrored);
            compare(iconOnly.indicator.x, ltrX);
            compare(iconOnly.indicator.x,
                    iconOnly.leftPadding
                    + (iconOnly.availableWidth - iconOnly.indicator.width) / 2);
        }
    }
}
