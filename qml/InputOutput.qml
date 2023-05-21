import QtQuick 2.7
import Lomiri.Components 1.3

import Example 1.0

Page {
	id: io
	// Output
	Label {
		id: outLabel
		anchors.top: parent.top
		fontSize: "large"
		text: "Output"
	}
	Button {
		text: outText.text != "" ? "Update Output" : "Get Output"
		anchors {
			top: parent.top
			right: parent.right
		}
		onClicked: outText.text = Example.getOutput();
	}
	Text {
		id: outText
		anchors.top: outLabel.bottom
		height: parent.height / 2
		text: Example.getOutput()
	}
	// Input
	Label {
		id: inLabel
		anchors.bottom: outText.bottom
		fontSize: "large"
		text: "Input"
	}
	Text {
		id: inText
		anchors.top: inLabel.bottom
	}
	TextField {
		id: inTextField
		anchors.top: inText.bottom
		//anchors.bottom: parent.bottom
		width: parent.width
		onAccepted: {
			inText.text += inTextField.text + "\n"
			inTextField.text = ""
		}
	}
}