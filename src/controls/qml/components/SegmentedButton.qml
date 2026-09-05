// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../internal"
import "../core/UiMetrics.js" as UiMetrics

/*!
    \class SegmentedButton
    \brief An outlined Material 3 choice in a SegmentedButtonGroup.

    Use SegmentedButton children in a SegmentedButtonGroup for single or multiple
    selection. The inherited text, icon.name, icon.source, checked,
    enabled, and activation signals remain available. The group synchronizes
    checked with its authoritative selectedIndexes, assigns equal widths, and
    joins the visible endpoints. A standalone segment is a checkable button.

    The default visual container is 40 dp high within a 48 dp interaction area.
    Selection reserves indicator space, so checking a segment does not resize
    its group. Labels elide when the assigned width cannot fit the content.

    Presentation depends only on text, icon.name, and icon.source. Text alone
    displays a centered label; an icon alone displays a centered icon. Together,
    the icon appears beside the label, mirrored in RTL. The inherited display
    property remains available through T.Button but has no effect on presentation
    or sizing, regardless of its value.

    For icon-only choices, omit text and set Accessible.name; decorative icons and labels are
    excluded from the accessibility tree. Grouped segments expose radio-button
    roles in single mode and checkbox roles in multiple mode. Accessibility
    activation uses the same button click path as mouse and keyboard activation.

    \code{.qml}
    MD.SegmentedButtonGroup {
        MD.SegmentedButton { text: qsTr("Day"); icon.name: MD.Symbols.today }
        MD.SegmentedButton { text: qsTr("Week"); icon.name: MD.Symbols.dateRange }
    }

    MD.SegmentedButtonGroup {
        MD.SegmentedButton {
            icon.name: MD.Symbols.viewList
            Accessible.name: qsTr("List view")
        }
        MD.SegmentedButton {
            icon.name: MD.Symbols.gridView
            Accessible.name: qsTr("Grid view")
        }
    }
    \endcode
*/
T.Button {
    id: control

    //! Label typography; defaults to the generated label-large token reference.
    property MD.typescale typescale: MD.Tokens.segmentedButton.labelTextFont

    /*!
        Whether selection displays a checkmark. Defaults to true. With text the
        checkmark replaces the leading icon, or adds an indicator to a label-only
        choice. Icon-only choices retain their option icon beside the checkmark.
        Space is reserved even when unchecked. False suppresses the indicator.
    */
    property bool showCheckmark: true

    /*!
        Container fill. Defaults to Style.secondaryContainerColor when selected
        and transparent otherwise, including disabled segments.
    */
    property color containerColor: checked ? control.MD.Style.secondaryContainerColor : "transparent"

    /*!
        Content color. Defaults to Style.onSecondaryContainerColor when selected
        and Style.onSurfaceColor otherwise. Disabled content uses onSurface with
        the generated disabled opacity. Explicit color assignments override this
        default; icon.color can independently override the option icon tint.
    */
    property color contentColor: !enabled
                                 ? Qt.alpha(control.MD.Style.onSurfaceColor, MD.Tokens.segmentedButton.disabledContentOpacity)
                                 : (checked ? control.MD.Style.onSecondaryContainerColor : control.MD.Style.onSurfaceColor)

    /*!
        Outline color. Defaults to Style.outlineColor; disabled outlines use
        Style.onSurfaceColor with the generated disabled outline opacity.
    */
    property color outlineColor: enabled ? control.MD.Style.outlineColor
                                         : Qt.alpha(control.MD.Style.onSurfaceColor, MD.Tokens.segmentedButton.disabledOutlineOpacity)

    /*!
        State-layer color, defaulting to the selected or unselected semantic
        content color. Its token opacity follows pressed, focused, then hovered
        precedence. Disabled segments have no state layer.
    */
    property color stateLayerColor: checked ? control.MD.Style.onSecondaryContainerColor : control.MD.Style.onSurfaceColor

    property var __segmentedButtonGroup: null
    property bool __leftEnd: true
    property bool __rightEnd: true
    readonly property bool __mirrored: __segmentedButtonGroup ? __segmentedButtonGroup.mirrored : mirrored
    readonly property real __stateLayerOpacity: !enabled ? 0
                                                : down ? MD.Tokens.segmentedButton.pressedStateLayerOpacity
                                                : visualFocus ? MD.Tokens.segmentedButton.focusStateLayerOpacity
                                                : hovered ? MD.Tokens.segmentedButton.hoverStateLayerOpacity : 0

    implicitWidth: Math.max(MD.Tokens.segmentedButton.minimumInteractiveSize,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(MD.Tokens.segmentedButton.minimumInteractiveSize,
                             implicitContentHeight + topPadding + bottomPadding,
                             MD.Tokens.segmentedButton.containerHeight + topInset + bottomInset)
    leftPadding: MD.Tokens.segmentedButton.contentPadding
    rightPadding: MD.Tokens.segmentedButton.contentPadding
    topPadding: topInset
    bottomPadding: bottomInset
    topInset: (MD.Tokens.segmentedButton.minimumInteractiveSize - MD.Tokens.segmentedButton.containerHeight) / 2
    bottomInset: topInset
    leftInset: 0
    rightInset: 0
    spacing: MD.Tokens.segmentedButton.contentSpacing
    icon.width: MD.Tokens.segmentedButton.iconSize
    icon.height: MD.Tokens.segmentedButton.iconSize
    icon.color: contentColor
    font.family: typescale.face === MD.Style.TypeFace.Brand ? control.MD.Style.brandFontFamily : control.MD.Style.plainFontFamily
    font.pixelSize: typescale.fontSize
    font.weight: typescale.fontWeight
    font.letterSpacing: typescale.tracking
    checkable: true
    autoExclusive: false
    hoverEnabled: true
    focusPolicy: Qt.StrongFocus

    Accessible.role: __segmentedButtonGroup && __segmentedButtonGroup.selectionMode === MD.SegmentedButtonGroup.SingleSelection
                     ? Accessible.RadioButton : Accessible.CheckBox
    Accessible.name: text
    Accessible.checkable: true
    Accessible.checked: checked
    Accessible.focusable: enabled && focusPolicy !== Qt.NoFocus
    Accessible.focused: activeFocus
    Accessible.pressed: down
    Accessible.onPressAction: {
        if (control.enabled && control.visible)
            control.click();
    }

    onCheckedChanged: {
        if (__segmentedButtonGroup)
            __segmentedButtonGroup.__childCheckedChanged(control);
    }
    onActiveFocusChanged: {
        if (activeFocus && __segmentedButtonGroup)
            __segmentedButtonGroup.__childFocused(control);
    }
    onVisibleChanged: {
        if (__segmentedButtonGroup)
            __segmentedButtonGroup.__scheduleSync();
    }
    onEnabledChanged: {
        if (__segmentedButtonGroup)
            __segmentedButtonGroup.__scheduleSync();
    }
    onImplicitWidthChanged: {
        if (__segmentedButtonGroup)
            __segmentedButtonGroup.__scheduleSync();
    }
    onImplicitHeightChanged: {
        if (__segmentedButtonGroup)
            __segmentedButtonGroup.__scheduleSync();
    }
    Keys.onPressed: event => {
        if (__segmentedButtonGroup && __segmentedButtonGroup.__handleKey(control, event))
            event.accepted = true;
        else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            if (!event.isAutoRepeat)
                control.click();
            event.accepted = true;
        }
    }

    contentItem: SegmentedButtonContent {
        text: control.text
        iconName: control.icon.name
        iconSource: control.icon.source
        iconWidth: control.icon.width
        iconHeight: control.icon.height
        checked: control.checked
        showCheckmark: control.showCheckmark
        mirrored: control.__mirrored
        textFont: control.font
        lineHeight: control.typescale.lineHeight
        contentColor: control.contentColor
        iconColor: control.icon.color
        spacing: control.spacing
        indicatorSize: MD.Tokens.segmentedButton.iconSize
    }

    background: SegmentedButtonBackground {
        implicitHeight: MD.Tokens.segmentedButton.containerHeight
        containerColor: control.containerColor
        outlineColor: control.outlineColor
        stateLayerColor: control.stateLayerColor
        stateLayerOpacity: control.__stateLayerOpacity
        outlineWidth: MD.Tokens.segmentedButton.outlineWidth
        leftRadius: control.__leftEnd ? UiMetrics.resolveShapeRadius(MD.Tokens.segmentedButton.containerShape.topLeft, width, height) : 0
        rightRadius: control.__rightEnd ? UiMetrics.resolveShapeRadius(MD.Tokens.segmentedButton.containerShape.topRight, width, height) : 0
        drawLeftOutline: control.__leftEnd
    }
}
