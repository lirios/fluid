import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.ApplicationWindow {
    width: 640
    height: 480
    title: qsTr("Hello World")
    visible: true

    initialPage: FluidControls.TabbedPage {
        title: qsTr("Tabbed Page")

        actions: [
            FluidControls.Action {
                iconName: "content/add"
                text: qsTr("Add content")
                toolTip: qsTr("Add content")
                onTriggered: console.log("Example action...")
            }
        ]

        FluidControls.Tab {
            title: qsTr("First")

            Page1 {
                anchors.fill: parent
            }
        }

        FluidControls.Tab {
            title: qsTr("Second")

            Label {
                text: qsTr("Second page")
                anchors.centerIn: parent
            }
        }
    }
}
