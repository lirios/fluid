/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.10
import QtTest 1.0
import Fluid.Controls 1.0
import QtQuick.Controls.Material 2.3

Icon {
    id: icon

    TestCase {
        name: "IconTests"
        when: windowShown

        function test_source_should_use_desktop_provider_for_freedesktop_icon() {
            icon.name = 'edit-cut-symbolic'

            compare(icon.source, 'image://fluidicontheme/edit-cut-symbolic')
        }

        function test_source_should_use_icon_prefix_for_material_icon() {
            icon.name = 'action/settings'

            compare(icon.source, 'image://fluidicontheme/action/settings')
        }

        function test_source_should_use_file_url_for_file_name() {
            icon.name = '/path/to/icon.png'

            compare(icon.source, 'file:///path/to/icon.png')
        }

        function test_source_should_use_file_url_for_file_url() {
            icon.name = 'file:///path/to/icon.png'

            compare(icon.source, 'file:///path/to/icon.png')
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
            compare(String(icon.color), String(Material.iconColor))
        }

        function test_color_should_be_dark_icon_color_for_dark_theme() {
            icon.Material.theme = Material.Dark

            // Colors must be converted to strings for compare to work
            compare(String(icon.color), String(Material.iconColor))
        }
    }
}
