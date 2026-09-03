// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

GalleryPage {
    id: page

    headline: qsTr("Dividers")
    description: qsTr("Dividers separate related content with full-width, inset, middle-inset, and vertical treatments.")

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Horizontal")

        ColumnLayout {
            id: horizontalExamples

            readonly property real labelWidth: Math.max(fullWidthLabel.implicitWidth,
                                                        insetLabel.implicitWidth,
                                                        middleInsetLabel.implicitWidth)

            anchors.fill: parent
            spacing: page.sectionSpacing

            // Full-width
            RowLayout {
                Layout.fillWidth: true
                spacing: page.contentSpacing

                MD.Label {
                    id: fullWidthLabel
                    objectName: "fullWidthHorizontalDividerLabel"

                    Layout.preferredWidth: horizontalExamples.labelWidth
                    text: qsTr("Full-width")
                }

                MD.Divider {
                    objectName: "fullWidthHorizontalDivider"
                    Layout.fillWidth: true
                }
            }

            // Inset
            RowLayout {
                Layout.fillWidth: true
                spacing: page.contentSpacing

                MD.Label {
                    id: insetLabel
                    objectName: "insetHorizontalDividerLabel"

                    Layout.preferredWidth: horizontalExamples.labelWidth
                    text: qsTr("Inset")
                }

                MD.Divider {
                    objectName: "insetHorizontalDivider"
                    Layout.fillWidth: true
                    leadingInset: MD.Tokens.divider.inset
                }
            }

            // Middle-inset
            RowLayout {
                Layout.fillWidth: true
                spacing: page.contentSpacing

                MD.Label {
                    id: middleInsetLabel
                    objectName: "middleInsetHorizontalDividerLabel"

                    Layout.preferredWidth: horizontalExamples.labelWidth
                    text: qsTr("Middle-inset")
                }

                MD.Divider {
                    objectName: "middleInsetHorizontalDivider"
                    Layout.fillWidth: true
                    leadingInset: MD.Tokens.divider.inset
                    trailingInset: MD.Tokens.divider.inset
                }
            }
        }
    }

    GalleryCard {
        gridColumns: page.columns
        title: qsTr("Vertical")

        RowLayout {
            objectName: "verticalDividerRow"

            anchors.fill: parent
            spacing: page.sectionSpacing

            // Full-width
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: page.contentSpacing

                MD.Label {
                    objectName: "fullHeightVerticalDividerLabel"

                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Full-width")
                }

                Item {
                    objectName: "fullHeightVerticalDividerSample"

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    implicitHeight: MD.Tokens.measurement.space800

                    MD.Divider {
                        objectName: "fullHeightVerticalDivider"

                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        orientation: Qt.Vertical
                    }
                }
            }

            // Inset
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: page.contentSpacing

                MD.Label {
                    objectName: "insetVerticalDividerLabel"

                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Inset")
                }

                Item {
                    objectName: "insetVerticalDividerSample"

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    implicitHeight: MD.Tokens.measurement.space800

                    MD.Divider {
                        objectName: "insetVerticalDivider"

                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        leadingInset: MD.Tokens.divider.inset
                        orientation: Qt.Vertical
                    }
                }
            }

            // Middle-inset
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: page.contentSpacing

                MD.Label {
                    objectName: "middleInsetVerticalDividerLabel"

                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Middle-inset")
                }

                Item {
                    objectName: "middleInsetVerticalDividerSample"

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    implicitHeight: MD.Tokens.measurement.space800

                    MD.Divider {
                        objectName: "middleInsetVerticalDivider"

                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        leadingInset: MD.Tokens.divider.inset
                        trailingInset: MD.Tokens.divider.inset
                        orientation: Qt.Vertical
                    }
                }
            }
        }
    }
}
