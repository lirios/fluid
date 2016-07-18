import QtQuick.Controls 2.0
import Fluid.Controls 1.0

Page {
    title: "Sub page demo"

    actions: [
        Action {
            iconName: "action/settings"
        }
    ]

    Label {
        anchors.centerIn: parent
        text: "Testing"
    }
}
