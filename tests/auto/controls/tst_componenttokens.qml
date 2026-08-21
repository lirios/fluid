// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 800
    height: 800

    MD.Button {
        id: metricButton
        text: "Action"
        type: MD.Button.Type.Outlined
    }

    MD.IconButton {
        id: metricIconButton
        text: "Action"
        icon.name: "add"
    }

    MD.FAB {
        id: metricFab
        text: "Action"
        icon.name: "add"
    }

    MD.CheckBox {
        id: metricCheckBox
        text: "Option"
    }

    MD.Switch {
        id: metricSwitch
        text: "Option"
    }

    MD.ListItem {
        id: metricListItem
        width: 300
        text: "Item"
    }

    MD.Symbol {
        id: metricSymbol
        name: "add"
    }

    TestCase {
        name: "ComponentTokenTests"

        function verifyValues(token, expected) {
            for (const propertyName in expected)
                compare(token[propertyName], expected[propertyName], propertyName);
        }

        function test_controlGeometry() {
            compare(metricButton.background.implicitHeight, MD.Tokens.button.containerHeightSmall);
            compare(metricButton.implicitHeight, MD.Tokens.button.minimumInteractiveSize);
            compare(metricButton.background.border.width, MD.Tokens.button.outlinedOutlineWidthSmall);
            metricButton.size = MD.Button.Size.Large;
            compare(metricButton.background.implicitHeight, MD.Tokens.button.containerHeightLarge);
            compare(metricButton.background.border.width, MD.Tokens.button.outlinedOutlineWidthLarge);
            metricButton.size = MD.Button.Size.Small;

            metricIconButton.size = MD.IconButton.Size.ExtraLarge;
            metricIconButton.widthVariant = MD.IconButton.Width.Wide;
            compare(metricIconButton.background.implicitWidth, 184);
            compare(metricIconButton.background.implicitHeight, MD.Tokens.iconButton.containerHeightExtraLarge);
            metricIconButton.size = MD.IconButton.Size.Small;
            metricIconButton.widthVariant = MD.IconButton.Width.Default;

            compare(metricFab.background.implicitWidth, MD.Tokens.fab.containerWidth);
            compare(metricFab.background.implicitHeight, MD.Tokens.fab.containerHeight);
            metricFab.size = MD.FAB.Size.Large;
            compare(metricFab.background.implicitWidth, MD.Tokens.fab.largeContainerWidth);
            compare(metricFab.background.implicitHeight, MD.Tokens.fab.largeContainerHeight);
            metricFab.size = MD.FAB.Size.Default;

            compare(metricCheckBox.indicator.implicitWidth, MD.Tokens.checkBox.containerSize + MD.Tokens.spacingSmall);
            compare(metricSwitch.indicator.implicitWidth, MD.Tokens.switch.trackWidth);
            compare(metricSwitch.indicator.implicitHeight, MD.Tokens.switch.trackHeight);

            compare(metricListItem.background.implicitHeight, MD.Tokens.listItem.oneLineContainerHeight);
            metricListItem.supportingText = "Supporting";
            compare(metricListItem.background.implicitHeight, MD.Tokens.listItem.twoLineContainerHeight);
            metricListItem.overline = "Overline";
            compare(metricListItem.background.implicitHeight, MD.Tokens.listItem.threeLineContainerHeight);
            metricListItem.supportingText = "";
            metricListItem.overline = "";

            compare(metricSymbol.implicitWidth, MD.Tokens.symbol.size);
            compare(metricSymbol.implicitHeight, MD.Tokens.symbol.size);
        }

        function test_button() {
            verifyValues(MD.Tokens.button, {
                minimumInteractiveSize: 48,
                containerHeightExtraSmall: 32, containerHeightSmall: 40,
                containerHeightMedium: 56, containerHeightLarge: 96,
                containerHeightExtraLarge: 136,
                iconSizeExtraSmall: 20, iconSizeSmall: 20, iconSizeMedium: 24,
                iconSizeLarge: 32, iconSizeExtraLarge: 40,
                leadingSpaceExtraSmall: 12, leadingSpaceSmall: 16,
                leadingSpaceMedium: 24, leadingSpaceLarge: 48,
                leadingSpaceExtraLarge: 64,
                trailingSpaceExtraSmall: 12, trailingSpaceSmall: 16,
                trailingSpaceMedium: 24, trailingSpaceLarge: 48,
                trailingSpaceExtraLarge: 64,
                iconLabelSpaceExtraSmall: 8, iconLabelSpaceSmall: 8,
                iconLabelSpaceMedium: 8, iconLabelSpaceLarge: 12,
                iconLabelSpaceExtraLarge: 16,
                outlinedOutlineWidthExtraSmall: 1, outlinedOutlineWidthSmall: 1,
                outlinedOutlineWidthMedium: 1, outlinedOutlineWidthLarge: 2,
                outlinedOutlineWidthExtraLarge: 3,
                containerShapeRound: 9999,
                containerShapeSquareExtraSmall: 12, containerShapeSquareSmall: 12,
                containerShapeSquareMedium: 16, containerShapeSquareLarge: 28,
                containerShapeSquareExtraLarge: 28,
                pressedContainerShapeExtraSmall: 8, pressedContainerShapeSmall: 8,
                pressedContainerShapeMedium: 12, pressedContainerShapeLarge: 16,
                pressedContainerShapeExtraLarge: 16,
                selectedContainerShapeRoundExtraSmall: 12,
                selectedContainerShapeRoundSmall: 12,
                selectedContainerShapeRoundMedium: 16,
                selectedContainerShapeRoundLarge: 28,
                selectedContainerShapeRoundExtraLarge: 28,
                selectedContainerShapeSquare: 9999,
                disabledContainerOpacity: 0.1, disabledIconOpacity: 0.38,
                disabledLabelTextOpacity: 0.38, hoverStateLayerOpacity: 0.08,
                focusStateLayerOpacity: 0.1, pressedStateLayerOpacity: 0.1,
                elevatedContainerElevation: 1, flatContainerElevation: 0
            });
        }

        function test_checkBox() {
            verifyValues(MD.Tokens.checkBox, {
                containerSize: 18, containerShape: 2, iconSize: 18,
                stateLayerSize: 40, selectedOutlineWidth: 0,
                unselectedOutlineWidth: 2, selectedDisabledContainerOpacity: 0.38,
                unselectedDisabledContainerOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_dialog() {
            verifyValues(MD.Tokens.dialog, {
                containerElevation: 6, containerShape: 28, withIconIconSize: 24,
                actionHoverStateLayerOpacity: 0.08,
                actionFocusStateLayerOpacity: 0.1,
                actionPressedStateLayerOpacity: 0.1
            });
        }

        function test_iconButton() {
            verifyValues(MD.Tokens.iconButton, {
                minimumInteractiveSize: 48,
                containerHeightExtraSmall: 32, containerHeightSmall: 40,
                containerHeightMedium: 56, containerHeightLarge: 96,
                containerHeightExtraLarge: 136,
                iconSizeExtraSmall: 20, iconSizeSmall: 24, iconSizeMedium: 24,
                iconSizeLarge: 32, iconSizeExtraLarge: 40,
                defaultLeadingSpaceExtraSmall: 6, defaultLeadingSpaceSmall: 8,
                defaultLeadingSpaceMedium: 16, defaultLeadingSpaceLarge: 32,
                defaultLeadingSpaceExtraLarge: 48,
                narrowLeadingSpaceExtraSmall: 4, narrowLeadingSpaceSmall: 4,
                narrowLeadingSpaceMedium: 12, narrowLeadingSpaceLarge: 16,
                narrowLeadingSpaceExtraLarge: 32,
                wideLeadingSpaceExtraSmall: 10, wideLeadingSpaceSmall: 14,
                wideLeadingSpaceMedium: 24, wideLeadingSpaceLarge: 48,
                wideLeadingSpaceExtraLarge: 72,
                defaultTrailingSpaceExtraSmall: 6, defaultTrailingSpaceSmall: 8,
                defaultTrailingSpaceMedium: 16, defaultTrailingSpaceLarge: 32,
                defaultTrailingSpaceExtraLarge: 48,
                narrowTrailingSpaceExtraSmall: 4, narrowTrailingSpaceSmall: 4,
                narrowTrailingSpaceMedium: 12, narrowTrailingSpaceLarge: 16,
                narrowTrailingSpaceExtraLarge: 32,
                wideTrailingSpaceExtraSmall: 10, wideTrailingSpaceSmall: 14,
                wideTrailingSpaceMedium: 24, wideTrailingSpaceLarge: 48,
                wideTrailingSpaceExtraLarge: 72,
                outlinedOutlineWidthExtraSmall: 1, outlinedOutlineWidthSmall: 1,
                outlinedOutlineWidthMedium: 1, outlinedOutlineWidthLarge: 2,
                outlinedOutlineWidthExtraLarge: 3,
                containerShapeRound: 9999,
                containerShapeSquareExtraSmall: 12, containerShapeSquareSmall: 12,
                containerShapeSquareMedium: 16, containerShapeSquareLarge: 28,
                containerShapeSquareExtraLarge: 28,
                pressedContainerShapeExtraSmall: 8, pressedContainerShapeSmall: 8,
                pressedContainerShapeMedium: 12, pressedContainerShapeLarge: 16,
                pressedContainerShapeExtraLarge: 16,
                selectedContainerShapeRoundExtraSmall: 12,
                selectedContainerShapeRoundSmall: 12,
                selectedContainerShapeRoundMedium: 16,
                selectedContainerShapeRoundLarge: 28,
                selectedContainerShapeRoundExtraLarge: 28,
                selectedContainerShapeSquare: 9999,
                disabledContainerOpacity: 0.1, disabledIconOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_fab() {
            compare(MD.Tokens.cornerRadiusLargeIncreased, 20);
            verifyValues(MD.Tokens.fab, {
                containerHeight: 56, containerShape: 16, containerWidth: 56,
                iconSize: 24,
                mediumContainerHeight: 80, mediumContainerShape: 20,
                mediumContainerWidth: 80, mediumIconSize: 28,
                largeContainerHeight: 96, largeContainerShape: 28,
                largeContainerWidth: 96, largeIconSize: 36,
                containerElevation: 6, focusContainerElevation: 6,
                hoverContainerElevation: 8, pressedContainerElevation: 6,
                loweredContainerElevation: 1, loweredFocusContainerElevation: 1,
                loweredHoverContainerElevation: 3,
                loweredPressedContainerElevation: 1,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_listItem() {
            verifyValues(MD.Tokens.listItem, {
                oneLineContainerHeight: 56, twoLineContainerHeight: 72,
                threeLineContainerHeight: 88, leadingSpace: 16, trailingSpace: 16,
                topSpace: 10, bottomSpace: 10, betweenSpace: 12, segmentedGap: 2,
                containerShape: 0, containerExpressiveShape: 4,
                hoveredContainerExpressiveShape: 12,
                focusedContainerExpressiveShape: 16,
                pressedContainerExpressiveShape: 16,
                selectedContainerExpressiveShape: 16,
                leadingIconSize: 24, trailingIconSize: 24,
                leadingAvatarSize: 40, leadingImageSize: 56,
                disabledContentOpacity: 0.38, disabledStateLayerOpacity: 0.1,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1, draggedStateLayerOpacity: 0.16,
                containerElevation: 0, draggedContainerElevation: 8
            });
        }

        function test_switch() {
            verifyValues(MD.Tokens.switch, {
                trackWidth: 52, trackHeight: 32, trackShape: 9999,
                trackOutlineWidth: 2, stateLayerSize: 40, stateLayerShape: 9999,
                selectedHandleSize: 24, unselectedHandleSize: 16,
                withIconHandleSize: 24, pressedHandleSize: 28, handleShape: 9999,
                selectedIconSize: 16, unselectedIconSize: 16,
                disabledTrackOpacity: 0.12, disabledSelectedHandleOpacity: 1,
                disabledUnselectedHandleOpacity: 0.38,
                disabledSelectedIconOpacity: 0.38,
                disabledUnselectedIconOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_existingGadgetAdditions() {
            verifyValues(MD.Tokens.appBar, {
                avatarSize: 32, iconButtonSpace: 0, leadingSpace: 4,
                trailingSpace: 4, containerShape: 0,
                mediumContainerHeight: 112, largeContainerHeight: 152
            });
            compare(MD.Tokens.menu.containerShape, 4);
            verifyValues(MD.Tokens.slider, {
                activeHandlePadding: 6, activeHandleTrailingSpace: 6,
                activeStopIndicatorContainerOpacity: 1,
                inactiveStopIndicatorContainerOpacity: 1,
                disabledHandleWidth: 4, hoverHandleWidth: 4,
                stopIndicatorTrailingSpace: 4,
                trackIconPaddingMedium: 6, trackIconPaddingLarge: 6,
                trackIconPaddingExtraLarge: 8
            });
            compare(MD.Tokens.symbol.size, 24);
        }
    }
}
