import QtQuick 2.6
import QtQuick.Controls 2.0
import Fluid.Controls 1.0

ApplicationWindow {
    visible: true

    ListView {
        anchors.fill: parent
        model: 5
        header: Subheader {
            text: "Header"
        }

        delegate: ListItem {
            text: "List Item " + (index + 1)
        }
    }
}
