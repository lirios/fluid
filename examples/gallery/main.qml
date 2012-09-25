
import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import FluidUi 1.0 as FluidUi

Rectangle {
	width: 300
	height: 300
	color: "gainsboro"

	Column {
		id: column
		spacing: 30
		width: 100

		FluidUi.Label { text: "This is a label" }
		FluidUi.Button { enabled: false; text: "Disabled Button" }
	}
}
