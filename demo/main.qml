import QtQuick 2.6
import QtQuick.Controls 2.0
import Fluid.Controls 1.0

FluidWindow {
    visible: true

    width: 600
    height: 650

    title: "Fluid Demo"

    initialPage: Page {
        title: "List demo"

        ListView {
            anchors.fill: parent
            model: ListModel {
                ListElement { title: "Typography"; source: "qrc:/TypographyPage.qml" }
                ListElement { title: "List Item 1"; source: "qrc:/SubPage.qml" }
                ListElement { title: "List Item 2"; source: "qrc:/SubPage.qml" }
                ListElement { title: "List Item 3"; source: "qrc:/SubPage.qml" }
                ListElement { title: "List Item 4"; source: "qrc:/SubPage.qml" }
            }
            header: Subheader {
                text: "Header"
            }
            delegate: ListItem {
                text: model.title
                onClicked: pageStack.push(model.source)
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }
}
