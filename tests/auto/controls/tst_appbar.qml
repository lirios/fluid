// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtTest
import Fluid as MD

TestCase {
    id: testCase

    name: "AppBarTests"
    width: 900
    height: 700
    visible: true
    when: windowShown

    SignalSpy {
        id: signalSpy
    }

    Component {
        id: appBarComponent
        MD.AppBar {}
    }

    Component {
        id: searchBarComponent
        MD.SearchAppBar {}
    }

    Component {
        id: overflowComponent
        Item {
            width: 190
            height: bar.implicitHeight
            property alias appBar: bar
            property alias high: highAction
            property alias low: lowAction
            property alias forced: forcedAction

            MD.AppBarAction {
                id: highAction
                text: "High"
                icon.name: MD.SymbolNames.symbolFavorite
                priority: 20
                checkable: true
            }
            MD.AppBarAction {
                id: lowAction
                text: "Low"
                icon.name: MD.SymbolNames.symbolShare
                priority: 1
            }
            MD.AppBarAction {
                id: forcedAction
                text: "Forced overflow"
                icon.name: MD.SymbolNames.symbolDelete
                overflowPolicy: MD.AppBarAction.AlwaysOverflow
                enabled: false
            }
            MD.AppBar {
                id: bar
                width: parent.width
                title: "A"
                actions: [lowAction, highAction, forcedAction]
            }
        }
    }

    Component {
        id: scrollComponent
        Item {
            width: 480
            height: 320
            property alias appBar: bar
            property alias flickable: flickable

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: width
                contentHeight: 1200
            }
            MD.AppBar {
                id: bar
                width: parent.width
                variant: MD.AppBar.MediumFlexible
                title: "Scrolling"
                scrollTarget: flickable
            }
        }
    }

    Component {
        id: galleryScrollComponent
        Item {
            width: 480
            height: 320
            property alias appBar: bar
            property alias flickable: flickable

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: width
                contentHeight: 1200
                topMargin: bar.implicitHeight
            }
            MD.AppBar {
                id: bar
                width: parent.width
                variant: MD.AppBar.LargeFlexible
                title: "Scrolling App Bar"
                subtitle: "The gallery layout that exposed the height loop"
                scrollTarget: flickable
            }
        }
    }

    Component {
        id: rtlComponent
        Item {
            width: 480
            height: bar.implicitHeight
            property alias appBar: bar
            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            MD.AppBar {
                id: bar
                width: parent.width
                title: "RTL"
                titleAlignment: MD.AppBar.Start
                navigationAction: MD.AppBarAction {
                    text: "Back"
                    icon.name: MD.SymbolNames.symbolArrowBack
                }
                actions: [
                    MD.AppBarAction {
                        text: "Favorite"
                        icon.name: MD.SymbolNames.symbolFavorite
                    }
                ]
            }
        }
    }

    function createAppBar(properties) {
        return createTemporaryObject(appBarComponent, testCase, properties || {});
    }

    function createSearchBar(properties) {
        return createTemporaryObject(searchBarComponent, testCase, properties || {});
    }

    function test_tokens() {
        const token = MD.Tokens.appBar;
        compare(token.containerElevation, 0);
        compare(token.onScrollContainerElevation, 3);
        compare(token.smallContainerHeight, 64);
        compare(token.mediumFlexibleContainerHeight, 112);
        compare(token.mediumFlexibleContainerHeightWithSubtitle, 136);
        compare(token.largeFlexibleContainerHeight, 120);
        compare(token.largeFlexibleContainerHeightWithSubtitle, 152);
        compare(token.searchContainerHeight, 56);
        compare(token.horizontalPadding, 4);
        compare(token.titleInset, 16);
        compare(token.mediumTitleBottomPadding, 24);
        compare(token.largeTitleBottomPadding, 28);
        compare(token.mediumTitleSubtitleGap, 4);
        compare(token.largeTitleSubtitleGap, 8);
        compare(token.minimumInteractiveSize, 48);
        compare(token.iconSize, 24);
        compare(token.searchOuterHorizontalPadding, 4);
        compare(token.searchOuterFieldMargin, 8);
        compare(token.searchAdaptiveBreakpoint, 312);
        compare(token.searchAdaptiveWidthFraction, 0.5);
        compare(token.searchLeadingSpace, 8);
        compare(token.searchTrailingSpace, 8);
        compare(token.searchContainedLeadingMargin, 24);
        compare(token.searchContainedTrailingMargin, 24);
        compare(token.searchContainedLeadingSpace, 4);
        compare(token.searchContainedTrailingSpace, 4);
        compare(token.searchContainedNoActionsLeadingSpace, 16);
        compare(token.searchContainedNoActionsTrailingSpace, 16);
        compare(token.searchIconLabelGap, 4);
        compare(token.searchAvatarTargetSize, 48);
        compare(token.searchAvatarSize, 30);
        compare(token.searchTrailingActionsGap, 0);
        compare(token.searchTrailingActionsLeadingSpace, 4);
        compare(token.searchTrailingActionsTrailingSpace, 4);
        compare(token.overflowItemHeight, 48);
        compare(token.overflowHorizontalPadding, 12);
        compare(token.overflowIconLabelGap, 12);
        compare(token.overflowMinimumWidth, 112);
        compare(token.overflowMaximumWidth, 280);
        compare(token.hoverStateLayerOpacity, 0.08);
        compare(token.focusStateLayerOpacity, 0.10);
        compare(token.pressedStateLayerOpacity, 0.10);
        compare(token.disabledContentOpacity, 0.38);
    }

    function test_action_defaults() {
        const action = createTemporaryQmlObject('import Fluid as MD; MD.AppBarAction {}', testCase);
        verify(action);
        compare(action.visible, true);
        compare(action.priority, 0);
        compare(action.overflowPolicy, MD.AppBarAction.AutoOverflow);
        compare(action.presentation, MD.AppBarAction.IconButton);
    }

    function test_appbar_defaults_and_heights() {
        const small = createAppBar({
            width: 480,
            title: "Small"
        });
        verify(small);
        compare(small.title, "Small");
        compare(small.subtitle, "");
        compare(small.titleAlignment, MD.AppBar.Start);
        compare(small.titleMaximumLineCount, 1);
        compare(small.subtitleMaximumLineCount, 1);
        compare(small.navigationAction, null);
        compare(small.actions.length, 0);
        compare(small.heightOffset, 0);
        compare(small.lifted, false);
        compare(small.overflowVisible, false);
        compare(small.variant, MD.AppBar.Small);
        compare(small.scrollBehavior, MD.BaseAppBar.Pinned);
        compare(small.implicitHeight, MD.Tokens.appBar.smallContainerHeight);
        compare(small.collapsedFraction, 1);

        const medium = createAppBar({
            width: 480,
            variant: MD.AppBar.MediumFlexible,
            title: "Medium"
        });
        compare(medium.implicitHeight, MD.Tokens.appBar.mediumFlexibleContainerHeight);
        compare(medium.scrollBehavior, MD.BaseAppBar.ExitUntilCollapsed);

        const mediumSubtitle = createAppBar({
            width: 480,
            variant: MD.AppBar.MediumFlexible,
            title: "Medium",
            subtitle: "Subtitle"
        });
        compare(mediumSubtitle.implicitHeight, MD.Tokens.appBar.mediumFlexibleContainerHeightWithSubtitle);

        const large = createAppBar({
            width: 480,
            variant: MD.AppBar.LargeFlexible,
            title: "Large"
        });
        compare(large.implicitHeight, MD.Tokens.appBar.largeFlexibleContainerHeight);

        const largeSubtitle = createAppBar({
            width: 480,
            variant: MD.AppBar.LargeFlexible,
            title: "Large",
            subtitle: "Subtitle"
        });
        compare(largeSubtitle.implicitHeight, MD.Tokens.appBar.largeFlexibleContainerHeightWithSubtitle);
    }

    function test_wrapping_grows_flexible_bar() {
        const bar = createAppBar({
            width: 180,
            variant: MD.AppBar.MediumFlexible,
            title: "A deliberately long flexible app bar title that wraps",
            titleMaximumLineCount: 3
        });
        verify(bar);
        tryVerify(() => bar.implicitHeight > MD.Tokens.appBar.mediumFlexibleContainerHeight);
    }

    function test_alignment_and_rtl() {
        const centered = createAppBar({
            width: 480,
            title: "Centered",
            titleAlignment: MD.AppBar.Center
        });
        compare(centered.titleAlignment, MD.AppBar.Center);
        const centeredLabel = findChild(centered, "titleLabel");
        verify(centeredLabel);
        compare(centeredLabel.horizontalAlignment, Text.AlignHCenter);

        const rtl = createTemporaryObject(rtlComponent, testCase);
        verify(rtl);
        const label = findChild(rtl.appBar, "titleLabel");
        const navigation = findChild(rtl.appBar, "navigationActionButton");
        const trailing = findChild(rtl.appBar, "trailingActions");
        verify(label);
        verify(navigation);
        verify(trailing);
        compare(label.horizontalAlignment, Text.AlignRight);
        verify(navigation.x > trailing.x);
        compare(navigation.width, MD.Tokens.appBar.minimumInteractiveSize);
    }

    function test_priority_and_forced_overflow() {
        const wrapper = createTemporaryObject(overflowComponent, testCase);
        verify(wrapper);
        const bar = wrapper.appBar;
        compare(bar.actions.length, 3);
        tryCompare(bar.overflowActions, "length", 2);
        compare(bar.visibleActions.length, 1);
        compare(bar.visibleActions[0], wrapper.high);
        compare(bar.overflowActions[0], wrapper.low);
        compare(bar.overflowActions[1], wrapper.forced);
        compare(bar.overflowActions[1].enabled, false);

        wrapper.high.trigger();
        compare(wrapper.high.checked, true);

        bar.openOverflow();
        tryCompare(bar, "overflowVisible", true);
        bar.closeOverflow();
        tryCompare(bar, "overflowVisible", false);
    }

    function test_exit_until_collapsed_scroll() {
        const wrapper = createTemporaryObject(scrollComponent, testCase);
        verify(wrapper);
        const bar = wrapper.appBar;
        const flickable = wrapper.flickable;
        compare(bar.heightOffset, 0);

        flickable.contentY = 100;
        tryCompare(bar, "heightOffset", bar.expandedHeight - bar.collapsedHeight);
        compare(bar.collapsedFraction, 1);
        compare(bar.lifted, true);
        compare(bar.implicitHeight, bar.collapsedHeight);

        flickable.contentY = 50;
        wait(0);
        compare(bar.heightOffset, bar.expandedHeight - bar.collapsedHeight);

        flickable.contentY = flickable.originY;
        tryCompare(bar, "heightOffset", 0);
        compare(bar.collapsedFraction, 0);

        bar.scrollBehavior = MD.BaseAppBar.Pinned;
        flickable.contentY = 80;
        wait(0);
        compare(bar.heightOffset, 0);
        compare(bar.lifted, true);
    }

    function test_gallery_scroll_layout_has_stable_container_height() {
        const wrapper = createTemporaryObject(galleryScrollComponent, testCase);
        verify(wrapper);
        const bar = wrapper.appBar;
        const flickable = wrapper.flickable;

        tryCompare(bar, "implicitHeight", MD.Tokens.appBar.largeFlexibleContainerHeightWithSubtitle);
        compare(bar.currentContainerHeight, bar.expandedHeight);
        compare(flickable.topMargin, bar.implicitHeight);

        flickable.contentY = 100;
        tryCompare(bar, "heightOffset", bar.expandedHeight - bar.collapsedHeight);
        compare(bar.currentContainerHeight, bar.collapsedHeight);
    }

    function test_search_defaults_keyboard_and_adaptive_width() {
        const launcher = createSearchBar({
            width: 800,
            placeholderText: "Find"
        });
        verify(launcher);
        compare(launcher.text, "");
        compare(launcher.textAlignment, MD.SearchAppBar.Start);
        compare(launcher.inputMethodHints, Qt.ImhNone);
        compare(launcher.validator, null);
        compare(launcher.navigationAction, null);
        compare(launcher.actions.length, 0);
        compare(launcher.searchActions.length, 0);
        verify(launcher.searchNavigationAction);
        compare(launcher.mode, MD.SearchAppBar.Launcher);
        compare(launcher.scrollBehavior, MD.BaseAppBar.EnterAlways);
        compare(launcher.implicitHeight, MD.Tokens.appBar.smallContainerHeight);

        const wideCapsule = findChild(launcher, "searchCapsule");
        const launcherButton = findChild(launcher, "searchLauncher");
        verify(wideCapsule);
        verify(launcherButton);
        tryCompare(wideCapsule, "width", 388);

        signalSpy.target = launcher;
        signalSpy.signalName = "activated";
        signalSpy.clear();
        launcherButton.forceActiveFocus();
        keyClick(Qt.Key_Return);
        compare(signalSpy.count, 1);

        const narrow = createSearchBar({
            width: 300
        });
        const narrowCapsule = findChild(narrow, "searchCapsule");
        verify(narrowCapsule);
        tryCompare(narrowCapsule, "width", 276);

        const editable = createSearchBar({
            width: 480,
            mode: MD.SearchAppBar.Editable
        });
        const field = findChild(editable, "searchField");
        verify(field);
        signalSpy.target = editable;
        signalSpy.signalName = "accepted";
        signalSpy.clear();
        field.forceActiveFocus();
        keyClick(Qt.Key_Q);
        keyClick(Qt.Key_U);
        keyClick(Qt.Key_E);
        keyClick(Qt.Key_R);
        keyClick(Qt.Key_Y);
        compare(editable.text, "query");
        keyClick(Qt.Key_Return);
        compare(signalSpy.count, 1);
    }

    function test_enter_always_scroll_and_runtime_target() {
        const target = createTemporaryQmlObject('import QtQuick; Flickable { width: 400; height: 200; contentHeight: 1000 }', testCase);
        const search = createSearchBar({
            width: 400,
            scrollTarget: target
        });
        verify(search);

        target.contentY = 40;
        tryCompare(search, "heightOffset", 40);
        target.contentY = 10;
        tryCompare(search, "heightOffset", 10);

        search.scrollTarget = null;
        compare(search.heightOffset, 0);
        target.contentY = 80;
        wait(0);
        compare(search.heightOffset, 0);
    }
}
