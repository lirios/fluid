
import QtQuick 2.0
import FluidUi 1.0

Item {
	width: 300
	height: 300

	Column {
		id: column
		spacing: 30
		width: 100

		Button { id: disabledButton; text: "Disabled"; enabled: false }
		Button { id: enabledButton; text: "Enabled" }
Row {
                Label { text: sl1.value.toFixed(2) ; color: "green"; width: 80 }
                Label { visible: screen.currentOrientation == Screen.Landscape; width: root.textColumnWidth; wrapMode: Text.Wrap; text: "Default Slider" }
                Slider { id: sl1 ; width:sliderWidth}
            }

Switch {
                    id: switch2
                    checked: true
                }
                Switch {
                    id: switch1
                    checked: false
                }

	}
}
