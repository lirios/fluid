// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

import QtQuick
import QtQuick.Templates as T
import QtQuick.Window

/*!
    \class Menu
    \brief A Material Design 3 Expressive menu.

    Menu presents a temporary list of actions. Actions declared as children are
    represented by accessible menu-item delegates with Material typography,
    selection, icon, shortcut, disabled, pointer, and keyboard-focus states.

    The surface grows to fit its content between the Material minimum and
    maximum widths. On compact windows it may become narrower than the preferred
    minimum, and tall menus are constrained to the available viewport and become
    scrollable. Logical layout and cascading-menu arrows mirror automatically in
    right-to-left locales.

    Keyboard navigation, focus restoration, menu roles, checked state, and
    accessible names are provided by Qt Quick Templates. Give every action a
    short, localized \c text value so it has a meaningful accessible name.

    \code{.qml}
    MD.Menu {
        id: editMenu

        Action {
            text: qsTr("Copy")
            icon.name: MD.SymbolNames.symbolContentCopy
            onTriggered: copySelection()
        }

        Action {
            text: qsTr("Show formatting")
            checkable: true
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/menus/overview">Material Design 3 menu guidelines</a>.
*/
T.Menu {
    id: control

    //! Selects the menu geometry specification.
    enum Variant {
        //! Material 3 Expressive vertically segmented menu geometry.
        Vertical,
        //! Original Material 3 baseline menu geometry.
        Baseline
    }

    //! Selects the semantic menu color family.
    enum ColorStyle {
        //! Neutral surface container with tertiary selection.
        Standard,
        //! Tertiary container with a stronger tertiary selection.
        Vibrant
    }

    /*!
        \brief Geometry specification used by the menu.

        The default is \c Menu.Vertical. Set this to \c Menu.Baseline to retain
        the original Material 3 menu geometry.
    */
    property int variant: Menu.Vertical

    /*!
        \brief Semantic color family used by the menu and its default items.

        The default is \c Menu.Standard.
    */
    property int colorStyle: Menu.Standard

    //! \internal Width available inside the window's popup viewport.
    readonly property real _viewportWidth: parent && parent.Window.window && parent.Window.window.width > 0
                                           ? parent.Window.window.width - leftMargin - rightMargin
                                           : MD.Tokens.menu.maximumWidth

    //! \internal Height available inside the window's popup viewport.
    readonly property real _viewportHeight: parent && parent.Window.window && parent.Window.window.height > 0
                                            ? parent.Window.window.height - topMargin - bottomMargin
                                            : Number.POSITIVE_INFINITY

    //! \internal Effective direction from the popup, locale, or anchor item.
    readonly property bool _layoutMirrored: mirrored || locale.textDirection === Qt.RightToLeft || (parent && parent.LayoutMirroring.enabled)

    //! \internal Widest action delegate before the menu constrains its width.
    readonly property real _itemsImplicitWidth: {
        let itemWidth = 0;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index);
            if (item)
                itemWidth = Math.max(itemWidth, item.implicitWidth);
        }
        return itemWidth;
    }

    //! \internal Combined delegate height using the active ListView spacing.
    readonly property real _itemsImplicitHeight: {
        let itemHeight = 0;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index);
            if (item)
                itemHeight += item.implicitHeight;
        }
        return itemHeight + Math.max(0, count - 1) * menuList.spacing;
    }

    //! \internal Natural width before Material and viewport constraints.
    readonly property real _naturalWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, _itemsImplicitWidth + leftPadding + rightPadding)

    //! \internal Natural height before the viewport constraint.
    readonly property real _naturalHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, _itemsImplicitHeight + topPadding + bottomPadding)

    implicitWidth: Math.max(0, Math.min(_viewportWidth, Math.max(MD.Tokens.menu.minimumWidth, Math.min(MD.Tokens.menu.maximumWidth, _naturalWidth))))
    implicitHeight: Math.max(0, Math.min(_viewportHeight, _naturalHeight))

    margins: 0
    leftMargin: variant === Menu.Vertical ? MD.Tokens.menu.horizontalViewportMargin : MD.Tokens.menu.viewportMargin
    rightMargin: leftMargin
    topMargin: variant === Menu.Vertical ? MD.Tokens.menu.verticalViewportMargin : MD.Tokens.menu.viewportMargin
    bottomMargin: topMargin
    topPadding: variant === Menu.Vertical ? MD.Tokens.menu.verticalGroupPadding : MD.Tokens.menu.topPadding
    bottomPadding: variant === Menu.Vertical ? MD.Tokens.menu.verticalGroupPadding : MD.Tokens.menu.bottomPadding
    leftPadding: variant === Menu.Vertical ? MD.Tokens.menu.verticalGroupPadding : 0
    rightPadding: leftPadding
    overlap: 0

    modal: false
    focus: true
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside
    transformOrigin: cascade ? (_layoutMirrored ? Item.TopRight : Item.TopLeft) : Item.Top

    delegate: MD.MenuItem {
        id: menuDelegate

        //! \internal Position of this delegate in the menu content model.
        readonly property int _menuIndex: {
            for (let itemIndex = 0; itemIndex < control.count; ++itemIndex) {
                if (control.itemAt(itemIndex) === menuDelegate)
                    return itemIndex;
            }
            return -1;
        }

        variant: control.variant === Menu.Vertical ? MD.MenuItem.Vertical : MD.MenuItem.Baseline
        colorStyle: control.colorStyle === Menu.Vibrant ? MD.MenuItem.Vibrant : MD.MenuItem.Standard
        groupPosition: control.count <= 1 ? MD.MenuItem.Only
                       : _menuIndex === 0 ? MD.MenuItem.First
                       : _menuIndex === control.count - 1 ? MD.MenuItem.Last
                       : MD.MenuItem.Middle
        LayoutMirroring.enabled: control._layoutMirrored
        LayoutMirroring.childrenInherit: true
    }

    contentItem: ListView {
        id: menuList
        objectName: "menuListView"

        implicitWidth: control._itemsImplicitWidth
        implicitHeight: control._itemsImplicitHeight
        model: control.contentModel
        currentIndex: control.currentIndex
        interactive: contentHeight + control.topPadding + control.bottomPadding > control.height
        boundsBehavior: Flickable.StopAtBounds
        spacing: control.variant === Menu.Vertical ? MD.Tokens.menu.verticalSegmentedGap : 0
        clip: true

        ScrollIndicator.vertical: MD.ScrollIndicator {}
    }

    background: MD.ElevationRectangle {
        objectName: "menuBackground"

        implicitWidth: MD.Tokens.menu.minimumWidth
        readonly property var containerShape: control.variant === Menu.Vertical
                                              ? MD.Tokens.menu.verticalContainerShape
                                              : MD.Tokens.menu.containerShape

        implicitHeight: control.variant === Menu.Vertical ? MD.Tokens.menu.verticalItemHeight : MD.Tokens.menu.itemHeight
        color: control.colorStyle === Menu.Vibrant
               ? control.MD.Style.tertiaryContainerColor
               : control.variant === Menu.Vertical
                 ? control.MD.Style.surfaceContainerLowColor
                 : control.MD.Style.surfaceContainerColor
        topLeftRadius: UiMetrics.resolveShapeRadius(containerShape.topLeft,
                                                    width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(containerShape.topRight,
                                                     width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(containerShape.bottomLeft,
                                                       width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(containerShape.bottomRight,
                                                        width, height)
        elevation: MD.Tokens.menu.containerElevation
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: control.variant === Menu.Vertical ? MD.Tokens.menu.closedScale : 0.94
            to: 1
            duration: MotionAnimation.expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: MotionAnimation.expressiveFastEffectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1
            to: control.variant === Menu.Vertical ? MD.Tokens.menu.closedScale : 0.94
            duration: MotionAnimation.expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
        }
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: MotionAnimation.expressiveFastEffectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
        }
    }
}
