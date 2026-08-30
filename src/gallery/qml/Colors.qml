// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: root

    readonly property int compactSpacing: 8
    readonly property int contentSpacing: 16
    readonly property int spaciousSpacing: 32

    readonly property var paletteNames: [
        "black",
        "error0", "error10", "error100", "error20", "error30", "error40", "error50",
        "error60", "error70", "error80", "error90", "error95", "error99",
        "neutral0", "neutral10", "neutral100", "neutral12", "neutral17", "neutral20",
        "neutral22", "neutral24", "neutral30", "neutral4", "neutral40", "neutral50",
        "neutral6", "neutral60", "neutral70", "neutral80", "neutral87", "neutral90",
        "neutral92", "neutral94", "neutral95", "neutral96", "neutral98", "neutral99",
        "neutralVariant0", "neutralVariant10", "neutralVariant100", "neutralVariant20",
        "neutralVariant30", "neutralVariant40", "neutralVariant50", "neutralVariant60",
        "neutralVariant70", "neutralVariant80", "neutralVariant90", "neutralVariant95",
        "neutralVariant99",
        "primary0", "primary10", "primary100", "primary20", "primary30", "primary40",
        "primary50", "primary60", "primary70", "primary80", "primary90", "primary95",
        "primary99",
        "secondary0", "secondary10", "secondary100", "secondary20", "secondary30",
        "secondary40", "secondary50", "secondary60", "secondary70", "secondary80",
        "secondary90", "secondary95", "secondary99",
        "tertiary0", "tertiary10", "tertiary100", "tertiary20", "tertiary30",
        "tertiary40", "tertiary50", "tertiary60", "tertiary70", "tertiary80",
        "tertiary90", "tertiary95", "tertiary99",
        "white"
    ]

    readonly property var semanticNames: [
        "background", "error", "errorContainer", "inverseOnSurface", "inversePrimary",
        "inverseSurface", "onBackground", "onError", "onErrorContainer", "onPrimary",
        "onPrimaryContainer", "onPrimaryFixed", "onPrimaryFixedVariant", "onSecondary",
        "onSecondaryContainer", "onSecondaryFixed", "onSecondaryFixedVariant", "onSurface",
        "onSurfaceVariant", "onTertiary", "onTertiaryContainer", "onTertiaryFixed",
        "onTertiaryFixedVariant", "outline", "outlineVariant", "primary", "primaryContainer",
        "primaryFixed", "primaryFixedDim", "scrim", "secondary", "secondaryContainer",
        "secondaryFixed", "secondaryFixedDim", "surface", "surfaceBright", "surfaceContainer",
        "surfaceContainerHigh", "surfaceContainerHighest", "surfaceContainerLow",
        "surfaceContainerLowest", "surfaceDim", "surfaceTint", "surfaceVariant", "tertiary",
        "tertiaryContainer", "tertiaryFixed", "tertiaryFixedDim"
    ]

    function tokenEntries(tokenSet, names) {
        return names.map(function(name) {
            return { "name": name, "color": tokenSet[name] };
        });
    }

    component ColorTile: Rectangle {
        id: colorTile

        required property string tokenName
        required property color tokenColor

        function contrastingColor(color) {
            const luminance = 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
            return luminance > 0.55 ? "#1D1B20" : "#FFFFFF";
        }

        function contrastingBorderColor(color) {
            const luminance = 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
            return luminance > 0.55 ? Qt.rgba(29 / 255, 27 / 255, 32 / 255, 0.25)
                                    : Qt.rgba(1, 1, 1, 0.25);
        }

        Layout.fillWidth: true
        Layout.preferredWidth: 152
        Layout.minimumWidth: 128
        implicitHeight: 72

        color: colorTile.tokenColor
        topLeftRadius: MD.Tokens.shape.cornerSmall.topLeft
        topRightRadius: MD.Tokens.shape.cornerSmall.topRight
        bottomLeftRadius: MD.Tokens.shape.cornerSmall.bottomLeft
        bottomRightRadius: MD.Tokens.shape.cornerSmall.bottomRight
        border.width: 1
        border.color: colorTile.contrastingBorderColor(colorTile.tokenColor)

        Column {
            anchors.fill: parent
            anchors.margins: root.compactSpacing
            spacing: 2

            Text {
                width: parent.width
                color: colorTile.contrastingColor(colorTile.tokenColor)
                elide: Text.ElideRight
                font.bold: true
                text: colorTile.tokenName
            }

            Text {
                color: colorTile.contrastingColor(colorTile.tokenColor)
                opacity: 0.8
                text: colorTile.tokenColor.toString().toUpperCase()
            }
        }
    }

    component TokenSection: ColumnLayout {
        id: tokenSection

        required property string sectionTitle
        required property var entries

        Layout.fillWidth: true
        spacing: root.contentSpacing

        MD.Label {
            text: tokenSection.sectionTitle
            font.pixelSize: 28
        }

        GridLayout {
            Layout.fillWidth: true
            columns: Math.max(1, Math.floor(width / 168))
            columnSpacing: root.contentSpacing
            rowSpacing: root.contentSpacing

            Repeater {
                model: tokenSection.entries

                delegate: ColorTile {
                    required property var modelData

                    tokenName: modelData.name
                    tokenColor: modelData.color
                }
            }
        }
    }

    MD.ScrollView {
        id: scrollView

        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: scrollView.availableWidth
            spacing: root.spaciousSpacing

            TokenSection {
                sectionTitle: qsTr("Reference palette")
                entries: root.tokenEntries(MD.Tokens.palette, root.paletteNames)
            }

            TokenSection {
                sectionTitle: qsTr("Light color roles")
                entries: root.tokenEntries(MD.Tokens.light, root.semanticNames)
            }

            TokenSection {
                sectionTitle: qsTr("Dark color roles")
                entries: root.tokenEntries(MD.Tokens.dark, root.semanticNames)
            }
        }
    }
}
