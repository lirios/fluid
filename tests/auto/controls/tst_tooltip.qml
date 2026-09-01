// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Templates as T
import QtTest

TestCase {
    id: testCase

    name: "ToolTipTests"
    width: 640
    height: 480
    visible: true
    when: windowShown

    Component {
        id: plainComponent

        MD.PlainToolTip {
            text: "Plain tooltip"
        }
    }

    Component {
        id: attachedAnchorComponent

        Item {
            readonly property var toolTip: MD.ToolTip.toolTip
            readonly property string attachedText: MD.ToolTip.text
            readonly property int attachedDelay: MD.ToolTip.delay
            readonly property int attachedTimeout: MD.ToolTip.timeout
            property bool toolTipVisible: false

            function hideToolTip() {
                MD.ToolTip.hide();
            }

            function showToolTip(text, timeout) {
                MD.ToolTip.show(text, timeout);
            }

            width: 80
            height: 40

            MD.ToolTip.text: "Attached tooltip"
            MD.ToolTip.delay: 25
            MD.ToolTip.timeout: 1000
            MD.ToolTip.visible: toolTipVisible
        }
    }

    Component {
        id: plainFixtureComponent

        Item {
            id: fixture
            property alias toolTip: plainToolTip
            property alias anchor: anchor

            width: testCase.width
            height: testCase.height

            Item {
                id: anchor
                x: 160
                y: 320
                width: 120
                height: 48
            }

            MD.PlainToolTip {
                id: plainToolTip
                parent: anchor
                text: "Positioned tooltip"
            }
        }
    }

    Component {
        id: richFixtureComponent

        Item {
            id: fixture
            property alias toolTip: richToolTip
            property alias anchor: anchor
            property alias firstAction: firstAction
            property alias secondAction: secondAction
            property alias thirdAction: thirdAction
            property int firstTriggerCount: 0
            property int secondTriggerCount: 0

            width: testCase.width
            height: testCase.height

            Item {
                id: anchor
                x: 160
                y: 320
                width: 120
                height: 48
            }

            T.Action {
                id: firstAction
                text: "Learn more"
                onTriggered: fixture.firstTriggerCount += 1
            }

            T.Action {
                id: secondAction
                text: "Dismiss"
                onTriggered: fixture.secondTriggerCount += 1
            }

            T.Action {
                id: thirdAction
                text: "Ignored"
            }

            MD.RichToolTip {
                id: richToolTip
                parent: anchor
                body: "Rich tooltip body"
            }
        }
    }

    function createPlain(properties) {
        return createTemporaryObject(plainComponent, testCase, properties || {});
    }

    function createRich(properties) {
        const fixture = createTemporaryObject(richFixtureComponent, testCase);
        verify(fixture !== null);
        if (properties) {
            for (const propertyName in properties)
                fixture.toolTip[propertyName] = properties[propertyName];
        }
        return fixture;
    }

    function verifyShape(actual, expected, name) {
        compare(actual.topLeft, expected[0], name + ".topLeft");
        compare(actual.topRight, expected[1], name + ".topRight");
        compare(actual.bottomRight, expected[2], name + ".bottomRight");
        compare(actual.bottomLeft, expected[3], name + ".bottomLeft");
    }

    function test_tokens() {
        const token = MD.Tokens.toolTip;
        compare(token.minimumWidth, 40);
        compare(token.minimumHeight, 24);
        compare(token.plainMaximumWidth, 200);
        compare(token.richMaximumWidth, 320);
        compare(token.anchorSpacing, 4);
        compare(token.viewportMargin, 4);
        compare(token.plainHorizontalPadding, 8);
        compare(token.plainVerticalPadding, 4);
        compare(token.richHorizontalPadding, 16);
        compare(token.richHeadlineFirstBaseline, 28);
        compare(token.richBodyFirstBaseline, 24);
        compare(token.richBodyBottomPadding, 16);
        compare(token.richActionMinimumHeight, 36);
        compare(token.richActionBottomPadding, 8);
        verifyShape(token.plainContainerShape, [4, 4, 4, 4], "plainContainerShape");
        verifyShape(token.richContainerShape, [12, 12, 12, 12], "richContainerShape");
        compare(token.richContainerElevation, 3);
        compare(token.closedScale, 0.8);
    }

    function test_plain_defaults_and_accessibility() {
        const toolTip = createPlain();
        verify(toolTip !== null);
        compare(toolTip.objectName, "plainToolTip");
        compare(toolTip.text, "Plain tooltip");
        compare(toolTip.leftPadding, MD.Tokens.toolTip.plainHorizontalPadding);
        compare(toolTip.rightPadding, MD.Tokens.toolTip.plainHorizontalPadding);
        compare(toolTip.topPadding, MD.Tokens.toolTip.plainVerticalPadding);
        compare(toolTip.bottomPadding, MD.Tokens.toolTip.plainVerticalPadding);
        const label = findChild(toolTip, "plainToolTipLabel");
        const background = findChild(toolTip, "plainToolTipBackground");
        verify(label !== null);
        verify(background !== null);
        compare(label.typescale, MD.Tokens.typescale.bodySmall);
        compare(label.color, toolTip.MD.Style.inverseOnSurfaceColor);
        compare(background.color, toolTip.MD.Style.inverseSurfaceColor);
        compare(background.topLeftRadius, 4);
        compare(background.topRightRadius, 4);
        compare(background.bottomRightRadius, 4);
        compare(background.bottomLeftRadius, 4);

        toolTip.delay = 0;
        toolTip.show("Standalone API", 1000);
        tryCompare(toolTip, "visible", true);
        compare(toolTip.text, "Standalone API");
        toolTip.hide();
        tryCompare(toolTip, "visible", false);
    }

    function test_plain_attached_api() {
        const anchor = createTemporaryObject(attachedAnchorComponent, testCase);
        verify(anchor !== null);
        verify(anchor.toolTip !== null);
        compare(anchor.toolTip.objectName, "plainToolTip");
        compare(anchor.attachedText, "Attached tooltip");
        compare(anchor.attachedDelay, 25);
        compare(anchor.attachedTimeout, 1000);

        anchor.toolTipVisible = true;
        tryCompare(anchor.toolTip, "visible", true);
        compare(anchor.toolTip.text, "Attached tooltip");
        compare(anchor.toolTip.delay, 25);
        compare(anchor.toolTip.timeout, 1000);
        anchor.hideToolTip();
        tryCompare(anchor.toolTip, "visible", false);

        anchor.showToolTip("Attached show API", 1000);
        tryCompare(anchor.toolTip, "visible", true);
        compare(anchor.toolTip.text, "Attached show API");
        anchor.hideToolTip();
        tryCompare(anchor.toolTip, "visible", false);
    }

    function test_plain_sizing_and_wrapping() {
        const shortToolTip = createPlain({ text: "Tip" });
        verify(shortToolTip !== null);
        compare(shortToolTip.implicitWidth, MD.Tokens.toolTip.minimumWidth);
        verify(shortToolTip.implicitHeight >= MD.Tokens.toolTip.minimumHeight);

        const longToolTip = createPlain({
            text: "A deliberately long tooltip description that must wrap within the Material maximum width instead of growing indefinitely."
        });
        verify(longToolTip !== null);
        compare(longToolTip.implicitWidth, MD.Tokens.toolTip.plainMaximumWidth);
        verify(longToolTip.implicitHeight > MD.Tokens.toolTip.minimumHeight);
    }

    function test_plain_position_fallback() {
        const fixture = createTemporaryObject(plainFixtureComponent, testCase);
        verify(fixture !== null);
        const toolTip = fixture.toolTip;

        fixture.anchor.y = 4;
        verify(toolTip._opensBelow);
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        compare(toolTip.y, fixture.anchor.height + MD.Tokens.toolTip.anchorSpacing);

        toolTip.close();
        tryCompare(toolTip, "visible", false, 1000);
        fixture.anchor.y = 320;
        verify(!toolTip._opensBelow);
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        compare(toolTip.y, -toolTip.height - MD.Tokens.toolTip.anchorSpacing);
        toolTip.close();
    }

    function test_rich_body_alias_and_semantics() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        compare(toolTip.body, "Rich tooltip body");
        toolTip.body = "Updated body";
        compare(toolTip.text, "Updated body");
        const body = findChild(toolTip, "richToolTipBody");
        const headline = findChild(toolTip, "richToolTipHeadline");
        const action = findChild(toolTip, "richToolTipAction0");
        const background = findChild(toolTip, "richToolTipBackground");
        verify(body !== null);
        verify(headline !== null);
        verify(action !== null);
        verify(background !== null);
        compare(headline.typescale, MD.Tokens.typescale.titleSmall);
        compare(body.typescale, MD.Tokens.typescale.bodyMedium);
        compare(action.typescale, MD.Tokens.typescale.labelLarge);
        compare(body.color, toolTip.MD.Style.onSurfaceVariantColor);
        compare(background.color, toolTip.MD.Style.surfaceContainerColor);
        compare(background.elevation, MD.Tokens.toolTip.richContainerElevation);
        compare(background.topLeftRadius, 12);
    }

    function test_rich_configurations_data() {
        return [
            { tag: "body", headline: "", count: 0 },
            { tag: "headline", headline: "Headline", count: 0 },
            { tag: "oneAction", headline: "", count: 1 },
            { tag: "headlineOneAction", headline: "Headline", count: 1 },
            { tag: "twoActions", headline: "", count: 2 },
            { tag: "headlineTwoActions", headline: "Headline", count: 2 }
        ];
    }

    function test_rich_configurations(data) {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        toolTip.headline = data.headline;
        if (data.count === 1)
            toolTip.actions = [fixture.firstAction];
        else if (data.count === 2)
            toolTip.actions = [fixture.firstAction, fixture.secondAction];

        compare(toolTip._displayedActionCount, data.count);
        compare(findChild(toolTip, "richToolTipHeadlineSlot").height > 0,
                data.headline.length > 0);
        compare(findChild(toolTip, "richToolTipActionSlot").height > 0, data.count > 0);
        compare(findChild(toolTip, "richToolTipAction0").action !== null, data.count > 0);
        compare(findChild(toolTip, "richToolTipAction1").action !== null, data.count > 1);
    }

    function test_rich_rejects_third_action() {
        const fixture = createRich();
        ignoreWarning("RichToolTip supports at most two actions; additional actions are ignored");
        fixture.toolTip.actions = [fixture.firstAction, fixture.secondAction, fixture.thirdAction];
        compare(fixture.toolTip._displayedActionCount, 2);
        compare(findChild(fixture.toolTip, "richToolTipAction0").text, "Learn more");
        compare(findChild(fixture.toolTip, "richToolTipAction1").text, "Dismiss");
        verify(findChild(fixture.toolTip, "richToolTipAction2") === null);
    }

    function test_rich_actions_wrap_and_mirror() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        toolTip.actions = [fixture.firstAction, fixture.secondAction];
        toolTip.width = 150;
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        const first = findChild(toolTip, "richToolTipAction0");
        const second = findChild(toolTip, "richToolTipAction1");
        const flow = findChild(toolTip, "richToolTipActionFlow");
        waitForItemPolished(flow);
        verify(second.y > first.y);

        fixture.anchor.LayoutMirroring.enabled = true;
        fixture.anchor.LayoutMirroring.childrenInherit = true;
        compare(flow.layoutDirection, Qt.RightToLeft);
        compare(findChild(toolTip, "richToolTipHeadline").horizontalAlignment, Text.AlignRight);
        compare(findChild(toolTip, "richToolTipBody").horizontalAlignment, Text.AlignRight);
        compare(toolTip.x, fixture.anchor.width - toolTip.width);
        toolTip.close();
    }

    function test_rich_position_fallback() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        fixture.anchor.y = 4;
        verify(toolTip._opensBelow);
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        compare(toolTip.y, fixture.anchor.height + MD.Tokens.toolTip.anchorSpacing);

        toolTip.close();
        tryCompare(toolTip, "visible", false, 1000);
        fixture.anchor.y = 320;
        verify(!toolTip._opensBelow);
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        compare(toolTip.y, -toolTip.height - MD.Tokens.toolTip.anchorSpacing);
        toolTip.close();
    }

    function test_rich_action_focus_trigger_and_dismissal() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        toolTip.actions = [fixture.firstAction, fixture.secondAction];
        fixture.anchor.forceActiveFocus();
        verify(fixture.anchor.activeFocus);
        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);

        const first = findChild(toolTip, "richToolTipAction0");
        const second = findChild(toolTip, "richToolTipAction1");
        tryVerify(() => first.activeFocus, 1000);
        compare(first.Accessible.name, "Learn more");
        compare(first.Accessible.role, Accessible.Button);
        compare(second.Accessible.name, "Dismiss");
        compare(second.Accessible.role, Accessible.Button);

        keyClick(Qt.Key_Space);
        compare(fixture.firstTriggerCount, 1);
        tryCompare(toolTip, "visible", false, 1000);
        tryVerify(() => fixture.anchor.activeFocus, 1000);
    }

    function test_rich_escape_dismissal_and_focus_restore() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        toolTip.actions = [fixture.firstAction];
        fixture.anchor.forceActiveFocus();
        verify(fixture.anchor.activeFocus);

        toolTip.open();
        tryCompare(toolTip, "opened", true, 1000);
        tryVerify(() => findChild(toolTip, "richToolTipAction0").activeFocus, 1000);

        keyClick(Qt.Key_Escape);
        tryCompare(toolTip, "visible", false, 1000);
        tryVerify(() => fixture.anchor.activeFocus, 1000);
    }

    function test_rich_disabled_action_focus() {
        const fixture = createRich();
        fixture.firstAction.enabled = false;
        fixture.toolTip.actions = [fixture.firstAction, fixture.secondAction];
        fixture.toolTip.open();
        tryCompare(fixture.toolTip, "opened", true, 1000);
        verify(findChild(fixture.toolTip, "richToolTipAction1").activeFocus);
        fixture.toolTip.close();
    }

    function test_theme_propagation() {
        const fixture = createRich();
        const toolTip = fixture.toolTip;
        const background = findChild(toolTip, "richToolTipBackground");
        fixture.anchor.MD.Style.theme = MD.Style.Dark;
        compare(toolTip.MD.Style.theme, MD.Style.Dark);
        compare(background.color, toolTip.MD.Style.surfaceContainerColor);
        fixture.anchor.MD.Style.theme = MD.Style.Light;
        compare(toolTip.MD.Style.theme, MD.Style.Light);
        compare(background.color, toolTip.MD.Style.surfaceContainerColor);
    }
}
