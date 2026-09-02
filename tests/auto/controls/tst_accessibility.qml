// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtTest

TestCase {
    id: testCase

    name: "AccessibilityTests"
    width: 960
    height: 720
    visible: true
    when: windowShown

    Component {
        id: semanticsComponent

        Item {
            property alias appBar: appBar
            property alias dropdown: dropdown
            property alias groupBox: groupBox
            property alias divider: divider
            property alias listItem: listItem
            property alias menuItem: menuItem
            property alias rail: rail
            property alias railItem: railItem
            property alias rangeSlider: rangeSlider
            property alias symbol: symbol
            property alias image: image
            property alias scrollIndicator: scrollIndicator
            property alias sliderTrack: sliderTrack
            property alias checkIndicator: checkIndicator
            property alias radioIndicator: radioIndicator
            property alias textField: textField

            width: 800
            height: 700

            MD.AppBar {
                id: appBar
                title: "Library"
                subtitle: "Recently added"
            }

            MD.ExposedDropdownMenu {
                id: dropdown
                y: 80
                width: 240
                label: "Country"
                placeholderText: "Choose a country"
                supportingText: "Required"
                model: ["Italy", "France"]
            }

            MD.GroupBox {
                id: groupBox
                y: 160
                title: "Options"
            }

            MD.Divider {
                id: divider
                y: 220
                width: 240
            }

            MD.ListItem {
                id: listItem
                y: 240
                width: 240
                text: "Downloads"
                supportingText: "Three files"
            }

            MD.MenuItem {
                id: menuItem
                y: 320
                text: "Archive"
                supportingText: "Move this item"
            }

            MD.NavigationRail {
                id: rail
                x: 300
                height: 320
                Accessible.name: "Primary navigation"

                MD.NavigationRailItem {
                    id: railItem
                    text: "Home"
                    icon.name: "home"
                }
            }

            MD.RangeSlider {
                id: rangeSlider
                x: 300
                y: 350
                width: 240
                from: 0
                to: 100
                stepSize: 10
                first.value: 20
                second.value: 80
                Accessible.name: "Price range"
            }

            MD.Symbol {
                id: symbol
                x: 580
                name: "home"
            }

            MD.SmoothFadeImage {
                id: image
                x: 620
                width: 40
                height: 40
            }

            MD.ScrollIndicator {
                id: scrollIndicator
                x: 680
                height: 100
            }

            MD.SliderTrack {
                id: sliderTrack
                x: 580
                y: 80
                horizontal: true
                mirrored: false
                centered: false
                rangeMode: false
                controlEnabled: true
                visualPosition: 0.5
                secondVisualPosition: 0
                rangeFrom: 0
                rangeTo: 1
                stepSize: 0
                tickVisibilityMode: 0
                autoLimitMode: 0
                autoHideMode: 1
                hiddenMode: 2
                trackHeight: 16
                trackOuterCornerRadius: 8
                handleHeight: 44
                effectiveHandleWidth: 4
                labelSpace: 0
                activeTrackColor: "blue"
                inactiveTrackColor: "gray"
                activeTickColor: "white"
                inactiveTickColor: "black"
                activeTrackOpacity: 1
                inactiveTrackOpacity: 1
                trackIconActiveStart: ""
                trackIconActiveEnd: ""
                trackIconInactiveStart: ""
                trackIconInactiveEnd: ""
                trackIconActiveColor: "white"
                trackIconInactiveColor: "black"
                trackIconSize: 0
                trackIconPadding: 0
            }

            MD.CheckIndicator {
                id: checkIndicator
                x: 580
                y: 160
                control: Item { property int checkState: Qt.Checked }
                color: "white"
                backgroundColor: "blue"
                outlineColor: "blue"
                outlineWidth: 0
            }

            MD.RadioIndicator {
                id: radioIndicator
                x: 620
                y: 160
                control: Item { property bool checked: true }
                color: "blue"
            }

            MD.TextField {
                id: textField
                x: 300
                y: 520
                width: 280
                label: "Email address"
                placeholderText: "name@example.com"
                supportingText: "Used for account notifications"
            }
        }
    }

    Component {
        id: controlsComponent

        Item {
            property alias button: button
            property alias checkBox: checkBox
            property alias radioButton: radioButton
            property alias switchControl: switchControl
            property alias slider: slider
            property alias scrollBar: scrollBar
            property alias search: search
            property alias fabMenu: fabMenu
            property alias firstFabItem: firstFabItem
            property alias secondFabItem: secondFabItem
            property alias richToolTip: richToolTip

            width: 800
            height: 700

            MD.Button { id: button; text: "Save" }
            MD.CheckBox { id: checkBox; y: 60; text: "Remember"; checked: true }
            MD.RadioButton { id: radioButton; y: 120; text: "Daily"; checked: true }
            MD.Switch { id: switchControl; y: 180; text: "Notifications" }
            MD.Slider {
                id: slider
                y: 240
                width: 200
                Accessible.name: "Volume"
            }
            MD.ScrollBar {
                id: scrollBar
                x: 220
                height: 160
                orientation: Qt.Vertical
                Accessible.name: "Results"
            }
            MD.SearchAppBar {
                id: search
                y: 360
                width: 600
                placeholderText: "Search messages"
            }
            MD.FabMenu {
                id: fabMenu
                anchors.fill: parent
                text: "Create"
                MD.FabMenuItem { id: firstFabItem; text: "Document" }
                MD.FabMenuItem { enabled: false; text: "Disabled" }
                MD.FabMenuItem { id: secondFabItem; text: "Folder" }
            }

            MD.RichToolTip {
                id: richToolTip
                headline: "Formatting"
                text: "Choose how text is emphasized"
            }
        }
    }

    function test_composite_semantics() {
        const host = createTemporaryObject(semanticsComponent, testCase);
        verify(host);

        compare(host.appBar.Accessible.role, Accessible.ToolBar);
        compare(host.appBar.Accessible.name, "Library");
        compare(host.appBar.Accessible.description, "Recently added");
        verify(findChild(host.appBar, "titleLabel").Accessible.ignored);
        verify(findChild(host.appBar, "subtitleLabel").Accessible.ignored);

        compare(host.dropdown.Accessible.name, "Country");
        compare(host.dropdown.Accessible.description, "Required");
        host.dropdown.error = true;
        host.dropdown.errorText = "Choose a valid country";
        compare(host.dropdown.Accessible.description, "Choose a valid country");

        compare(host.textField.Accessible.role, Accessible.EditableText);
        compare(host.textField.Accessible.name, "Email address");
        compare(host.textField.Accessible.description, "Used for account notifications");
        verify(host.textField.Accessible.editable);
        host.textField.errorText = "Enter a valid email address";
        host.textField.error = true;
        compare(host.textField.Accessible.description, "Enter a valid email address");

        compare(host.groupBox.Accessible.role, Accessible.Grouping);
        compare(host.groupBox.Accessible.name, "Options");
        compare(host.divider.Accessible.role, Accessible.Separator);
        compare(host.listItem.Accessible.name, "Downloads");
        compare(host.listItem.Accessible.description, "Three files");
        compare(host.menuItem.Accessible.description, "Move this item");

        compare(host.rail.Accessible.role, Accessible.PageTabList);
        compare(host.rail.Accessible.name, "Primary navigation");
        compare(host.railItem.Accessible.role, Accessible.PageTab);
        compare(host.railItem.Accessible.name, "Home");
        verify(host.railItem.Accessible.selected);
    }

    function test_decorative_helpers_and_opt_in_images() {
        const host = createTemporaryObject(semanticsComponent, testCase);
        verify(host);
        verify(host.symbol.Accessible.ignored);
        verify(host.image.Accessible.ignored);
        verify(host.scrollIndicator.Accessible.ignored);
        verify(host.sliderTrack.Accessible.ignored);
        verify(host.checkIndicator.Accessible.ignored);
        verify(host.radioIndicator.Accessible.ignored);

        host.symbol.Accessible.name = "Home illustration";
        host.image.Accessible.name = "Profile photo";
        verify(!host.symbol.Accessible.ignored);
        verify(!host.image.Accessible.ignored);
        compare(host.symbol.Accessible.role, Accessible.Graphic);
        compare(host.image.Accessible.role, Accessible.Graphic);
    }

    function test_standard_control_contracts() {
        const host = createTemporaryObject(controlsComponent, testCase);
        verify(host);
        compare(host.button.text, "Save");
        compare(host.button.focusPolicy, Qt.StrongFocus);
        verify(host.checkBox.checked);
        compare(host.checkBox.focusPolicy, Qt.StrongFocus);
        compare(host.radioButton.Accessible.role, Accessible.RadioButton);
        compare(host.radioButton.Accessible.name, "Daily");
        verify(host.radioButton.Accessible.checked);
        verify(host.radioButton.Accessible.checkable);
        verify(host.radioButton.Accessible.focusable);
        verify(host.radioButton.contentItem.Accessible.ignored);
        compare(host.radioButton.focusPolicy, Qt.StrongFocus);
        compare(host.switchControl.text, "Notifications");
        compare(host.slider.focusPolicy, Qt.StrongFocus);
        compare(host.slider.Accessible.name, "Volume");
        compare(host.scrollBar.focusPolicy, Qt.StrongFocus);

        const launcher = findChild(host.search, "searchLauncher");
        const defaultSearchAction = findChild(host.search, "searchNavigationActionButton");
        compare(launcher.Accessible.role, Accessible.Button);
        compare(launcher.Accessible.name, "Search messages");
        verify(findChild(host.search, "searchLauncherLabel").Accessible.ignored);
        verify(defaultSearchAction.accessibilityIgnored);
        verify(defaultSearchAction.loadedAction.Accessible.ignored);

        host.search.mode = MD.SearchAppBar.Editable;
        const field = findChild(host.search, "searchField");
        compare(field.Accessible.role, Accessible.EditableText);
        compare(field.Accessible.name, "Search messages");
        verify(field.Accessible.searchEdit);

        const richContent = findChild(host.richToolTip, "richToolTipContent");
        compare(richContent.Accessible.role, Accessible.ToolTip);
        compare(richContent.Accessible.name, "Formatting");
        compare(richContent.Accessible.description, "Choose how text is emphasized");
        verify(findChild(host.richToolTip, "richToolTipHeadline").Accessible.ignored);
        verify(findChild(host.richToolTip, "richToolTipBody").Accessible.ignored);
    }

    function test_range_slider_handle_contracts_and_actions() {
        const host = createTemporaryObject(semanticsComponent, testCase);
        const slider = host.rangeSlider;
        const firstHandle = slider.first.handle;
        const secondHandle = slider.second.handle;

        verify(slider.Accessible.ignored);
        compare(firstHandle.Accessible.role, Accessible.Slider);
        compare(secondHandle.Accessible.role, Accessible.Slider);
        compare(firstHandle.Accessible.name, "Price range minimum");
        compare(secondHandle.Accessible.name, "Price range maximum");
        compare(firstHandle.value, 20);
        compare(firstHandle.minimumValue, 0);
        compare(firstHandle.maximumValue, 80);
        compare(secondHandle.value, 80);
        compare(secondHandle.minimumValue, 20);
        compare(secondHandle.maximumValue, 100);

        firstHandle.Accessible.increaseAction();
        compare(slider.first.value, 30);
        secondHandle.Accessible.decreaseAction();
        compare(slider.second.value, 70);
    }

    function test_fab_menu_keyboard_focus_and_restore() {
        const host = createTemporaryObject(controlsComponent, testCase);
        const menu = host.fabMenu;
        menu.button.forceActiveFocus(Qt.TabFocusReason);
        menu.open();
        tryVerify(() => host.firstFabItem.activeFocus);

        keyClick(Qt.Key_Down);
        verify(host.secondFabItem.activeFocus);
        keyClick(Qt.Key_Home);
        verify(host.firstFabItem.activeFocus);
        keyClick(Qt.Key_End);
        verify(menu.button.activeFocus);
        keyClick(Qt.Key_Escape);
        verify(!menu.expanded);
        tryVerify(() => menu.button.activeFocus);
    }
}
