// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    id: root

    width: 800
    height: 800

    Component {
        id: switchComponent

        MD.Switch {
            text: "Setting"
        }
    }

    TestCase {
        name: "SwitchTests"
        when: windowShown

        function createSwitch(properties) {
            return createTemporaryObject(switchComponent, root, properties);
        }

        function verifyHandleGeometry(control, checked, expectedSize) {
            const track = findChild(control, "switchTrack");
            const handle = findChild(control, "switchHandle");
            verify(track);
            verify(handle);

            const expectedCenter = checked !== control.mirrored
                                 ? track.width - track.height / 2
                                 : track.height / 2;
            tryVerify(function() {
                const topLeft = handle.mapToItem(track, 0, 0);
                return Math.abs(topLeft.x + handle.width / 2 - expectedCenter) < 0.01
                        && Math.abs(topLeft.y + handle.height / 2 - track.height / 2) < 0.01
                        && Math.abs(handle.width - expectedSize) < 0.01;
            });

            const topLeft = handle.mapToItem(track, 0, 0);
            verify(topLeft.x >= 0);
            verify(topLeft.y >= 0);
            verify(topLeft.x + handle.width <= track.width);
            verify(topLeft.y + handle.height <= track.height);
        }

        function test_initialGeometry_data() {
            return [
                { tag: "no-icons-unchecked", checked: false,
                  configuration: MD.Switch.IconConfiguration.NoIcons, handleSize: 16 },
                { tag: "no-icons-checked", checked: true,
                  configuration: MD.Switch.IconConfiguration.NoIcons, handleSize: 24 },
                { tag: "selected-icon-unchecked", checked: false,
                  configuration: MD.Switch.IconConfiguration.SelectedIcon, handleSize: 16 },
                { tag: "selected-icon-checked", checked: true,
                  configuration: MD.Switch.IconConfiguration.SelectedIcon, handleSize: 24 },
                { tag: "both-icons-unchecked", checked: false,
                  configuration: MD.Switch.IconConfiguration.BothIcons, handleSize: 24 },
                { tag: "both-icons-checked", checked: true,
                  configuration: MD.Switch.IconConfiguration.BothIcons, handleSize: 24 }
            ];
        }

        function test_initialGeometry(data) {
            const control = createSwitch({
                checkable: false,
                checked: data.checked,
                iconConfiguration: data.configuration
            });
            verify(control);
            verifyHandleGeometry(control, data.checked, data.handleSize);
        }

        function test_toggleGeometry() {
            const control = createSwitch({
                checked: false,
                iconConfiguration: MD.Switch.IconConfiguration.NoIcons
            });
            verify(control);
            verifyHandleGeometry(control, false, 16);

            mouseClick(control, control.indicator.x + control.indicator.width / 2,
                       control.indicator.y + control.indicator.height / 2);
            verify(control.checked);
            verifyHandleGeometry(control, true, 24);

            mouseClick(control, control.indicator.x + control.indicator.width / 2,
                       control.indicator.y + control.indicator.height / 2);
            verify(!control.checked);
            verifyHandleGeometry(control, false, 16);
        }

        function test_disabledGeometry_data() {
            return [
                { tag: "unchecked", checked: false, handleSize: 16 },
                { tag: "checked", checked: true, handleSize: 24 }
            ];
        }

        function test_disabledGeometry(data) {
            const control = createSwitch({
                checked: data.checked,
                enabled: false,
                iconConfiguration: MD.Switch.IconConfiguration.NoIcons
            });
            verify(control);
            verifyHandleGeometry(control, data.checked, data.handleSize);
        }

        function test_mirroredGeometry() {
            const control = createSwitch({
                checked: false,
                iconConfiguration: MD.Switch.IconConfiguration.NoIcons
            });
            verify(control);
            control.LayoutMirroring.enabled = true;
            verify(control.mirrored);
            verifyHandleGeometry(control, false, 16);

            control.checked = true;
            verifyHandleGeometry(control, true, 24);
        }
    }
}
