// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "ActionTests"

    Component {
        id: actionFixtureComponent

        Item {
            property alias action: action
            property alias triggeredSpy: triggeredSpy

            MD.Action {
                id: action
            }

            SignalSpy {
                id: triggeredSpy
                target: action
                signalName: "triggered"
            }
        }
    }

    function createActionFixture() {
        const fixture = createTemporaryObject(actionFixtureComponent, testCase);
        verify(fixture !== null);
        verify(fixture.triggeredSpy.valid);
        return fixture;
    }

    function test_defaults() {
        const action = createActionFixture().action;

        compare(action.supportingText, "");
        compare(action.trailingText, "");
        compare(action.badgeContent, "");
        compare(action.text, "");
        compare(action.enabled, true);
        compare(action.checkable, false);
        compare(action.checked, false);
        compare(action.icon.name, "");
        compare(action.icon.source.toString(), "");
    }

    function test_extended_property_mutation() {
        const action = createActionFixture().action;

        action.supportingText = "Supporting details";
        action.trailingText = "Ctrl+S";
        action.badgeContent = 0;

        compare(action.supportingText, "Supporting details");
        compare(action.trailingText, "Ctrl+S");
        compare(action.badgeContent, 0);
        verify(action.badgeContent !== "");

        action.badgeContent = "New";
        compare(action.badgeContent, "New");
    }

    function test_inherited_properties_and_icon() {
        const action = createActionFixture().action;
        const source = Qt.resolvedUrl("../../../src/gallery/icons/32x32/apps/io.liri.Fluid.Gallery.png");

        action.text = "Favorite";
        action.enabled = false;
        action.checkable = true;
        action.checked = true;
        action.icon.name = MD.Symbols.favorite;
        action.icon.source = source;

        compare(action.text, "Favorite");
        compare(action.enabled, false);
        compare(action.checkable, true);
        compare(action.checked, true);
        compare(action.icon.name, MD.Symbols.favorite);
        compare(action.icon.source, source);
    }

    function test_trigger_and_checkable_behavior() {
        const fixture = createActionFixture();
        const action = fixture.action;
        const spy = fixture.triggeredSpy;

        action.checkable = true;
        action.trigger();
        compare(spy.count, 1);
        compare(action.checked, true);

        action.trigger();
        compare(spy.count, 2);
        compare(action.checked, false);

        action.checkable = false;
        action.trigger();
        compare(spy.count, 3);
        compare(action.checked, false);
    }
}
