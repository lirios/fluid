// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    required property string headline
    required property string description

    default property alias contentData: grid.contentData

    readonly property alias columns: grid.columns
    readonly property alias breakpoint: grid.breakpoint
    readonly property real compactSpacing: MD.Tokens.measurement.space100
    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    readonly property real spaciousSpacing: MD.Tokens.measurement.space400

    MD.ScrollView {
        id: scrollView

        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: scrollView.availableWidth
            spacing: page.sectionSpacing

            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: page.sectionSpacing
                Layout.rightMargin: page.sectionSpacing
                Layout.topMargin: page.sectionSpacing
                spacing: page.compactSpacing

                MD.Label {
                    objectName: "galleryPageHeadline"

                    Layout.fillWidth: true
                    text: page.headline
                    typescale: MD.Tokens.typescale.headlineMedium
                    color: page.MD.Style.onSurfaceColor
                }

                MD.Label {
                    objectName: "galleryPageDescription"

                    Layout.fillWidth: true
                    text: page.description
                    typescale: MD.Tokens.typescale.bodyLarge
                    color: page.MD.Style.onSurfaceVariantColor
                    wrapMode: Text.WordWrap
                }
            }

            MD.AdaptiveGrid {
                id: grid
                objectName: "galleryPageGrid"

                Layout.fillWidth: true
                rowSpacing: page.sectionSpacing
            }

            Item {
                Layout.fillWidth: true
                implicitHeight: page.sectionSpacing
            }
        }
    }
}
