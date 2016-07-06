/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtTest 1.0
import Fluid.UI 1.0
import QtQuick.Controls.Material 2.0

Icon {
    id: icon

    TestCase {
        name: "IconTests"
        when: windowShown

        function test_source_should_use_desktop_provider_for_freedesktop_icon() {
            icon.name = 'edit-cut-symbolic'

            compare(icon.source, 'image://desktoptheme/edit-cut-symbolic')
        }

        function test_source_should_use_icon_prefix_for_material_icon() {
            icon.name = 'action/settings'

            compare(icon.source, 'icon://action/settings')
        }

        function test_colorize_should_be_true_for_material_icon() {
            icon.name = 'action/settings'

            compare(icon.colorize, true)
        }

        function test_colorize_should_be_true_for_symbolic_icon() {
            icon.name = 'edit-cut-symbolic'

            compare(icon.colorize, true)
        }

        function test_colorize_should_be_false_for_regular_icon() {
            icon.name = 'gimp'

            compare(icon.colorize, false)
        }

        function test_color_should_be_light_icon_color_for_light_theme() {
            icon.Material.theme = Material.Light

            // Colors must be converted to strings for compare to work
            compare(String(icon.color), String(FluidStyle.iconColorLight))
        }

        function test_color_should_be_dark_icon_color_for_dark_theme() {
            icon.Material.theme = Material.Dark

            // Colors must be converted to strings for compare to work
            compare(String(icon.color), String(FluidStyle.iconColorDark))
        }
    }
}
