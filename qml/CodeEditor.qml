import QtQuick 2.7
import QtQuick.Controls 2.2 as QQC2
import Lomiri.Components 1.3

import Example 1.0

Page {
	id: codeEditor
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('C/C++ IDE')
	    extension: Sections {
			id: headerSections
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            model: [i18n.tr("Code Editor"), i18n.tr("Input/Output"), i18n.tr("Settings")]
        }
        trailingActionBar {
            actions: [
                Action {
                    iconName: "send"
                    text: i18n.tr("Run")
                    onTriggered: {
                        Example.runAsync(Options.argv);
                    }
                    shortcut: "Ctrl+R"
                },
                Action {
                    iconName: "settings"
                    text: i18n.tr("Compile")
                    onTriggered: {
                        if (Example.compile(Options.compiler, Options.std) === -1)
                            toast.show(i18n.tr("Your code is garbage! However, the error is in the logs."), 5000)
                        else
                            toast.show(i18n.tr("Your code compiled!"))
                    }
                    shortcut: "Ctrl+B"
                },
                Action {
                    iconName: "document-save"
                    text: i18n.tr("Save")
                    onTriggered: {
                        Example.save(Options.lang, code.text);
                        //console.log(code.text);
                    }
                    shortcut: "Ctrl+S"
                }
            ]
        }
    }
	VisualItemModel {
        id: sections
		Item {
            width: tabView.width
            height: tabView.height
			TextArea {
				id: code
				color: "black"
				
				anchors.fill: parent
				
				font.bold: true
				font.family: "Consolas"
				wrapMode: Text.Wrap
				placeholderText: i18n.tr("Enter Code")
			}
		}
		InputOutput {
            width: tabView.width
            height: tabView.height
		}
        Settings {
            width: tabView.width
            height: tabView.height
        }
	}
    ListView {
        id: tabView
        model: sections
        interactive: false

        anchors {
            top: codeEditor.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        snapMode: ListView.SnapOneItem
        currentIndex: headerSections.selectedIndex
        highlightMoveDuration: LomiriAnimation.FastDuration
    }
}