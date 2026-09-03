// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Layouts

Item {
    id: page

    readonly property real sectionSpacing: MD.Tokens.measurement.space300
    readonly property real itemSpacing: MD.Tokens.measurement.space200

    component ExampleButton: MD.Button {
        type: MD.Button.Outlined
    }

    MD.Action {
        id: learnMoreAction
        text: qsTr("Learn more")
    }

    MD.Action {
        id: dismissAction
        text: qsTr("Dismiss")
    }

    MD.Action {
        id: enableAction
        text: qsTr("Enable")
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Tooltips")
        description: qsTr("Tooltips identify controls or provide concise supporting information through plain and rich presentations.")

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Plain tooltips")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.floor(width / 160))
                columnSpacing: page.itemSpacing
                rowSpacing: page.itemSpacing

                ExampleButton {
                    text: qsTr("Hover or focus")
                    focusPolicy: Qt.StrongFocus

                    MD.ToolTip.text: qsTr("Available from pointer and keyboard")
                    MD.ToolTip.visible: hovered || visualFocus
                }

                ExampleButton {
                    text: qsTr("Press and hold")

                    MD.ToolTip.text: qsTr("Long-press tooltip")
                    MD.ToolTip.delay: Application.styleHints.mousePressAndHoldInterval
                    MD.ToolTip.visible: pressed
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Rich tooltip configurations")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.min(3, Math.floor(width / 160)))
                columnSpacing: page.itemSpacing
                rowSpacing: page.itemSpacing

                ExampleButton {
                    id: bodyOnlyAnchor
                    text: qsTr("Body only")
                    onClicked: bodyOnlyTip.open()
                }

                ExampleButton {
                    id: headlineAnchor
                    text: qsTr("Headline + body")
                    onClicked: headlineTip.open()
                }

                ExampleButton {
                    id: oneActionAnchor
                    text: qsTr("One button")
                    onClicked: oneActionTip.open()
                }

                ExampleButton {
                    id: headlineActionAnchor
                    text: qsTr("Headline + one button")
                    onClicked: headlineActionTip.open()
                }

                ExampleButton {
                    id: twoActionsAnchor
                    text: qsTr("Two buttons")
                    onClicked: twoActionsTip.open()
                }

                ExampleButton {
                    id: completeAnchor
                    text: qsTr("Headline + two buttons")
                    onClicked: completeTip.open()
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Wrapping, themes, and RTL")

            GridLayout {
                width: parent.width
                columns: Math.max(1, Math.floor(width / 196))
                columnSpacing: page.itemSpacing
                rowSpacing: page.itemSpacing

                ExampleButton {
                    id: narrowAnchor
                    text: qsTr("Narrow actions")
                    onClicked: narrowTip.open()
                }

                Rectangle {
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 96
                    color: MD.Style.surfaceDimColor
                    radius: 16
                    MD.Style.theme: MD.Style.Dark

                    ExampleButton {
                        id: darkAnchor
                        anchors.centerIn: parent
                        text: qsTr("Dark theme")
                        onClicked: darkTip.open()
                    }
                }

                Item {
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 96
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true

                    ExampleButton {
                        id: rtlAnchor
                        anchors.centerIn: parent
                        text: qsTr("RTL")
                        onClicked: rtlTip.open()
                    }
                }
            }
        }
    }

    MD.RichToolTip {
        id: bodyOnlyTip
        parent: bodyOnlyAnchor
        body: qsTr("A rich tooltip can contain only supporting body text.")
    }

    MD.RichToolTip {
        id: headlineTip
        parent: headlineAnchor
        headline: qsTr("Optional headline")
        body: qsTr("Headline and body use their Material type scales.")
    }

    MD.RichToolTip {
        id: oneActionTip
        parent: oneActionAnchor
        body: qsTr("Actions are reusable Qt Quick Template actions.")
        actions: [learnMoreAction]
    }

    MD.RichToolTip {
        id: headlineActionTip
        parent: headlineActionAnchor
        headline: qsTr("Permission required")
        body: qsTr("Enable access to continue using this feature.")
        actions: [enableAction]
    }

    MD.RichToolTip {
        id: twoActionsTip
        parent: twoActionsAnchor
        body: qsTr("Two short actions remain on the same logical row.")
        actions: [learnMoreAction, dismissAction]
    }

    MD.RichToolTip {
        id: completeTip
        parent: completeAnchor
        headline: qsTr("Complete rich tooltip")
        body: qsTr("The headline and number of buttons are independently configurable.")
        actions: [learnMoreAction, dismissAction]
    }

    MD.RichToolTip {
        id: narrowTip
        parent: narrowAnchor
        width: 180
        headline: qsTr("Wrapped actions")
        body: qsTr("The second action moves to another row when space is constrained.")
        actions: [learnMoreAction, dismissAction]
    }

    MD.RichToolTip {
        id: darkTip
        parent: darkAnchor
        headline: qsTr("Dark theme")
        body: qsTr("Semantic colors follow the anchor's inherited theme.")
        actions: [dismissAction]
    }

    MD.RichToolTip {
        id: rtlTip
        parent: rtlAnchor
        headline: qsTr("Right-to-left")
        body: qsTr("Text, placement, and actions follow logical direction.")
        actions: [learnMoreAction, dismissAction]
    }
}
