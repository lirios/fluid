// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtTest
import Fluid as MD
import "../../../src/gallery/qml" as Gallery

TestCase {
    id: testCase

    name: "GalleryTests"
    width: 1800
    height: 800
    visible: true
    when: windowShown

    Component {
        id: pageComponent

        Gallery.GalleryPage {
            id: galleryPage

            width: 480
            height: 600
            headline: "Headline"
            description: "Description"

            Gallery.GalleryCard {
                objectName: "standardGalleryCard"
                gridColumns: galleryPage.columns
                title: "Standard"

                Item {
                    implicitHeight: 40
                }
            }

            Gallery.GalleryCard {
                objectName: "fullWidthGalleryCard"
                gridColumns: galleryPage.columns
                fullWidth: true
                title: "Full width"

                Item {
                    implicitHeight: 40
                }
            }
        }
    }

    function test_adaptiveCardSpans_data() {
        return [
            {
                tag: "compact",
                width: 480,
                columns: 4,
                standardSpan: 4
            },
            {
                tag: "medium",
                width: 720,
                columns: 8,
                standardSpan: 4
            },
            {
                tag: "large",
                width: 1280,
                columns: 12,
                standardSpan: 6
            }
        ];
    }

    function test_adaptiveCardSpans(data) {
        const page = createTemporaryObject(pageComponent, testCase, {
            width: data.width
        });
        verify(page);
        tryCompare(page, "columns", data.columns);

        const standardCard = findChild(page, "standardGalleryCard");
        const fullWidthCard = findChild(page, "fullWidthGalleryCard");
        verify(standardCard);
        verify(fullWidthCard);
        compare(standardCard.Layout.columnSpan, data.standardSpan);
        compare(fullWidthCard.Layout.columnSpan, data.columns);
        compare(findChild(page, "galleryPageHeadline").text, "Headline");
        compare(findChild(page, "galleryPageDescription").text, "Description");
    }

    function test_galleryPages_data() {
        const pages = [["app-bars", "AppBars.qml"], ["button-groups", "ButtonGroups.qml"], ["colors", "Colors.qml"], ["components", "Components.qml"], ["divider", "Divider.qml"], ["elevation", "Elevation.qml"], ["exposed-dropdown-menus", "ExposedDropdownMenus.qml"], ["fab", "FAB.qml"], ["fab-menu", "FabMenu.qml"], ["grids", "Grids.qml"], ["icon-button", "IconButton.qml"], ["indicators", "Indicators.qml"], ["segmented-buttons", "SegmentedButtons.qml"], ["slider", "Slider.qml"], ["lists", "Lists.qml"], ["menus", "Menus.qml"], ["navigation-rails", "NavigationRails.qml"], ["symbols", "Symbols.qml"], ["text-fields", "TextFields.qml"], ["typography", "Typography.qml"], ["tooltips", "ToolTips.qml"]];

        const rows = [];
        for (const page of pages) {
            rows.push({
                tag: page[0] + "-compact",
                file: page[1],
                width: 480,
                columns: 4
            });
            rows.push({
                tag: page[0] + "-medium",
                file: page[1],
                width: 720,
                columns: 8
            });
            rows.push({
                tag: page[0] + "-large",
                file: page[1],
                width: 1280,
                columns: 12
            });
        }
        return rows;
    }

    function test_galleryPages(data) {
        const component = Qt.createComponent(Qt.resolvedUrl("../../../src/gallery/qml/" + data.file));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());

        const page = createTemporaryObject(component, testCase, {
            width: data.width,
            height: 700
        });
        verify(page);
        wait(0);

        const grid = findChild(page, "galleryPageGrid");
        const headline = findChild(page, "galleryPageHeadline");
        const description = findChild(page, "galleryPageDescription");
        verify(grid);
        compare(grid.columns, data.columns);
        verify(headline && headline.text.length > 0);
        verify(description && description.text.length > 0);
    }

    function test_fabPropertiesLayout_data() {
        return [
            { tag: "compact", width: 480 },
            { tag: "medium", width: 720 },
            { tag: "large", width: 1280 }
        ];
    }

    function test_fabPropertiesLayout(data) {
        const component = Qt.createComponent(
                            Qt.resolvedUrl("../../../src/gallery/qml/FAB.qml"));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());

        const page = createTemporaryObject(component, testCase, {
            width: data.width,
            height: 700
        });
        verify(page);
        wait(0);

        const controlsGrid = findChild(page, "fabPropertyControlsGrid");
        const examplesGrid = findChild(page, "fabPropertyExamplesGrid");
        verify(controlsGrid);
        verify(examplesGrid);

        const controls = [
            "fabEnabledSwitch",
            "fabLoweredSwitch",
            "fabInteractiveExample",
            "fabActivationCount"
        ];
        const examples = [
            "fabCustomColorsExample",
            "fabSourceImageExample",
            "fabMirroredIconExample",
            "fabLabeledSourceImageExample",
            "fabRtlLabelExample",
            "fabTextOnlyExample",
            "fabDisabledExample"
        ];

        for (const objectName of controls)
            verifyItemContained(findChild(page, objectName), controlsGrid, objectName);
        for (const objectName of examples)
            verifyItemContained(findChild(page, objectName), examplesGrid, objectName);

        const firstControl = findChild(page, controls[0]);
        const activationCount = findChild(page, "fabActivationCount");
        compare(activationCount.lineCount, 1);
        const firstPosition = firstControl.mapToItem(controlsGrid, 0, 0);
        const rowCenter = firstPosition.y + firstControl.height / 2;
        for (const objectName of controls.slice(1)) {
            const item = findChild(page, objectName);
            const position = item.mapToItem(controlsGrid, 0, 0);
            verify(Math.abs(position.y + item.height / 2 - rowCenter) <= 0.5,
                   objectName + " is not in the controls row");
        }
    }

    function verifyItemContained(item, container, name) {
        verify(item, name + " exists");
        const position = item.mapToItem(container, 0, 0);
        verify(position.x >= 0, name + " starts before its grid");
        verify(position.y >= 0, name + " starts above its grid");
        verify(position.x + item.width <= container.width,
               name + " extends past its grid width");
        verify(position.y + item.height <= container.height,
               name + " extends past its grid height");
    }

    function test_dividerGalleryLayout() {
        const component = Qt.createComponent(Qt.resolvedUrl("../../../src/gallery/qml/Divider.qml"));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());

        const page = createTemporaryObject(component, testCase, {
            width: 480,
            height: 700
        });
        verify(page);

        const horizontalExamples = [
            ["fullWidthHorizontalDividerLabel", "fullWidthHorizontalDivider", "Full-width"],
            ["insetHorizontalDividerLabel", "insetHorizontalDivider", "Inset"],
            ["middleInsetHorizontalDividerLabel", "middleInsetHorizontalDivider", "Middle-inset"]
        ];
        for (const example of horizontalExamples) {
            const label = findChild(page, example[0]);
            const divider = findChild(page, example[1]);
            verify(label);
            verify(divider);
            compare(label.text, example[2]);
            verify(label.x + label.width <= divider.x);
        }

        const row = findChild(page, "verticalDividerRow");
        const fullHeightDivider = findChild(page, "fullHeightVerticalDivider");
        const insetDivider = findChild(page, "insetVerticalDivider");
        const middleInsetDivider = findChild(page, "middleInsetVerticalDivider");
        verify(row);
        verify(fullHeightDivider);
        verify(insetDivider);
        verify(middleInsetDivider);

        verify(row.implicitHeight > MD.Tokens.measurement.space800);
        tryCompare(fullHeightDivider, "height", MD.Tokens.measurement.space800);
        compare(fullHeightDivider.width, MD.Tokens.divider.thickness);
        compare(insetDivider.width, MD.Tokens.divider.thickness);
        compare(middleInsetDivider.width, MD.Tokens.divider.thickness);

        compare(lineForDivider(fullHeightDivider).height, fullHeightDivider.height);
        compare(lineForDivider(insetDivider).height,
                insetDivider.height - MD.Tokens.divider.inset);
        compare(lineForDivider(middleInsetDivider).height,
                middleInsetDivider.height - 2 * MD.Tokens.divider.inset);

        const verticalExamples = [
            ["fullHeightVerticalDividerLabel", "fullHeightVerticalDividerSample", "Full-width"],
            ["insetVerticalDividerLabel", "insetVerticalDividerSample", "Inset"],
            ["middleInsetVerticalDividerLabel", "middleInsetVerticalDividerSample", "Middle-inset"]
        ];
        for (const example of verticalExamples) {
            const label = findChild(page, example[0]);
            const sample = findChild(page, example[1]);
            verify(label);
            verify(sample);
            compare(label.text, example[2]);
            verify(label.y + label.height <= sample.y);
        }
    }

    function lineForDivider(divider) {
        const line = findChild(divider, "dividerLine");
        verify(line);
        return line;
    }
}
