import QtQuick 2.6
import QtQuick.Controls 2.0
import Fluid.Controls 1.0
import Fluid.UI 1.0

FluidWindow {
    visible: true

    width: 600
    height: 450

    title: "Fluid Demo"

    initialPage: Page {
        title: "List demo"

        ListView {
            anchors.fill: parent
            model: 5
            header: Subheader {
                text: "Header"
            }

            delegate: ListItem {
                text: "List Item " + (index + 1)
                onClicked: pageStack.push(Qt.resolvedUrl('SubPage.qml'))
            }
        }
    }
}
