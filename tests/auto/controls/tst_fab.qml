/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Controls 2.3
import QtTest 1.0
import Fluid.Controls 1.0 as FluidControls

TestCase {
    id: testCase

    name: "FABTests"
    width: 200
    height: 200
    visible: true
    when: windowShown

    Component {
        id: fabComponent
        FluidControls.FloatingActionButton {}
    }

    function test_size() {
        var fab = fabComponent.createObject(testCase)
        verify(fab)

        // 40 (width) + 12 (padding)
        fab.mini = true;
        compare(fab.width, 52);
        compare(fab.height, fab.width);
        compare(fab.implicitWidth, 52);
        compare(fab.implicitHeight, fab.implicitWidth);

        // 56 (width) + 12 (padding)
        fab.mini = false;
        compare(fab.width, 68);
        compare(fab.height, fab.width);
        compare(fab.implicitWidth, 68);
        compare(fab.implicitHeight, fab.implicitWidth);
    }
}
