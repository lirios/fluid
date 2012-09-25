
import QtQuick 2.0
import FluidCore 1.0

Item {
	width: 300
	height: 300

	Column {
		id: column
		spacing: 30
		width: 100

		FluidCore.Label { text: "CIAO" }
		FluidCore.Button { id: disabledButton; text: "Disabled"; enabled: false }
		FluidCore.Button { id: enabledButton; text: "Enabled" }
	}
}
