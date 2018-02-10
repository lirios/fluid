import QtQuick 2.0
import QtQuick.Controls 1.4
import Fluid.Controls 1.0 as FluidControls

Item {
    id: root

    height: checked ? summaryRow.height + spacing*4 + contentLoader.height : summaryRow.height

    property int paddingLeft   : 24
    property int paddingRight  : paddingLeft
    property int paddingTop    : spacing
    property int paddingBottom : paddingTop
    property int spacing       : 16

    property int animationDuration  : 100

    property alias summaryDelegate: summaryLoader.sourceComponent
    property alias expandedPanelDelegate: contentLoader.sourceComponent
    property alias backgroundDelegate: backgroundLoader.sourceComponent

    property string summaryTitle
    property string summarySubtitle

    property bool           checked: false
    property ExclusiveGroup exclusiveGroup: null

    onExclusiveGroupChanged: if (exclusiveGroup) exclusiveGroup.bindCheckable(root)

    Card {
        id: card

        anchors.fill         : parent
        anchors.topMargin    : root.checked ? root.spacing : 0
        anchors.bottomMargin : anchors.topMargin
        anchors.leftMargin   : 10
        anchors.rightMargin  : 10
    }

    MouseArea {
        id: mouseArea

        width       : parent.width
        height      : summaryRow.height

        anchors.top : summaryRow.top

        onClicked   : root.checked = !root.checked
    }

    Loader {
        id: backgroundLoader

        width        : card.width
        height       : summaryRow.height

        anchors.top  : summaryRow.top
        anchors.left : card.left

        sourceComponent: Rectangle {
            color : mouseArea.pressed && !root.checked ? "#C8C8C8" : "white"

            Behavior on color { ColorAnimation { duration: root.animationDuration } }
        }
    }

    Row {
        id: summaryRow

        anchors.top         : parent.top
        anchors.topMargin   : root.checked ? spacing : 0

        height              : root.checked ? 64 : 48

        spacing             : root.spacing

        anchors.left        : parent.left
        anchors.leftMargin  : root.paddingLeft
        anchors.right       : parent.right
        anchors.rightMargin : root.paddingRight

        Behavior on height { NumberAnimation { duration: root.animationDuration } }

        Loader {
            id: summaryLoader

            width  : parent.width - expandedIndicatorIcon.width - parent.spacing
            height : parent.height

            sourceComponent: Row {

                spacing: summaryRow.spacing

                BodyLabel {
                    id: titleLabel

                    width             : parent.width * 0.3
                    height            : parent.height

                    verticalAlignment : "AlignVCenter"

                    opacity           : 0.87

                    text              : root.summaryTitle
                }

                BodyLabel {
                    width             : parent.width - parent.spacing - titleLabel.width
                    height            : parent.height

                    verticalAlignment : "AlignVCenter"

                    opacity           : 0.54

                    text              : root.summarySubtitle
                }
            }
        }

        Icon {
            id: expandedIndicatorIcon

            anchors.top       : parent.top
            anchors.topMargin : 12

            opacity           : 0.54

            name              : FluidControls.Utils.iconUrl(root.checked ? "hardware/keyboard_arrow_up" : "hardware/keyboard_arrow_down")
        }
    }

    Item {
        height              : visible ? contentLoader.height : 0

        anchors.top         : summaryRow.bottom
        anchors.topMargin   : root.checked ? root.paddingTop : 0
        anchors.left        : parent.left
        anchors.leftMargin  : root.paddingLeft
        anchors.right       : parent.right
        anchors.rightMargin : root.paddingRight

        visible             : root.checked
        clip                : true

        Behavior on height { NumberAnimation { duration: root.animationDuration } }

        Loader {
            id: contentLoader

            width : parent.width
        }
    }
}
