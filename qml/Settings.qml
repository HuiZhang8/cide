import Lomiri.Components 1.3
import QtQuick 2.7

Page {
	id: settingsPage

	Label {
		id: args
		anchors.top: parent.top
		text: i18n.tr("Command line arguments (Experimental):")
	}
	TextField {
		id: argsText
		width: parent.width / 1.5
		anchors.top: args.bottom
		onAccepted: Options.argv = this.text
	}
	Button {
		anchors.top: args.bottom
		anchors.right: parent.right
		text: i18n.tr("Set")
		onClicked: Options.argv = argsText.text
	}

	OptionSelector {
		id: langSelect
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
	OptionSelector {
		anchors.top: langSelect.bottom
		text: i18n.tr("Standard version: ")
		model: [
			"89",
			"90",
			"95",
			"99",
			"11",
			"17"/*,
			"20"*/
		]
		selectedIndex: 4
		onSelectedIndexChanged: {
			switch (selectedIndex) {
				case 0:
					Options.std = 89;
					break;
				case 1:
					Options.std = 90;
					break;
				case 2:
					Options.std = 95
					break;
				case 3:
					Options.std = 99
					break;
				case 4:
					Options.std = 11
					break;
				case 5:
					Options.std = 17
					break;/*
				case 6:
					Options.std = 20
					break;*/
			}
		}
	}
}
