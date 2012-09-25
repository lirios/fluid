
import QtQuick 2.0
import FluidCore 1.0

Rectangle {
	width: 300
	height: 300
	color: "gainsboro"

	Column {
		id: column
		spacing: 30
		width: 100

		Label { text: "CIAO" }
		FluidCore.Button { id: disabledButton; text: "Disabled"; enabled: false }
		FluidCore.Button { id: enabledButton; text: "Enabled" }
	}
}
