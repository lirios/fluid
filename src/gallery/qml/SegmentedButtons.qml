// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

GalleryPage {
    headline: qsTr("Segmented buttons")
    description: qsTr("Outlined segmented buttons offer a single choice or multiple selections. Use two to five related options; arrow keys move focus and Space or Enter selects.")

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Single selection · two to five choices")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.SegmentedButtonGroup {
                MD.SegmentedButton { text: qsTr("Day") }
                MD.SegmentedButton { text: qsTr("Week") }
            }
            MD.SegmentedButtonGroup {
                selectedIndexes: [1]
                MD.SegmentedButton { text: qsTr("List"); icon.name: MD.Symbols.viewList }
                MD.SegmentedButton { text: qsTr("Grid"); icon.name: MD.Symbols.gridView }
                MD.SegmentedButton { text: qsTr("Favorites"); icon.name: MD.Symbols.favorite }
            }
            MD.SegmentedButtonGroup {
                MD.SegmentedButton { text: qsTr("XS") }
                MD.SegmentedButton { text: qsTr("S") }
                MD.SegmentedButton { text: qsTr("M") }
                MD.SegmentedButton { text: qsTr("L") }
            }
            MD.SegmentedButtonGroup {
                selectedIndexes: [2]
                MD.SegmentedButton { text: "1" }
                MD.SegmentedButton { text: "2" }
                MD.SegmentedButton { text: "3" }
                MD.SegmentedButton { text: "4" }
                MD.SegmentedButton { text: "5" }
            }
        }
    }

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Multiple selection · two to five choices")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.SegmentedButtonGroup {
                selectionMode: MD.SegmentedButtonGroup.MultiSelection
                MD.SegmentedButton { text: qsTr("Photos") }
                MD.SegmentedButton { text: qsTr("Videos") }
            }
            MD.SegmentedButtonGroup {
                selectionMode: MD.SegmentedButtonGroup.MultiSelection
                selectedIndexes: [1]
                MD.SegmentedButton { text: qsTr("Home"); icon.name: MD.Symbols.home }
                MD.SegmentedButton { text: qsTr("Work"); icon.name: MD.Symbols.work }
                MD.SegmentedButton { text: qsTr("Saved"); icon.name: MD.Symbols.star }
            }
            MD.SegmentedButtonGroup {
                selectionMode: MD.SegmentedButtonGroup.MultiSelection
                selectedIndexes: [0, 2]
                MD.SegmentedButton { icon.name: MD.Symbols.formatBold; Accessible.name: qsTr("Bold") }
                MD.SegmentedButton { icon.name: MD.Symbols.formatItalic; Accessible.name: qsTr("Italic") }
                MD.SegmentedButton { icon.name: MD.Symbols.formatUnderlined; Accessible.name: qsTr("Underline") }
                MD.SegmentedButton { icon.name: MD.Symbols.favorite; Accessible.name: qsTr("Favorite") }
            }
            MD.SegmentedButtonGroup {
                selectionMode: MD.SegmentedButtonGroup.MultiSelection
                selectedIndexes: [0, 3]
                MD.SegmentedButton { text: qsTr("M") }
                MD.SegmentedButton { text: qsTr("T") }
                MD.SegmentedButton { text: qsTr("W") }
                MD.SegmentedButton { text: qsTr("T") }
                MD.SegmentedButton { text: qsTr("F") }
            }
        }
    }

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Optional selection and disabled states")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.SegmentedButtonGroup {
                selectionRequired: false
                MD.SegmentedButton { text: qsTr("Optional") }
                MD.SegmentedButton { text: qsTr("Choice") }
            }
            MD.SegmentedButtonGroup {
                selectedIndexes: [1]
                MD.SegmentedButton { text: qsTr("Available") }
                MD.SegmentedButton { text: qsTr("Selected"); enabled: false }
                MD.SegmentedButton { text: qsTr("Disabled"); enabled: false }
            }
            MD.SegmentedButtonGroup {
                enabled: false
                MD.SegmentedButton { text: qsTr("Day") }
                MD.SegmentedButton { text: qsTr("Week") }
            }
        }
    }

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Content and checkmarks")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.SegmentedButtonGroup {
                selectionMode: MD.SegmentedButtonGroup.MultiSelection
                selectedIndexes: [0, 1]
                MD.SegmentedButton { text: qsTr("Favorite"); icon.name: MD.Symbols.star }
                MD.SegmentedButton { text: qsTr("Text only") }
            }
            MD.SegmentedButtonGroup {
                MD.SegmentedButton { text: qsTr("Without"); showCheckmark: false }
                MD.SegmentedButton { text: qsTr("Checkmark"); showCheckmark: false }
            }
            MD.SegmentedButtonGroup {
                MD.SegmentedButton { text: qsTr("Image"); icon.source: Qt.resolvedUrl("../icons/32x32/apps/io.liri.Fluid.Gallery.png") }
                MD.SegmentedButton { text: qsTr("Symbol"); icon.name: MD.Symbols.star }
            }
        }
    }

    GalleryCard {
        gridColumns: parent.columns
        fullWidth: true
        title: qsTr("Right to left and constrained labels")

        MD.AutomaticGridLayout {
            width: parent.width

            MD.SegmentedButtonGroup {
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true
                MD.SegmentedButton { text: qsTr("First"); icon.name: MD.Symbols.home }
                MD.SegmentedButton { text: qsTr("Second"); icon.name: MD.Symbols.star }
                MD.SegmentedButton { text: qsTr("Third"); icon.name: MD.Symbols.favorite }
            }
            Item {
                implicitWidth: 240
                implicitHeight: constrainedGroup.implicitHeight

                MD.SegmentedButtonGroup {
                    id: constrainedGroup
                    width: Math.min(parent.width, 240)
                    MD.SegmentedButton { text: qsTr("Recently modified") }
                    MD.SegmentedButton { text: qsTr("Alphabetical order") }
                    MD.SegmentedButton { text: qsTr("Most frequently used") }
                }
            }
        }
    }
}
