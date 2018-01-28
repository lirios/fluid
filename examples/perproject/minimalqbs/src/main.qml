import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Fluid.Core 1.0 as FluidCore
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
                icon.source: FluidCore.Utils.iconUrl("content/add")
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
