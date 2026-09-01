// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl as TImpl
import Fluid as MD
import "../internal" as Internal

/*!
    \class NavigationRailItem
    \brief A destination in a Material Design 3 Expressive navigation rail.

    NavigationRailItem displays an icon above its label in a collapsed rail and
    moves the icon to the logical leading side when the rail expands. Labels
    are always shown when supplied. Icon-only destinations remain centered in
    both layouts.

    The inherited \c text, \c icon, \c action, \c enabled, \c checked, and
    \c clicked APIs follow Qt Quick Templates. Items declared inside a
    NavigationRail or ModalNavigationRail are automatically made exclusive and
    synchronized with the rail's \c currentIndex.

    \code{.qml}
    MD.NavigationRailItem {
        text: qsTr("Home")
        icon.name: MD.SymbolNames.symbolHome
        onClicked: stack.currentIndex = 0
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/navigation-rail/overview">Material Design 3 navigation rail guidelines</a>.
*/
T.ItemDelegate {
    id: control

    /*! Whether source-based icons are tinted with the resolved icon color.

        Disable this for multicolor artwork or photographs.
    */
    property bool tintSourceIcon: true

    //! Icon color used while this destination is selected.
    property color selectedIconColor: control.MD.Style.onSecondaryContainerColor

    //! Label color used while this destination is selected.
    property color selectedLabelColor: control.MD.Style.secondaryColor

    //! Indicator fill color used while this destination is selected.
    property color selectedIndicatorColor: control.MD.Style.secondaryContainerColor

    //! Icon color used while this destination is not selected.
    property color unselectedIconColor: control.MD.Style.onSurfaceVariantColor

    //! Label color used while this destination is not selected.
    property color unselectedLabelColor: control.MD.Style.onSurfaceVariantColor

    //! \internal The NavigationRail that owns this destination.
    property NavigationRail rail: null

    //! \internal Position of this destination in its owning rail.
    property int _railIndex: -1

    //! \internal Whether the owning rail currently uses expanded geometry.
    readonly property bool _railExpanded: rail ? rail.expanded : false

    //! \internal Single normalized progress coordinating collapsed and expanded geometry.
    readonly property real _positionProgress: rail ? rail._layoutProgress
                                                   : (_railExpanded ? 1 : 0)

    //! \internal Whether label layout and typography have crossed into expanded placement.
    readonly property bool _expandedPlacement: _positionProgress >= 0.5

    //! \internal Whether a Material Symbol icon is available.
    readonly property bool _hasNamedIcon: icon.name.length > 0

    //! \internal Whether a source-based icon is available.
    readonly property bool _hasSourceIcon: icon.source.toString().length > 0

    //! \internal Whether the destination has a visible label.
    readonly property bool _hasLabel: text.length > 0

    //! \internal Resolved icon color for selection state.
    readonly property color _iconColor: checked ? selectedIconColor : unselectedIconColor

    //! \internal Resolved label color for selection state.
    readonly property color _labelColor: checked ? selectedLabelColor : unselectedLabelColor

    //! \internal Opacity applied to disabled icon and label content.
    readonly property real _contentOpacity: enabled ? 1 : MD.Tokens.navigationRail.disabledContentOpacity

    //! \internal Interaction state-layer opacity.
    readonly property real _stateLayerOpacity: {
        if (!enabled)
            return 0;
        if (down)
            return MD.Tokens.navigationRail.pressedStateLayerOpacity;
        if (visualFocus)
            return MD.Tokens.navigationRail.focusStateLayerOpacity;
        if (hovered)
            return MD.Tokens.navigationRail.hoverStateLayerOpacity;
        return 0;
    }

    checkable: true
    autoExclusive: true
    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    padding: 0
    spacing: _railExpanded ? MD.Tokens.navigationRail.horizontalIconLabelSpace
                           : MD.Tokens.navigationRail.verticalIconLabelSpace

    icon.width: MD.Tokens.navigationRail.iconSize
    icon.height: MD.Tokens.navigationRail.iconSize

    //! \internal Natural width of the expanded endpoint, independent of transition state.
    readonly property real _expandedImplicitWidth:
        MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace
        + icon.width
        + (_hasLabel
           ? MD.Tokens.navigationRail.horizontalIconLabelSpace
             + expandedLabelMeasure.implicitWidth
           : 0)
        + MD.Tokens.navigationRail.horizontalFullWidthTrailingSpace

    implicitWidth: _railExpanded
                   ? _expandedImplicitWidth
                   : MD.Tokens.navigationRail.collapsedContainerWidth
    implicitHeight: MD.Tokens.navigationRail.itemContainerHeight
                    + (MD.Tokens.navigationRail.horizontalActiveIndicatorHeight
                       - MD.Tokens.navigationRail.itemContainerHeight) * _positionProgress

    Keys.onUpPressed: event => {
        if (control.rail)
            control.rail._moveSelection(-1);
        else
            event.accepted = false;
    }
    Keys.onDownPressed: event => {
        if (control.rail)
            control.rail._moveSelection(1);
        else
            event.accepted = false;
    }
    Keys.onPressed: event => {
        if (!control.rail) {
            event.accepted = false;
        } else if (event.key === Qt.Key_Home) {
            control.rail._selectBoundary(false);
            event.accepted = true;
        } else if (event.key === Qt.Key_End) {
            control.rail._selectBoundary(true);
            event.accepted = true;
        } else {
            event.accepted = false;
        }
    }

    Connections {
        target: control

        function onClicked() {
            if (control.rail)
                control.rail._activateItem(control);
        }

        function onCheckedChanged() {
            if (control.rail)
                control.rail._itemCheckedChanged(control);
        }
    }

    contentItem: Item {
        id: content
        objectName: "navigationRailItemContent"

        function lerp(start, end, progress) {
            return start + (end - start) * progress;
        }

        readonly property real collapsedIndicatorX: (width - MD.Tokens.navigationRail.verticalActiveIndicatorWidth) / 2
        readonly property real collapsedIndicatorY: control._hasLabel
                                                    ? 0
                                                    : (height - MD.Tokens.navigationRail.verticalActiveIndicatorHeight) / 2
        readonly property real expandedIndicatorY: (height - MD.Tokens.navigationRail.horizontalActiveIndicatorHeight) / 2
        readonly property real collapsedIconX: (width - control.icon.width) / 2
        readonly property real collapsedIconY: collapsedIndicatorY
                                               + (MD.Tokens.navigationRail.verticalActiveIndicatorHeight - control.icon.height) / 2
        readonly property real expandedIconX: control._hasLabel
                                              ? control.mirrored
                                                ? width - MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace - control.icon.width
                                                : MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace
                                              : (width - control.icon.width) / 2
        readonly property real expandedIconY: (height - control.icon.height) / 2
        readonly property real collapsedLabelWidth: Math.min(width,
                                                             collapsedLabelMeasure.implicitWidth)

        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight

        MD.Label {
            id: collapsedLabelMeasure
            visible: false
            text: control.text
            typescale: MD.Tokens.typescale.labelMedium
            wrapMode: Text.NoWrap
        }

        MD.Label {
            id: expandedLabelMeasure
            visible: false
            text: control.text
            typescale: MD.Tokens.typescale.labelLarge
            wrapMode: Text.NoWrap
        }

        Internal.NavigationRailItemIndicator {
            id: indicator
            objectName: "navigationRailItemIndicator"

            x: content.lerp(content.collapsedIndicatorX, 0, control._positionProgress)
            y: content.lerp(content.collapsedIndicatorY, content.expandedIndicatorY,
                            control._positionProgress)
            width: content.lerp(MD.Tokens.navigationRail.verticalActiveIndicatorWidth,
                                content.width, control._positionProgress)
            height: content.lerp(MD.Tokens.navigationRail.verticalActiveIndicatorHeight,
                                 MD.Tokens.navigationRail.horizontalActiveIndicatorHeight,
                                 control._positionProgress)
            selected: control.checked
            pressed: control.down
            pressX: control.pressX - x
            pressY: control.pressY - y
            selectedColor: control.selectedIndicatorColor
            stateLayerColor: control._iconColor
            stateLayerOpacity: control._stateLayerOpacity

        }

        Item {
            id: iconSlot
            objectName: "navigationRailItemIcon"

            x: content.lerp(content.collapsedIconX, content.expandedIconX,
                            control._positionProgress)
            y: content.lerp(content.collapsedIconY, content.expandedIconY,
                            control._positionProgress)
            width: control.icon.width
            height: control.icon.height
            opacity: control._contentOpacity

            TImpl.IconImage {
                id: sourceIcon
                anchors.fill: iconSlot
                source: control.icon.source
                sourceSize: Qt.size(sourceIcon.width, sourceIcon.height)
                fillMode: Image.PreserveAspectFit
                color: control.tintSourceIcon ? control._iconColor : "transparent"
                visible: control._hasSourceIcon
            }

            MD.Symbol {
                anchors.fill: parent
                name: control.icon.name
                iconWidth: width
                iconHeight: height
                color: control._iconColor
                fill: control.checked
                visible: !control._hasSourceIcon && control._hasNamedIcon
            }
        }

        MD.Label {
            id: label
            objectName: "navigationRailItemLabel"

            x: control._expandedPlacement
               ? control.mirrored
                 ? MD.Tokens.navigationRail.horizontalFullWidthTrailingSpace
                 : MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace
                   + control.icon.width + MD.Tokens.navigationRail.horizontalIconLabelSpace
               : (content.width - content.collapsedLabelWidth) / 2
            y: control._expandedPlacement
               ? (content.height - height) / 2
               : content.collapsedIndicatorY
                 + MD.Tokens.navigationRail.verticalActiveIndicatorHeight
                 + MD.Tokens.navigationRail.verticalIconLabelSpace
            width: control._expandedPlacement
                   ? control.mirrored
                     ? Math.max(0, content.expandedIconX
                                      - MD.Tokens.navigationRail.horizontalIconLabelSpace
                                      - MD.Tokens.navigationRail.horizontalFullWidthTrailingSpace)
                     : Math.max(0, content.width
                                      - MD.Tokens.navigationRail.horizontalFullWidthLeadingSpace
                                      - control.icon.width
                                      - MD.Tokens.navigationRail.horizontalIconLabelSpace
                                      - MD.Tokens.navigationRail.horizontalFullWidthTrailingSpace)
                   : content.collapsedLabelWidth
            text: control.text
            color: control._labelColor
            opacity: control._contentOpacity
                     * Math.pow(control._positionProgress * 2 - 1, 2)
            visible: control._hasLabel
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
            typescale: control._expandedPlacement ? MD.Tokens.typescale.labelLarge
                                                  : MD.Tokens.typescale.labelMedium
            horizontalAlignment: control._expandedPlacement
                                 ? (control.mirrored ? Text.AlignRight : Text.AlignLeft)
                                 : Text.AlignHCenter

        }
    }

    background: Item {}
}
