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
        icon.name: MD.Symbols.add
    }

    MD.FAB {
        id: metricFab
        text: "Action"
        icon.name: MD.Symbols.add
    }

    MD.FabMenu {
        id: metricFabMenu
        x: 400
        y: 400
        width: 300
        height: 380

        MD.FabMenuItem {
            id: metricFabMenuItem
            text: "Item"
            icon.name: MD.Symbols.add
        }
    }

    MD.CheckBox {
        id: metricCheckBox
        text: "Option"
    }

    MD.RadioButton {
        id: metricRadioButton
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
        name: MD.Symbols.add
    }

    TestCase {
        name: "ComponentTokenTests"

        function verifyValues(token, expected) {
            for (const propertyName in expected) {
                const expectedValue = expected[propertyName];
                if (Array.isArray(expectedValue) ||
                        (typeof expectedValue === "object" && expectedValue.topLeft !== undefined)) {
                    verifyShape(token[propertyName], expectedValue, propertyName);
                } else {
                    compare(token[propertyName], expectedValue, propertyName);
                }
            }
        }

        function verifyShape(actual, expected, name) {
            const values = Array.isArray(expected)
                         ? expected
                         : [expected.topLeft, expected.topRight,
                            expected.bottomRight, expected.bottomLeft];
            compare(actual.topLeft, values[0], name + ".topLeft");
            compare(actual.topRight, values[1], name + ".topRight");
            compare(actual.bottomRight, values[2], name + ".bottomRight");
            compare(actual.bottomLeft, values[3], name + ".bottomLeft");
        }

        function verifyRectangleShape(rectangle, shape, name) {
            const full = MD.Tokens.shape.cornerValueFull;
            const maximum = Math.min(rectangle.width, rectangle.height) / 2;
            compare(rectangle.topLeftRadius,
                    shape.topLeft === full ? maximum : shape.topLeft, name + ".topLeftRadius");
            compare(rectangle.topRightRadius,
                    shape.topRight === full ? maximum : shape.topRight,
                    name + ".topRightRadius");
            compare(rectangle.bottomRightRadius,
                    shape.bottomRight === full ? maximum : shape.bottomRight,
                    name + ".bottomRightRadius");
            compare(rectangle.bottomLeftRadius,
                    shape.bottomLeft === full ? maximum : shape.bottomLeft,
                    name + ".bottomLeftRadius");
        }

        function test_controlGeometry() {
            compare(metricButton.background.implicitHeight, MD.Tokens.button.containerHeightSmall);
            compare(metricButton.implicitHeight, MD.Tokens.button.minimumInteractiveSize);
            compare(metricButton.background.border.width, MD.Tokens.button.outlinedOutlineWidthSmall);
            verifyRectangleShape(metricButton.background, MD.Tokens.button.containerShapeRound,
                                 "buttonBackground");
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
            verifyRectangleShape(metricIconButton.background,
                                 MD.Tokens.iconButton.containerShapeRound,
                                 "iconButtonBackground");

            compare(metricFab.background.implicitWidth, MD.Tokens.fab.containerWidth);
            compare(metricFab.background.implicitHeight, MD.Tokens.fab.containerHeight);
            metricFab.size = MD.FAB.Size.Large;
            compare(metricFab.background.implicitWidth, MD.Tokens.fab.largeContainerWidth);
            compare(metricFab.background.implicitHeight, MD.Tokens.fab.largeContainerHeight);
            metricFab.size = MD.FAB.Size.Default;

            compare(metricFabMenu.margins, MD.Tokens.fabMenu.containerMargin);
            compare(metricFabMenu.button.background.implicitWidth, MD.Tokens.fab.containerWidth);
            compare(metricFabMenu.button.background.implicitHeight, MD.Tokens.fab.containerHeight);
            compare(metricFabMenuItem.implicitHeight, MD.Tokens.fabMenu.listItemContainerHeight);
            compare(metricFabMenuItem.background.implicitHeight, MD.Tokens.fabMenu.listItemContainerHeight);
            verifyRectangleShape(metricFabMenuItem.background,
                                 MD.Tokens.fabMenu.listItemContainerShape,
                                 "fabMenuItemBackground");
            compare(metricFabMenuItem.leftPadding, MD.Tokens.fabMenu.listItemLeadingSpace);
            compare(metricFabMenuItem.rightPadding, MD.Tokens.fabMenu.listItemTrailingSpace);

            compare(metricCheckBox.indicator.implicitWidth,
                    MD.Tokens.checkBox.containerSize + MD.Tokens.checkBox.containerPadding * 2);
            compare(metricRadioButton.implicitHeight,
                    MD.Tokens.radioButton.minimumInteractiveSize);
            compare(metricRadioButton.indicator.implicitWidth,
                    MD.Tokens.radioButton.iconSize
                    + MD.Tokens.radioButton.indicatorPadding * 2);
            compare(metricRadioButton.indicator.implicitHeight,
                    MD.Tokens.radioButton.iconSize
                    + MD.Tokens.radioButton.indicatorPadding * 2);
            const radioOuterRing = findChild(metricRadioButton, "radioOuterRing");
            const radioStateLayer = findChild(metricRadioButton, "radioStateLayer");
            verify(radioOuterRing);
            verify(radioStateLayer);
            compare(radioOuterRing.width, MD.Tokens.radioButton.iconSize);
            compare(radioOuterRing.height, MD.Tokens.radioButton.iconSize);
            compare(radioOuterRing.border.width, MD.Tokens.radioButton.outlineWidth);
            compare(radioStateLayer.width, MD.Tokens.radioButton.stateLayerSize);
            compare(radioStateLayer.height, MD.Tokens.radioButton.stateLayerSize);
            compare(metricSwitch.indicator.implicitWidth, MD.Tokens.switch.trackWidth);
            compare(metricSwitch.indicator.implicitHeight, MD.Tokens.switch.trackHeight);
            const switchTrack = findChild(metricSwitch, "switchTrack");
            const switchStateLayer = findChild(metricSwitch, "switchStateLayer");
            const switchHandle = findChild(metricSwitch, "switchHandle");
            verify(switchTrack);
            verify(switchStateLayer);
            verify(switchHandle);
            verifyRectangleShape(switchTrack, MD.Tokens.switch.trackShape, "switchTrack");
            verifyRectangleShape(switchStateLayer, MD.Tokens.switch.stateLayerShape,
                                 "switchStateLayer");
            verifyRectangleShape(switchHandle, MD.Tokens.switch.handleShape, "switchHandle");

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
                leadingSpaceExtraSmall: 16, leadingSpaceSmall: 16,
                leadingSpaceMedium: 24, leadingSpaceLarge: 48,
                leadingSpaceExtraLarge: 64,
                trailingSpaceExtraSmall: 16, trailingSpaceSmall: 16,
                trailingSpaceMedium: 24, trailingSpaceLarge: 48,
                trailingSpaceExtraLarge: 64,
                iconLabelSpaceExtraSmall: 8, iconLabelSpaceSmall: 8,
                iconLabelSpaceMedium: 8, iconLabelSpaceLarge: 12,
                iconLabelSpaceExtraLarge: 16,
                outlinedOutlineWidthExtraSmall: 1, outlinedOutlineWidthSmall: 1,
                outlinedOutlineWidthMedium: 1, outlinedOutlineWidthLarge: 2,
                outlinedOutlineWidthExtraLarge: 3,
                containerShapeRound: [9999, 9999, 9999, 9999],
                containerShapeSquareExtraSmall: [12, 12, 12, 12],
                containerShapeSquareSmall: [12, 12, 12, 12],
                containerShapeSquareMedium: [16, 16, 16, 16],
                containerShapeSquareLarge: [28, 28, 28, 28],
                containerShapeSquareExtraLarge: [28, 28, 28, 28],
                pressedContainerShapeExtraSmall: [8, 8, 8, 8],
                pressedContainerShapeSmall: [8, 8, 8, 8],
                pressedContainerShapeMedium: [12, 12, 12, 12],
                pressedContainerShapeLarge: [16, 16, 16, 16],
                pressedContainerShapeExtraLarge: [16, 16, 16, 16],
                selectedContainerShapeRoundExtraSmall: [12, 12, 12, 12],
                selectedContainerShapeRoundSmall: [12, 12, 12, 12],
                selectedContainerShapeRoundMedium: [16, 16, 16, 16],
                selectedContainerShapeRoundLarge: [28, 28, 28, 28],
                selectedContainerShapeRoundExtraLarge: [28, 28, 28, 28],
                selectedContainerShapeSquareExtraSmall: [9999, 9999, 9999, 9999],
                selectedContainerShapeSquareSmall: [9999, 9999, 9999, 9999],
                selectedContainerShapeSquareMedium: [9999, 9999, 9999, 9999],
                selectedContainerShapeSquareLarge: [9999, 9999, 9999, 9999],
                selectedContainerShapeSquareExtraLarge: [9999, 9999, 9999, 9999],
                disabledContainerOpacity: 0.1, disabledIconOpacity: 0.38,
                disabledLabelTextOpacity: 0.38, hoverStateLayerOpacity: 0.08,
                focusStateLayerOpacity: 0.1, pressedStateLayerOpacity: 0.1,
                elevatedContainerElevation: 1, flatContainerElevation: 0
            });
        }

        function test_buttonGroup() {
            verifyValues(MD.Tokens.buttonGroup, {
                standardSpacing: 12,
                connectedSpacing: 2,
                smallReferenceHeight: 40,
                connectedContainerShape: [9999, 9999, 9999, 9999],
                connectedInnerCorner: 8,
                pressedInnerCorner: 4,
                selectedInnerCornerPercentage: 50,
                standardPressedExpansionRatio: 0.15
            });
        }

        function test_checkBox() {
            verifyValues(MD.Tokens.checkBox, {
                containerSize: 18, containerShape: [2, 2, 2, 2], iconSize: 18,
                stateLayerSize: 40, selectedOutlineWidth: 0,
                contentPadding: 8, contentSpacing: 8, containerPadding: 4,
                unselectedOutlineWidth: 2, selectedDisabledContainerOpacity: 0.38,
                unselectedDisabledContainerOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_radioButton() {
            verifyValues(MD.Tokens.radioButton, {
                minimumInteractiveSize: 48, iconSize: 20, stateLayerSize: 40,
                indicatorPadding: 2, outlineWidth: 2,
                contentPadding: 8, contentSpacing: 8,
                selectedDisabledIconOpacity: 0.38,
                unselectedDisabledIconOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_dialog() {
            verifyValues(MD.Tokens.dialog, {
                containerElevation: 6, containerShape: [28, 28, 28, 28],
                withIconIconSize: 24,
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
                containerShapeRound: [9999, 9999, 9999, 9999],
                containerShapeSquareExtraSmall: [12, 12, 12, 12],
                containerShapeSquareSmall: [12, 12, 12, 12],
                containerShapeSquareMedium: [16, 16, 16, 16],
                containerShapeSquareLarge: [28, 28, 28, 28],
                containerShapeSquareExtraLarge: [28, 28, 28, 28],
                pressedContainerShapeExtraSmall: [8, 8, 8, 8],
                pressedContainerShapeSmall: [8, 8, 8, 8],
                pressedContainerShapeMedium: [12, 12, 12, 12],
                pressedContainerShapeLarge: [16, 16, 16, 16],
                pressedContainerShapeExtraLarge: [16, 16, 16, 16],
                selectedContainerShapeRoundExtraSmall: [12, 12, 12, 12],
                selectedContainerShapeRoundSmall: [12, 12, 12, 12],
                selectedContainerShapeRoundMedium: [16, 16, 16, 16],
                selectedContainerShapeRoundLarge: [28, 28, 28, 28],
                selectedContainerShapeRoundExtraLarge: [28, 28, 28, 28],
                selectedContainerShapeSquare: [9999, 9999, 9999, 9999],
                disabledContainerOpacity: 0.1, disabledIconOpacity: 0.38,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_fab() {
            verifyValues(MD.Tokens.fab, {
                containerHeight: 56, containerShape: [16, 16, 16, 16],
                containerWidth: 56,
                iconSize: 24,
                mediumContainerHeight: 80, mediumContainerShape: [20, 20, 20, 20],
                mediumContainerWidth: 80, mediumIconSize: 28,
                largeContainerHeight: 96, largeContainerShape: [28, 28, 28, 28],
                largeContainerWidth: 96, largeIconSize: 32,
                leadingSpace: 16, mediumLeadingSpace: 26, largeLeadingSpace: 28,
                trailingSpace: 16, mediumTrailingSpace: 26, largeTrailingSpace: 28,
                iconLabelSpace: 8, mediumIconLabelSpace: 12,
                largeIconLabelSpace: 16,
                containerElevation: 6, focusContainerElevation: 6,
                hoverContainerElevation: 8, pressedContainerElevation: 6,
                loweredContainerElevation: 1, loweredFocusContainerElevation: 1,
                loweredHoverContainerElevation: 3,
                loweredPressedContainerElevation: 1,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_fabMenu() {
            verifyValues(MD.Tokens.fabMenu, {
                closeButtonContainerWidth: 56, closeButtonContainerHeight: 56,
                closeButtonContainerShape: [9999, 9999, 9999, 9999],
                closeButtonIconSize: 20,
                closeButtonContainerElevation: 6,
                closeButtonFocusContainerElevation: 6,
                closeButtonHoverContainerElevation: 8,
                closeButtonPressedContainerElevation: 6,
                closeButtonBetweenSpace: 8,
                listItemContainerHeight: 56,
                listItemContainerShape: [9999, 9999, 9999, 9999],
                listItemContainerElevation: 6, listItemIconSize: 24,
                listItemIconLabelSpace: 8, listItemLeadingSpace: 24,
                listItemTrailingSpace: 24, listItemBetweenSpace: 4,
                listItemStaggerDelay: 30,
                hoverStateLayerOpacity: 0.08, focusStateLayerOpacity: 0.1,
                pressedStateLayerOpacity: 0.1, disabledContentOpacity: 0.38,
                scrimOpacity: 0.32, containerMargin: 16
            });
        }

        function test_listItem() {
            verifyValues(MD.Tokens.listItem, {
                oneLineContainerHeight: 56, twoLineContainerHeight: 72,
                threeLineContainerHeight: 88, leadingSpace: 16, trailingSpace: 16,
                topSpace: 10, bottomSpace: 10, betweenSpace: 12, segmentedGap: 2,
                containerShape: [0, 0, 0, 0],
                containerExpressiveShape: [4, 4, 4, 4],
                hoveredContainerExpressiveShape: [12, 12, 12, 12],
                focusedContainerExpressiveShape: [16, 16, 16, 16],
                pressedContainerExpressiveShape: [16, 16, 16, 16],
                selectedContainerExpressiveShape: [16, 16, 16, 16],
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
                trackWidth: 52, trackHeight: 32, trackShape: [9999, 9999, 9999, 9999],
                trackOutlineWidth: 2, stateLayerSize: 40,
                stateLayerShape: [9999, 9999, 9999, 9999],
                selectedHandleSize: 24, unselectedHandleSize: 16,
                withIconHandleSize: 24, pressedHandleSize: 28,
                handleShape: [9999, 9999, 9999, 9999],
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
                trailingSpace: 4, containerShape: [0, 0, 0, 0],
                mediumContainerHeight: 112, largeContainerHeight: 152
            });
            verifyValues(MD.Tokens.menu, {
                containerShape: [4, 4, 4, 4],
                verticalContainerShape: [16, 16, 16, 16],
                verticalGroupShape: [8, 8, 8, 8],
                verticalItemShape: [4, 4, 4, 4],
                verticalOnlyItemShape: [12, 12, 12, 12],
                verticalFirstItemShape: [12, 12, 4, 4],
                verticalMiddleItemShape: [4, 4, 4, 4],
                verticalLastItemShape: [4, 4, 12, 12],
                verticalSelectedItemShape: [12, 12, 12, 12],
                verticalInactiveItemShape: [8, 8, 8, 8],
                verticalItemHeight: 44,
                verticalGroupPadding: 4,
                verticalSegmentedGap: 2,
                verticalItemTopPadding: 8,
                verticalItemBottomPadding: 8,
                verticalItemLeadingSpace: 16,
                verticalItemTrailingSpace: 16,
                verticalItemBetweenSpace: 12,
                verticalIconSize: 20,
                closedScale: 0.8,
                horizontalViewportMargin: 8,
                verticalViewportMargin: 48
            });
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

        function test_exposedDropdownMenu() {
            verifyValues(MD.Tokens.exposedDropdownMenu, {
                fieldHeight: 56,
                minimumWidth: 280,
                preferredWidth: 280,
                horizontalPadding: 16,
                contentVerticalPadding: 8,
                labelInputTextSpace: 4,
                supportingTextTopSpace: 4,
                filledContainerShape: [4, 4, 0, 0],
                filledLeadingIconSize: 20,
                filledActiveIndicatorHeight: 1,
                filledHoverActiveIndicatorHeight: 1,
                filledFocusActiveIndicatorHeight: 2,
                filledDisabledContainerOpacity: 0.04,
                outlinedContainerShape: [4, 4, 4, 4],
                outlinedLeadingIconSize: 24,
                outlinedOutlineWidth: 1,
                outlinedHoverOutlineWidth: 1,
                outlinedFocusOutlineWidth: 2,
                outlinedDisabledOutlineOpacity: 0.12,
                outlinedLabelHorizontalPadding: 4,
                trailingIconSize: 24,
                leadingIconContentSpace: 16,
                trailingIconContentSpace: 12,
                disabledContentOpacity: 0.38,
                popupAnchorGap: 4,
                popupContainerShape: [16, 16, 16, 16],
                popupContainerElevation: 3
            });
        }

        function test_textField() {
            verifyValues(MD.Tokens.textField, {
                minimumWidth: 280,
                containerHeight: 56,
                horizontalPadding: 16,
                contentVerticalPadding: 8,
                supportingTextTopSpace: 4,
                supportingTextMinimumHeight: 16,
                prefixSuffixTextSpace: 2,
                iconSize: 24,
                iconTargetSize: 48,
                filledContainerShape: [4, 4, 0, 0],
                filledActiveIndicatorHeight: 1,
                filledHoverActiveIndicatorHeight: 1,
                filledDisabledActiveIndicatorHeight: 1,
                filledFocusActiveIndicatorHeight: 2,
                filledDisabledActiveIndicatorOpacity: 0.38,
                filledDisabledContainerOpacity: 0.04,
                outlinedContainerShape: [4, 4, 4, 4],
                outlinedOutlineWidth: 1,
                outlinedHoverOutlineWidth: 1,
                outlinedDisabledOutlineWidth: 1,
                outlinedFocusOutlineWidth: 2,
                outlinedDisabledOutlineOpacity: 0.12,
                outlinedLabelHorizontalPadding: 4,
                disabledContentOpacity: 0.38
            });
        }

        function test_componentToSystemMappings() {
            const shape = MD.Tokens.shape;
            const elevation = MD.Tokens.elevation;
            const state = MD.Tokens.state;

            verifyValues(MD.Tokens.textField, {
                filledContainerShape: shape.cornerExtraSmallTop,
                outlinedContainerShape: shape.cornerExtraSmall
            });

            verifyValues(MD.Tokens.button, {
                containerShapeRound: shape.cornerFull,
                containerShapeSquareExtraSmall: shape.cornerMedium,
                containerShapeSquareSmall: shape.cornerMedium,
                containerShapeSquareMedium: shape.cornerLarge,
                containerShapeSquareLarge: shape.cornerExtraLarge,
                containerShapeSquareExtraLarge: shape.cornerExtraLarge,
                pressedContainerShapeExtraSmall: shape.cornerSmall,
                pressedContainerShapeSmall: shape.cornerSmall,
                pressedContainerShapeMedium: shape.cornerMedium,
                pressedContainerShapeLarge: shape.cornerLarge,
                pressedContainerShapeExtraLarge: shape.cornerLarge,
                selectedContainerShapeRoundExtraSmall: shape.cornerMedium,
                selectedContainerShapeRoundSmall: shape.cornerMedium,
                selectedContainerShapeRoundMedium: shape.cornerLarge,
                selectedContainerShapeRoundLarge: shape.cornerExtraLarge,
                selectedContainerShapeRoundExtraLarge: shape.cornerExtraLarge,
                selectedContainerShapeSquareExtraSmall: shape.cornerFull,
                selectedContainerShapeSquareSmall: shape.cornerFull,
                selectedContainerShapeSquareMedium: shape.cornerFull,
                selectedContainerShapeSquareLarge: shape.cornerFull,
                selectedContainerShapeSquareExtraLarge: shape.cornerFull,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity,
                elevatedContainerElevation: elevation.level1,
                flatContainerElevation: elevation.level0
            });

            verifyValues(MD.Tokens.buttonGroup, {
                connectedContainerShape: shape.cornerFull,
                connectedInnerCorner: shape.cornerValueSmall,
                pressedInnerCorner: shape.cornerValueExtraSmall
            });

            verifyValues(MD.Tokens.iconButton, {
                containerShapeRound: shape.cornerFull,
                containerShapeSquareExtraSmall: shape.cornerMedium,
                containerShapeSquareSmall: shape.cornerMedium,
                containerShapeSquareMedium: shape.cornerLarge,
                containerShapeSquareLarge: shape.cornerExtraLarge,
                containerShapeSquareExtraLarge: shape.cornerExtraLarge,
                pressedContainerShapeExtraSmall: shape.cornerSmall,
                pressedContainerShapeSmall: shape.cornerSmall,
                pressedContainerShapeMedium: shape.cornerMedium,
                pressedContainerShapeLarge: shape.cornerLarge,
                pressedContainerShapeExtraLarge: shape.cornerLarge,
                selectedContainerShapeRoundExtraSmall: shape.cornerMedium,
                selectedContainerShapeRoundSmall: shape.cornerMedium,
                selectedContainerShapeRoundMedium: shape.cornerLarge,
                selectedContainerShapeRoundLarge: shape.cornerExtraLarge,
                selectedContainerShapeRoundExtraLarge: shape.cornerExtraLarge,
                selectedContainerShapeSquare: shape.cornerFull,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });

            verifyValues(MD.Tokens.checkBox, {
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.radioButton, {
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.dialog, {
                containerElevation: elevation.level3,
                containerShape: shape.cornerExtraLarge,
                actionHoverStateLayerOpacity: state.hoverStateLayerOpacity,
                actionFocusStateLayerOpacity: state.focusStateLayerOpacity,
                actionPressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.fab, {
                containerShape: shape.cornerLarge,
                mediumContainerShape: shape.cornerLargeIncreased,
                largeContainerShape: shape.cornerExtraLarge,
                containerElevation: elevation.level3,
                focusContainerElevation: elevation.level3,
                hoverContainerElevation: elevation.level4,
                pressedContainerElevation: elevation.level3,
                loweredContainerElevation: elevation.level1,
                loweredFocusContainerElevation: elevation.level1,
                loweredHoverContainerElevation: elevation.level2,
                loweredPressedContainerElevation: elevation.level1,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.fabMenu, {
                closeButtonContainerShape: shape.cornerFull,
                closeButtonContainerElevation: elevation.level3,
                closeButtonFocusContainerElevation: elevation.level3,
                closeButtonHoverContainerElevation: elevation.level4,
                closeButtonPressedContainerElevation: elevation.level3,
                listItemContainerShape: shape.cornerFull,
                listItemContainerElevation: elevation.level3,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.listItem, {
                containerShape: shape.cornerNone,
                containerExpressiveShape: shape.cornerExtraSmall,
                hoveredContainerExpressiveShape: shape.cornerMedium,
                focusedContainerExpressiveShape: shape.cornerLarge,
                pressedContainerExpressiveShape: shape.cornerLarge,
                selectedContainerExpressiveShape: shape.cornerLarge,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity,
                draggedStateLayerOpacity: state.draggedStateLayerOpacity,
                containerElevation: elevation.level0,
                draggedContainerElevation: elevation.level4
            });
            verifyValues(MD.Tokens.switch, {
                trackShape: shape.cornerFull,
                stateLayerShape: shape.cornerFull,
                handleShape: shape.cornerFull,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.appBar, {
                containerShape: shape.cornerNone,
                containerElevation: elevation.level0,
                onScrollContainerElevation: elevation.level2,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
            verifyValues(MD.Tokens.menu, {
                containerShape: shape.cornerExtraSmall,
                containerElevation: elevation.level2,
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity,
                verticalContainerShape: shape.cornerLarge,
                verticalGroupShape: shape.cornerSmall,
                verticalItemShape: shape.cornerExtraSmall,
                verticalOnlyItemShape: shape.cornerMedium,
                verticalFirstItemShape: [12, 12, 4, 4],
                verticalMiddleItemShape: shape.cornerExtraSmall,
                verticalLastItemShape: [4, 4, 12, 12],
                verticalSelectedItemShape: shape.cornerMedium,
                verticalInactiveItemShape: shape.cornerSmall
            });
            verifyValues(MD.Tokens.exposedDropdownMenu, {
                filledContainerShape: shape.cornerExtraSmallTop,
                outlinedContainerShape: shape.cornerExtraSmall,
                popupContainerShape: shape.cornerLarge,
                popupContainerElevation: elevation.level2
            });
            verifyValues(MD.Tokens.slider, {
                hoverStateLayerOpacity: state.hoverStateLayerOpacity,
                focusStateLayerOpacity: state.focusStateLayerOpacity,
                pressedStateLayerOpacity: state.pressedStateLayerOpacity
            });
        }
    }
}
