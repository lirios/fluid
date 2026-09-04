// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

/*!
    \class AppBar
    \brief A Material 3 Expressive top app bar.

    AppBar provides small, medium flexible, and large flexible variants. Flexible
    variants expand to show larger wrapping title content and collapse into the
    small layout as their \c scrollTarget scrolls. The inherited
    \c navigationAction and \c actions properties accept AppBarAction objects,
    with lower-priority actions moving into an adaptive overflow menu.

    Place an AppBar in a page or application window header:

    \code
    MD.AppBar {
        variant: MD.AppBar.MediumFlexible
        title: qsTr("Library")
        subtitle: qsTr("Recently added")
        scrollTarget: pageFlickable

        navigationAction: MD.AppBarAction {
            text: qsTr("Back")
            icon.name: MD.Symbols.arrowBack
        }

        actions: [
            MD.AppBarAction {
                text: qsTr("Favorite")
                icon.name: MD.Symbols.favorite
            }
        ]
    }
    \endcode

    Safe-area insets and right-to-left layout mirroring are applied
    automatically. The background and \c expandedBackground remain edge-to-edge.

    For more information see the
    <a href="https://m3.material.io/components/app-bars/overview">Material Design 3 app bar guidelines</a>.
*/
MD.BaseAppBar {
    id: control

    Accessible.role: Accessible.ToolBar
    Accessible.name: title
    Accessible.description: subtitle

    /*!
        Selects the app bar's size and expansion behavior.

        - \c Small: A fixed 64 dp app bar with compact typography.
        - \c MediumFlexible: A flexible app bar with medium expanded typography.
        - \c LargeFlexible: A flexible app bar with large expanded typography.
    */
    enum Variant {
        Small,
        MediumFlexible,
        LargeFlexible
    }

    /*!
        Controls the logical alignment of title content.

        - \c Start: Aligns text to the logical start edge.
        - \c Center: Keeps text geometrically centered despite unequal side actions.
    */
    enum TitleAlignment {
        Start,
        Center
    }

    //! The app bar variant. The default is \c Small.
    property int variant: AppBar.Small

    //! The primary title displayed by the app bar.
    property string title

    //! Optional supporting text displayed below the title.
    property string subtitle

    //! The logical title alignment. The default is \c Start.
    property int titleAlignment: AppBar.Start

    /*!
        Maximum title lines in the expanded layout.

        The default is one line for a small app bar and two lines for flexible
        variants. Collapsed title content always uses one line.
    */
    property int titleMaximumLineCount: variant === AppBar.Small ? 1 : 2

    /*!
        Maximum subtitle lines in the expanded layout.

        Collapsed subtitle content always uses one line.
    */
    property int subtitleMaximumLineCount: 1

    //! \internal
    property real _expandedTextHeight: 0

    //! \internal
    property real _titleImplicitWidth: 0

    //! \internal
    readonly property bool _centeredTitle: titleAlignment !== 0

    //! \internal
    readonly property bool _hasSubtitle: subtitle.length > 0

    //! \internal
    readonly property real _tokenExpandedHeight: {
        switch (variant) {
        case AppBar.MediumFlexible:
            return _hasSubtitle ? MD.Tokens.appBar.mediumFlexibleContainerHeightWithSubtitle : MD.Tokens.appBar.mediumFlexibleContainerHeight;
        case AppBar.LargeFlexible:
            return _hasSubtitle ? MD.Tokens.appBar.largeFlexibleContainerHeightWithSubtitle : MD.Tokens.appBar.largeFlexibleContainerHeight;
        default:
            return collapsedHeight;
        }
    }

    //! \internal
    readonly property real _expandedTitleLineHeight: variant === AppBar.LargeFlexible ? MD.Tokens.typescale.displaySmall.lineHeight : MD.Tokens.typescale.headlineMedium.lineHeight

    //! \internal
    readonly property real _expandedSubtitleLineHeight: _hasSubtitle ? (variant === AppBar.LargeFlexible ? MD.Tokens.typescale.titleMedium.lineHeight : MD.Tokens.typescale.labelLarge.lineHeight) : 0

    //! \internal
    readonly property real _expandedGap: _hasSubtitle ? (variant === AppBar.LargeFlexible ? MD.Tokens.appBar.largeTitleSubtitleGap : MD.Tokens.appBar.mediumTitleSubtitleGap) : 0

    //! \internal
    readonly property real _defaultExpandedTextHeight: _expandedTitleLineHeight + _expandedGap + _expandedSubtitleLineHeight

    //! \internal
    readonly property real _bottomPadding: variant === AppBar.LargeFlexible ? MD.Tokens.appBar.largeTitleBottomPadding : MD.Tokens.appBar.mediumTitleBottomPadding

    collapsedHeight: MD.Tokens.appBar.smallContainerHeight
    expandedHeight: variant === AppBar.Small ? collapsedHeight : _tokenExpandedHeight + Math.max(0, _expandedTextHeight - _defaultExpandedTextHeight)
    scrollBehavior: variant === AppBar.Small ? MD.BaseAppBar.Pinned : MD.BaseAppBar.ExitUntilCollapsed
    minimumCenterWidth: Math.max(MD.Tokens.appBar.titleInset * 2, Math.min(barContentWidth, _titleImplicitWidth + MD.Tokens.appBar.titleInset * 2))

    centerContent: Component {
        Item {
            id: titleArea
            objectName: "titleArea"

            readonly property real fraction: control.variant === AppBar.Small ? 1 : control.collapsedFraction
            readonly property bool collapsedTypography: fraction >= 0.5
            readonly property real physicalLeadingWidth: control.layoutMirrored ? control.trailingWidth : control.leadingWidth
            readonly property real physicalTrailingWidth: control.layoutMirrored ? control.leadingWidth : control.trailingWidth
            readonly property real collapsedSide: Math.max(physicalLeadingWidth, physicalTrailingWidth) + MD.Tokens.appBar.titleInset
            readonly property real collapsedStartX: control._centeredTitle ? collapsedSide : physicalLeadingWidth + MD.Tokens.appBar.titleInset
            readonly property real collapsedEndX: control._centeredTitle ? width - collapsedSide : width - physicalTrailingWidth - MD.Tokens.appBar.titleInset
            readonly property real expandedStartX: MD.Tokens.appBar.titleInset
            readonly property real expandedEndX: width - MD.Tokens.appBar.titleInset
            readonly property real targetStartX: expandedStartX + (collapsedStartX - expandedStartX) * fraction
            readonly property real targetEndX: expandedEndX + (collapsedEndX - expandedEndX) * fraction
            readonly property real collapsedY: (control.collapsedHeight - titleColumn.implicitHeight) / 2
            readonly property real expandedY: control.currentContainerHeight - control._bottomPadding - titleColumn.implicitHeight

            // Measure the fully expanded text independently from the animated
            // title column. The latter changes width as collapsedFraction
            // changes, so using its implicit height to calculate expandedHeight
            // would make the container height depend on itself.
            MD.Label {
                id: expandedTitleMetrics

                visible: false
                width: Math.max(0, titleArea.width - MD.Tokens.appBar.titleInset * 2)
                text: control.title
                typescale: control.variant === AppBar.LargeFlexible ? MD.Tokens.typescale.displaySmall : MD.Tokens.typescale.headlineMedium
                maximumLineCount: Math.max(1, control.titleMaximumLineCount)
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                Accessible.ignored: true
            }

            MD.Label {
                id: expandedSubtitleMetrics

                visible: false
                width: expandedTitleMetrics.width
                text: control.subtitle
                typescale: control.variant === AppBar.LargeFlexible ? MD.Tokens.typescale.titleMedium : MD.Tokens.typescale.labelLarge
                maximumLineCount: Math.max(1, control.subtitleMaximumLineCount)
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                Accessible.ignored: true
            }

            Binding {
                target: control
                property: "_expandedTextHeight"
                value: expandedTitleMetrics.implicitHeight + (control._hasSubtitle ? control._expandedGap + expandedSubtitleMetrics.implicitHeight : 0)
            }

            Binding {
                target: control
                property: "_titleImplicitWidth"
                value: titleLabel.implicitWidth
            }

            Column {
                id: titleColumn

                x: titleArea.targetStartX
                y: titleArea.expandedY + (titleArea.collapsedY - titleArea.expandedY) * titleArea.fraction
                width: Math.max(0, titleArea.targetEndX - titleArea.targetStartX)
                spacing: control._hasSubtitle ? (titleArea.collapsedTypography ? MD.Tokens.appBar.mediumTitleSubtitleGap : control._expandedGap) : 0

                MD.Label {
                    id: titleLabel
                    objectName: "titleLabel"

                    width: parent.width
                    text: control.title
                    color: control.titleColor
                    typescale: titleArea.collapsedTypography ? MD.Tokens.typescale.titleLarge : control.variant === AppBar.LargeFlexible ? MD.Tokens.typescale.displaySmall : MD.Tokens.typescale.headlineMedium
                    maximumLineCount: titleArea.collapsedTypography ? 1 : Math.max(1, control.titleMaximumLineCount)
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    horizontalAlignment: control._centeredTitle ? Text.AlignHCenter : control.layoutMirrored ? Text.AlignRight : Text.AlignLeft
                    Accessible.ignored: true
                }

                MD.Label {
                    id: subtitleLabel
                    width: parent.width
                    objectName: "subtitleLabel"
                    text: control.subtitle
                    color: control.subtitleColor
                    typescale: titleArea.collapsedTypography ? MD.Tokens.typescale.labelMedium : control.variant === AppBar.LargeFlexible ? MD.Tokens.typescale.titleMedium : MD.Tokens.typescale.labelLarge
                    maximumLineCount: titleArea.collapsedTypography ? 1 : Math.max(1, control.subtitleMaximumLineCount)
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    horizontalAlignment: control._centeredTitle ? Text.AlignHCenter : control.layoutMirrored ? Text.AlignRight : Text.AlignLeft
                    visible: control._hasSubtitle
                    Accessible.ignored: true
                }
            }
        }
    }
}
