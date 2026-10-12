// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Window
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

        pages.push(["split-buttons", "SplitButtons.qml"]);
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

    function test_splitButtonGalleryCoverage() {
        const component = Qt.createComponent(Qt.resolvedUrl("../../../src/gallery/qml/SplitButtons.qml"));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());
        const page = createTemporaryObject(component, testCase, {width: 1280, height: 700});
        verify(page);
        const types = ["filled", "tonal", "elevated", "outlined"];
        const sizes = ["extrasmall", "small", "medium", "large", "extralarge"];
        for (let type = 0; type < types.length; ++type) {
            for (let size = 0; size < sizes.length; ++size) {
                const button = findChild(page, "splitButton-" + types[type] + "-" + sizes[size]);
                verify(button);
                compare(button.type, type);
                compare(button.size, size);
            }
        }
        const label = findChild(page, "splitButton-labelOnly");
        const icon = findChild(page, "splitButton-iconOnly");
        const combined = findChild(page, "splitButton-combined");
        const source = findChild(page, "splitButton-sourceIcon");
        verify(label && icon && combined && source);
        verify(label.text.length > 0);
        compare(label.icon.name, "");
        compare(icon.text, "");
        verify(icon.icon.name.length > 0);
        verify(icon.leadingButton.Accessible.name.length > 0);
        verify(combined.text.length > 0 && combined.icon.name.length > 0);
        verify(source.icon.source.toString().length > 0);
        verify(findChild(page, "splitButton-rtl-control").mirrored);
        const disabled = findChild(page, "splitButton-disabled");
        verify(disabled);
        verify(!disabled.leadingButton.enabled && !disabled.trailingButton.enabled);
        compare(findChild(page, "splitButton-lightTheme").MD.Style.theme, MD.Style.Light);
        compare(findChild(page, "splitButton-darkTheme").MD.Style.theme, MD.Style.Dark);
        const managed = findChild(page, "splitButton-managedMenu");
        verify(managed && managed.menu);
        managed.openMenu();
        tryCompare(managed.menu, "opened", true);
        managed.closeMenu();
        tryCompare(managed.menu, "visible", false);
        const custom = findChild(page, "splitButton-customPopup");
        verify(custom);
        compare(custom.menu, null);
        const popup = findChild(page, "splitButton-customPopup-menu");
        verify(popup);
        for (const pageWidth of [1280, 960]) {
            page.width = pageWidth;
            custom.locale = Qt.locale(pageWidth === 960 ? "ar" : "en");
            wait(0);
            custom.trailingButton.forceActiveFocus(Qt.TabFocusReason);
            keyClick(Qt.Key_Space);
            tryCompare(custom, "expanded", true);
            tryCompare(popup, "opened", true);
            compare(popup.parent, custom.trailingButton);
            const mirrored = custom.mirrored || custom.locale.textDirection === Qt.RightToLeft;
            const expectedX = mirrored ? custom.trailingButton.width - popup.width : 0;
            const expectedY = custom.trailingButton.background.y
                + custom.trailingButton.background.height + MD.Tokens.splitButton.menuAnchorGap;
            verify(Math.abs(popup.x - expectedX) <= 0.5, "custom popup follows the current logical edge");
            verify(Math.abs(popup.y - expectedY) <= 0.5, "custom popup follows the current visible bottom");
            compare(popup.background.color, custom.MD.Style.surfaceContainerColor);
            compare(popup.contentItem.color, custom.MD.Style.onSurfaceColor);
            custom.trailingButton.forceActiveFocus(Qt.TabFocusReason);
            keyClick(Qt.Key_Space);
            tryCompare(custom, "expanded", false);
            tryCompare(popup, "visible", false);
        }
        custom.trailingButton.forceActiveFocus(Qt.TabFocusReason);
        keyClick(Qt.Key_Space);
        tryCompare(popup, "opened", true);
        keyClick(Qt.Key_Escape);
        tryCompare(custom, "expanded", false);
        tryCompare(popup, "visible", false);
        verify(findChild(page, "splitButton-constrained"));
    }

    function test_splitButtonAppearanceLayout_data() {
        const rows = [];
        for (const type of ["filled", "tonal", "elevated", "outlined"]) {
            for (const width of [480, 720, 1280])
                rows.push({ tag: type + "-" + width, type: type, width: width });
        }
        return rows;
    }

    function splitButtonAppearanceGeometry(page, type) {
        const card = findChild(page, "splitButton-appearancesCard");
        const layout = findChild(page, "splitButton-appearancesLayout");
        const appearance = findChild(page, "splitButton-appearance-" + type);
        const flow = findChild(page, "splitButton-appearanceFlow-" + type);
        verify(card && layout && appearance && flow);
        compare(card.contentItem, layout);
        compare(flow.spacing, MD.Tokens.measurement.space200);
        verifyItemContained(flow, appearance, type + " examples flow");
        verifyItemContained(appearance, layout, type + " appearance");
        verifyItemContained(layout, card, "appearances content");
        verify(Math.abs(card.height - (layout.implicitHeight + card.topPadding + card.bottomPadding)) <= 0.5,
               "the card includes every wrapped appearance's full height");

        const rows = [];
        const sizes = ["extrasmall", "small", "medium", "large", "extralarge"];
        const tokenSizes = ["ExtraSmall", "Small", "Medium", "Large", "ExtraLarge"];
        const captions = ["XS", "S", "M", "L", "XL"];
        for (let index = 0; index < sizes.length; ++index) {
            const suffix = type + "-" + sizes[index];
            const example = findChild(page, "splitButton-example-" + suffix);
            const button = findChild(page, "splitButton-" + suffix);
            const caption = findChild(page, "splitButton-caption-" + suffix);
            verify(example && button && caption, suffix + " example and caption exist");
            compare(button.size, index);
            compare(caption.text, captions[index]);
            verifyItemContained(example, flow, suffix + " example");
            verifyItemContained(button, example, suffix + " button");
            verifyItemContained(caption, example, suffix + " caption");
            verifyItemContained(button, card.background, suffix + " button inside the outline");
            verifyItemContained(caption, card.background, suffix + " caption inside the outline");
            const preferredWidth = Math.ceil(button.implicitWidth);
            verify(Math.abs(button.width - Math.min(preferredWidth, flow.width)) <= 0.5,
                   suffix + " retains its pixel-aligned preferred width unless one example exceeds the viewport");
            const label = findChild(button, "splitButtonLabel");
            verify(label, suffix + " primary label exists");
            if (flow.width >= preferredWidth)
                verify(!label.truncated, suffix + " shows the full primary label when its preferred width fits");
            const tokenSize = tokenSizes[index];
            compare(button.trailingButton.width,
                    Math.max(MD.Tokens.measurement.minimumInteractiveSize,
                             MD.Tokens.splitButton["trailingIconSize" + tokenSize]
                             + MD.Tokens.splitButton["trailingButtonLeadingSpace" + tokenSize]
                             + MD.Tokens.splitButton["trailingButtonTrailingSpace" + tokenSize]));
            const buttonPosition = button.mapToItem(example, 0, 0);
            const captionPosition = caption.mapToItem(example, 0, 0);
            // Layout rounds caption width and alignment independently of the fractional button width.
            verify(Math.abs(buttonPosition.x + button.width / 2
                            - captionPosition.x - caption.width / 2) <= 1,
                   suffix + " caption stays centered below its button");
            verify(captionPosition.y >= buttonPosition.y + button.height
                   + MD.Tokens.measurement.space100 - 0.5,
                   suffix + " caption follows its button with the specified spacing");

            const position = example.mapToItem(flow, 0, 0);
            const lastRow = rows.length > 0 ? rows[rows.length - 1] : null;
            if (lastRow && Math.abs(position.y - lastRow.y) <= 0.5) {
                verify(position.x >= lastRow.right + flow.spacing - 0.5,
                       suffix + " follows the previous size without horizontal overlap");
                lastRow.right = position.x + example.width;
                lastRow.bottom = Math.max(lastRow.bottom, position.y + example.height);
            } else {
                if (lastRow) {
                    verify(position.y >= lastRow.bottom + flow.spacing - 0.5,
                           suffix + " starts below the previous row's tallest example");
                }
                verify(Math.abs(position.x) <= 0.5, suffix + " begins a row at the flow's leading edge");
                rows.push({ y: position.y, right: position.x + example.width,
                            bottom: position.y + example.height });
            }
        }
        verify(Math.abs(flow.height - rows[rows.length - 1].bottom) <= 0.5,
               type + " flow height includes the final row and its captions");

        const types = ["filled", "tonal", "elevated", "outlined"];
        const nextType = types.indexOf(type) + 1;
        if (nextType < types.length) {
            const nextAppearance = findChild(page, "splitButton-appearance-" + types[nextType]);
            verify(nextAppearance.y >= appearance.y + appearance.height + layout.spacing - 0.5,
                   "the next appearance follows all wrapped examples and captions");
        }
        return { rows: rows.length, height: flow.height, cardHeight: card.height };
    }

    function test_splitButtonAppearanceLayout(data) {
        const component = Qt.createComponent(Qt.resolvedUrl("../../../src/gallery/qml/SplitButtons.qml"));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());
        const page = createTemporaryObject(component, testCase, {width: data.width, height: 700});
        verify(page);
        verify(waitForPolish(page.Window.window), "the initial responsive layout finishes polishing");

        // The appearance matrix remains complete at every responsive breakpoint.
        for (const type of ["filled", "tonal", "elevated", "outlined"]) {
            for (const size of ["extrasmall", "small", "medium", "large", "extralarge"]) {
                verify(findChild(page, "splitButton-" + type + "-" + size));
                verify(findChild(page, "splitButton-caption-" + type + "-" + size));
            }
        }
        const initial = splitButtonAppearanceGeometry(page, data.type);
        if (data.width <= 720)
            verify(initial.rows > 1, "the examples wrap at compact and medium widths");

        page.width = 480;
        verify(waitForPolish(page.Window.window), "the compact responsive layout finishes polishing");
        const narrow = splitButtonAppearanceGeometry(page, data.type);
        verify(narrow.rows > 1, "the compact flow contains multiple rows");
        page.width = 1280;
        verify(waitForPolish(page.Window.window), "the widened responsive layout finishes polishing");
        const wide = splitButtonAppearanceGeometry(page, data.type);
        verify(wide.rows < narrow.rows, "widening uses fewer example rows");
        verify(wide.height < narrow.height, "widening reduces the appearance's height");
        verify(wide.cardHeight < narrow.cardHeight, "the card follows the reduced content height");
        page.width = data.width;
        verify(waitForPolish(page.Window.window), "the restored responsive layout finishes polishing");
        const restored = splitButtonAppearanceGeometry(page, data.type);
        compare(restored.rows, initial.rows);
        verify(Math.abs(restored.height - initial.height) <= 0.5,
               "the original flow height returns after the resize cycle");
        verify(Math.abs(restored.cardHeight - initial.cardHeight) <= 0.5,
               "the original card height returns after the resize cycle");
    }

    function test_splitButtonConstrainedLayout_data() {
        return [
            { tag: "compact", width: 480 },
            { tag: "medium", width: 720 },
            { tag: "large", width: 1280 }
        ];
    }

    function test_splitButtonConstrainedLayout(data) {
        const component = Qt.createComponent(Qt.resolvedUrl("../../../src/gallery/qml/SplitButtons.qml"));
        tryCompare(component, "status", Component.Ready);
        if (component.status !== Component.Ready)
            fail(component.errorString());
        const page = createTemporaryObject(component, testCase, {width: 208, height: 700});
        verify(page);
        wait(0);

        const card = findChild(page, "splitButton-constrainedCard");
        const layout = findChild(page, "splitButton-constrainedLayout");
        const description = findChild(page, "splitButton-constrainedDescription");
        const button = findChild(page, "splitButton-constrained");
        verify(card && layout && description && button);
        tryVerify(() => layout.width > 0 && description.lineCount > 1);
        const narrowWidth = layout.width;
        const narrowHeight = layout.height;
        verify(button.width < button.implicitWidth * 0.65,
               "the button shrinks to the narrow card's available width");

        page.width = data.width;
        tryVerify(() => layout.width > narrowWidth && description.width === layout.width);
        wait(0);

        compare(card.contentItem, layout);
        compare(layout.spacing, MD.Tokens.measurement.space200);
        compare(description.wrapMode, Text.WordWrap);
        verify(!description.truncated, "the full explanation remains visible");
        if (data.width <= 720)
            verify(description.lineCount > 1, "the explanation wraps at compact and medium widths");
        verifyItemContained(description, layout, "constrained explanation");
        verifyItemContained(button, layout, "constrained split button");
        verifyItemContained(layout, card, "constrained content");
        verifyItemContained(description, card.background, "explanation inside the outline");
        verifyItemContained(button, card.background, "split button inside the outline");
        verify(button.y >= description.y + description.height + layout.spacing - 0.5,
               "the button follows the wrapped explanation without overlap");
        verify(Math.abs(button.width - Math.min(layout.width, button.implicitWidth * 0.65)) <= 0.5,
               "the button retains its constrained preferred width");
        verify(Math.abs(card.height - (layout.implicitHeight + card.topPadding + card.bottomPadding)) <= 0.5,
               "the card's height includes both children and their spacing");

        const label = findChild(button, "splitButtonLabel");
        verify(label);
        verify(label.truncated, "the primary action still demonstrates text elision");
        verifyItemContained(button.leadingButton, button, "primary target");
        verifyItemContained(button.trailingButton, button, "secondary target");
        verify(button.leadingButton.x + button.leadingButton.width < button.trailingButton.x,
               "the primary and secondary targets remain distinct");
        compare(button.trailingButton.width,
                Math.max(MD.Tokens.measurement.minimumInteractiveSize,
                         MD.Tokens.splitButton.trailingIconSizeSmall
                         + MD.Tokens.splitButton.trailingButtonLeadingSpaceSmall
                         + MD.Tokens.splitButton.trailingButtonTrailingSpaceSmall));

        page.width = 208;
        tryCompare(layout, "width", narrowWidth);
        tryCompare(layout, "height", narrowHeight);
        verifyItemContained(description, layout, "resized constrained explanation");
        verifyItemContained(button, layout, "resized constrained split button");
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
