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
import QtTest 1.0
import Fluid.Core 1.0
import Fluid.Controls 1.0
import QtQuick.Controls 2.3

TestCase {
    id: testCase
    name: "TypographyTests"
    width: 200
    height: 200
    visible: true
    when: windowShown

    Component {
        id: displayLabelComponent
        DisplayLabel {}
    }

    Component {
        id: bodyLabelComponent
        BodyLabel {}
    }

    Component {
        id: captionLabelComponent
        CaptionLabel {}
    }

    Component {
        id: headlineLabelComponent
        HeadlineLabel {}
    }

    Component {
        id: subheadingLabelComponent
        SubheadingLabel {}
    }

    Component {
        id: titleLabelComponent
        TitleLabel {}
    }

    function test_display_label() {
        var displayLabel = displayLabelComponent.createObject(testCase)
        verify(displayLabel)

        displayLabel.level = 1
        compare(displayLabel.font.pixelSize, 34)
        compare(displayLabel.font.weight, Font.Normal)
        displayLabel.level = 2
        compare(displayLabel.font.pixelSize, 45)
        compare(displayLabel.font.weight, Font.Normal)
        displayLabel.level = 3
        compare(displayLabel.font.pixelSize, 56)
        compare(displayLabel.font.weight, Font.Normal)
        displayLabel.level = 4
        compare(displayLabel.font.pixelSize, 112)
        compare(displayLabel.font.weight, Font.Light)
    }

    function test_body_label() {
        var bodyLabel = bodyLabelComponent.createObject(testCase)
        verify(bodyLabel)

        bodyLabel.level = 1
        if (Device.isMobile)
            compare(bodyLabel.font.pixelSize, 14)
        else
            compare(bodyLabel.font.pixelSize, 13)
        compare(bodyLabel.lineHeight, 20.0)
        compare(bodyLabel.lineHeightMode, Text.FixedHeight)

        bodyLabel.level = 2
        if (Device.isMobile)
            compare(bodyLabel.font.pixelSize, 14)
        else
            compare(bodyLabel.font.pixelSize, 13)
        compare(bodyLabel.lineHeight, 24.0)
        compare(bodyLabel.lineHeightMode, Text.FixedHeight)
    }

    function test_caption_label() {
        var captionLabel = captionLabelComponent.createObject(testCase)
        verify(captionLabel)

        compare(captionLabel.font.pixelSize, 12)
    }

    function test_headline_label() {
        var headlineLabel = headlineLabelComponent.createObject(testCase)
        verify(headlineLabel)

        compare(headlineLabel.font.pixelSize, 24)
        compare(headlineLabel.lineHeight, 32.0)
        compare(headlineLabel.lineHeightMode, Text.FixedHeight)
    }

    function test_subheading_label() {
        var subheadingLabel = subheadingLabelComponent.createObject(testCase)
        verify(subheadingLabel)

        subheadingLabel.level = 1
        if (Device.isMobile)
            compare(subheadingLabel.font.pixelSize, 16)
        else
            compare(subheadingLabel.font.pixelSize, 15)
        compare(subheadingLabel.lineHeight, 24.0)
        compare(subheadingLabel.lineHeightMode, Text.FixedHeight)

        subheadingLabel.level = 2
        if (Device.isMobile)
            compare(subheadingLabel.font.pixelSize, 16)
        else
            compare(subheadingLabel.font.pixelSize, 15)
        compare(subheadingLabel.lineHeight, 28.0)
        compare(subheadingLabel.lineHeightMode, Text.FixedHeight)
    }

    function test_title_label() {
        var titleLabel = titleLabelComponent.createObject(testCase)
        verify(titleLabel)

        compare(titleLabel.font.pixelSize, 20)
        compare(titleLabel.font.weight, Font.Medium)
    }
}
