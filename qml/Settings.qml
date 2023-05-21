import Lomiri.Components 1.3
import QtQuick 2.7

Page {
	id: settingsPage

	Label {
		id: args
		anchors.top: parent.top
		text: "Command line arguments:"
	}
	TextField {
		id: argsText
		anchors.top: args.bottom
		onAccepted: Options.argv = this.text
	}
	Button {
		anchors.top: args.bottom
		anchors.right: parent.right
		text: "Set"
		onClicked: Options.argv = argsText.text
	}

	OptionSelector {
		anchors.top: argsText.bottom
		text: i18n.tr("Language: ")
		model: [
			i18n.tr("C "),
			i18n.tr("C++ "),
		]
		onDelegateClicked: {
			Options.lang = this.selectedIndex
		}
	}

}
